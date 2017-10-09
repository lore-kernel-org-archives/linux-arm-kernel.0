From: claudiu.beznea@microchip.com (Claudiu Beznea)
Date: Mon, 9 Oct 2017 19:09:28 +0300
Subject: [PATCH 06/15] ARM: dts: at91: sama5d27_som1_ek: add pinmuxing for pwm0
In-Reply-To: <1507565377-1545-1-git-send-email-claudiu.beznea@microchip.com>
References: <1507565377-1545-1-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <1507565377-1545-7-git-send-email-claudiu.beznea@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pin muxing for pwm0 and set it as disabled since it is in conflict
with the pins for leds.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
index 6c4c976a99d1..339f4e71cf40 100644
--- a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
@@ -136,7 +136,9 @@
 			};
 
 			pwm0: pwm at f802c000 {
-				status = "okay";
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_mikrobus1_pwm &pinctrl_mikrobus2_pwm>;
+				status = "disabled"; /* Conflict with leds. */
 			};
 
 			flx1: flexcom at f8038000 {
@@ -529,7 +531,7 @@
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_led_gpio_default>;
-		status = "okay";
+		status = "okay"; /* Conflict with pwm0. */
 
 		red {
 			label = "red";
-- 
2.7.4
