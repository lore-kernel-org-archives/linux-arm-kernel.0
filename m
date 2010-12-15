From: dwalker@codeaurora.org (Daniel Walker)
Date: Wed, 15 Dec 2010 09:55:28 -0800
Subject: [PATCH 2/7] msm: Physical offset for MSM8960
In-Reply-To: <20101215153837.GB15817@huya.qualcomm.com>
References: <1292384961-8851-1-git-send-email-stepanm@codeaurora.org>
	<1292384961-8851-3-git-send-email-stepanm@codeaurora.org>
	<4D08BFFC.3020103@ru.mvista.com>
	<20101215135508.GB8682@huya.qualcomm.com>
	<1292424054.13887.5.camel@m0nster>
	<20101215153837.GB15817@huya.qualcomm.com>
Message-ID: <1292435728.7789.8.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-12-15 at 07:38 -0800, David Brown wrote:
> On Wed, Dec 15, 2010 at 06:40:54AM -0800, Daniel Walker wrote:
> 
> > > > -#elif defined(CONFIG_ARCH_MSM8X60)
> > > > +#elif defined(CONFIG_ARCH_MSM8X60) || defined(CONFIG_ARCH_MSM8960)
> > > 
> > > I guess it's a matter of style, and what one is trying to emphasize.
> > > Having each one listed makes it easier to change them individually.
> > > The file is just a listing of the addresses of each chip, so I don't
> > > see much reason to try and compact it.
> > 
> > It just shows a deeper issue, that the namespace needs work. There's too
> > much duplication here vs. 8x60 .. If you look over this whole patchset
> > it looks very much like 8x60 was just copied over.
> 
> There's not very much copying here, in fact there isn't very much to
> the 8960 support to begin with.  Despite the confusing names, 8960 is
> quite a bit different from 8[26]60.  I agree we would probably be best
> with different names, which might help make the difference clearer.

The board file is very similar, plus the ifdefs. The code differences
are the io and irq's .. The naming issue and the duplication can be
simplified just by combining 8960 and 8660 .. If you create two new
Kconfig options,

config MACH_MSM8660
	bool
config MACH_MSM8960
	bool

and use ARCH_MSM8X60 for all the duplication .. That gives you the
ability to leverage the similarities, and enough macros to distinguish
between the two for the differences. If there's no duplication (but we
know there is) then you just don't use ARCH_MSM8X60. You could also have
board-msm8660.c and board-msm8960.c to hold board file differences and
board-msm8x60.c to hold the similarities.

I haven't explored this in great detail, but it seems like a better
naming scheme than what you have here.

Daniel

-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
