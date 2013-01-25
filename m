From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 25 Jan 2013 11:13:23 +0900
Subject: [PATCH 05/15] ARM: sh7372: add clock lookup entries for DT-based
 devices
In-Reply-To: <1359080013-29189-1-git-send-email-horms+renesas@verge.net.au>
References: <1359080013-29189-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1359080013-29189-6-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

When booting with DT, devices are named differently. To get their clocks
additional entries have to be added to the lookup table.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/mach-shmobile/clock-sh7372.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-sh7372.c b/arch/arm/mach-shmobile/clock-sh7372.c
index 3ca6757b..45d21fe 100644
--- a/arch/arm/mach-shmobile/clock-sh7372.c
+++ b/arch/arm/mach-shmobile/clock-sh7372.c
@@ -544,6 +544,7 @@ static struct clk_lookup lookups[] = {
 
 	/* MSTP32 clocks */
 	CLKDEV_DEV_ID("i2c-sh_mobile.2", &mstp_clks[MSTP001]), /* IIC2 */
+	CLKDEV_DEV_ID("fff30000.i2c", &mstp_clks[MSTP001]), /* IIC2 */
 	CLKDEV_DEV_ID("spi_sh_msiof.0", &mstp_clks[MSTP000]), /* MSIOF0 */
 	CLKDEV_DEV_ID("uio_pdrv_genirq.4", &mstp_clks[MSTP131]), /* VEU3 */
 	CLKDEV_DEV_ID("uio_pdrv_genirq.3", &mstp_clks[MSTP130]), /* VEU2 */
@@ -556,6 +557,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-mipi-dsi.0", &mstp_clks[MSTP118]), /* DSITX0 */
 	CLKDEV_DEV_ID("sh_mobile_lcdc_fb.1", &mstp_clks[MSTP117]), /* LCDC1 */
 	CLKDEV_DEV_ID("i2c-sh_mobile.0", &mstp_clks[MSTP116]), /* IIC0 */
+	CLKDEV_DEV_ID("fff20000.i2c", &mstp_clks[MSTP116]), /* IIC0 */
 	CLKDEV_DEV_ID("sh_mobile_meram.0", &mstp_clks[MSTP113]), /* MERAM */
 	CLKDEV_DEV_ID("uio_pdrv_genirq.5", &mstp_clks[MSTP106]), /* JPU */
 	CLKDEV_DEV_ID("uio_pdrv_genirq.0", &mstp_clks[MSTP101]), /* VPU */
@@ -577,18 +579,25 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-sci.4", &mstp_clks[MSTP200]), /* SCIFA4 */
 	CLKDEV_DEV_ID("sh_fsi2", &mstp_clks[MSTP328]), /* FSI2 */
 	CLKDEV_DEV_ID("i2c-sh_mobile.1", &mstp_clks[MSTP323]), /* IIC1 */
+	CLKDEV_DEV_ID("e6c20000.i2c", &mstp_clks[MSTP323]), /* IIC1 */
 	CLKDEV_DEV_ID("r8a66597_hcd.0", &mstp_clks[MSTP322]), /* USB0 */
 	CLKDEV_DEV_ID("r8a66597_udc.0", &mstp_clks[MSTP322]), /* USB0 */
 	CLKDEV_DEV_ID("renesas_usbhs.0", &mstp_clks[MSTP322]), /* USB0 */
 	CLKDEV_DEV_ID("sh_flctl.0", &mstp_clks[MSTP315]), /* FLCTL */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.0", &mstp_clks[MSTP314]), /* SDHI0 */
+	CLKDEV_DEV_ID("e6850000.sdhi", &mstp_clks[MSTP314]), /* SDHI0 */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.1", &mstp_clks[MSTP313]), /* SDHI1 */
+	CLKDEV_DEV_ID("e6860000.sdhi", &mstp_clks[MSTP313]), /* SDHI1 */
 	CLKDEV_DEV_ID("sh_mmcif.0", &mstp_clks[MSTP312]), /* MMC */
+	CLKDEV_DEV_ID("e6bd0000.mmcif", &mstp_clks[MSTP312]), /* MMC */
 	CLKDEV_DEV_ID("sh-mipi-dsi.1", &mstp_clks[MSTP423]), /* DSITX1 */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.2", &mstp_clks[MSTP415]), /* SDHI2 */
+	CLKDEV_DEV_ID("e6870000.sdhi", &mstp_clks[MSTP415]), /* SDHI2 */
 	CLKDEV_DEV_ID("sh-mobile-hdmi", &mstp_clks[MSTP413]), /* HDMI */
 	CLKDEV_DEV_ID("i2c-sh_mobile.3", &mstp_clks[MSTP411]), /* IIC3 */
+	CLKDEV_DEV_ID("e6d20000.i2c", &mstp_clks[MSTP411]), /* IIC3 */
 	CLKDEV_DEV_ID("i2c-sh_mobile.4", &mstp_clks[MSTP410]), /* IIC4 */
+	CLKDEV_DEV_ID("e6d30000.i2c", &mstp_clks[MSTP410]), /* IIC4 */
 	CLKDEV_DEV_ID("sh-dma-engine.4", &mstp_clks[MSTP407]), /* USB-DMAC1 */
 	CLKDEV_DEV_ID("r8a66597_hcd.1", &mstp_clks[MSTP406]), /* USB1 */
 	CLKDEV_DEV_ID("r8a66597_udc.1", &mstp_clks[MSTP406]), /* USB1 */
-- 
1.7.10.4
