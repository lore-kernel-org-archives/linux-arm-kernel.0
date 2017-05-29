From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 29 May 2017 16:00:58 -0300
Subject: [PATCH 1/3] ARM: dts: imx7d-sdb: Adjust the regulator nodes
Message-ID: <1496084460-20910-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

It is not recommended to place the regulator nodes inside 'simple-bus',
so adjust them accordingly.

The motivation for rearranging this is to make it easier to add new
regulator nodes in the future.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx7d-sdb.dts | 66 +++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 38 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index 77c400f..38944ca 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -73,47 +73,37 @@
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
-			gpio = <&gpio1 5 GPIO_ACTIVE_HIGH>;
-			enable-active-high;
-		};
+	reg_usb_otg1_vbus: regulator-usb-otg1-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_otg1_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio1 5 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
 
-		reg_usb_otg2_vbus: regulator at 1 {
-			compatible = "regulator-fixed";
-			reg = <1>;
-			regulator-name = "usb_otg2_vbus";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			gpio = <&gpio4 7 GPIO_ACTIVE_HIGH>;
-			enable-active-high;
-		};
+	reg_usb_otg2_vbus: regulator-usb-otg1-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_otg2_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio4 7 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
 
-		reg_can2_3v3: regulator at 2 {
-			compatible = "regulator-fixed";
-			reg = <2>;
-			regulator-name = "can2-3v3";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			gpio = <&gpio1 7 GPIO_ACTIVE_LOW>;
-		};
+	reg_can2_3v3: regulator-can2-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "can2-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio1 7 GPIO_ACTIVE_LOW>;
+	};
 
-		reg_vref_1v8: regulator at 3 {
-			compatible = "regulator-fixed";
-			reg = <3>;
-			regulator-name = "vref-1v8";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-		};
+	reg_vref_1v8: regulator-vref-1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "vref-1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
 	};
 };
 
-- 
2.7.4
