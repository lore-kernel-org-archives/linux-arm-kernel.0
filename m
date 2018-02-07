From: joonas.kylmala@iki.fi (=?UTF-8?q?Joonas=20Kylm=C3=A4l=C3=A4?=)
Date: Wed,  7 Feb 2018 22:48:04 +0200
Subject: [PATCH v2 1/2] ARM: dts: sun8i: h3-h5: Move pinctrl of mmc0 from dts
 to dtsi
In-Reply-To: <20180207204805.16884-1-joonas.kylmala@iki.fi>
References: <20180207204805.16884-1-joonas.kylmala@iki.fi>
Message-ID: <20180207204805.16884-2-joonas.kylmala@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most of the boards use the mmc0 pins and their attributes defined in
mmc0_pins_a. Let's default to those by moving the pinctrl attributes
to the dtsi file. This makes it easier to modify device trees in the
future as there is only one place to change the pinctrl attributes.

As a side effect this patch also removes the GPIO detect
pin (mmc0_cd_pin) from pinctrl. The GPIO detect pin is already
requested and configured by mmc_gpiod_request_cd() in
drivers/mmc/core/slot-gpio.c so pinctrl is not needed.

Signed-off-by: Joonas Kylm?l? <joonas.kylmala@iki.fi>
---
 arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts  | 2 --
 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts    | 2 --
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts          | 2 --
 arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts | 2 --
 arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts      | 2 --
 arch/arm/boot/dts/sun8i-h3-nanopi.dtsi             | 2 --
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts          | 2 --
 arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts       | 2 --
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts        | 2 --
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts         | 2 --
 arch/arm/boot/dts/sunxi-h3-h5.dtsi                 | 8 ++------
 11 files changed, 2 insertions(+), 26 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
index 9a5017bb1440..f3b066ff63cb 100644
--- a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
+++ b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
@@ -112,8 +112,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
diff --git a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts b/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
index 3a196a86a984..bea49ed89cc7 100644
--- a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
@@ -136,8 +136,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
diff --git a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
index 7824f0dbf022..9fc07593e907 100644
--- a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
@@ -115,8 +115,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
diff --git a/arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts b/arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts
index d9dc14fe2aa3..d0d41eb86cb4 100644
--- a/arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts
+++ b/arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts
@@ -150,8 +150,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_vcc_io>;
 	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts
index 48563adc7430..07e2e6180792 100644
--- a/arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts
@@ -80,8 +80,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi.dtsi b/arch/arm/boot/dts/sun8i-h3-nanopi.dtsi
index e9af61394f5d..f110ee382239 100644
--- a/arch/arm/boot/dts/sun8i-h3-nanopi.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi.dtsi
@@ -96,8 +96,6 @@
 &mmc0 {
 	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
 	status = "okay";
 	vmmc-supply = <&reg_vcc3v3>;
 };
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
index 629f76b85005..ac6f52f3fa62 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
@@ -132,8 +132,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts
index 398f975b380d..82ab5b6b730b 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts
@@ -106,8 +106,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
index 40941fef4ff3..c1a8cd93c463 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
@@ -106,8 +106,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
index c4769def8cd6..537227b85935 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
@@ -128,8 +128,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 7a83b15225c7..3a0854a96a04 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -141,6 +141,8 @@
 		mmc0: mmc at 1c0f000 {
 			/* compatible and clocks are in per SoC .dtsi file */
 			reg = <0x01c0f000 0x1000>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&mmc0_pins_a>;
 			resets = <&ccu RST_BUS_MMC0>;
 			reset-names = "ahb";
 			interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
@@ -356,12 +358,6 @@
 				bias-pull-up;
 			};
 
-			mmc0_cd_pin: mmc0_cd_pin {
-				pins = "PF6";
-				function = "gpio_in";
-				bias-pull-up;
-			};
-
 			mmc1_pins_a: mmc1 {
 				pins = "PG0", "PG1", "PG2", "PG3",
 				       "PG4", "PG5";
-- 
2.11.0
