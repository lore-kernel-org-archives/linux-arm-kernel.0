From: marcofrk@gmail.com (Marco Franchi)
Date: Wed,  6 Dec 2017 00:53:03 -0200
Subject: [PATCH 2/3] ARM: dts: imx6sl-evk: Rearrange the regulators node
In-Reply-To: <1512528784-29288-1-git-send-email-marcofrk@gmail.com>
References: <1512528784-29288-1-git-send-email-marcofrk@gmail.com>
Message-ID: <1512528784-29288-2-git-send-email-marcofrk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is not recommended to place regulators inside "simple-bus", so move 
them out.

The motivation for doing this is to make it easier to adding new 
regulators.

Signed-off-by: Marco Franchi <marcofrk@gmail.com>
---
 arch/arm/boot/dts/imx6sl-evk.dts | 85 +++++++++++++++++-----------------------
 1 file changed, 37 insertions(+), 48 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sl-evk.dts b/arch/arm/boot/dts/imx6sl-evk.dts
index 60600b4..645a460 100644
--- a/arch/arm/boot/dts/imx6sl-evk.dts
+++ b/arch/arm/boot/dts/imx6sl-evk.dts
@@ -39,58 +39,47 @@
 		};
 	};
 
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		reg_usb_otg1_vbus: regulator at 0 {
-			compatible = "regulator-fixed";
-			reg = <0>;
-			regulator-name = "usb_otg1_vbus";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			gpio = <&gpio4 0 0>;
-			enable-active-high;
-			vin-supply = <&swbst_reg>;
-		};
+	reg_usb_otg1_vbus: regulator-usb-otg1-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_otg1_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio4 0 0>;
+		enable-active-high;
+		vin-supply = <&swbst_reg>;
+	};
 
-		reg_usb_otg2_vbus: regulator at 1 {
-			compatible = "regulator-fixed";
-			reg = <1>;
-			regulator-name = "usb_otg2_vbus";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			gpio = <&gpio4 2 0>;
-			enable-active-high;
-			vin-supply = <&swbst_reg>;
-		};
+	reg_usb_otg2_vbus: regulator-usb-otg2-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_otg2_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio4 2 0>;
+		enable-active-high;
+		vin-supply = <&swbst_reg>;
+	};
 
-		reg_aud3v: regulator at 2 {
-			compatible = "regulator-fixed";
-			reg = <2>;
-			regulator-name = "wm8962-supply-3v15";
-			regulator-min-microvolt = <3150000>;
-			regulator-max-microvolt = <3150000>;
-			regulator-boot-on;
-		};
+	reg_aud3v: regulator-aud3v {
+		compatible = "regulator-fixed";
+		regulator-name = "wm8962-supply-3v15";
+		regulator-min-microvolt = <3150000>;
+		regulator-max-microvolt = <3150000>;
+		regulator-boot-on;
+	};
 
-		reg_aud4v: regulator at 3 {
-			compatible = "regulator-fixed";
-			reg = <3>;
-			regulator-name = "wm8962-supply-4v2";
-			regulator-min-microvolt = <4325000>;
-			regulator-max-microvolt = <4325000>;
-			regulator-boot-on;
-		};
+	reg_aud4v: regulator-aud4v {
+		compatible = "regulator-fixed";
+		regulator-name = "wm8962-supply-4v2";
+		regulator-min-microvolt = <4325000>;
+		regulator-max-microvolt = <4325000>;
+		regulator-boot-on;
+	};
 
-		reg_lcd_3v3: regulator at 4 {
-			compatible = "regulator-fixed";
-			reg = <4>;
-			regulator-name = "lcd-3v3";
-			gpio = <&gpio4 3 0>;
-			enable-active-high;
-		};
+	reg_lcd_3v3: regulator-lcd-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "lcd-3v3";
+		gpio = <&gpio4 3 0>;
+		enable-active-high;
 	};
 
 	sound {
-- 
2.7.4
