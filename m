From: ben-linux@fluff.org (Ben Dooks)
Date: Tue,  8 Dec 2009 02:07:19 +0000
Subject: [[clock v2]] ARM: S3C64XX: Cleanup common init code in s3c6400-clock.c
In-Reply-To: <1260238045-12694-1-git-send-email-ben-linux@fluff.org>
References: <1260238045-12694-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1260238045-12694-3-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the four fields from clksrc_clk.clk which are always the same
and init them when the clock is registered. This helps remove the amount
of repeated code.

This is a re-work of Harald Welte's clock changes for the latest kernel.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/plat-s3c64xx/s3c6400-clock.c |   49 +++-----------------------------
 1 files changed, 5 insertions(+), 44 deletions(-)

diff --git a/arch/arm/plat-s3c64xx/s3c6400-clock.c b/arch/arm/plat-s3c64xx/s3c6400-clock.c
index 6ffa21e..5882470 100644
--- a/arch/arm/plat-s3c64xx/s3c6400-clock.c
+++ b/arch/arm/plat-s3c64xx/s3c6400-clock.c
@@ -364,10 +364,6 @@ static struct clksrc_clk clk_mmc0 = {
 		.id		= 0,
 		.ctrlbit        = S3C_CLKCON_SCLK_MMC0,
 		.enable		= s3c64xx_sclk_ctrl,
-		.set_parent	= s3c64xx_setparent_clksrc,
-		.get_rate	= s3c64xx_getrate_clksrc,
-		.set_rate	= s3c64xx_setrate_clksrc,
-		.round_rate	= s3c64xx_roundrate_clksrc,
 	},
 	.shift		= S3C6400_CLKSRC_MMC0_SHIFT,
 	.mask		= S3C6400_CLKSRC_MMC0_MASK,
@@ -382,10 +378,6 @@ static struct clksrc_clk clk_mmc1 = {
 		.id		= 1,
 		.ctrlbit        = S3C_CLKCON_SCLK_MMC1,
 		.enable		= s3c64xx_sclk_ctrl,
-		.get_rate	= s3c64xx_getrate_clksrc,
-		.set_rate	= s3c64xx_setrate_clksrc,
-		.set_parent	= s3c64xx_setparent_clksrc,
-		.round_rate	= s3c64xx_roundrate_clksrc,
 	},
 	.shift		= S3C6400_CLKSRC_MMC1_SHIFT,
 	.mask		= S3C6400_CLKSRC_MMC1_MASK,
@@ -400,10 +392,6 @@ static struct clksrc_clk clk_mmc2 = {
 		.id		= 2,
 		.ctrlbit        = S3C_CLKCON_SCLK_MMC2,
 		.enable		= s3c64xx_sclk_ctrl,
-		.get_rate	= s3c64xx_getrate_clksrc,
-		.set_rate	= s3c64xx_setrate_clksrc,
-		.set_parent	= s3c64xx_setparent_clksrc,
-		.round_rate	= s3c64xx_roundrate_clksrc,
 	},
 	.shift		= S3C6400_CLKSRC_MMC2_SHIFT,
 	.mask		= S3C6400_CLKSRC_MMC2_MASK,
@@ -418,10 +406,6 @@ static struct clksrc_clk clk_usbhost = {
 		.id		= -1,
 		.ctrlbit        = S3C_CLKCON_SCLK_UHOST,
 		.enable		= s3c64xx_sclk_ctrl,
-		.set_parent	= s3c64xx_setparent_clksrc,
-		.get_rate	= s3c64xx_getrate_clksrc,
-		.set_rate	= s3c64xx_setrate_clksrc,
-		.round_rate	= s3c64xx_roundrate_clksrc,
 	},
 	.shift		= S3C6400_CLKSRC_UHOST_SHIFT,
 	.mask		= S3C6400_CLKSRC_UHOST_MASK,
@@ -436,10 +420,6 @@ static struct clksrc_clk clk_uart_uclk1 = {
 		.id		= -1,
 		.ctrlbit        = S3C_CLKCON_SCLK_UART,
 		.enable		= s3c64xx_sclk_ctrl,
-		.set_parent	= s3c64xx_setparent_clksrc,
-		.get_rate	= s3c64xx_getrate_clksrc,
-		.set_rate	= s3c64xx_setrate_clksrc,
-		.round_rate	= s3c64xx_roundrate_clksrc,
 	},
 	.shift		= S3C6400_CLKSRC_UART_SHIFT,
 	.mask		= S3C6400_CLKSRC_UART_MASK,
