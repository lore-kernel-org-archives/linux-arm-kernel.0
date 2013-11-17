From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 17 Nov 2013 12:04:09 +0100
Subject: [PATCH 20/21] ARM: ux500: move snowball LED pin control to device tree
In-Reply-To: <1384686250-10542-1-git-send-email-linus.walleij@linaro.org>
References: <1384686250-10542-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1384686250-10542-21-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves the Snowball LED pin config to the device tree.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-snowball.dts      | 11 +++++++++++
 arch/arm/mach-ux500/board-mop500-pins.c |  2 --
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
index 744ab956059a..605188ba30cd 100644
--- a/arch/arm/boot/dts/ste-snowball.dts
+++ b/arch/arm/boot/dts/ste-snowball.dts
@@ -76,6 +76,8 @@
 
 	leds {
 		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&gpioled_snowball_mode>;
 		used-led {
 			label = "user_led";
 			gpios = <&gpio4 14 0x4>;
@@ -414,6 +416,15 @@
 
 				};
 			};
+			gpio_led {
+				gpioled_snowball_mode: gpioled_default {
+					snowball_cfg1 {
+						ste,pins = "GPIO142_C11";
+						ste,config = <&gpio_out_hi>;
+					};
+
+				};
+			};
 		};
 
 		mcde at a0350000 {
diff --git a/arch/arm/mach-ux500/board-mop500-pins.c b/arch/arm/mach-ux500/board-mop500-pins.c
index 0e5d2684bc9a..aae9cfcfd56a 100644
--- a/arch/arm/mach-ux500/board-mop500-pins.c
+++ b/arch/arm/mach-ux500/board-mop500-pins.c
@@ -297,8 +297,6 @@ static struct pinctrl_map __initdata ab8505_pinmap[] = {
 };
 
 static struct pinctrl_map __initdata snowball_pinmap[] = {
-	/* User LED */
-	DB8500_PIN_HOG("GPIO142_C11", gpio_out_hi),
 	/*  Accelerometer/Magnetometer */
 	DB8500_PIN_HOG("GPIO163_C20", gpio_in_pu), /* ACCEL_IRQ1 */
 	DB8500_PIN_HOG("GPIO164_B21", gpio_in_pu), /* ACCEL_IRQ2 */
-- 
1.8.3.1
