From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 20 Jan 2012 12:00:03 +0000
Subject: Building of arch/arm/plat-mxc/ssi-fiq.S failed w/ THUMB2 enabled?
In-Reply-To: <20120120115216.GK1068@n2100.arm.linux.org.uk>
References: <CAMPhdO_4NQUFB14eecTb3N4oQJa86ojSk8FUveqg+Lye5_jY+A@mail.gmail.com>
 <20111202102418.GT26618@pengutronix.de>
 <20120120115216.GK1068@n2100.arm.linux.org.uk>
Message-ID: <20120120120003.GB2046@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2012 at 11:52:17AM +0000, Russell King - ARM Linux wrote:
> On Fri, Dec 02, 2011 at 11:24:18AM +0100, Uwe Kleine-K?nig wrote:
> > On Fri, Dec 02, 2011 at 06:01:08PM +0800, Eric Miao wrote:
> > > Hi Dave & Sascha,
> > > 
> > > I checked the log of this file, found a THUMB2 related changes, yet
> > > I'm still having the failure below, can you help do a quick check?
> > the problem is that in Thumb most commands don't work with r8-r15
> > because there are only three bits used to encode them. This is
> > unfortunate as the other registers are not banked for FIQ.
> > 
> > The best possibility I see is to save some unbanked registers to the
> > banked registers on entry and restore them on exception exit.
> 
> Or always build this as ARM code.

That should work, sure -- I prefer to keep the number of instances where
we need to do this to a minimum if we can, though.

Cheers
---Dave
