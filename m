From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 29 Jun 2010 06:04:52 +0000 (UTC)
Subject: [PATCH 27/61] ARM: imx: new Kconfig symbol and feature test macro
	=?utf-8?b?Zm9yCURNQQ==?= on mx1 and mx2
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1277387397-3467-28-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <loom.20100629T075846-421@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

Uwe Kleine-K?nig <u.kleine-koenig <at> pengutronix.de> writes:
> This should be used instead of hard coding the corresponding platforms.
> The feature test macro is needed to support different SOCs in a single
> kernel image.  While at it rename dma-mx1-mx2 to dma-v1 as mx25 doesn't
> use it and so the mx2 part is wrong and move the header to
> arch/arm/mach-imx.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig <at> pengutronix.de>

This commit breaks build of the (hopefully) soon to-be-merged mx2_camera driver.
This driver is for both mx25 and mx27. Since dma-mx1-mx2.h is now under the
non-mx25 mach-imx/ directory, mx25 build can't find this header.

The solution is either:

1. move mx25 to mach-imx/ as well, or

2. postpone the dma-mx1-mx2.h header move for now, and leave it under plat-mxc/

Any thoughts?

baruch
