From: john.stultz@linaro.org (John Stultz)
Date: Mon, 17 Jun 2013 14:50:03 -0700
Subject: [PATCH] ARM: sched_clock: Load cycle count after epoch stabilizes
In-Reply-To: <51BF68DC.5030804@codeaurora.org>
References: <1371082214-1119-1-git-send-email-sboyd@codeaurora.org>
 <51BF68DC.5030804@codeaurora.org>
Message-ID: <51BF848B.2030501@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/17/2013 12:51 PM, Stephen Boyd wrote:
> John,
>
> I just saw your pull request for making this code generic. I believe
> this patch fixes a bug that nobody has seen in practice so it's probably
> fine to delay this until 3.11.
>
> Also, I've just noticed that "ARM: sched_clock: Return suspended count
> earlier" that I sent in that series is going to break the arm
> architected timer path because they're circumventing all this epoch_ns
> code. It would be better if you could replace that patch with this patch
> because this optimizes it in the same way and also fixes a bug at the
> same time.

Sorry, could you clarify a bit more? The above sounds like there are two 
issues, but you only sent one patch.

I'm also not sure how to proceed with the patch you sent, since it 
collides with the patch that moves sched_clock to be generic.

Could you refactor the change on-top of git branch I sent to Thomas? 
Otherwise I'll have to withdraw the pull request, and we'll probably 
miss 3.11 for the generic sched_clock change.

thanks
-john
