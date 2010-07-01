From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 1 Jul 2010 08:33:11 +0200
Subject: [PATCH 27/61] ARM: imx: new Kconfig symbol and feature test
	macro for?DMA on mx1 and mx2
In-Reply-To: <20100701052433.GC16981@jasper.tkos.co.il>
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1277387397-3467-28-git-send-email-u.kleine-koenig@pengutronix.de>
	<loom.20100629T075846-421@post.gmane.org>
	<20100630071718.GB11746@pengutronix.de>
	<20100701045156.GA16981@jasper.tkos.co.il>
	<20100701050348.GA28535@pengutronix.de>
	<20100701052433.GC16981@jasper.tkos.co.il>
Message-ID: <20100701063311.GC28535@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch,

On Thu, Jul 01, 2010 at 08:24:33AM +0300, Baruch Siach wrote:
> Hi Uwe,
> 
> On Thu, Jul 01, 2010 at 07:03:48AM +0200, Uwe Kleine-K?nig wrote:
> > On Thu, Jul 01, 2010 at 07:51:56AM +0300, Baruch Siach wrote:
> > > On Wed, Jun 30, 2010 at 09:17:18AM +0200, Uwe Kleine-K?nig wrote:
> > > > On Tue, Jun 29, 2010 at 06:04:52AM +0000, Baruch Siach wrote:
> > > > > Uwe Kleine-K?nig <u.kleine-koenig <at> pengutronix.de> writes:
> > > > > > This should be used instead of hard coding the corresponding platforms.
> > > > > > The feature test macro is needed to support different SOCs in a single
> > > > > > kernel image.  While at it rename dma-mx1-mx2 to dma-v1 as mx25 doesn't
> > > > > > use it and so the mx2 part is wrong and move the header to
> > > > > > arch/arm/mach-imx.
> > > > > > 
> > > > > > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig <at> pengutronix.de>
> > > > > 
> > > > > This commit breaks build of the (hopefully) soon to-be-merged mx2_camera driver.
> > > > > This driver is for both mx25 and mx27. Since dma-mx1-mx2.h is now under the
> > > > > non-mx25 mach-imx/ directory, mx25 build can't find this header.
> > > > > 
> > > > > The solution is either:
> > > > > 
> > > > > 1. move mx25 to mach-imx/ as well, or
> > > > > 
> > > > > 2. postpone the dma-mx1-mx2.h header move for now, and leave it under plat-mxc/
> > > > 
> > > > 3. don't include dma-mx1-mx2.h for mx25 builds.
> > > > 
> > > > An mx25 kernel doesn't provide the functions declared in dma-mx1-mx2.h,
> > > > so I assume it's due to compiler optimizations that you don't get a
> > > > build failure.
> > > > 
> > > > I wouldn't do 1. in the .36 merge window because I want to continue with
> > > > some cleanups first.  I have no problems with 2 and can do it, but I
> > > > think 3 is more correct, though it add #ifdefery to your driver, which
> > > > is bad.  What do you think?
> > > 
> > > Doing (3) adds quite a few #ifdefs throughout the driver. For a temporary 
> > > solution (until mx25 moves to mach-imx/) I think (2) is better. Since this 
> > > driver should go via your/Shascha's tree, I'll accept your decision.
> > You call (2) a temporary solution.  What is your long term plan here?  A
> > unified imx dma API?  If so, please start sending patches :-)
> 
> I was under the impression that YOUR long term plan in to move all imx 
> variants into mach-imx/. That's why I called this solution temporary. I would 
> very much like to help with the mach-mx25/ -> mach-imx/ move, but I don't 
> think that the costumer I work for is willing to sponsor this kind of work.
Yes, my long term plan is to move all imx variants into mach-imx/ but
the issue I pointed out remains after this is complete.  Probably my
concern is theoretical only, still I consider it unclean.  BTW my long
long term todo list contains such a unified dma API.
 
> I'll go for (3) then, and also s/MX2_VIDEO/VIDEO_MX2_HOSTSUPPORT/ as you 
> suggested in the other thread.
Fine.

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
