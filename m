From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:45:41 +0100
Subject: [PATCH 40/77] ARM: dts: sun7i: Remove card detect pull-up
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <94d897a4a9fc186a716f96c69460a4554e16b132.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Boards usually have an external pull-up on the card-detect signal, so
there's no need to add another one.

This also removes a DTC warning.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts | 10 +---------
 arch/arm/boot/dts/sun7i-a20-bananapi.dts         |  8 +-------
 arch/arm/boot/dts/sun7i-a20-bananapro.dts        | 10 +---------
 arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts        |  8 +-------
 arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts   |  8 +-------
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts  |  8 +-------
 arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts    | 16 ++--------------
 arch/arm/boot/dts/sun7i-a20-orangepi.dts         |  8 +-------
 8 files changed, 9 insertions(+), 67 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts b/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
index a0483bedb6a1..ccd7b313448e 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
@@ -175,7 +175,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_bpi_m1p>;
+	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 10 GPIO_ACTIVE_LOW>; /* PH10 */
@@ -220,14 +220,6 @@
 	status = "okay";
 };
 
-&pio {
-	mmc0_cd_pin_bpi_m1p: mmc0_cd_pin at 0 {
-		pins = "PH10";
-		function = "gpio_in";
-		bias-pull-up;
-	};
-};
-
 &reg_dcdc2 {
 	regulator-always-on;
 	regulator-min-microvolt = <1000000>;
diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi.dts b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
index c5c183a4c0d8..339c48a477f5 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapi.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
@@ -177,7 +177,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_bananapi>;
+	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 10 GPIO_ACTIVE_LOW>; /* PH10 */
@@ -253,12 +253,6 @@
 		function = "gpio_in";
 		bias-pull-up;
 	};
-
-	mmc0_cd_pin_bananapi: mmc0_cd_pin at 0 {
-		pins = "PH10";
-		function = "gpio_in";
-		bias-pull-up;
-	};
 };
 
 #include "axp209.dtsi"
diff --git a/arch/arm/boot/dts/sun7i-a20-bananapro.dts b/arch/arm/boot/dts/sun7i-a20-bananapro.dts
index f442caf91435..a4c0a38e1262 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapro.dts
@@ -149,7 +149,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_bananapro>;
+	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 10 GPIO_ACTIVE_LOW>; /* PH10 */
@@ -182,14 +182,6 @@
 	status = "okay";
 };
 
-&pio {
-	mmc0_cd_pin_bananapro: mmc0_cd_pin at 0 {
-		pins = "PH10";
-		function = "gpio_in";
-		bias-pull-up;
-	};
-};
-
 &reg_usb1_vbus {
 	gpio = <&pio 7 0 GPIO_ACTIVE_HIGH>; /* PH0 */
 	status = "okay";
diff --git a/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts b/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
index 66bc413e846b..cccfee6add35 100644
--- a/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
+++ b/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
@@ -220,7 +220,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_lamobo_r1>;
+	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 10 GPIO_ACTIVE_LOW>; /* PH10 */
@@ -241,12 +241,6 @@
 		function = "gpio_in";
 		bias-pull-up;
 	};
-
-	mmc0_cd_pin_lamobo_r1: mmc0_cd_pin at 0 {
-		pins = "PH10";
-		function = "gpio_in";
-		bias-pull-up;
-	};
 };
 
 #include "axp209.dtsi"
diff --git a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
index f54820d9b2d9..892b84bbf357 100644
--- a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
@@ -219,7 +219,7 @@
 
 &mmc3 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc3_pins_a>, <&mmc3_cd_pin_olimex_som_evb>;
+	pinctrl-0 = <&mmc3_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 0 GPIO_ACTIVE_LOW>; /* PH0 */
@@ -244,12 +244,6 @@
 		function = "gpio_out";
 		drive-strength = <20>;
 	};
-
-	mmc3_cd_pin_olimex_som_evb: mmc3_cd_pin at 0 {
-		pins = "PH0";
-		function = "gpio_in";
-		bias-pull-up;
-	};
 };
 
 &reg_ahci_5v {
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
index 866d230593be..50e7229727a6 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
@@ -232,7 +232,7 @@
 
 &mmc3 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc3_pins_a>, <&mmc3_cd_pin_olinuxinom>;
+	pinctrl-0 = <&mmc3_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 11 GPIO_ACTIVE_LOW>; /* PH11 */
@@ -257,12 +257,6 @@
 		function = "gmac";
 	};
 
-	mmc3_cd_pin_olinuxinom: mmc3_cd_pin at 0 {
-		pins = "PH11";
-		function = "gpio_in";
-		bias-pull-up;
-	};
-
 	led_pins_olinuxino: led_pins at 0 {
 		pins = "PH2";
 		function = "gpio_out";
diff --git a/arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts b/arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts
index b45a61dea108..c138e39ac072 100644
--- a/arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts
+++ b/arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts
@@ -162,7 +162,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_orangepi>;
+	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 10 GPIO_ACTIVE_LOW>; /* PH10 */
@@ -171,7 +171,7 @@
 
 &mmc3 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc3_pins_a>, <&mmc3_cd_pin_orangepi>;
+	pinctrl-0 = <&mmc3_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 11 GPIO_ACTIVE_LOW>; /* PH11 */
@@ -188,18 +188,6 @@
 		function = "gpio_in";
 		bias-pull-up;
 	};
-
-	mmc0_cd_pin_orangepi: mmc0_cd_pin at 0 {
-		pins = "PH10";
-		function = "gpio_in";
-		bias-pull-up;
-	};
-
-	mmc3_cd_pin_orangepi: mmc3_cd_pin at 0 {
-		pins = "PH11";
-		function = "gpio_in";
-		bias-pull-up;
-	};
 };
 
 &reg_dcdc2 {
diff --git a/arch/arm/boot/dts/sun7i-a20-orangepi.dts b/arch/arm/boot/dts/sun7i-a20-orangepi.dts
index a5c5948e44f7..4f4821d6466d 100644
--- a/arch/arm/boot/dts/sun7i-a20-orangepi.dts
+++ b/arch/arm/boot/dts/sun7i-a20-orangepi.dts
@@ -128,7 +128,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_orangepi>;
+	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 10 GPIO_ACTIVE_LOW>; /* PH10 */
@@ -145,12 +145,6 @@
 		function = "gpio_in";
 		bias-pull-up;
 	};
-
-	mmc0_cd_pin_orangepi: mmc0_cd_pin at 0 {
-		pins = "PH10";
-		function = "gpio_in";
-		bias-pull-up;
-	};
 };
 
 &reg_dcdc2 {
-- 
git-series 0.9.1
