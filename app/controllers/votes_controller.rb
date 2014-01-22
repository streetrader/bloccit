class VotesController < ApplicationController

  before_filter: setup

   def setup
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    authorize! :create, Vote, message: "You need to be a user to do that."

    @vote = @post.votes.where(user_id: current_user.id).first
  end
  

  def up_vote
    update_vote(1)
    redirect_to :back
  end

  def down_vote
    update_vote(-1)
    redirect_to :back
  end

    if @vote # if it exists, update it
      @vote.update_attribute(:value, 1)
    else # create it
      @vote = current_user.votes.create(value: 1, post: @post)
    end
    redirect_to :back
  end
end

private

  def setup
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])

    @vote = @post.votes.where(user_id: current_user.id).first
  end
end