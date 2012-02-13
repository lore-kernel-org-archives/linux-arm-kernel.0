From: philippe.langlais@stericsson.com (Philippe Langlais)
Date: Mon, 13 Feb 2012 10:52:25 +0100
Subject: [PATCH] mach-ux500: Fix around AB8500 GPIO macro name
Message-ID: <1329126745-19079-1-git-send-email-philippe.langlais@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philippe Langlais <philippe.langlais@linaro.org>

AB8500 GPIO1 is the base of AB8500 gpio number too.

Signed-off-by: Philippe Langlais <philippe.langlais@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c |    2 +-
 arch/arm/mach-ux500/board-mop500.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 8748087..542914b 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -72,7 +72,7 @@ static struct platform_device snowball_led_dev = {
 };
 
 static struct ab8500_gpio_platform_data ab8500_gpio_pdata = {
-	.gpio_base		= MOP500_AB8500_GPIO(0),
+	.gpio_base		= MOP500_AB8500_PIN_GPIO(1),
 	.irq_base		= MOP500_AB8500_VIR_GPIO_IRQ_BASE,
 	/* config_reg is the initial configuration of ab8500 pins.
 	 * The pins can be configured as GPIO or alt functions based
diff --git a/arch/arm/mach-ux500/board-mop500.h b/arch/arm/mach-ux500/board-mop500.h
index f926d3d..7ff6cbf 100644
--- a/arch/arm/mach-ux500/board-mop500.h
+++ b/arch/arm/mach-ux500/board-mop500.h
@@ -63,7 +63,7 @@
  * because the AB8500 GPIO pins are enumbered starting from 1, so the value in
  * parens matches the GPIO pin number in the data sheet.
  */
-#define MOP500_AB8500_GPIO(x)		(MOP500_EGPIO_END + (x) - 1)
+#define MOP500_AB8500_PIN_GPIO(x)	(MOP500_EGPIO_END + (x) - 1)
 /*Snowball AB8500 GPIO */
 #define SNOWBALL_VSMPS2_1V8_GPIO	MOP500_AB8500_PIN_GPIO(1)	/* SYSCLKREQ2/GPIO1 */
 #define SNOWBALL_PM_GPIO1_GPIO		MOP500_AB8500_PIN_GPIO(2)	/* SYSCLKREQ3/GPIO2 */
-- 
1.7.6
