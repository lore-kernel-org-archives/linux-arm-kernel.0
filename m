From: dwalker@codeaurora.org (Daniel Walker)
Date: Wed, 15 Dec 2010 10:21:12 -0800
Subject: [PATCH 2/7] msm: Physical offset for MSM8960
In-Reply-To: <4D0903EB.6080206@codeaurora.org>
References: <1292384961-8851-1-git-send-email-stepanm@codeaurora.org>
	<1292384961-8851-3-git-send-email-stepanm@codeaurora.org>
	<4D08BFFC.3020103@ru.mvista.com>
	<20101215135508.GB8682@huya.qualcomm.com>
	<1292424054.13887.5.camel@m0nster>
	<20101215153837.GB15817@huya.qualcomm.com>
	<1292435728.7789.8.camel@c-dwalke-linux.qualcomm.com>
	<4D0903EB.6080206@codeaurora.org>
Message-ID: <1292437272.7789.18.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-12-15 at 10:07 -0800, Steve Muckle wrote:
> On 12/15/10 09:55, Daniel Walker wrote:
> > The board file is very similar, plus the ifdefs. The code differences
> > are the io and irq's .. The naming issue and the duplication can be
> 
> 8x60 and 8960 are expected to diverge over time. It is not worth it to
> try and make them common in this early stage where they are the same
> simply because a very small amount of 8960 (and 8660 for that matter)
> has been sent upstream.

My scheme should deal with that .. 

> > simplified just by combining 8960 and 8660 .. If you create two new
> > Kconfig options,
> > 
> > config MACH_MSM8660
> > 	bool
> > config MACH_MSM8960
> > 	bool
> 
> We currently use ARCH_MSM* for SoCs, and MACH_* for boards based on
> those SoCs. For this reason I think this scheme will be confusing and
> lead to machine_is_() calls everywhere.

You just need to look at this a different way. It's actually not much
different than what we currently have, it just saves us the duplication
and eliminates the naming problem .. The current version shouldn't need
machine_is_() calls so then this new way shouldn't either. You just use
the ifdef's ..

> I suggest we rename 8x60 to 8660 (SteveMo's idea actually) if the
> current naming is largely considered unacceptable.

I wouldn't say it's unacceptable, it's just a open question if there's a
better way.

Daniel

-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
