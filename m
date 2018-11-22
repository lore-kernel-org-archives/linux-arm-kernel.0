From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 22 Nov 2018 08:57:42 +0100
Subject: [PATCH] MAINTAINERS: add all files matching "imx" and "mxs" to the
 IMX entry
Message-ID: <20181122075742.31966-1-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This way also the spi, i2c and other drivers are covered.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Hello,

I was surprised by changes to the spi-imx driver[1]. To lessen the
chances that this happens again, I like making the IMX entry match all
relevant drivers.

Best regards
Uwe

[1] FTR: I didn't test yet, but I think
987a2dfe3f0485a82d87106e7e1c43f35c1d3b09 broke i.MX31 and i.MX35. Even
though a later patch made spi_imx_dma_transfer fail if .setup_wml isn't
provided, I guess this only changes from a NULL pointer exception to a
non-functional driver.

 MAINTAINERS | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b755a89fa325..cb9cbaa1ba19 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1517,15 +1517,8 @@ R:	NXP Linux Team <linux-imx@nxp.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
-F:	arch/arm/mach-imx/
-F:	arch/arm/mach-mxs/
-F:	arch/arm/boot/dts/imx*
-F:	arch/arm/configs/imx*_defconfig
-F:	drivers/clk/imx/
-F:	drivers/firmware/imx/
-F:	drivers/soc/imx/
-F:	include/linux/firmware/imx/
-F:	include/soc/imx/
+N:	imx
+N:	mxs
 
 ARM/FREESCALE VYBRID ARM ARCHITECTURE
 M:	Shawn Guo <shawnguo@kernel.org>
-- 
2.19.1