@@ -456,10 +436,6 @@ static struct clksrc_clk clk_spi0 = {
 		.id		= 0,
 		.ctrlbit        = S3C_CLKCON_SCLK_SPI0,
 		.enable		= s3c64xx_sclk_ctrl,
-		.set_parent	= s3c64xx_setparent_clksrc,
-		.get_rate	= s3c64xx_getrate_clksrc,
-		.set_rate	= s3c64xx_setrate_clksrc,
-		.round_rate	= s3c64xx_roundrate_clksrc,
 	},
 	.shift		= S3C6400_CLKSRC_SPI0_SHIFT,
 	.mask		= S3C6400_CLKSRC_SPI0_MASK,
@@ -474,10 +450,6 @@ static struct clksrc_clk clk_spi1 = {
 		.id		= 1,
 		.ctrlbit        = S3C_CLKCON_SCLK_SPI1,
 		.enable		= s3c64xx_sclk_ctrl,
-		.set_parent	= s3c64xx_setparent_clksrc,
-		.get_rate	= s3c64xx_getrate_clksrc,
-		.set_rate	= s3c64xx_setrate_clksrc,
-		.round_rate	= s3c64xx_roundrate_clksrc,
 	},
 	.shift		= S3C6400_CLKSRC_SPI1_SHIFT,
 	.mask		= S3C6400_CLKSRC_SPI1_MASK,
@@ -520,10 +492,6 @@ static struct clksrc_clk clk_audio0 = {
 		.id		= 0,
 		.ctrlbit        = S3C_CLKCON_SCLK_AUDIO0,
 		.enable		= s3c64xx_sclk_ctrl,
-		.set_parent	= s3c64xx_setparent_clksrc,
-		.get_rate	= s3c64xx_getrate_clksrc,
-		.set_rate	= s3c64xx_setrate_clksrc,
-		.round_rate	= s3c64xx_roundrate_clksrc,
 	},
 	.shift		= S3C6400_CLKSRC_AUDIO0_SHIFT,
 	.mask		= S3C6400_CLKSRC_AUDIO0_MASK,
@@ -551,10 +519,6 @@ static struct clksrc_clk clk_audio1 = {
 		.id		= 1,
 		.ctrlbit        = S3C_CLKCON_SCLK_AUDIO1,
 		.enable		= s3c64xx_sclk_ctrl,
-		.set_parent	= s3c64xx_setparent_clksrc,
-		.get_rate	= s3c64xx_getrate_clksrc,
-		.set_rate	= s3c64xx_setrate_clksrc,
-		.round_rate	= s3c64xx_roundrate_clksrc,
 	},
 	.shift		= S3C6400_CLKSRC_AUDIO1_SHIFT,
 	.mask		= S3C6400_CLKSRC_AUDIO1_MASK,
@@ -569,10 +533,6 @@ static struct clksrc_clk clk_irda = {
 		.id		= 0,
 		.ctrlbit        = S3C_CLKCON_SCLK_IRDA,
 		.enable		= s3c64xx_sclk_ctrl,
-		.set_parent	= s3c64xx_setparent_clksrc,
-		.get_rate	= s3c64xx_getrate_clksrc,
-		.set_rate	= s3c64xx_setrate_clksrc,
-		.round_rate	= s3c64xx_roundrate_clksrc,
 	},
 	.shift		= S3C6400_CLKSRC_IRDA_SHIFT,
 	.mask		= S3C6400_CLKSRC_IRDA_MASK,
@@ -596,10 +556,6 @@ static struct clksrc_clk clk_camif = {
 		.id		= -1,
 		.ctrlbit        = S3C_CLKCON_SCLK_CAM,
 		.enable		= s3c64xx_sclk_ctrl,
-		.set_parent	= s3c64xx_setparent_clksrc,
-		.get_rate	= s3c64xx_getrate_clksrc,
-		.set_rate	= s3c64xx_setrate_clksrc,
-		.round_rate	= s3c64xx_roundrate_clksrc,
 	},
 	.shift		= 0,
 	.mask		= 0,
@@ -641,6 +597,11 @@ static void __init_or_cpufreq s3c6400_set_clksrc(struct clksrc_clk *clk)
 		return;
 	}
 
+	clk->clk.get_rate = s3c64xx_getrate_clksrc;
+	clk->clk.set_rate = s3c64xx_setrate_clksrc;
+	clk->clk.set_parent = s3c64xx_setparent_clksrc;
+	clk->clk.round_rate = s3c64xx_roundrate_clksrc;
+
 	clk->clk.parent = srcs->sources[clksrc];
 
 	printk(KERN_INFO "%s: source is %s (%d), rate is %ld\n",
-- 
1.5.6.5
