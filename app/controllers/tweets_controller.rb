class TweetsController < ApplicationController
  before_action :set_tweet, only: [:edit, :update, :destroy]

  def index
    @tweets = Tweet.all
  end

  def new
    if params[:back]
      @tweet = Tweet.new(tweets_params)
    else
      @tweet = Tweet.new
    end
  end
  
  def confirm
    @tweet = Tweet.new(tweets_params)
    render :new if @tweet.invalid?
  end

  def create
    @tweet = Tweet.new(tweets_params)
    if @tweet.save
      redirect_to tweets_path, notice: "ツイートしました！"
    else
      # 入力フォームを再描画します。
      render 'new'
    end
  end
  
  def edit
  end

  def update
    if @tweet.update(tweets_params)
      redirect_to tweets_path, notice: "ツイートを編集しました！"
    else
      # 入力フォームを再描画します。
      render 'edit'
    end
  end
  
  def destroy
    @tweet.destroy
    redirect_to tweets_path, notice: "ツイートを削除しました！"
  end

  private
    def tweets_params
      params.require(:tweet).permit(:content)
    end

    # idをキーとして値を取得するメソッド
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end
end
