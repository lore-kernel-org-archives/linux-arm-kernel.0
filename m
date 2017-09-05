From: embed3d@gmail.com (Philipp Rossak)
Date: Tue,  5 Sep 2017 22:34:16 +0200
Subject: [PATCH v2] ARM: dts: sun8i: h3: Fix Pincrtl bindings on Bananapi M2
 Plus
Message-ID: <1504643656-4926-1-git-send-email-embed3d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philipp Rossak <embed3d@gmail.com>

There is no need for pincontrol nodes when the pin is set to a GPIO

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
This is Patch is a new version of the following patch:
https://patchwork.kernel.org/patch/9934835/


changes since version 1:
* vqmmc-supply was added again
* The pincontrolers for the leds and gpio_keys were removed

 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts b/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
index d756ff8..cc20d67 100644
--- a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
@@ -64,7 +64,6 @@
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
-		pinctrl-0 = <&pwr_led_bpi_m2p>;
 
 		pwr_led {
 			label = "bananapi-m2-plus:red:pwr";
@@ -76,7 +75,6 @@
 	gpio_keys {
 		compatible = "gpio-keys";
 		pinctrl-names = "default";
-		pinctrl-0 = <&sw_r_bpi_m2p>;
 
 		sw4 {
 			label = "power";
@@ -98,7 +96,6 @@
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		pinctrl-names = "default";
-		pinctrl-0 = <&wifi_en_bpi_m2p>;
 		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
 	};
 };
@@ -190,23 +187,6 @@
 	status = "okay";
 };
 
-&r_pio {
-	pwr_led_bpi_m2p: led_pins at 0 {
-		pins = "PL10";
-		function = "gpio_out";
-	};
-
-	sw_r_bpi_m2p: key_pins at 0 {
-		pins = "PL3";
-		function = "gpio_in";
-	};
-
-	wifi_en_bpi_m2p: wifi_en_pin {
-		pins = "PL7";
-		function = "gpio_out";
-	};
-};
-
 &reg_usb0_vbus {
 	gpio = <&pio 3 11 GPIO_ACTIVE_HIGH>; /* PD11 */
 	status = "okay";
-- 
2.7.4
