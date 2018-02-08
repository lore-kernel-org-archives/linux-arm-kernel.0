From: joonas.kylmala@iki.fi (=?UTF-8?q?Joonas=20Kylm=C3=A4l=C3=A4?=)
Date: Thu,  8 Feb 2018 14:01:39 +0200
Subject: [PATCH v3 2/4] ARM: dts: sunxi: h3-h5: Move pinctrl of mmc0 from dts
 to dtsi
In-Reply-To: <20180208120141.15780-1-joonas.kylmala@iki.fi>
References: <20180208120141.15780-1-joonas.kylmala@iki.fi>
Message-ID: <20180208120141.15780-3-joonas.kylmala@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most of the boards use the mmc0 pins and their attributes defined in
mmc0_pins_a. Let's default to those by moving the pinctrl attributes
to the dtsi file. This makes it easier to modify device trees in the
future as there is only one place to change the pinctrl attributes.

Signed-off-by: Joonas Kylm?l? <joonas.kylmala@iki.fi>
---
 arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts               | 2 --
 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts                 | 2 --
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts                       | 2 --
 arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts              | 2 --
 arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts                   | 2 --
 arch/arm/boot/dts/sun8i-h3-nanopi.dtsi                          | 2 --
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts                       | 2 --
 arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts                    | 2 --
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts                     | 2 --
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts                      | 2 --
 arch/arm/boot/dts/sunxi-h3-h5.dtsi                              | 2 ++
 arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts    | 2 --
 arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts         | 2 --
 arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts        | 2 --
 arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts      | 2 --
 arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts | 2 --
 16 files changed, 2 insertions(+), 30 deletions(-)

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
index 781270fb79c3..bea49ed89cc7 100644
--- a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
@@ -136,8 +136,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
diff --git a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
index 20bbe2d712d0..9fc07593e907 100644
--- a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
@@ -115,8 +115,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
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
index 1e2aa6bc7a7f..07e2e6180792 100644
--- a/arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts
@@ -80,8 +80,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi.dtsi b/arch/arm/boot/dts/sun8i-h3-nanopi.dtsi
index 32bf624dc59d..f110ee382239 100644
--- a/arch/arm/boot/dts/sun8i-h3-nanopi.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi.dtsi
@@ -96,8 +96,6 @@
 &mmc0 {
 	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
 	status = "okay";
 	vmmc-supply = <&reg_vcc3v3>;
 };
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
index 99bce9822cad..ac6f52f3fa62 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
@@ -132,8 +132,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts
index df444056001a..82ab5b6b730b 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts
@@ -106,8 +106,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
index 4a4236b13220..c1a8cd93c463 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
@@ -106,8 +106,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
index 583aae37694d..537227b85935 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
@@ -128,8 +128,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 6521d0f6a282..3a0854a96a04 100644
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
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
index ea1101293892..2189cfd85ea5 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
@@ -134,8 +134,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts
index f1447003ea3c..cc268a69786c 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts
@@ -126,8 +126,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
index 9e51d3a5f4e6..58505fbc2667 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
@@ -160,8 +160,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts
index 0f25c4a6f15d..586ec67f4101 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts
@@ -167,8 +167,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
index 69ac04516ddb..09f263f8cd18 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
@@ -67,8 +67,6 @@
 };
 
 &mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins_a>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>;
-- 
2.11.0
