#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-
# usage: echo "だるい！！ #takawo杯" | hashtagize.rb
module TextConverter
  extend self

  def hashtagize(text)
    result = split_with_saving_hashtags(text).map{|x| "#" + x  }.join(" ")
  end

  def split_with_saving_hashtags(text)
    text.split.map do |x|
      if x.match /^\#/
        x.sub(/^#/, "")
      else
        x.chars.to_a
      end
    end.flatten
  end
end

if ARGV.shift == '--test'
  require 'minitest/spec'
  require "minitest/autorun"
  describe TextConverter do
    it("hashtaggable array"){ TextConverter.split_with_saving_hashtags("#泉 PNG子 #takawo杯").must_equal %w[泉 P N G 子 takawo杯] }

    it("alphabet"){ TextConverter.hashtagize("PENTAX!").must_equal "#P #E #N #T #A #X #!" }
    it("hiragana"){ TextConverter.hashtagize("泉PNG子").must_equal "#泉 #P #N #G #子" }
    it("with whitespace"){ TextConverter.hashtagize("ね む       い   ").must_equal "#ね #む #い" }
    it("with hashtag"){ TextConverter.hashtagize("#泉 PNG 子 #takawo杯").must_equal "#泉 #P #N #G #子 #takawo杯" }
    it("with url"){ TextConverter.hashtagize("#takawo杯 http://example.com/").must_equal "#takawo杯 #h #t #t #p #: #/ #/ #e #x #a #m #p #l #e #. #c #o #m #/" }
  end
else
  puts TextConverter.hashtagize(ARGF.read)
end
