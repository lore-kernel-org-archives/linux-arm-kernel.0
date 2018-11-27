From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:46:03 +0100
Subject: [PATCH 62/77] ARM: dts: sun8i: a23/a33: Remove card detect pull-up
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <7e71c2b672d2a007a6a98bfa0945da402e31c8ed.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Boards usually have an external pull-up on the card-detect signal, so
there's no need to add another one.

This also removes a DTC warning.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun8i-a23-evb.dts                  | 10 +---------
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts       | 10 +---------
 arch/arm/boot/dts/sun8i-r16-parrot.dts               |  8 +-------
 arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi |  8 +-------
 4 files changed, 4 insertions(+), 32 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a23-evb.dts b/arch/arm/boot/dts/sun8i-a23-evb.dts
index b6aeb23b6ee9..3c994df0ffdf 100644
--- a/arch/arm/boot/dts/sun8i-a23-evb.dts
+++ b/arch/arm/boot/dts/sun8i-a23-evb.dts
@@ -104,21 +104,13 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_evb>;
+	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_vcc3v0>;
 	bus-width = <4>;
 	cd-gpios = <&pio 1 4 GPIO_ACTIVE_LOW>; /* PB4 */
 	status = "okay";
 };
 
-&pio {
-	mmc0_cd_pin_evb: mmc0_cd_pin at 0 {
-		pins = "PB4";
-		function = "gpio_in";
-		bias-pull-up;
-	};
-};
-
 /*
  * The RX line has a non-populated resistance. In order to use it, you
  * need to solder R207 on the back of the board in order to close the
diff --git a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
index a2b8948393fc..035c4d8006cd 100644
--- a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
+++ b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
@@ -134,7 +134,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_sina33>;
+	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
 	cd-gpios = <&pio 1 4 GPIO_ACTIVE_LOW>; /* PB4 */
@@ -155,14 +155,6 @@
 	status = "okay";
 };
 
-&pio {
-	mmc0_cd_pin_sina33: mmc0_cd_pin at 0 {
-		pins = "PB4";
-		function = "gpio_in";
-		bias-pull-up;
-	};
-};
-
 &r_rsb {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/sun8i-r16-parrot.dts b/arch/arm/boot/dts/sun8i-r16-parrot.dts
index ffb3a5b6b043..0465863743c2 100644
--- a/arch/arm/boot/dts/sun8i-r16-parrot.dts
+++ b/arch/arm/boot/dts/sun8i-r16-parrot.dts
@@ -127,7 +127,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_parrot>;
+	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_dcdc1>;
 	cd-gpios = <&pio 3 14 GPIO_ACTIVE_LOW>; /* PD14 */
 	bus-width = <4>;
@@ -159,12 +159,6 @@
 };
 
 &pio {
-	mmc0_cd_pin_parrot: mmc0_cd_pin at 0 {
-		pins = "PD14";
-		function = "gpio_in";
-		bias-pull-up;
-	};
-
 	usb0_id_det: usb0_id_detect_pin at 0 {
 		pins = "PD10";
 		function = "gpio_in";
diff --git a/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi b/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
index c5f0f2e627bf..6838bce7dd4e 100644
--- a/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
+++ b/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
@@ -81,7 +81,7 @@
 
 &mmc0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
+	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
 	cd-gpios = <&pio 1 4 GPIO_ACTIVE_LOW>; /* PB4 */
@@ -89,12 +89,6 @@
 };
 
 &pio {
-	mmc0_cd_pin: mmc0_cd_pin at 0 {
-		pins = "PB4";
-		function = "gpio_in";
-		bias-pull-up;
-	};
-
 	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
 		pins = "PH8";
 		function = "gpio_in";
-- 
git-series 0.9.1
