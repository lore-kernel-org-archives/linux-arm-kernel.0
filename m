From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 20 Dec 2013 14:11:36 +0100
Subject: [PATCH v4 9/9] ARM: DTS: imx5* imx6*, use imx51-ssi
In-Reply-To: <1387545096-2334-1-git-send-email-mpa@pengutronix.de>
References: <1387545096-2334-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1387545096-2334-10-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

imx51-ssi and imx21-ssi are different IPs. imx51-ssi supports online
reconfiguration and needs this for correct interaction with SDMA. This
patch adds imx51-ssi before each imx21-ssi for all imx5/imx6 SoCs.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/boot/dts/imx53.dtsi   | 10 +++++++---
 arch/arm/boot/dts/imx6qdl.dtsi | 12 +++++++++---
 arch/arm/boot/dts/imx6sl.dtsi  | 12 +++++++++---
 3 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 4307e80..034b8b0 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -149,7 +149,9 @@
 				};
 
 				ssi2: ssi at 50014000 {
-					compatible = "fsl,imx53-ssi", "fsl,imx21-ssi";
+					compatible = "fsl,imx53-ssi",
+							"fsl,imx51-ssi",
+							"fsl,imx21-ssi";
 					reg = <0x50014000 0x4000>;
 					interrupts = <30>;
 					clocks = <&clks 49>;
@@ -1049,7 +1051,8 @@
 			};
 
 			ssi1: ssi at 63fcc000 {
-				compatible = "fsl,imx53-ssi", "fsl,imx21-ssi";
+				compatible = "fsl,imx53-ssi", "fsl,imx51-ssi",
+						"fsl,imx21-ssi";
 				reg = <0x63fcc000 0x4000>;
 				interrupts = <29>;
 				clocks = <&clks 48>;
@@ -1076,7 +1079,8 @@
 			};
 
 			ssi3: ssi at 63fe8000 {
-				compatible = "fsl,imx53-ssi", "fsl,imx21-ssi";
+				compatible = "fsl,imx53-ssi", "fsl,imx51-ssi",
+						"fsl,imx21-ssi";
 				reg = <0x63fe8000 0x4000>;
 				interrupts = <96>;
 				clocks = <&clks 50>;
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 59154dc..c51440b 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -232,7 +232,9 @@
 				};
 
 				ssi1: ssi at 02028000 {
-					compatible = "fsl,imx6q-ssi","fsl,imx21-ssi";
+					compatible = "fsl,imx6q-ssi",
+							"fsl,imx51-ssi",
+							"fsl,imx21-ssi";
 					reg = <0x02028000 0x4000>;
 					interrupts = <0 46 0x04>;
 					clocks = <&clks 178>;
@@ -245,7 +247,9 @@
 				};
 
 				ssi2: ssi at 0202c000 {
-					compatible = "fsl,imx6q-ssi","fsl,imx21-ssi";
+					compatible = "fsl,imx6q-ssi",
+							"fsl,imx51-ssi",
+							"fsl,imx21-ssi";
 					reg = <0x0202c000 0x4000>;
 					interrupts = <0 47 0x04>;
 					clocks = <&clks 179>;
@@ -258,7 +262,9 @@
 				};
 
 				ssi3: ssi at 02030000 {
-					compatible = "fsl,imx6q-ssi","fsl,imx21-ssi";
+					compatible = "fsl,imx6q-ssi",
+							"fsl,imx51-ssi",
+							"fsl,imx21-ssi";
 					reg = <0x02030000 0x4000>;
 					interrupts = <0 48 0x04>;
 					clocks = <&clks 180>;
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 28558f1..1e7b712 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -195,7 +195,9 @@
 				};
 
 				ssi1: ssi at 02028000 {
-					compatible = "fsl,imx6sl-ssi","fsl,imx21-ssi";
+					compatible = "fsl,imx6sl-ssi",
+							"fsl,imx51-ssi",
+							"fsl,imx21-ssi";
 					reg = <0x02028000 0x4000>;
 					interrupts = <0 46 0x04>;
 					clocks = <&clks IMX6SL_CLK_SSI1>;
@@ -207,7 +209,9 @@
 				};
 
 				ssi2: ssi at 0202c000 {
-					compatible = "fsl,imx6sl-ssi","fsl,imx21-ssi";
+					compatible = "fsl,imx6sl-ssi",
+							"fsl,imx51-ssi",
+							"fsl,imx21-ssi";
 					reg = <0x0202c000 0x4000>;
 					interrupts = <0 47 0x04>;
 					clocks = <&clks IMX6SL_CLK_SSI2>;
@@ -219,7 +223,9 @@
 				};
 
 				ssi3: ssi at 02030000 {
-					compatible = "fsl,imx6sl-ssi","fsl,imx21-ssi";
+					compatible = "fsl,imx6sl-ssi",
+							"fsl,imx51-ssi",
+							"fsl,imx21-ssi";
 					reg = <0x02030000 0x4000>;
 					interrupts = <0 48 0x04>;
 					clocks = <&clks IMX6SL_CLK_SSI3>;
-- 
1.8.5.1
