From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:45:29 +0100
Subject: [PATCH 28/77] ARM: dts: sun6i: Remove all useless pinctrl nodes
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <af84d92ced266a1f2e8eefb194abc5f813884c91.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gpio pinctrl nodes are redundant and as such useless most of the times.
Since they will also generate warnings in DTC, we can simply remove most of
them.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun6i-a31-app4-evb1.dts        |  8 +------
 arch/arm/boot/dts/sun6i-a31-colombus.dts         |  7 +-----
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts      | 13 +---------
 arch/arm/boot/dts/sun6i-a31-i7.dts               | 14 +----------
 arch/arm/boot/dts/sun6i-a31-m9.dts               | 14 +----------
 arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts | 14 +----------
 arch/arm/boot/dts/sun6i-a31s-primo81.dts         |  7 +-----
 arch/arm/boot/dts/sun6i-a31s-sina31s.dts         |  7 +-----
 arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts | 23 +-----------------
 9 files changed, 3 insertions(+), 104 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31-app4-evb1.dts b/arch/arm/boot/dts/sun6i-a31-app4-evb1.dts
index 7f34323a668c..f26b84b61daf 100644
--- a/arch/arm/boot/dts/sun6i-a31-app4-evb1.dts
+++ b/arch/arm/boot/dts/sun6i-a31-app4-evb1.dts
@@ -65,15 +65,7 @@
 	status = "okay";
 };
 
-&pio {
-	usb1_vbus_pin_a: usb1_vbus_pin at 0 {
-		pins = "PH27";
-		function = "gpio_out";
-	};
-};
-
 &reg_usb1_vbus {
-	pinctrl-0 = <&usb1_vbus_pin_a>;
 	gpio = <&pio 7 27 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/sun6i-a31-colombus.dts b/arch/arm/boot/dts/sun6i-a31-colombus.dts
index 939c497a6f70..557d4a988d9a 100644
--- a/arch/arm/boot/dts/sun6i-a31-colombus.dts
+++ b/arch/arm/boot/dts/sun6i-a31-colombus.dts
@@ -132,11 +132,6 @@
 		bias-pull-up;
 	};
 
