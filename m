From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  5 Oct 2017 12:49:46 +0200
Subject: [PATCH 11/20] ARM: dts: sun4i: Remove all useless pinctrl nodes
In-Reply-To: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
References: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
Message-ID: <c913d459e9fa32d8907d642db55fb01d486e49a2.1507198895.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gpio pinctrl nodes are redundant and as such useless most of the times.
Since they will also generate warnings in DTC, we can simply remove most of
them.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10-a1000.dts            | 16 +----------
 arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts       |  6 +----
 arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts | 28 +-----------------
 arch/arm/boot/dts/sun4i-a10-gemei-g9.dts         |  9 +-----
 arch/arm/boot/dts/sun4i-a10-hackberry.dts        | 16 +----------
 arch/arm/boot/dts/sun4i-a10-inet1.dts            | 14 +---------
 arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts       | 16 +----------
 arch/arm/boot/dts/sun4i-a10-marsboard.dts        |  7 +----
 arch/arm/boot/dts/sun4i-a10-mk802.dts            | 20 +------------
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts   |  6 +----
 arch/arm/boot/dts/sun4i-a10-pcduino.dts          | 14 +---------
 arch/arm/boot/dts/sun4i-a10-pcduino2.dts         |  9 +-----
 arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts | 21 +-------------
 13 files changed, 182 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts b/arch/arm/boot/dts/sun4i-a10-a1000.dts
