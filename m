From: david@lechnology.com (David Lechner)
Date: Sun,  3 Dec 2017 15:58:15 -0600
Subject: [PATCH v2] ARM: da850: Fix LEGO EV3 battery voltage gpio
Message-ID: <1512338295-10633-1-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes the battery voltage monitoring gpio-hog settings.

When the gpio is low, it turns off the battery voltage to the ADC chip.
However, this needs to be on all of the time so that we can monitor
battery voltage.

Also, there was a typo that prevented pinmuxing from working correctly.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/boot/dts/da850-lego-ev3.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/da850-lego-ev3.dts b/arch/arm/boot/dts/da850-lego-ev3.dts
index 65ceaa3..a4ee12f 100644
--- a/arch/arm/boot/dts/da850-lego-ev3.dts
+++ b/arch/arm/boot/dts/da850-lego-ev3.dts
@@ -178,7 +178,7 @@
 	 */
 	battery {
 		pinctrl-names = "default";
-		pintctrl-0 = <&battery_pins>;
+		pinctrl-0 = <&battery_pins>;
 		compatible = "lego,ev3-battery";
 		io-channels = <&adc 4>, <&adc 3>;
 		io-channel-names = "voltage", "current";
@@ -465,7 +465,7 @@
 	batt_volt_en {
 		gpio-hog;
 		gpios = <6 GPIO_ACTIVE_HIGH>;
-		output-low;
+		output-high;
 	};
 
 	/* Don't impede Bluetooth clock signal */
-- 
2.7.4
