From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:45:40 +0100
Subject: [PATCH 39/77] ARM: dts: sun7i: Remove all useless pinctrl nodes
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <6fdd9b5d257601d88a8deb13727b6309c6c75fce.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gpio pinctrl nodes are redundant and as such useless most of the times.
Since they will also generate warnings in DTC, we can simply remove most of
them.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts     | 21 +-------
 arch/arm/boot/dts/sun7i-a20-bananapi.dts             | 14 +-----
 arch/arm/boot/dts/sun7i-a20-bananapro.dts            | 33 +-----------
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts          |  7 +--
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts           | 40 +-------------
 arch/arm/boot/dts/sun7i-a20-hummingbird.dts          | 28 +---------
 arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts            | 30 +----------
 arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts            | 14 +-----
 arch/arm/boot/dts/sun7i-a20-m3.dts                   |  9 +---
 arch/arm/boot/dts/sun7i-a20-mk808c.dts               | 14 +-----
 arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts       | 20 +-------
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts       |  6 +--
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts |  9 +---
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts      | 12 +----
 arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts        | 26 +--------
 arch/arm/boot/dts/sun7i-a20-orangepi.dts             | 26 +--------
 arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts        | 19 +------
 arch/arm/boot/dts/sun7i-a20-pcduino3.dts             | 14 +-----
 arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts       | 21 +-------
 arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts     |  7 +--
 20 files changed, 370 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts b/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
