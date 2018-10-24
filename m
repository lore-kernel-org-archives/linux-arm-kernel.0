From: qiangqing.zhang@nxp.com (Joakim Zhang)
Date: Wed, 24 Oct 2018 10:25:12 +0000
Subject: [PATCH V1] ARM: dts: sabreauto: Remove reg property from fixed
 regulator
Message-ID: <20181024102255.25640-1-qiangqing.zhang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove reg property from fixed regulator as upstream has no longer
needed this property.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi | 53 ++++++++++--------------
 1 file changed, 22 insertions(+), 31 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index a6dc5c42c632..a10f0ad0bfb1 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -75,39 +75,30 @@
 		};
 	};
 
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
+	reg_audio: regulator-audio {
+		compatible = "regulator-fixed";
+		regulator-name = "cs42888_supply";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
 
-		reg_audio: regulator at 0 {
-			compatible = "regulator-fixed";
-			reg = <0>;
-			regulator-name = "cs42888_supply";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			regulator-always-on;
-		};
+	reg_usb_h1_vbus: regulator-usb-h1-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_h1_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&max7310_b 7 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
 
-		reg_usb_h1_vbus: regulator at 1 {
-			compatible = "regulator-fixed";
-			reg = <1>;
-			regulator-name = "usb_h1_vbus";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			gpio = <&max7310_b 7 GPIO_ACTIVE_HIGH>;
-			enable-active-high;
-		};
-
-		reg_usb_otg_vbus: regulator at 2 {
-			compatible = "regulator-fixed";
-			reg = <2>;
-			regulator-name = "usb_otg_vbus";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			gpio = <&max7310_c 1 GPIO_ACTIVE_HIGH>;
-			enable-active-high;
-		};
+	reg_usb_otg_vbus: regulator-usb-otg-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_otg_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&max7310_c 1 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
 	};
 
 	sound-cs42888 {
-- 
2.17.1