index 69513f341a8e..09e909576c61 100644
--- a/arch/arm/boot/dts/sun4i-a10-a1000.dts
+++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts
@@ -62,8 +62,6 @@
 
 	leds {
 		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&led_pins_a1000>;
 
 		red {
 			label = "a1000:red:usr";
@@ -79,8 +77,6 @@
 
 	reg_emac_3v3: emac-3v3 {
 		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&emac_power_pin_a1000>;
 		regulator-name = "emac-3v3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
@@ -181,18 +177,6 @@
 	status = "okay";
 };
 
-&pio {
-	emac_power_pin_a1000: emac_power_pin at 0 {
-		pins = "PH15";
-		function = "gpio_out";
-	};
-
-	led_pins_a1000: led_pins at 0 {
-		pins = "PH10", "PH20";
-		function = "gpio_out";
-	};
-};
-
 #include "axp209.dtsi"
 
 &reg_dcdc2 {
diff --git a/arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts b/arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts
index f18c832d4e16..39ba4ccb9e2e 100644
--- a/arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts
+++ b/arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts
@@ -119,12 +119,6 @@
 	status = "okay";
 };
 
-&pio {
-	usb2_vbus_pin_a: usb2_vbus_pin at 0 {
-		pins = "PH12";
-	};
-};
-
 &reg_usb0_vbus {
 	regulator-boot-on;
 	status = "okay";
diff --git a/arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts b/arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts
index 96b595d4c064..acbf692e837f 100644
--- a/arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts
+++ b/arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts
@@ -58,8 +58,6 @@
 
 	backlight: backlight {
 		compatible = "pwm-backlight";
-		pinctrl-names = "default";
-		pinctrl-0 = <&bl_en_pin_dsrv9703c>;
 		pwms = <&pwm 0 50000 PWM_POLARITY_INVERTED>;
 		brightness-levels = <0 10 20 30 40 50 60 70 80 90 100>;
 		default-brightness-level = <8>;
@@ -79,8 +77,6 @@
 
 	reg_motor: reg_motor {
 		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&motor_pins>;
 		regulator-name = "vcc-motor";
 		regulator-min-microvolt = <3000000>;
 		regulator-max-microvolt = <3000000>;
@@ -90,8 +86,6 @@
 };
 
 &codec {
-	pinctrl-names = "default";
-	pinctrl-0 = <&codec_pa_pin>;
 	allwinner,pa-gpios = <&pio 7 15 GPIO_ACTIVE_HIGH>; /* PH15 */
 	status = "okay";
 };
@@ -128,8 +122,6 @@
 		reg = <0x38>;
 		interrupt-parent = <&pio>;
 		interrupts = <7 21 IRQ_TYPE_EDGE_FALLING>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&touchscreen_pins>;
 		reset-gpios = <&pio 1 13 GPIO_ACTIVE_LOW>;
 		touchscreen-size-x = <1024>;
 		touchscreen-size-y = <768>;
@@ -168,26 +160,6 @@
 };
 
 &pio {
-	bl_en_pin_dsrv9703c: bl_en_pin at 0 {
-		pins = "PH7";
-		function = "gpio_out";
-	};
-
-	codec_pa_pin: codec_pa_pin at 0 {
-		pins = "PH15";
-		function = "gpio_out";
-	};
-
-	motor_pins: motor_pins at 0 {
-		pins = "PB3";
-		function = "gpio_out";
-	};
-
-	touchscreen_pins: touchscreen_pins at 0 {
-		pins = "PB13";
-		function = "gpio_out";
-	};
-
 	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
 		pins = "PH4";
 		function = "gpio_in";
diff --git a/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts b/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
index 4d85262f6292..41ca8bded89f 100644
--- a/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
+++ b/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
@@ -72,8 +72,6 @@
  */
 &codec {
 	/* PH15 controls power to external amplifier (ft2012q) */
-	pinctrl-names = "default";
-	pinctrl-0 = <&codec_pa_pin>;
 	allwinner,pa-gpios = <&pio 7 15 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 };
@@ -148,13 +146,6 @@
 	status = "okay";
 };
 
-&pio {
-	codec_pa_pin: codec_pa_pin at 0 {
-		pins = "PH15";
-		function = "gpio_out";
-	};
-};
-
 &reg_dcdc2 {
 	regulator-always-on;
 	regulator-min-microvolt = <1000000>;
diff --git a/arch/arm/boot/dts/sun4i-a10-hackberry.dts b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
index d6ae111d8cd1..f33e42d6ce8b 100644
--- a/arch/arm/boot/dts/sun4i-a10-hackberry.dts
+++ b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
@@ -119,27 +119,11 @@
 	status = "okay";
 };
 
-&pio {
-	pinctrl-names = "default";
-	pinctrl-0 = <&hackberry_hogs>;
-
-	hackberry_hogs: hogs at 0 {
-		pins = "PH19";
-		function = "gpio_out";
-	};
-
-	usb2_vbus_pin_hackberry: usb2_vbus_pin at 0 {
-		pins = "PH12";
-		function = "gpio_out";
-	};
-};
-
 &reg_usb1_vbus {
 	status = "okay";
 };
 
 &reg_usb2_vbus {
-	pinctrl-0 = <&usb2_vbus_pin_hackberry>;
 	gpio = <&pio 7 12 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/sun4i-a10-inet1.dts b/arch/arm/boot/dts/sun4i-a10-inet1.dts
index d96e149e7909..2374ee7dfc64 100644
--- a/arch/arm/boot/dts/sun4i-a10-inet1.dts
+++ b/arch/arm/boot/dts/sun4i-a10-inet1.dts
@@ -58,8 +58,6 @@
 
 	backlight: backlight {
 		compatible = "pwm-backlight";
-		pinctrl-names = "default";
-		pinctrl-0 = <&bl_en_pin_inet>;
 		pwms = <&pwm 0 50000 PWM_POLARITY_INVERTED>;
 		brightness-levels = <0 10 20 30 40 50 60 70 80 90 100>;
 		default-brightness-level = <8>;
@@ -118,8 +116,6 @@
 		reg = <0x38>;
 		interrupt-parent = <&pio>;
 		interrupts = <7 21 IRQ_TYPE_EDGE_FALLING>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&touchscreen_wake_pin>;
 		wake-gpios = <&pio 1 13 GPIO_ACTIVE_HIGH>; /* PB13 */
 		touchscreen-size-x = <600>;
 		touchscreen-size-y = <1024>;
@@ -170,16 +166,6 @@
 };
 
 &pio {
-	bl_en_pin_inet: bl_en_pin at 0 {
-		pins = "PH7";
-		function = "gpio_out";
-	};
-
-	touchscreen_wake_pin: touchscreen_wake_pin at 0 {
-		pins = "PB13";
-		function = "gpio_out";
-	};
-
 	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
 		pins = "PH4";
 		function = "gpio_in";
diff --git a/arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts b/arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts
index 86f779bd9648..879141ca6027 100644
--- a/arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts
+++ b/arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts
@@ -62,8 +62,6 @@
 
 	leds {
 		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&led_pins_q5>;
 
 		green {
 			label = "q5:green:usr";
@@ -74,8 +72,6 @@
 
 	reg_emac_3v3: emac-3v3 {
 		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&emac_power_pin_q5>;
 		regulator-name = "emac-3v3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
@@ -154,18 +150,6 @@
 	status = "okay";
 };
 
-&pio {
-	emac_power_pin_q5: emac_power_pin at 0 {
-		pins = "PH19";
-		function = "gpio_out";
-	};
-
-	led_pins_q5: led_pins at 0 {
-		pins = "PH20";
-		function = "gpio_out";
-	};
-};
-
 &reg_usb0_vbus {
 	regulator-boot-on;
 	status = "okay";
diff --git a/arch/arm/boot/dts/sun4i-a10-marsboard.dts b/arch/arm/boot/dts/sun4i-a10-marsboard.dts
index d9af1042b045..86c7c3fcaf9c 100644
--- a/arch/arm/boot/dts/sun4i-a10-marsboard.dts
+++ b/arch/arm/boot/dts/sun4i-a10-marsboard.dts
@@ -61,8 +61,6 @@
 
 	leds {
 		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&led_pins_marsboard>;
 
 		red1 {
 			label = "marsboard:red1:usr";
@@ -152,11 +150,6 @@
 };
 
 &pio {
-	led_pins_marsboard: led_pins at 0 {
-		pins = "PB5", "PB6", "PB7", "PB8";
-		function = "gpio_out";
-	};
-
 	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
 		pins = "PH4";
 		function = "gpio_in";
diff --git a/arch/arm/boot/dts/sun4i-a10-mk802.dts b/arch/arm/boot/dts/sun4i-a10-mk802.dts
index b8d1501ef7e6..7198b34e2e50 100644
--- a/arch/arm/boot/dts/sun4i-a10-mk802.dts
+++ b/arch/arm/boot/dts/sun4i-a10-mk802.dts
@@ -86,23 +86,6 @@
 	status = "okay";
 };
 
-&pio {
-	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
-		pins = "PH4";
-		function = "gpio_in";
-	};
-
-	usb0_vbus_detect_pin: usb0_vbus_detect_pin at 0 {
-		pins = "PH5";
-		function = "gpio_in";
-	};
-
-	usb2_vbus_pin_mk802: usb2_vbus_pin at 0 {
-		pins = "PH12";
-		function = "gpio_out";
-	};
-};
-
 &reg_usb0_vbus {
 	status = "okay";
 };
@@ -112,7 +95,6 @@
 };
 
 &reg_usb2_vbus {
-	pinctrl-0 = <&usb2_vbus_pin_mk802>;
 	gpio = <&pio 7 12 GPIO_ACTIVE_HIGH>; /* PH12 */
 	status = "okay";
 };
@@ -129,8 +111,6 @@
 };
 
 &usbphy {
-	pinctrl-names = "default";
-	pinctrl-0 = <&usb0_id_detect_pin>, <&usb0_vbus_detect_pin>;
 	usb0_id_det-gpios = <&pio 7 4 GPIO_ACTIVE_HIGH>; /* PH4 */
 	usb0_vbus_det-gpios = <&pio 7 5 GPIO_ACTIVE_HIGH>; /* PH5 */
 	usb0_vbus-supply = <&reg_usb0_vbus>;
diff --git a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
index 45df067cb35f..3689b8c3b7a0 100644
--- a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
+++ b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
@@ -158,11 +158,6 @@
 };
 
 &pio {
-	ahci_pwr_pin_olinuxinolime: ahci_pwr_pin at 1 {
-		pins = "PC3";
-		function = "gpio_out";
-	};
-
 	led_pins_olinuxinolime: led_pins at 0 {
 		pins = "PH2";
 		function = "gpio_out";
@@ -183,7 +178,6 @@
 };
 
 &reg_ahci_5v {
-	pinctrl-0 = <&ahci_pwr_pin_olinuxinolime>;
 	gpio = <&pio 2 3 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/sun4i-a10-pcduino.dts b/arch/arm/boot/dts/sun4i-a10-pcduino.dts
index d19e0ddfe353..c62db1e2c115 100644
--- a/arch/arm/boot/dts/sun4i-a10-pcduino.dts
+++ b/arch/arm/boot/dts/sun4i-a10-pcduino.dts
@@ -62,8 +62,6 @@
 
 	leds {
 		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&led_pins_pcduino>;
 
 		tx {
 			label = "pcduino:green:tx";
@@ -78,8 +76,6 @@
 
 	gpio_keys {
 		compatible = "gpio-keys";
-		pinctrl-names = "default";
-		pinctrl-0 = <&key_pins_pcduino>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 
@@ -162,16 +158,6 @@
 };
 
 &pio {
-	led_pins_pcduino: led_pins at 0 {
-		pins = "PH15", "PH16";
-		function = "gpio_out";
-	};
-
-	key_pins_pcduino: key_pins at 0 {
-		pins = "PH17", "PH18", "PH19";
-		function = "gpio_in";
-	};
-
 	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
 		pins = "PH4";
 		function = "gpio_in";
diff --git a/arch/arm/boot/dts/sun4i-a10-pcduino2.dts b/arch/arm/boot/dts/sun4i-a10-pcduino2.dts
index 811d00ee2ade..bc4f128965ed 100644
--- a/arch/arm/boot/dts/sun4i-a10-pcduino2.dts
+++ b/arch/arm/boot/dts/sun4i-a10-pcduino2.dts
@@ -55,16 +55,7 @@
 	compatible = "linksprite,a10-pcduino2", "allwinner,sun4i-a10";
 };
 
-&pio {
-	usb2_vbus_pin_pcduino2: usb2_vbus_pin at 0 {
-		pins = "PD2";
-		function = "gpio_out";
-	};
-};
-
 &reg_usb2_vbus {
-	pinctrl-names = "default";
-	pinctrl-0 = <&usb2_vbus_pin_pcduino2>;
 	gpio = <&pio 3 2 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts b/arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts
index 96d100828ab4..46e485ff925b 100644
--- a/arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts
+++ b/arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts
@@ -58,8 +58,6 @@
 
 	backlight: backlight {
 		compatible = "pwm-backlight";
-		pinctrl-names = "default";
-		pinctrl-0 = <&bl_en_pin_protab>;
 		pwms = <&pwm 0 50000 PWM_POLARITY_INVERTED>;
 		brightness-levels = <0 10 20 30 40 50 60 70 80 90 100>;
 		default-brightness-level = <8>;
@@ -72,8 +70,6 @@
 };
 
 &codec {
-	pinctrl-names = "default";
-	pinctrl-0 = <&codec_pa_pin>;
 	allwinner,pa-gpios = <&pio 7 15 GPIO_ACTIVE_HIGH>; /* PH15 */
 	status = "okay";
 };
@@ -106,8 +102,6 @@
 	status = "okay";
 
 	pixcir_ts at 5c {
-		pinctrl-names = "default";
-		pinctrl-0 = <&touchscreen_pins>;
 		compatible = "pixcir,pixcir_tangoc";
 		reg = <0x5c>;
 		interrupt-parent = <&pio>;
@@ -154,21 +148,6 @@
 };
 
 &pio {
-	bl_en_pin_protab: bl_en_pin at 0 {
-		pins = "PH7";
-		function = "gpio_out";
-	};
-
-	codec_pa_pin: codec_pa_pin at 0 {
-		pins = "PH15";
-		function = "gpio_out";
-	};
-
-	touchscreen_pins: touchscreen_pins at 0 {
-		pins = "PA5", "PB13";
-		function = "gpio_out";
-	};
-
 	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
 		pins = "PH4";
 		function = "gpio_in";
-- 
git-series 0.9.1
