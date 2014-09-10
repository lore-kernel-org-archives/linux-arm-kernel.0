From: d.lavnikevich@sam-solutions.com (Dmitry Lavnikevich)
Date: Wed, 10 Sep 2014 16:46:45 +0300
Subject: [PATCH 1/5] ARM: dts: pbab01: move i2c pins and frequency
 configuration into pfla02
In-Reply-To: <1410356809-26179-1-git-send-email-d.lavnikevich@sam-solutions.com>
References: <1410356809-26179-1-git-send-email-d.lavnikevich@sam-solutions.com>
Message-ID: <1410356809-26179-2-git-send-email-d.lavnikevich@sam-solutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since pins and frequency are specific to module (pfla02), not base board
(pbab02), it is better to be initialized in corresponding dts file.

Signed-off-by: Dmitry Lavnikevich <d.lavnikevich@sam-solutions.com>
---
 arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi | 22 ----------------------
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi | 26 ++++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi
index 584721264121..f1bdcae5b97d 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi
@@ -28,9 +28,6 @@
 };
 
 &i2c2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c2>;
-	clock-frequency = <100000>;
 	status = "okay";
 
 	tlv320 at 18 {
@@ -55,9 +52,6 @@
 };
 
 &i2c3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c3>;
-	clock-frequency = <100000>;
 	status = "okay";
 };
 
@@ -84,19 +78,3 @@
 &usdhc3 {
 	status = "okay";
 };
-
-&iomuxc {
-	pinctrl_i2c2: i2c2grp {
-		fsl,pins = <
-			MX6QDL_PAD_EIM_EB2__I2C2_SCL		0x4001b8b1
-			MX6QDL_PAD_EIM_D16__I2C2_SDA		0x4001b8b1
-		>;
-	};
-
-	pinctrl_i2c3: i2c3grp {
-		fsl,pins = <
-			MX6QDL_PAD_EIM_D17__I2C3_SCL		0x4001b8b1
-			MX6QDL_PAD_EIM_D18__I2C3_SDA		0x4001b8b1
-		>;
-	};
-};
diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
index 2694aa84e187..a927e88ccc98 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
@@ -162,6 +162,18 @@
 	};
 };
 
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	clock-frequency = <100000>;
+};
+
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	clock-frequency = <100000>;
+};
+
 &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
@@ -235,6 +247,20 @@
 			>;
 		};
 
+		pinctrl_i2c2: i2c2grp {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_EB2__I2C2_SCL		0x4001b8b1
+				MX6QDL_PAD_EIM_D16__I2C2_SDA		0x4001b8b1
+			>;
+		};
+
+		pinctrl_i2c3: i2c3grp {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_D17__I2C3_SCL		0x4001b8b1
+				MX6QDL_PAD_EIM_D18__I2C3_SDA		0x4001b8b1
+			>;
+		};
+
 		pinctrl_uart3: uart3grp {
 			fsl,pins = <
 				MX6QDL_PAD_EIM_D24__UART3_TX_DATA	0x1b0b1
-- 
2.1.0
