From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 30 Jun 2010 09:17:18 +0200
Subject: [PATCH 27/61] ARM: imx: new Kconfig symbol and feature test
	macro for?DMA on mx1 and mx2
In-Reply-To: <loom.20100629T075846-421@post.gmane.org>
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1277387397-3467-28-git-send-email-u.kleine-koenig@pengutronix.de>
	<loom.20100629T075846-421@post.gmane.org>
Message-ID: <20100630071718.GB11746@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 29, 2010 at 06:04:52AM +0000, Baruch Siach wrote:
> Hi Uwe,
> 
> Uwe Kleine-K?nig <u.kleine-koenig <at> pengutronix.de> writes:
> > This should be used instead of hard coding the corresponding platforms.
> > The feature test macro is needed to support different SOCs in a single
> > kernel image.  While at it rename dma-mx1-mx2 to dma-v1 as mx25 doesn't
> > use it and so the mx2 part is wrong and move the header to
> > arch/arm/mach-imx.
> > 
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig <at> pengutronix.de>
> 
> This commit breaks build of the (hopefully) soon to-be-merged mx2_camera driver.
> This driver is for both mx25 and mx27. Since dma-mx1-mx2.h is now under the
> non-mx25 mach-imx/ directory, mx25 build can't find this header.
> 
> The solution is either:
> 
> 1. move mx25 to mach-imx/ as well, or
> 
> 2. postpone the dma-mx1-mx2.h header move for now, and leave it under plat-mxc/

3. don't include dma-mx1-mx2.h for mx25 builds.

An mx25 kernel doesn't provide the functions declared in dma-mx1-mx2.h,
so I assume it's due to compiler optimizations that you don't get a
build failure.

I wouldn't do 1. in the .36 merge window because I want to continue with
some cleanups first.  I have no problems with 2 and can do it, but I
think 3 is more correct, though it add #ifdefery to your driver, which
is bad.  What do you think?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
