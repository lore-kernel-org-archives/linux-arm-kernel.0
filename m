From: padma.v@samsung.com (Padmavathi Venna)
Date: Thu, 20 Oct 2011 17:16:20 +0530
Subject: [PATCH] ARM: ep93xx: Use CLKDEV_INIT for creating clk_lookup instance
Message-ID: <1319111180-27711-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A common macro CLKDEV_INIT was added for creating clk_lookup
instance in include/linux/clkdev.h. So replace INIT_CK macro with
CLKDEV_INIT.

Suggested-by: Russell King <rmk+kernel@arm.linux.org.uk>
Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 arch/arm/mach-ep93xx/clock.c |   61 ++++++++++++++++++++----------------------
 1 files changed, 29 insertions(+), 32 deletions(-)

diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-ep93xx/clock.c
index ca4de71..60fc2f3 100644
--- a/arch/arm/mach-ep93xx/clock.c
+++ b/arch/arm/mach-ep93xx/clock.c
@@ -198,39 +198,36 @@ static struct clk clk_m2m1 = {
 	.enable_mask	= EP93XX_SYSCON_PWRCNT_DMA_M2M1,
 };
 
-#define INIT_CK(dev,con,ck)					\
-	{ .dev_id = dev, .con_id = con, .clk = ck }
-
 static struct clk_lookup clocks[] = {
-	INIT_CK(NULL,			"xtali",	&clk_xtali),
-	INIT_CK("apb:uart1",		NULL,		&clk_uart1),
-	INIT_CK("apb:uart2",		NULL,		&clk_uart2),
-	INIT_CK("apb:uart3",		NULL,		&clk_uart3),
-	INIT_CK(NULL,			"pll1",		&clk_pll1),
-	INIT_CK(NULL,			"fclk",		&clk_f),
-	INIT_CK(NULL,			"hclk",		&clk_h),
-	INIT_CK(NULL,			"apb_pclk",	&clk_p),
-	INIT_CK(NULL,			"pll2",		&clk_pll2),
-	INIT_CK("ep93xx-ohci",		NULL,		&clk_usb_host),
-	INIT_CK("ep93xx-keypad",	NULL,		&clk_keypad),
-	INIT_CK("ep93xx-fb",		NULL,		&clk_video),
-	INIT_CK("ep93xx-spi.0",		NULL,		&clk_spi),
-	INIT_CK("ep93xx-i2s",		"mclk",		&clk_i2s_mclk),
-	INIT_CK("ep93xx-i2s",		"sclk",		&clk_i2s_sclk),
-	INIT_CK("ep93xx-i2s",		"lrclk",	&clk_i2s_lrclk),
-	INIT_CK(NULL,			"pwm_clk",	&clk_pwm),
-	INIT_CK(NULL,			"m2p0",		&clk_m2p0),
-	INIT_CK(NULL,			"m2p1",		&clk_m2p1),
-	INIT_CK(NULL,			"m2p2",		&clk_m2p2),
-	INIT_CK(NULL,			"m2p3",		&clk_m2p3),
-	INIT_CK(NULL,			"m2p4",		&clk_m2p4),
-	INIT_CK(NULL,			"m2p5",		&clk_m2p5),
-	INIT_CK(NULL,			"m2p6",		&clk_m2p6),
-	INIT_CK(NULL,			"m2p7",		&clk_m2p7),
-	INIT_CK(NULL,			"m2p8",		&clk_m2p8),
-	INIT_CK(NULL,			"m2p9",		&clk_m2p9),
-	INIT_CK(NULL,			"m2m0",		&clk_m2m0),
-	INIT_CK(NULL,			"m2m1",		&clk_m2m1),
+	CLKDEV_INIT(NULL,			"xtali",	&clk_xtali),
+	CLKDEV_INIT("apb:uart1",		NULL,		&clk_uart1),
+	CLKDEV_INIT("apb:uart2",		NULL,		&clk_uart2),
+	CLKDEV_INIT("apb:uart3",		NULL,		&clk_uart3),
+	CLKDEV_INIT(NULL,			"pll1",		&clk_pll1),
+	CLKDEV_INIT(NULL,			"fclk",		&clk_f),
+	CLKDEV_INIT(NULL,			"hclk",		&clk_h),
+	CLKDEV_INIT(NULL,			"apb_pclk",	&clk_p),
+	CLKDEV_INIT(NULL,			"pll2",		&clk_pll2),
+	CLKDEV_INIT("ep93xx-ohci",		NULL,		&clk_usb_host),
+	CLKDEV_INIT("ep93xx-keypad",	NULL,		&clk_keypad),
+	CLKDEV_INIT("ep93xx-fb",		NULL,		&clk_video),
+	CLKDEV_INIT("ep93xx-spi.0",		NULL,		&clk_spi),
+	CLKDEV_INIT("ep93xx-i2s",		"mclk",		&clk_i2s_mclk),
+	CLKDEV_INIT("ep93xx-i2s",		"sclk",		&clk_i2s_sclk),
+	CLKDEV_INIT("ep93xx-i2s",		"lrclk",	&clk_i2s_lrclk),
+	CLKDEV_INIT(NULL,			"pwm_clk",	&clk_pwm),
+	CLKDEV_INIT(NULL,			"m2p0",		&clk_m2p0),
+	CLKDEV_INIT(NULL,			"m2p1",		&clk_m2p1),
+	CLKDEV_INIT(NULL,			"m2p2",		&clk_m2p2),
+	CLKDEV_INIT(NULL,			"m2p3",		&clk_m2p3),
+	CLKDEV_INIT(NULL,			"m2p4",		&clk_m2p4),
+	CLKDEV_INIT(NULL,			"m2p5",		&clk_m2p5),
+	CLKDEV_INIT(NULL,			"m2p6",		&clk_m2p6),
+	CLKDEV_INIT(NULL,			"m2p7",		&clk_m2p7),
+	CLKDEV_INIT(NULL,			"m2p8",		&clk_m2p8),
+	CLKDEV_INIT(NULL,			"m2p9",		&clk_m2p9),
+	CLKDEV_INIT(NULL,			"m2m0",		&clk_m2m0),
+	CLKDEV_INIT(NULL,			"m2m1",		&clk_m2m1),
 };
 
 static DEFINE_SPINLOCK(clk_lock);
-- 
1.7.4.4
