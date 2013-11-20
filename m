From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 20 Nov 2013 10:04:22 +0100
Subject: [PATCH 8/8] ARM: DTS: imx5* imx6*, use imx50-ssi
In-Reply-To: <1384938262-20554-1-git-send-email-mpa@pengutronix.de>
References: <1384938262-20554-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1384938262-20554-9-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

imx50-ssi and imx21-ssi are different IPs. imx50-ssi supports online
reconfiguration and needs this for correct interaction with SDMA. This
patch adds imx50-ssi before each imx21-ssi for all imx5/imx6 SoCs.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/boot/dts/imx51.dtsi   | 10 +++++++---
 arch/arm/boot/dts/imx53.dtsi   | 10 +++++++---
 arch/arm/boot/dts/imx6qdl.dtsi | 12 +++++++++---
 arch/arm/boot/dts/imx6sl.dtsi  | 12 +++++++++---
 4 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 54cee65..706bdf3 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -150,7 +150,9 @@
 				};
 
 				ssi2: ssi at 70014000 {
-					compatible = "fsl,imx51-ssi", "fsl,imx21-ssi";
+					compatible = "fsl,imx51-ssi",
+							"fsl,imx50-ssi",
+							"fsl,imx21-ssi";
 					reg = <0x70014000 0x4000>;
 					interrupts = <30>;
 					clocks = <&clks 49>;
@@ -427,7 +429,8 @@
 			};
 
 			ssi1: ssi at 83fcc000 {
-				compatible = "fsl,imx51-ssi", "fsl,imx21-ssi";
+				compatible = "fsl,imx51-ssi", "fsl,imx50-ssi",
+						"fsl,imx21-ssi";
 				reg = <0x83fcc000 0x4000>;
 				interrupts = <29>;
 				clocks = <&clks 48>;
@@ -479,7 +482,8 @@
 			};
 
 			ssi3: ssi at 83fe8000 {
-				compatible = "fsl,imx51-ssi", "fsl,imx21-ssi";
+				compatible = "fsl,imx51-ssi", "fsl,imx50-ssi",
+						"fsl,imx21-ssi";
 				reg = <0x83fe8000 0x4000>;
 				interrupts = <96>;
 				clocks = <&clks 50>;
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 4307e80..1f5c622 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -149,7 +149,9 @@
 				};
 
 				ssi2: ssi at 50014000 {
-					compatible = "fsl,imx53-ssi", "fsl,imx21-ssi";
+					compatible = "fsl,imx53-ssi",
+							"fsl,imx50-ssi",
+							"fsl,imx21-ssi";
 					reg = <0x50014000 0x4000>;
 					interrupts = <30>;
 					clocks = <&clks 49>;
@@ -1049,7 +1051,8 @@
 			};
 
 			ssi1: ssi at 63fcc000 {
-				compatible = "fsl,imx53-ssi", "fsl,imx21-ssi";
+				compatible = "fsl,imx53-ssi", "fsl,imx50-ssi",
+						"fsl,imx21-ssi";
 				reg = <0x63fcc000 0x4000>;
 				interrupts = <29>;
 				clocks = <&clks 48>;
@@ -1076,7 +1079,8 @@
 			};
 
 			ssi3: ssi at 63fe8000 {
-				compatible = "fsl,imx53-ssi", "fsl,imx21-ssi";
+				compatible = "fsl,imx53-ssi", "fsl,imx50-ssi",
+						"fsl,imx21-ssi";
 				reg = <0x63fe8000 0x4000>;
 				interrupts = <96>;
 				clocks = <&clks 50>;
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index ccd55c2..26dc080 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -201,7 +201,9 @@
 				};
 
 				ssi1: ssi at 02028000 {
-					compatible = "fsl,imx6q-ssi","fsl,imx21-ssi";
+					compatible = "fsl,imx6q-ssi",
+							"fsl,imx50-ssi",
+							"fsl,imx21-ssi";
 					reg = <0x02028000 0x4000>;
 					interrupts = <0 46 0x04>;
 					clocks = <&clks 178>;
@@ -214,7 +216,9 @@
 				};
 
 				ssi2: ssi at 0202c000 {
-					compatible = "fsl,imx6q-ssi","fsl,imx21-ssi";
+					compatible = "fsl,imx6q-ssi",
+							"fsl,imx50-ssi",
+							"fsl,imx21-ssi";
 					reg = <0x0202c000 0x4000>;
 					interrupts = <0 47 0x04>;
 					clocks = <&clks 179>;
@@ -227,7 +231,9 @@
 				};
 
 				ssi3: ssi at 02030000 {
-					compatible = "fsl,imx6q-ssi","fsl,imx21-ssi";
+					compatible = "fsl,imx6q-ssi",
+							"fsl,imx50-ssi",
+							"fsl,imx21-ssi";
 					reg = <0x02030000 0x4000>;
 					interrupts = <0 48 0x04>;
 					clocks = <&clks 180>;
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index c46651e..22cec8b 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -191,7 +191,9 @@
 				};
 
 				ssi1: ssi at 02028000 {
-					compatible = "fsl,imx6sl-ssi","fsl,imx21-ssi";
+					compatible = "fsl,imx6sl-ssi",
+							"fsl,imx50-ssi",
+							"fsl,imx21-ssi";
 					reg = <0x02028000 0x4000>;
 					interrupts = <0 46 0x04>;
 					clocks = <&clks IMX6SL_CLK_SSI1>;
@@ -203,7 +205,9 @@
 				};
 
 				ssi2: ssi at 0202c000 {
-					compatible = "fsl,imx6sl-ssi","fsl,imx21-ssi";
+					compatible = "fsl,imx6sl-ssi",
+							"fsl,imx50-ssi",
+							"fsl,imx21-ssi";
 					reg = <0x0202c000 0x4000>;
 					interrupts = <0 47 0x04>;
 					clocks = <&clks IMX6SL_CLK_SSI2>;
@@ -215,7 +219,9 @@
 				};
 
 				ssi3: ssi at 02030000 {
-					compatible = "fsl,imx6sl-ssi","fsl,imx21-ssi";
+					compatible = "fsl,imx6sl-ssi",
+							"fsl,imx50-ssi",
+							"fsl,imx21-ssi";
 					reg = <0x02030000 0x4000>;
 					interrupts = <0 48 0x04>;
 					clocks = <&clks IMX6SL_CLK_SSI3>;
-- 
1.8.4.2
