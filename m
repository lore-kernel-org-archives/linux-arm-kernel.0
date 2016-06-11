From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 11 Jun 2016 18:49:16 -0300
Subject: [PATCH] ARM: dts: imx6qdl-sabresd: Remove regulators under
 'simple-bus'
Message-ID: <1465681756-5286-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Device-tree folks do not like the idea of placing regulators nodes
under 'simple-bus'.

Move them out of 'simple-bus'.

Also use the convention: reg_xxxx: regulator-xxxx
for the regulator names.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 78 +++++++++++++++-------------------
 1 file changed, 34 insertions(+), 44 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 5248e7b..8453721 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -22,53 +22,43 @@
 		reg = <0x10000000 0x40000000>;
 	};
 
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		reg_usb_otg_vbus: regulator at 0 {
-			compatible = "regulator-fixed";
-			reg = <0>;
-			regulator-name = "usb_otg_vbus";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			gpio = <&gpio3 22 0>;
-			enable-active-high;
-			vin-supply = <&swbst_reg>;
-		};
+	reg_usb_otg_vbus: regulator-usb-otg-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_otg_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio3 22 0>;
+		enable-active-high;
+		vin-supply = <&swbst_reg>;
+	};
 
-		reg_usb_h1_vbus: regulator at 1 {
-			compatible = "regulator-fixed";
-			reg = <1>;
-			regulator-name = "usb_h1_vbus";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			gpio = <&gpio1 29 0>;
-			enable-active-high;
-			vin-supply = <&swbst_reg>;
-		};
+	reg_usb_h1_vbus: regulator-usb-h1-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_h1_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio1 29 0>;
+		enable-active-high;
+		vin-supply = <&swbst_reg>;
+	};
 
-		reg_audio: regulator at 2 {
-			compatible = "regulator-fixed";
-			reg = <2>;
-			regulator-name = "wm8962-supply";
-			gpio = <&gpio4 10 0>;
-			enable-active-high;
-		};
+	reg_audio: regulator-audio {
+		compatible = "regulator-fixed";
+		regulator-name = "wm8962-supply";
+		gpio = <&gpio4 10 0>;
+		enable-active-high;
+	};
 
-		reg_pcie: regulator at 3 {
-			compatible = "regulator-fixed";
-			reg = <3>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_pcie_reg>;
-			regulator-name = "MPCIE_3V3";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			gpio = <&gpio3 19 0>;
-			regulator-always-on;
-			enable-active-high;
-		};
+	reg_pcie: regulator-pcie {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pcie_reg>;
+		regulator-name = "MPCIE_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio3 19 0>;
+		regulator-always-on;
+		enable-active-high;
 	};
 
 	gpio-keys {
-- 
1.9.1
