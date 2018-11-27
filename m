From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:46:06 +0100
Subject: [PATCH 65/77] ARM: dts: sunxi: reference: Move the muxing back to the
 common DTSI
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <0d7bc6062323688d22b7873e2a1fa354ab42a0af.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that all the SoCs using the tablet reference design DTSI are using the
same pinctrl naming scheme, we can move back the pinctrl phandles to the
main DTSI.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi |  8 --------
 arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi |  9 ---------
 arch/arm/boot/dts/sunxi-reference-design-tablet.dtsi |  6 +++---
 3 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi b/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi
index b046436ff773..6202aabedbfe 100644
--- a/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi
+++ b/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi
@@ -76,8 +76,6 @@
 };
 
 &i2c0 {
-	pinctrl-0 = <&i2c0_pins>;
-
 	axp209: pmic at 34 {
 		reg = <0x34>;
 		interrupts = <0>;
@@ -85,8 +83,6 @@
 };
 
 &i2c1 {
-	pinctrl-0 = <&i2c1_pins>;
-
 	/*
 	 * The gsl1680 is rated at 400KHz and it will not work reliable at
 	 * 100KHz, this has been confirmed on multiple different q8 tablets.
@@ -150,10 +146,6 @@
 	};
 };
 
-&pwm {
-	pinctrl-0 = <&pwm0_pin>;
-};
-
 &reg_dcdc2 {
 	regulator-always-on;
 	regulator-min-microvolt = <1000000>;
diff --git a/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi b/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
index 787a3121e179..0111e6c6f177 100644
--- a/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
+++ b/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
@@ -62,7 +62,6 @@
 };
 
 &i2c0 {
-	pinctrl-0 = <&i2c0_pins>;
 	/*
 	 * The gsl1680 is rated at 400KHz and it will not work reliable at
 	 * 100KHz, this has been confirmed on multiple different q8 tablets.
@@ -80,10 +79,6 @@
 	};
 };
 
-&i2c1 {
-	pinctrl-0 = <&i2c1_pins>;
-};
-
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
@@ -101,10 +96,6 @@
 	};
 };
 
-&pwm {
-	pinctrl-0 = <&pwm0_pin>;
-};
-
 &r_rsb {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/sunxi-reference-design-tablet.dtsi b/arch/arm/boot/dts/sunxi-reference-design-tablet.dtsi
index 00dc6623f30f..117198c52e1f 100644
--- a/arch/arm/boot/dts/sunxi-reference-design-tablet.dtsi
+++ b/arch/arm/boot/dts/sunxi-reference-design-tablet.dtsi
@@ -46,13 +46,13 @@
 
 &i2c0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins_a>;
+	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 };
 
 &i2c1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins_a>;
+	pinctrl-0 = <&i2c1_pins>;
 	status = "okay";
 };
 
@@ -77,6 +77,6 @@
 
 &pwm {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pwm0_pins>;
+	pinctrl-0 = <&pwm0_pin>;
 	status = "okay";
 };
-- 
git-series 0.9.1
