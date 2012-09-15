From: davidb@codeaurora.org (David Brown)
Date: Sat, 15 Sep 2012 10:00:26 -0700
Subject: [PATCH v2 RESEND 1/2] ARM: arch timer: Set the TVAL before timer
 is enabled
In-Reply-To: <1347694914-1457-1-git-send-email-rvaswani@codeaurora.org>
References: <1347694914-1457-1-git-send-email-rvaswani@codeaurora.org>
Message-ID: <20120915170026.GA8706@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 15, 2012 at 12:41:53AM -0700, Rohit Vaswani wrote:
> On some hardware, the timer deasserts the interrupt when a
> new TVAL is written only when the enable bit is cleared.
> Hence explicitly disable the timer and then program the
> TVAL followed by enabling the timer.
> If this order is not followed, there are chances that
> you would not receive any timer interrupts.

It's a little unclear to me who you intend to take this patch.  In the
To field, you've listed Marc, the MSM maintainers, as well as Russell.
The MSM tree doesn't really make sense, since this is general ARM
code.  Marc would make sense if you depend on an active patch series
he is working on, so he could include it.

I'm guessing you meant it for Russell, though, and the rest of us as
CCs.

Thanks,
David

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
