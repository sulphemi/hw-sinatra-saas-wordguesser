class WordGuesserGame
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  attr_accessor :wrong_guesses, :guesses, :word

  # Get a word from remote "random word" service

  def initialize(word)
    @word = word
    @wrong_guesses = ""
    @guesses = ""
  end

  def guess(letter)
    raise ArgumentError unless letter != nil
    raise ArgumentError unless letter.length == 1

    letter = letter.downcase
    raise ArgumentError unless ('a'..'z').include? letter

    if guesses.include? letter or wrong_guesses.include? letter
      return false
    elsif word.include? letter
      @guesses += letter
      return true
    else
      @wrong_guesses += letter
      return true
    end
  end

  def word_with_guesses()
    le_word = "-" * @word.length
    guesses.each_char do |guess|
      @word.each_char.with_index do |char, index|
        if char == guess
          le_word[index] = guess
        end
      end
    end
    return le_word
  end

  def check_win_or_lose()
    if word_with_guesses() == @word
      return :win
    elsif wrong_guesses.length >= 7
      return :lose
    else
      return :play
    end
  end

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start do |http|
      return http.post(uri, "").body
    end
  end
end
