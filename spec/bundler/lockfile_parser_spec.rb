require "spec_helper"

describe Bundler::LockfileParser do
  include Bundler::GemHelpers

  before do
    install_gemfile <<-G
      source "file://#{gem_repo1}"
      gem "rack"
    G
  end

  subject do
    lockfile_contents = File.read(bundled_app("Gemfile.lock"))
    lockfile_contents <<  "\n\nMETADATA\n  version: 1.0.6"
    Bundler::LockfileParser.new(lockfile_contents)
  end

  it "ignores the METADATA section" do
    puts subject.dependencies
    subject.dependencies.map(&:name).should_not include("version: 1.0.6")
  end
end
