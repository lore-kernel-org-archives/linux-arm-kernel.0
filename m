From: alexandre.belloni@piout.net (Alexandre Belloni)
Date: Fri, 26 Oct 2012 21:29:12 +0200
Subject: [PATCH] at91sam9m10g45-ek: rename leds to match board
Message-ID: <1351279752-6491-1-git-send-email-alexandre.belloni@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The leds' name in the board file didn't match the names written on the
board itsef. This can be confusing when trying to use them for another
purpose.

Signed-off-by: Alexandre Belloni <alexandre.belloni@piout.net>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91sam9m10g45ek.dts  |   12 ++++++------
 arch/arm/mach-at91/board-sam9m10g45ek.c |    8 ++++----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
index 15e1dd4..c58b628 100644
--- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
@@ -93,20 +93,20 @@
 	leds {
 		compatible = "gpio-leds";
 
-		d8 {
-			label = "d8";
+		d3 {
+			label = "d3";
 			gpios = <&pioD 30 0>;
 			linux,default-trigger = "heartbeat";
 		};
 
-		d6 {
-			label = "d6";
+		d1 {
+			label = "d1";
 			gpios = <&pioD 0 1>;
 			linux,default-trigger = "nand-disk";
 		};
 
-		d7 {
-			label = "d7";
+		d2 {
+			label = "d2";
 			gpios = <&pioD 31 1>;
 			linux,default-trigger = "mmc0";
 		};
diff --git a/arch/arm/mach-at91/board-sam9m10g45ek.c b/arch/arm/mach-at91/board-sam9m10g45ek.c
index 3d48ec1..6d77687 100644
--- a/arch/arm/mach-at91/board-sam9m10g45ek.c
+++ b/arch/arm/mach-at91/board-sam9m10g45ek.c
@@ -413,19 +413,19 @@ static struct ac97c_platform_data ek_ac97_data = {
  */
 static struct gpio_led ek_leds[] = {
 	{	/* "top" led, red, powerled */
-		.name			= "d8",
+		.name			= "d3",
 		.gpio			= AT91_PIN_PD30,
 		.default_trigger	= "heartbeat",
 	},
 	{	/* "left" led, green, userled2, pwm3 */
-		.name			= "d6",
+		.name			= "d1",
 		.gpio			= AT91_PIN_PD0,
 		.active_low		= 1,
 		.default_trigger	= "nand-disk",
 	},
 #if !(defined(CONFIG_LEDS_ATMEL_PWM) || defined(CONFIG_LEDS_ATMEL_PWM_MODULE))
 	{	/* "right" led, green, userled1, pwm1 */
-		.name			= "d7",
+		.name			= "d2",
 		.gpio			= AT91_PIN_PD31,
 		.active_low		= 1,
 		.default_trigger	= "mmc0",
@@ -440,7 +440,7 @@ static struct gpio_led ek_leds[] = {
 static struct gpio_led ek_pwm_led[] = {
 #if defined(CONFIG_LEDS_ATMEL_PWM) || defined(CONFIG_LEDS_ATMEL_PWM_MODULE)
 	{	/* "right" led, green, userled1, pwm1 */
-		.name			= "d7",
+		.name			= "d2",
 		.gpio			= 1,	/* is PWM channel number */
 		.active_low		= 1,
 		.default_trigger	= "none",
-- 
1.7.9.5
