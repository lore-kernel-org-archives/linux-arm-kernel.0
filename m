From: festevam@gmail.com (Fabio Estevam)
Date: Fri,  1 Dec 2017 17:24:38 -0200
Subject: [PATCH 05/12] ARM: dts: imx6qdl-apf6dev: Move regulators out of
 simple-bus
In-Reply-To: <1512156285-18451-1-git-send-email-festevam@gmail.com>
References: <1512156285-18451-1-git-send-email-festevam@gmail.com>
Message-ID: <1512156285-18451-5-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

It is not recommended to place regulator nodes inside simple-bus, so
move them out in order to fix the following build warnings with W=1:

arch/arm/boot/dts/imx6dl-apf6dev.dtb: Warning (simple_bus_reg): Node /regulators/3p3v missing or empty reg/ranges property
arch/arm/boot/dts/imx6dl-apf6dev.dtb: Warning (simple_bus_reg): Node /regulators/usb-h1-vbus missing or empty reg/ranges property
arch/arm/boot/dts/imx6dl-apf6dev.dtb: Warning (simple_bus_reg): Node /regulators/usb-otg-vbus missing or empty reg/ranges property

Cc: S?bastien Szymanski <sebastien.szymanski@armadeus.com>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6qdl-apf6dev.dtsi | 44 ++++++++++++++++------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-apf6dev.dtsi b/arch/arm/boot/dts/imx6qdl-apf6dev.dtsi
index 829a479..a61dd1a 100644
--- a/arch/arm/boot/dts/imx6qdl-apf6dev.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apf6dev.dtsi
@@ -111,32 +111,28 @@
 		};
 	};
 
-	regulators {
-		compatible = "simple-bus";
-
-		reg_3p3v: 3p3v {
-			compatible = "regulator-fixed";
-			regulator-name = "3P3V";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			regulator-always-on;
-		};
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "3P3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
 
-		reg_usbh1_vbus: usb-h1-vbus {
-			compatible = "regulator-fixed";
-			regulator-name = "usb_h1_vbus";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			regulator-always-on;
-		};
+	reg_usbh1_vbus: regulator-usb-h1-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_h1_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
 
-		reg_usb_otg_vbus: usb-otg-vbus {
-			compatible = "regulator-fixed";
-			regulator-name = "usb_otg_vbus";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			regulator-always-on;
-		};
+	reg_usb_otg_vbus: regulator-usb-otg-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_otg_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
 	};
 
 	sound {
-- 
2.7.4
