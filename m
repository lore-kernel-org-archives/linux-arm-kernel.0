From: davidb@codeaurora.org (David Brown)
Date: Thu, 29 Sep 2011 11:04:28 -0700
Subject: [PATCHv2 2/2] ARM: debug: Move DEBUG_ICEDCC into the DEBUG_LL
	choice
In-Reply-To: <4E84A962.9030806@codeaurora.org>
References: <1316568208-4518-1-git-send-email-sboyd@codeaurora.org>
	<1316568208-4518-2-git-send-email-sboyd@codeaurora.org>
	<4E83D25C.6020306@codeaurora.org>
	<20110929092102.GB25061@e102144-lin.cambridge.arm.com>
	<20110929094243.GC25061@e102144-lin.cambridge.arm.com>
	<20110929094602.GH23944@n2100.arm.linux.org.uk>
	<20110929103939.GD25061@e102144-lin.cambridge.arm.com>
	<4E84A962.9030806@codeaurora.org>
Message-ID: <20110929180428.GA8125@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 29, 2011 at 10:22:42AM -0700, Stephen Boyd wrote:
> >> One of the problems you'll encounter is that there's places where we
> >> don't have any timer infrastructure (eg, decompressor) and software
> >> timing loops won't work (they'll be too slow for the lower-end CPUs
> >> and too fast for the upper-end CPUs.)
> > Agreed, software timing loops are the only option and it's impossible to get
> > them right everywhere. I think the Kconfig help text should be updated so
> > that the timeout paragraph is removed.
> 
> Yes if you wait a long time the timeout for each character will expire
> and the execution will continue.

Wouldn't it be better to detect the first timeout and then stop trying
to write to the DCC?

But, do we really want fancy auto-detection stuff in DEBUG_LL?  A
timeout might make sense for a DCC console, but not here.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
