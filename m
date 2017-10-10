From: claudiu.beznea@microchip.com (Claudiu Beznea)
Date: Tue, 10 Oct 2017 13:09:45 +0300
Subject: [PATCH v2 10/14] ARM: dts: at91: sama5d2_xplained: add pinmuxing for
 pwm0
In-Reply-To: <1507630189-15504-1-git-send-email-claudiu.beznea@microchip.com>
References: <1507630189-15504-1-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <1507630189-15504-11-git-send-email-claudiu.beznea@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pin muxing for pwm0 and set it as disabled since it is in conflict
with pins for leds.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index 0b78476cec4a..851a095fd51d 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -224,7 +224,9 @@
 			};
 
 			pwm0: pwm at f802c000 {
-				status = "okay";
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_pwm0_pwm2_default>;
+				status = "disabled"; /* conflict with leds */
 			};
 
 			flx0: flexcom at f8034000 {
@@ -494,6 +496,11 @@
 					bias-disable;
 				};
 
+				pinctrl_pwm0_pwm2_default: pwm0_pwm2_default {
+					pinmux = <PIN_PB5__PWMH2>,
+						 <PIN_PB6__PWML2>;
+					bias-pull-up;
+				};
 			};
 
 			classd: classd at fc048000 {
@@ -530,7 +537,7 @@
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_led_gpio_default>;
-		status = "okay";
+		status = "okay"; /* conflict with pwm0 */
 
 		red {
 			label = "red";
-- 
2.7.4