index 763cb03033c4..a0483bedb6a1 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
@@ -73,8 +73,6 @@
 
 	leds {
 		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&led_pins_bpi_m1p>;
 
 		green {
 			label = "bananapi-m1-plus:green:usr";
@@ -90,15 +88,11 @@
 
 	mmc3_pwrseq: mmc3_pwrseq {
 		compatible = "mmc-pwrseq-simple";
-		pinctrl-names = "default";
-		pinctrl-0 = <&mmc3_pwrseq_pin_bpi_m1p>;
 		reset-gpios = <&pio 7 22 GPIO_ACTIVE_LOW>; /* PH22 WL-PMU-EN */
 	};
 
 	reg_gmac_3v3: gmac-3v3 {
 		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&gmac_power_pin_bpi_m1p>;
 		regulator-name = "gmac-3v3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
@@ -227,26 +221,11 @@
 };
 
 &pio {
-	gmac_power_pin_bpi_m1p: gmac_power_pin at 0 {
-		pins = "PH23";
-		function = "gpio_out";
-	};
-
-	led_pins_bpi_m1p: led_pins at 0 {
-		pins = "PH24", "PH25";
-		function = "gpio_out";
-	};
-
 	mmc0_cd_pin_bpi_m1p: mmc0_cd_pin at 0 {
 		pins = "PH10";
 		function = "gpio_in";
 		bias-pull-up;
 	};
-
-	mmc3_pwrseq_pin_bpi_m1p: mmc3_pwrseq_pin at 0 {
-		pins = "PH22";
-		function = "gpio_out";
-	};
 };
 
 &reg_dcdc2 {
diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi.dts b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
index 70dfc4ac0bb5..c5c183a4c0d8 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapi.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
@@ -76,8 +76,6 @@
 
 	leds {
 		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&led_pins_bananapi>;
 
 		green {
 			label = "bananapi:green:usr";
@@ -87,8 +85,6 @@
 
 	reg_gmac_3v3: gmac-3v3 {
 		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&gmac_power_pin_bananapi>;
 		regulator-name = "gmac-3v3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
@@ -263,16 +259,6 @@
 		function = "gpio_in";
 		bias-pull-up;
 	};
-
-	gmac_power_pin_bananapi: gmac_power_pin at 0 {
-		pins = "PH23";
-		function = "gpio_out";
-	};
-
-	led_pins_bananapi: led_pins at 0 {
-		pins = "PH24";
-		function = "gpio_out";
-	};
 };
 
 #include "axp209.dtsi"
diff --git a/arch/arm/boot/dts/sun7i-a20-bananapro.dts b/arch/arm/boot/dts/sun7i-a20-bananapro.dts
index 0898eb6162f5..f442caf91435 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapro.dts
@@ -62,8 +62,6 @@
 
 	leds {
 		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&led_pins_bananapro>;
 
 		blue {
 			label = "bananapro:blue:usr";
@@ -78,15 +76,11 @@
 
 	wifi_pwrseq: wifi-pwrseq {
 		compatible = "mmc-pwrseq-simple";
-		pinctrl-names = "default";
-		pinctrl-0 = <&vmmc3_pin_bananapro>;
 		reset-gpios = <&pio 7 22 GPIO_ACTIVE_LOW>;
 	};
 
 	reg_gmac_3v3: gmac-3v3 {
 		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&gmac_power_pin_bananapro>;
 		regulator-name = "gmac-3v3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
@@ -189,46 +183,19 @@
 };
 
 &pio {
-	gmac_power_pin_bananapro: gmac_power_pin at 0 {
-		pins = "PH23";
-		function = "gpio_out";
-	};
-
-	led_pins_bananapro: led_pins at 0 {
-		pins = "PH24", "PG2";
-		function = "gpio_out";
-	};
-
 	mmc0_cd_pin_bananapro: mmc0_cd_pin at 0 {
 		pins = "PH10";
 		function = "gpio_in";
 		bias-pull-up;
 	};
-
-	usb1_vbus_pin_bananapro: usb1_vbus_pin at 0 {
-		pins = "PH0";
-		function = "gpio_out";
-	};
-
-	usb2_vbus_pin_bananapro: usb2_vbus_pin at 0 {
-		pins = "PH1";
-		function = "gpio_out";
-	};
-
-	vmmc3_pin_bananapro: vmmc3_pin at 0 {
-		pins = "PH22";
-		function = "gpio_out";
-	};
 };
 
 &reg_usb1_vbus {
-	pinctrl-0 = <&usb1_vbus_pin_bananapro>;
 	gpio = <&pio 7 0 GPIO_ACTIVE_HIGH>; /* PH0 */
 	status = "okay";
 };
 
 &reg_usb2_vbus {
-	pinctrl-0 = <&usb2_vbus_pin_bananapro>;
 	gpio = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
index 942ac9dfd4a5..849244e03f3a 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
@@ -74,8 +74,6 @@
 
 	leds {
 		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&led_pins_cubieboard2>;
 
 		blue {
 			label = "cubieboard2:blue:usr";
@@ -182,11 +180,6 @@
 };
 
 &pio {
-	led_pins_cubieboard2: led_pins at 0 {
-		pins = "PH20", "PH21";
-		function = "gpio_out";
-	};
-
 	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
 		pins = "PH4";
 		function = "gpio_in";
diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index 5649161de1d7..0adcd0aab0aa 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -74,8 +74,6 @@
 
 	leds {
 		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&led_pins_cubietruck>;
 
 		blue {
 			label = "cubietruck:blue:usr";
@@ -100,8 +98,6 @@
 
 	mmc3_pwrseq: mmc3_pwrseq {
 		compatible = "mmc-pwrseq-simple";
-		pinctrl-names = "default";
-		pinctrl-0 = <&mmc3_pwrseq_pin_cubietruck>;
 		reset-gpios = <&pio 7 9 GPIO_ACTIVE_LOW>; /* PH9 WIFI_EN */
 	};
 
@@ -245,38 +241,6 @@
 	status = "okay";
 };
 
-&pio {
-	ahci_pwr_pin_cubietruck: ahci_pwr_pin at 1 {
-		pins = "PH12";
-		function = "gpio_out";
-	};
-
-	led_pins_cubietruck: led_pins at 0 {
-		pins = "PH7", "PH11", "PH20", "PH21";
-		function = "gpio_out";
-	};
-
-	mmc3_pwrseq_pin_cubietruck: mmc3_pwrseq_pin at 0 {
-		pins = "PH9";
-		function = "gpio_out";
-	};
-
-	usb0_vbus_pin_a: usb0_vbus_pin at 0 {
-		pins = "PH17";
-		function = "gpio_out";
-	};
-
-	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
-		pins = "PH19";
-		function = "gpio_in";
-	};
-
-	usb0_vbus_detect_pin: usb0_vbus_detect_pin at 0 {
-		pins = "PH22";
-		function = "gpio_in";
-	};
-};
-
 &pwm {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pwm0_pins_a>, <&pwm1_pins_a>;
@@ -284,7 +248,6 @@
 };
 
 &reg_ahci_5v {
-	pinctrl-0 = <&ahci_pwr_pin_cubietruck>;
 	gpio = <&pio 7 12 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 };
@@ -325,7 +288,6 @@
 };
 
 &reg_usb0_vbus {
-	pinctrl-0 = <&usb0_vbus_pin_a>;
 	gpio = <&pio 7 17 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 };
@@ -360,8 +322,6 @@
 };
 
 &usbphy {
-	pinctrl-names = "default";
-	pinctrl-0 = <&usb0_id_detect_pin>, <&usb0_vbus_detect_pin>;
 	usb0_id_det-gpios = <&pio 7 19 GPIO_ACTIVE_HIGH>; /* PH19 */
 	usb0_vbus_det-gpios = <&pio 7 22 GPIO_ACTIVE_HIGH>; /* PH22 */
 	usb0_vbus_power-supply = <&usb_power_supply>;
diff --git a/arch/arm/boot/dts/sun7i-a20-hummingbird.dts b/arch/arm/boot/dts/sun7i-a20-hummingbird.dts
index 1f0e5ecbf0c4..6ba689354f22 100644
--- a/arch/arm/boot/dts/sun7i-a20-hummingbird.dts
+++ b/arch/arm/boot/dts/sun7i-a20-hummingbird.dts
@@ -67,8 +67,6 @@
 
 	reg_mmc3_vdd: mmc3_vdd {
 		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&mmc3_vdd_pin_a20_hummingbird>;
 		regulator-name = "mmc3_vdd";
 		regulator-min-microvolt = <3000000>;
 		regulator-max-microvolt = <3000000>;
@@ -78,8 +76,6 @@
 
 	reg_gmac_vdd: gmac_vdd {
 		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&gmac_vdd_pin_a20_hummingbird>;
 		regulator-name = "gmac_vdd";
 		regulator-min-microvolt = <3000000>;
 		regulator-max-microvolt = <3000000>;
@@ -184,28 +180,6 @@
 	status = "okay";
 };
 
-&pio {
-	ahci_pwr_pin_a20_hummingbird: ahci_pwr_pin at 0 {
-		pins = "PH15";
-		function = "gpio_out";
-	};
-
-	usb1_vbus_pin_a20_hummingbird: usb1_vbus_pin at 0 {
-		pins = "PH2";
-		function = "gpio_out";
-	};
-
-	mmc3_vdd_pin_a20_hummingbird: mmc3_vdd_pin at 0 {
-		pins = "PH9";
-		function = "gpio_out";
-	};
-
-	gmac_vdd_pin_a20_hummingbird: gmac_vdd_pin at 0 {
-		pins = "PH16";
-		function = "gpio_out";
-	};
-};
-
 &pwm {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pwm0_pins_a>;
@@ -213,13 +187,11 @@
 };
 
 &reg_ahci_5v {
-	pinctrl-0 = <&ahci_pwr_pin_a20_hummingbird>;
 	gpio = <&pio 7 15 GPIO_ACTIVE_HIGH>; /* PH15 */
 	status = "okay";
 };
 
 &reg_usb1_vbus {
-	pinctrl-0 = <&usb1_vbus_pin_a20_hummingbird>;
 	gpio = <&pio 7 2 GPIO_ACTIVE_HIGH>; /* PH2 */
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts b/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
index 2e3f2f29d124..fe2b827cfa76 100644
--- a/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
+++ b/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
@@ -61,8 +61,6 @@
 
 	leds {
 		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&led_pins_i12_tvbox>;
 
 		red {
 			label = "i12_tvbox:red:usr";
@@ -77,8 +75,6 @@
 
 	reg_vmmc3: vmmc3 {
 		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&vmmc3_pin_i12_tvbox>;
 		regulator-name = "vmmc3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
@@ -88,8 +84,6 @@
 
 	reg_vmmc3_io: vmmc3-io {
 		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&vmmc3_io_pin_i12_tvbox>;
 		regulator-name = "vmmc3-io";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
@@ -101,8 +95,6 @@
 
 	reg_gmac_3v3: gmac-3v3 {
 		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&gmac_power_pin_i12_tvbox>;
 		regulator-name = "gmac-3v3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
@@ -194,28 +186,6 @@
 	status = "okay";
 };
 
-&pio {
-	vmmc3_pin_i12_tvbox: vmmc3_pin at 0 {
-		pins = "PH2";
-		function = "gpio_out";
-	};
-
-	vmmc3_io_pin_i12_tvbox: vmmc3_io_pin at 0 {
-		pins = "PH12";
-		function = "gpio_out";
-	};
-
-	gmac_power_pin_i12_tvbox: gmac_power_pin at 0 {
-		pins = "PH21";
-		function = "gpio_out";
-	};
-
-	led_pins_i12_tvbox: led_pins at 0 {
-		pins = "PH9", "PH20";
-		function = "gpio_out";
-	};
-};
-
 &reg_usb1_vbus {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts b/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
index b1ab7c1c33e3..66bc413e846b 100644
--- a/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
+++ b/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
@@ -74,8 +74,6 @@
 
 	leds {
 		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&led_pins_lamobo_r1>;
 
 		green {
 			label = "lamobo_r1:green:usr";
@@ -85,8 +83,6 @@
 
 	reg_gmac_3v3: gmac-3v3 {
 		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&gmac_power_pin_lamobo_r1>;
 		regulator-name = "gmac-3v3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
@@ -251,16 +247,6 @@
 		function = "gpio_in";
 		bias-pull-up;
 	};
-
-	gmac_power_pin_lamobo_r1: gmac_power_pin at 0 {
-		pins = "PH23";
-		function = "gpio_out";
-	};
-
-	led_pins_lamobo_r1: led_pins at 0 {
-		pins = "PH24";
-		function = "gpio_out";
-	};
 };
 
 #include "axp209.dtsi"
diff --git a/arch/arm/boot/dts/sun7i-a20-m3.dts b/arch/arm/boot/dts/sun7i-a20-m3.dts
index e91a209850bc..cb8725d95e2b 100644
--- a/arch/arm/boot/dts/sun7i-a20-m3.dts
+++ b/arch/arm/boot/dts/sun7i-a20-m3.dts
@@ -63,8 +63,6 @@
 
 	leds {
 		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&led_pins_m3>;
 
 		blue {
 			label = "m3:blue:usr";
@@ -141,13 +139,6 @@
 	status = "okay";
 };
 
-&pio {
-	led_pins_m3: led_pins at 0 {
-		pins = "PH20";
-		function = "gpio_out";
-	};
-};
-
 &reg_usb1_vbus {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/sun7i-a20-mk808c.dts b/arch/arm/boot/dts/sun7i-a20-mk808c.dts
index 6109f794a9c1..a4c5da733fbc 100644
--- a/arch/arm/boot/dts/sun7i-a20-mk808c.dts
+++ b/arch/arm/boot/dts/sun7i-a20-mk808c.dts
@@ -153,18 +153,6 @@
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
-};
-
 &reg_usb0_vbus {
 	status = "okay";
 };
@@ -195,8 +183,6 @@
 };
 
 &usbphy {
-	pinctrl-names = "default";
-	pinctrl-0 = <&usb0_id_detect_pin>, <&usb0_vbus_detect_pin>;
 	usb0_id_det-gpios = <&pio 7 4 GPIO_ACTIVE_HIGH>; /* PH4 */
 	usb0_vbus_det-gpios = <&pio 7 5 GPIO_ACTIVE_HIGH>; /* PH5 */
 	usb0_vbus-supply = <&reg_usb0_vbus>;
diff --git a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
index f080f82b58ef..f54820d9b2d9 100644
--- a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
@@ -74,8 +74,6 @@
 
 	leds {
 		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&led_pins_olimex_som_evb>;
 
 		green {
 			label = "a20-olimex-som-evb:green:usr";
@@ -241,11 +239,6 @@
 };
 
 &pio {
-	ahci_pwr_pin_olimex_som_evb: ahci_pwr_pin at 1 {
-		pins = "PC3";
-		function = "gpio_out";
-	};
-
 	led_pins_olimex_som_evb: led_pins at 0 {
 		pins = "PH2";
 		function = "gpio_out";
@@ -257,20 +250,9 @@
 		function = "gpio_in";
 		bias-pull-up;
 	};
-
-	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
-		pins = "PH4";
-		function = "gpio_in";
-	};
-
-	usb0_vbus_detect_pin: usb0_vbus_detect_pin at 0 {
-		pins = "PH5";
-		function = "gpio_in";
-	};
 };
 
 &reg_ahci_5v {
-	pinctrl-0 = <&ahci_pwr_pin_olimex_som_evb>;
 	gpio = <&pio 2 3 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 };
@@ -352,8 +334,6 @@
 };
 
 &usbphy {
-	pinctrl-names = "default";
-	pinctrl-0 = <&usb0_id_detect_pin>, <&usb0_vbus_detect_pin>;
 	usb0_id_det-gpios = <&pio 7 4 GPIO_ACTIVE_HIGH>; /* PH04 */
 	usb0_vbus_det-gpios = <&pio 7 5 GPIO_ACTIVE_HIGH>; /* PH05 */
 	usb0_vbus-supply = <&reg_usb0_vbus>;
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts
index d20fd03596e9..46cd00ba8a74 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts
@@ -175,11 +175,6 @@
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
@@ -200,7 +195,6 @@
 };
 
 &reg_ahci_5v {
-	pinctrl-0 = <&ahci_pwr_pin_olinuxinolime>;
 	gpio = <&pio 2 3 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts
index 81f376f2a44d..727dffe1db05 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts
@@ -48,20 +48,11 @@
 	compatible = "olimex,a20-olinuxino-lime2-emmc", "allwinner,sun7i-a20";
 
 	mmc2_pwrseq: pwrseq {
-		pinctrl-0 = <&mmc2_pins_nrst>;
-		pinctrl-names = "default";
 		compatible = "mmc-pwrseq-emmc";
 		reset-gpios = <&pio 2 16 GPIO_ACTIVE_LOW>;
 	};
 };
 
-&pio {
-	mmc2_pins_nrst: mmc2-rst-pin {
-		pins = "PC16";
-		function = "gpio_out";
-	};
-};
-
 &mmc2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc2_pins_a>;
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
index fbdb6faffcd4..ed6f4e1e94b3 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
@@ -180,11 +180,6 @@
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
@@ -202,15 +197,9 @@
 		function = "gpio_in";
 		bias-pull-down;
 	};
-
-	usb0_vbus_pin_lime2: usb0_vbus_pin at 0 {
-		pins = "PC17";
-		function = "gpio_out";
-	};
 };
 
 &reg_ahci_5v {
-	pinctrl-0 = <&ahci_pwr_pin_olinuxinolime>;
 	gpio = <&pio 2 3 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 };
@@ -258,7 +247,6 @@
 };
 
 &reg_usb0_vbus {
-	pinctrl-0 = <&usb0_vbus_pin_lime2>;
 	gpio = <&pio 2 17 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts b/arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts
index f5c7178eb063..b45a61dea108 100644
--- a/arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts
+++ b/arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts
@@ -74,8 +74,6 @@
 
 	leds {
 		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&led_pins_orangepi>;
 
 		green {
 			label = "orangepi:green:usr";
@@ -90,8 +88,6 @@
 
 	reg_gmac_3v3: gmac-3v3 {
 		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&gmac_power_pin_orangepi>;
 		regulator-name = "gmac-3v3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
@@ -204,26 +200,6 @@
 		function = "gpio_in";
 		bias-pull-up;
 	};
-
-	usb2_vbus_pin_bananapro: usb2_vbus_pin at 0 {
-		pins = "PH22";
-		function = "gpio_out";
-	};
-
-	gmac_power_pin_orangepi: gmac_power_pin at 0 {
-		pins = "PH23";
-		function = "gpio_out";
-	};
-
-	led_pins_orangepi: led_pins at 0 {
-		pins = "PH24", "PH25";
-		function = "gpio_out";
-	};
-
-	usb1_vbus_pin_bananapro: usb1_vbus_pin at 0 {
-		pins = "PH26";
-		function = "gpio_out";
-	};
 };
 
 &reg_dcdc2 {
@@ -256,13 +232,11 @@
 };
 
 &reg_usb1_vbus {
-	pinctrl-0 = <&usb1_vbus_pin_bananapro>;
 	gpio = <&pio 7 26 GPIO_ACTIVE_HIGH>; /* PH26 */
 	status = "okay";
 };
 
 &reg_usb2_vbus {
-	pinctrl-0 = <&usb2_vbus_pin_bananapro>;
 	gpio = <&pio 7 22 GPIO_ACTIVE_HIGH>; /* PH22 */
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/sun7i-a20-orangepi.dts b/arch/arm/boot/dts/sun7i-a20-orangepi.dts
index 7a4244e57589..a5c5948e44f7 100644
--- a/arch/arm/boot/dts/sun7i-a20-orangepi.dts
+++ b/arch/arm/boot/dts/sun7i-a20-orangepi.dts
@@ -63,8 +63,6 @@
 
 	leds {
 		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&led_pins_orangepi>;
 
 		green {
 			label = "orangepi:green:usr";
@@ -74,8 +72,6 @@
 
 	reg_gmac_3v3: gmac-3v3 {
 		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&gmac_power_pin_orangepi>;
 		regulator-name = "gmac-3v3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
@@ -155,26 +151,6 @@
 		function = "gpio_in";
 		bias-pull-up;
 	};
-
-	usb2_vbus_pin_bananapro: usb2_vbus_pin at 0 {
-		pins = "PH22";
-		function = "gpio_out";
-	};
-
-	gmac_power_pin_orangepi: gmac_power_pin at 0 {
-		pins = "PH23";
-		function = "gpio_out";
-	};
-
-	led_pins_orangepi: led_pins at 0 {
-		pins = "PH24";
-		function = "gpio_out";
-	};
-
-	usb1_vbus_pin_bananapro: usb1_vbus_pin at 0 {
-		pins = "PH26";
-		function = "gpio_out";
-	};
 };
 
 &reg_dcdc2 {
@@ -207,13 +183,11 @@
 };
 
 &reg_usb1_vbus {
-	pinctrl-0 = <&usb1_vbus_pin_bananapro>;
 	gpio = <&pio 7 26 GPIO_ACTIVE_HIGH>; /* PH26 */
 	status = "okay";
 };
 
 &reg_usb2_vbus {
-	pinctrl-0 = <&usb2_vbus_pin_bananapro>;
 	gpio = <&pio 7 22 GPIO_ACTIVE_HIGH>; /* PH22 */
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts b/arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts
index bfca960b03e0..5e538a23476c 100644
--- a/arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts
+++ b/arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts
@@ -71,8 +71,6 @@
 
 	leds {
 		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&led_pins_pcduino3_nano>;
 
 		/* Marked "LED3" on the PCB. */
 		usr1 {
@@ -175,30 +173,14 @@
 };
 
 &pio {
-	ahci_pwr_pin_pcduino3_nano: ahci_pwr_pin at 0 {
-		pins = "PH2";
-		function = "gpio_out";
-	};
-
-	led_pins_pcduino3_nano: led_pins at 0 {
-		pins = "PH16", "PH15";
-		function = "gpio_out";
-	};
-
 	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
 		pins = "PH4";
 		function = "gpio_in";
 		bias-pull-up;
 	};
-
-	usb1_vbus_pin_pcduino3_nano: usb1_vbus_pin at 0 {
-		pins = "PD2";
-		function = "gpio_out";
-	};
 };
 
 &reg_ahci_5v {
-	pinctrl-0 = <&ahci_pwr_pin_pcduino3_nano>;
 	gpio = <&pio 7 2 GPIO_ACTIVE_HIGH>; /* PH2 */
 	status = "okay";
 };
@@ -232,7 +214,6 @@
 
 /* A single regulator (U24) powers both USB host ports. */
 &reg_usb1_vbus {
-	pinctrl-0 = <&usb1_vbus_pin_pcduino3_nano>;
 	gpio = <&pio 3 2 GPIO_ACTIVE_HIGH>; /* PD2 */
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/sun7i-a20-pcduino3.dts b/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
index c576f101fbde..fc5319836752 100644
--- a/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
+++ b/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
@@ -63,8 +63,6 @@
 
 	leds {
 		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&led_pins_pcduino3>;
 
 		tx {
 			label = "pcduino3:green:tx";
@@ -79,8 +77,6 @@
 
 	gpio_keys {
 		compatible = "gpio-keys";
-		pinctrl-names = "default";
-		pinctrl-0 = <&key_pins_pcduino3>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		button at 0 {
@@ -176,16 +172,6 @@
 };
 
 &pio {
-	led_pins_pcduino3: led_pins at 0 {
-		pins = "PH15", "PH16";
-		function = "gpio_out";
-	};
-
-	key_pins_pcduino3: key_pins at 0 {
-		pins = "PH17", "PH18", "PH19";
-		function = "gpio_in";
-	};
-
 	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
 		pins = "PH4";
 		function = "gpio_in";
diff --git a/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts b/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
index 8202c87ca6a3..b526890a3203 100644
--- a/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
+++ b/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
@@ -63,8 +63,6 @@
 		pwms = <&pwm 0 50000 PWM_POLARITY_INVERTED>;
 		brightness-levels = <0 10 20 30 40 50 60 70 80 90 100>;
 		default-brightness-level = <8>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&bl_enable_pin>;
 		enable-gpios = <&pio 7 7 GPIO_ACTIVE_HIGH>; /* PH7 */
 	};
 
@@ -74,8 +72,6 @@
 };
 
 &codec {
-	pinctrl-names = "default";
-	pinctrl-0 = <&codec_pa_pin>;
 	allwinner,pa-gpios = <&pio 7 15 GPIO_ACTIVE_HIGH>; /* PH15 */
 	status = "okay";
 };
@@ -122,8 +118,6 @@
 		reg = <0x5d>;
 		interrupt-parent = <&pio>;
 		interrupts = <7 21 IRQ_TYPE_EDGE_FALLING>; /* EINT21 (PH21) */
-		pinctrl-names = "default";
-		pinctrl-0 = <&ts_reset_pin>;
 		irq-gpios = <&pio 7 21 GPIO_ACTIVE_HIGH>; /* INT (PH21) */
 		reset-gpios = <&pio 1 13 GPIO_ACTIVE_HIGH>; /* RST (PB13) */
 		touchscreen-swapped-x-y;
@@ -171,21 +165,6 @@
 };
 
 &pio {
-	bl_enable_pin: bl_enable_pin at 0 {
-		pins = "PH7";
-		function = "gpio_out";
-	};
-
-	codec_pa_pin: codec_pa_pin at 0 {
-		pins = "PH15";
-		function = "gpio_out";
-	};
-
-	ts_reset_pin: ts_reset_pin at 0 {
-		pins = "PB13";
-		function = "gpio_out";
-	};
-
 	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
 		pins = "PH4";
 		function = "gpio_in";
diff --git a/arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts b/arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts
index ff5c1086585c..bf4f51160737 100644
--- a/arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts
+++ b/arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts
@@ -62,8 +62,6 @@
 
 	mmc3_pwrseq: mmc3_pwrseq {
 		compatible = "mmc-pwrseq-simple";
-		pinctrl-names = "default";
-		pinctrl-0 = <&vmmc3_pin_ap6xxx_wl_regon>;
 		reset-gpios = <&pio 7 9 GPIO_ACTIVE_LOW>; /* PH9 WIFI_EN */
 	};
 };
@@ -158,11 +156,6 @@
 };
 
 &pio {
-	vmmc3_pin_ap6xxx_wl_regon: vmmc3_pin at 0 {
-		pins = "PH9";
-		function = "gpio_out";
-	};
-
 	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
 		pins = "PH4";
 		function = "gpio_in";
-- 
git-series 0.9.1