-	usb2_vbus_pin_colombus: usb2_vbus_pin at 0 {
-		pins = "PH24";
-		function = "gpio_out";
-	};
-
 	i2c_lcd_pins: i2c_lcd_pin at 0 {
 		pins = "PA23", "PA24";
 		function = "gpio_out";
@@ -145,8 +140,6 @@
 };
 
 &reg_usb2_vbus {
-	pinctrl-names = "default";
-	pinctrl-0 = <&usb2_vbus_pin_colombus>;
 	gpio = <&pio 7 24 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
index 4eab94737203..a55291538c59 100644
--- a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
+++ b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
@@ -152,7 +152,7 @@
 
 &gmac {
 	pinctrl-names = "default";
-	pinctrl-0 = <&gmac_pins_rgmii_a>, <&gmac_phy_reset_pin_hummingbird>;
+	pinctrl-0 = <&gmac_pins_rgmii_a>;
 	phy = <&phy1>;
 	phy-mode = "rgmii";
 	snps,reset-gpio = <&pio 0 21 GPIO_ACTIVE_HIGH>;
@@ -221,7 +221,7 @@
 
 &mmc1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins_a>, <&wifi_reset_pin_hummingbird>;
+	pinctrl-0 = <&mmc1_pins_a>;
 	vmmc-supply = <&reg_aldo1>;
 	mmc-pwrseq = <&wifi_pwrseq>;
 	bus-width = <4>;
@@ -234,21 +234,12 @@
 };
 
 &pio {
-	gmac_phy_reset_pin_hummingbird: gmac_phy_reset_pin at 0 {
-		pins = "PA21";
-		function = "gpio_out";
-	};
-
 	mmc0_cd_pin_hummingbird: mmc0_cd_pin at 0 {
 		pins = "PA8";
 		function = "gpio_in";
 		bias-pull-up;
 	};
 
-	wifi_reset_pin_hummingbird: wifi_reset_pin at 0 {
-		pins = "PG10";
-		function = "gpio_out";
-	};
 };
 
 &p2wi {
diff --git a/arch/arm/boot/dts/sun6i-a31-i7.dts b/arch/arm/boot/dts/sun6i-a31-i7.dts
index d659be9dbc50..679f0fa7e50c 100644
--- a/arch/arm/boot/dts/sun6i-a31-i7.dts
+++ b/arch/arm/boot/dts/sun6i-a31-i7.dts
@@ -71,8 +71,6 @@
 
 	leds {
 		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&led_pins_i7>;
 
 		blue {
 			label = "i7:blue:usr";
@@ -154,26 +152,14 @@
 };
 
 &pio {
-	led_pins_i7: led_pins at 0 {
-		pins = "PH13";
-		function = "gpio_out";
-	};
-
 	mmc0_cd_pin_i7: mmc0_cd_pin at 0 {
 		pins = "PH22";
 		function = "gpio_in";
 		bias-pull-up;
 	};
-
-	usb1_vbus_pin_i7: usb1_vbus_pin at 0 {
-		pins = "PC27";
-		function = "gpio_out";
-	};
 };
 
 &reg_usb1_vbus {
-	pinctrl-names = "default";
-	pinctrl-0 = <&usb1_vbus_pin_i7>;
 	gpio = <&pio 2 27 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/sun6i-a31-m9.dts b/arch/arm/boot/dts/sun6i-a31-m9.dts
index 9698f6d38d03..87ae3031aa89 100644
--- a/arch/arm/boot/dts/sun6i-a31-m9.dts
+++ b/arch/arm/boot/dts/sun6i-a31-m9.dts
@@ -60,8 +60,6 @@
 
 	leds {
 		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&led_pins_m9>;
 
 		blue {
 			label = "m9:blue:pwr";
@@ -125,21 +123,11 @@
 #include "axp22x.dtsi"
 
 &pio {
-	led_pins_m9: led_pins at 0 {
-		pins = "PH13";
-		function = "gpio_out";
-	};
-
 	mmc0_cd_pin_m9: mmc0_cd_pin at 0 {
 		pins = "PH22";
 		function = "gpio_in";
 		bias-pull-up;
 	};
-
-	usb1_vbus_pin_m9: usb1_vbus_pin at 0 {
-		pins = "PC27";
-		function = "gpio_out";
-	};
 };
 
 &reg_aldo1 {
@@ -215,8 +203,6 @@
 };
 
 &reg_usb1_vbus {
-	pinctrl-names = "default";
-	pinctrl-0 = <&usb1_vbus_pin_m9>;
 	gpio = <&pio 2 27 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts b/arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts
index bb14b171b160..0711f55945e0 100644
--- a/arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts
+++ b/arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts
@@ -60,8 +60,6 @@
 
 	leds {
 		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&led_pins_m9>;
 
 		blue {
 			label = "a1000g:blue:pwr";
@@ -125,21 +123,11 @@
 #include "axp22x.dtsi"
 
 &pio {
-	led_pins_m9: led_pins at 0 {
-		pins = "PH13";
-		function = "gpio_out";
-	};
-
 	mmc0_cd_pin_m9: mmc0_cd_pin at 0 {
 		pins = "PH22";
 		function = "gpio_in";
 		bias-pull-up;
 	};
-
-	usb1_vbus_pin_m9: usb1_vbus_pin at 0 {
-		pins = "PC27";
-		function = "gpio_out";
-	};
 };
 
 &reg_aldo1 {
@@ -215,8 +203,6 @@
 };
 
 &reg_usb1_vbus {
-	pinctrl-names = "default";
-	pinctrl-0 = <&usb1_vbus_pin_m9>;
 	gpio = <&pio 2 27 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/sun6i-a31s-primo81.dts b/arch/arm/boot/dts/sun6i-a31s-primo81.dts
index ca1c711ed450..dd6ede6a8377 100644
--- a/arch/arm/boot/dts/sun6i-a31s-primo81.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-primo81.dts
@@ -101,8 +101,6 @@
 	status = "okay";
 
 	ctp at 5d {
-		pinctrl-names = "default";
-		pinctrl-0 = <&gt911_int_primo81>;
 		compatible = "goodix,gt911";
 		reg = <0x5d>;
 		interrupt-parent = <&pio>;
@@ -156,11 +154,6 @@
 };
 
 &pio {
-	gt911_int_primo81: gt911_int_pin at 0 {
-		pins = "PA3";
-		function = "gpio_in";
-	};
-
 	mma8452_int_primo81: mma8452_int_pin at 0 {
 		pins = "PA9";
 		function = "gpio_in";
diff --git a/arch/arm/boot/dts/sun6i-a31s-sina31s.dts b/arch/arm/boot/dts/sun6i-a31s-sina31s.dts
index 3a7e68c46ba7..1b07a950cb45 100644
--- a/arch/arm/boot/dts/sun6i-a31s-sina31s.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-sina31s.dts
@@ -66,8 +66,6 @@
 
 	leds {
 		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&led_pin_sina31s>;
 
 		status {
 			label = "sina31s:status:usr";
@@ -176,11 +174,6 @@
 };
 
 &pio {
-	led_pin_sina31s: led_pin at 0 {
-		pins = "PH13";
-		function = "gpio_out";
-	};
-
 	mmc0_cd_pin_sina31s: mmc0_cd_pin at 0 {
 		pins = "PA4";
 		function = "gpio_in";
diff --git a/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts b/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
index b8b79c0e9ee0..ea29af15125b 100644
--- a/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
@@ -58,8 +58,6 @@
 
 	leds {
 		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&led_pins_bpi_m2>;
 
 		blue {
 			label = "bpi-m2:blue:usr";
@@ -79,8 +77,6 @@
 
 	mmc2_pwrseq: mmc2_pwrseq {
 		compatible = "mmc-pwrseq-simple";
-		pinctrl-names = "default";
-		pinctrl-0 = <&mmc2_pwrseq_pin_bpi_m2>;
 		reset-gpios = <&r_pio 0 8 GPIO_ACTIVE_LOW>; /* PL8 WIFI_EN */
 	};
 };
@@ -95,7 +91,7 @@
 
 &gmac {
 	pinctrl-names = "default";
-	pinctrl-0 = <&gmac_pins_rgmii_a>, <&gmac_phy_reset_pin_bpi_m2>;
+	pinctrl-0 = <&gmac_pins_rgmii_a>;
 	phy = <&phy1>;
 	phy-mode = "rgmii";
 	phy-supply = <&reg_dldo1>;
@@ -168,16 +164,6 @@
 };
 
 &pio {
-	gmac_phy_reset_pin_bpi_m2: gmac_phy_reset_pin at 0 {
-		pins = "PA21";
-		function = "gpio_out";
-	};
-
-	led_pins_bpi_m2: led_pins at 0 {
-		pins = "PG5", "PG10", "PG11";
-		function = "gpio_out";
-	};
-
 	mmc0_cd_pin_bpi_m2: mmc0_cd_pin at 0 {
 		pins = "PA4";
 		function = "gpio_in";
@@ -185,13 +171,6 @@
 	};
 };
 
-&r_pio {
-	mmc2_pwrseq_pin_bpi_m2: mmc2_pwrseq_pin at 0 {
-		pins = "PL8";
-		function = "gpio_out";
-	};
-};
-
 #include "axp22x.dtsi"
 
 &reg_aldo1 {
-- 
git-series 0.9.1
