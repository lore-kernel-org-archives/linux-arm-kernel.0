From: padma.v@samsung.com (Padmavathi Venna)
Date: Thu, 20 Oct 2011 17:18:30 +0530
Subject: [PATCH] ARM: lpc32xx: Use CLKDEV_INIT for creating clk_lookup instance
Message-ID: <1319111310-27784-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A common macro CLKDEV_INIT was added for creating clk_lookup
instance in include/linux/clkdev.h. So replace _REGISTER_CLOCK macro
with CLKDEV_INIT.

Suggested-by: Russell King <rmk+kernel@arm.linux.org.uk>
Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 arch/arm/mach-lpc32xx/clock.c |   75 ++++++++++++++++++----------------------
 1 files changed, 34 insertions(+), 41 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/clock.c b/arch/arm/mach-lpc32xx/clock.c
index 1e02751..37034c2 100644
--- a/arch/arm/mach-lpc32xx/clock.c
+++ b/arch/arm/mach-lpc32xx/clock.c
@@ -1041,48 +1041,41 @@ struct clk *clk_get_parent(struct clk *clk)
 }
 EXPORT_SYMBOL(clk_get_parent);
 
-#define _REGISTER_CLOCK(d, n, c) \
-	{ \
-		.dev_id = (d), \
-		.con_id = (n), \
-		.clk = &(c), \
-	},
-
 static struct clk_lookup lookups[] = {
-	_REGISTER_CLOCK(NULL, "osc_32KHz", osc_32KHz)
-	_REGISTER_CLOCK(NULL, "osc_pll397", osc_pll397)
-	_REGISTER_CLOCK(NULL, "osc_main", osc_main)
-	_REGISTER_CLOCK(NULL, "sys_ck", clk_sys)
-	_REGISTER_CLOCK(NULL, "arm_pll_ck", clk_armpll)
-	_REGISTER_CLOCK(NULL, "ck_pll5", clk_usbpll)
-	_REGISTER_CLOCK(NULL, "hclk_ck", clk_hclk)
-	_REGISTER_CLOCK(NULL, "pclk_ck", clk_pclk)
-	_REGISTER_CLOCK(NULL, "timer0_ck", clk_timer0)
-	_REGISTER_CLOCK(NULL, "timer1_ck", clk_timer1)
-	_REGISTER_CLOCK(NULL, "timer2_ck", clk_timer2)
-	_REGISTER_CLOCK(NULL, "timer3_ck", clk_timer3)
-	_REGISTER_CLOCK(NULL, "vfp9_ck", clk_vfp9)
-	_REGISTER_CLOCK(NULL, "clk_dmac", clk_dma)
-	_REGISTER_CLOCK("pnx4008-watchdog", NULL, clk_wdt)
-	_REGISTER_CLOCK(NULL, "uart3_ck", clk_uart3)
-	_REGISTER_CLOCK(NULL, "uart4_ck", clk_uart4)
-	_REGISTER_CLOCK(NULL, "uart5_ck", clk_uart5)
-	_REGISTER_CLOCK(NULL, "uart6_ck", clk_uart6)
-	_REGISTER_CLOCK("pnx-i2c.0", NULL, clk_i2c0)
-	_REGISTER_CLOCK("pnx-i2c.1", NULL, clk_i2c1)
-	_REGISTER_CLOCK("pnx-i2c.2", NULL, clk_i2c2)
-	_REGISTER_CLOCK("dev:ssp0", NULL, clk_ssp0)
-	_REGISTER_CLOCK("dev:ssp1", NULL, clk_ssp1)
-	_REGISTER_CLOCK("lpc32xx_keys.0", NULL, clk_kscan)
-	_REGISTER_CLOCK("lpc32xx-nand.0", "nand_ck", clk_nand)
-	_REGISTER_CLOCK("tbd", "i2s0_ck", clk_i2s0)
-	_REGISTER_CLOCK("tbd", "i2s1_ck", clk_i2s1)
-	_REGISTER_CLOCK("ts-lpc32xx", NULL, clk_tsc)
-	_REGISTER_CLOCK("dev:mmc0", "MCLK", clk_mmc)
-	_REGISTER_CLOCK("lpc-net.0", NULL, clk_net)
-	_REGISTER_CLOCK("dev:clcd", NULL, clk_lcd)
-	_REGISTER_CLOCK("lpc32xx_udc", "ck_usbd", clk_usbd)
-	_REGISTER_CLOCK("lpc32xx_rtc", NULL, clk_rtc)
+	CLKDEV_INIT(NULL, "osc_32KHz", &osc_32KHz),
+	CLKDEV_INIT(NULL, "osc_pll397", &osc_pll397),
+	CLKDEV_INIT(NULL, "osc_main", &osc_main),
+	CLKDEV_INIT(NULL, "sys_ck", &clk_sys),
+	CLKDEV_INIT(NULL, "arm_pll_ck", &clk_armpll),
+	CLKDEV_INIT(NULL, "ck_pll5", &clk_usbpll),
+	CLKDEV_INIT(NULL, "hclk_ck", &clk_hclk),
+	CLKDEV_INIT(NULL, "pclk_ck", &clk_pclk),
+	CLKDEV_INIT(NULL, "timer0_ck", &clk_timer0),
+	CLKDEV_INIT(NULL, "timer1_ck", &clk_timer1),
+	CLKDEV_INIT(NULL, "timer2_ck", &clk_timer2),
+	CLKDEV_INIT(NULL, "timer3_ck", &clk_timer3),
+	CLKDEV_INIT(NULL, "vfp9_ck", &clk_vfp9),
+	CLKDEV_INIT(NULL, "clk_dmac", &clk_dma),
+	CLKDEV_INIT("pnx4008-watchdog", NULL, &clk_wdt),
+	CLKDEV_INIT(NULL, "uart3_ck", &clk_uart3),
+	CLKDEV_INIT(NULL, "uart4_ck", &clk_uart4),
+	CLKDEV_INIT(NULL, "uart5_ck", &clk_uart5),
+	CLKDEV_INIT(NULL, "uart6_ck", &clk_uart6),
+	CLKDEV_INIT("pnx-i2c.0", NULL, &clk_i2c0),
+	CLKDEV_INIT("pnx-i2c.1", NULL, &clk_i2c1),
+	CLKDEV_INIT("pnx-i2c.2", NULL, &clk_i2c2),
+	CLKDEV_INIT("dev:ssp0", NULL, &clk_ssp0),
+	CLKDEV_INIT("dev:ssp1", NULL, &clk_ssp1),
+	CLKDEV_INIT("lpc32xx_keys.0", NULL, &clk_kscan),
+	CLKDEV_INIT("lpc32xx-nand.0", "nand_ck", &clk_nand),
+	CLKDEV_INIT("tbd", "i2s0_ck", &clk_i2s0),
+	CLKDEV_INIT("tbd", "i2s1_ck", &clk_i2s1),
+	CLKDEV_INIT("ts-lpc32xx", NULL, &clk_tsc),
+	CLKDEV_INIT("dev:mmc0", "MCLK", &clk_mmc),
+	CLKDEV_INIT("lpc-net.0", NULL, &clk_net),
+	CLKDEV_INIT("dev:clcd", NULL, &clk_lcd),
+	CLKDEV_INIT("lpc32xx_udc", "ck_usbd", &clk_usbd),
+	CLKDEV_INIT("lpc32xx_rtc", NULL, &clk_rtc),
 };
 
 static int __init clk_init(void)
-- 
1.7.4.4
