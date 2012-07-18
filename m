From: stigge@antcom.de (Roland Stigge)
Date: Wed, 18 Jul 2012 14:06:49 +0200
Subject: [PATCH 2/4] ARM: LPC32xx: Add PWM clock
In-Reply-To: <1342613211-13190-1-git-send-email-stigge@antcom.de>
References: <1342613211-13190-1-git-send-email-stigge@antcom.de>
Message-ID: <1342613211-13190-3-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexandre Pereira da Silva <aletes.xgr@gmail.com>

Signed-off-by: Alexandre Pereira da Silva <aletes.xgr@gmail.com>
Signed-off-by: Roland Stigge <stigge@antcom.de>
---

 arch/arm/mach-lpc32xx/clock.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- linux-2.6.orig/arch/arm/mach-lpc32xx/clock.c
+++ linux-2.6/arch/arm/mach-lpc32xx/clock.c
@@ -607,6 +607,19 @@ static struct clk clk_dma = {
 	.get_rate	= local_return_parent_rate,
 };
 
+static struct clk clk_pwm = {
+	.parent		= &clk_pclk,
+	.enable		= local_onoff_enable,
+	.enable_reg	= LPC32XX_CLKPWR_PWM_CLK_CTRL,
+	.enable_mask	= LPC32XX_CLKPWR_PWMCLK_PWM1CLK_EN |
+			  LPC32XX_CLKPWR_PWMCLK_PWM1SEL_PCLK |
+			  LPC32XX_CLKPWR_PWMCLK_PWM1_DIV(1) |
+			  LPC32XX_CLKPWR_PWMCLK_PWM2CLK_EN |
+			  LPC32XX_CLKPWR_PWMCLK_PWM2SEL_PCLK |
+			  LPC32XX_CLKPWR_PWMCLK_PWM2_DIV(1),
+	.get_rate	= local_return_parent_rate,
+};
+
 static struct clk clk_uart3 = {
 	.parent		= &clk_pclk,
 	.enable		= local_onoff_enable,
@@ -1188,6 +1201,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_INIT(NULL, "vfp9_ck", &clk_vfp9),
 	CLKDEV_INIT("pl08xdmac", NULL, &clk_dma),
 	CLKDEV_INIT("4003c000.watchdog", NULL, &clk_wdt),
+	CLKDEV_INIT("4005c000.pwm", NULL, &clk_pwm),
 	CLKDEV_INIT(NULL, "uart3_ck", &clk_uart3),
 	CLKDEV_INIT(NULL, "uart4_ck", &clk_uart4),
 	CLKDEV_INIT(NULL, "uart5_ck", &clk_uart5),
