From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 12 Nov 2013 09:50:07 +0100
Subject: [PATCH v7 4/7] ARM: dts: imx27 phyCARD-S pinctrl
In-Reply-To: <1384246210-9257-1-git-send-email-mpa@pengutronix.de>
References: <1384246210-9257-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1384246210-9257-5-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable pinctrl for phyCARD-S devices.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts | 43 ++++++++++++++++++++++++
 arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts | 16 +++++++++
 2 files changed, 59 insertions(+)

diff --git a/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts b/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts
index 5a31c77..5289680 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts
@@ -54,6 +54,8 @@
 };
 
 &i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
 	status = "okay";
 
 	rtc at 51 {
@@ -68,7 +70,42 @@
 	};
 };
 
+&iomuxc {
+	imx27-phycard-s-rdk {
+		pinctrl_i2c1: i2c1grp {
+			fsl,pins = <MX27_I2C2_PINGRP1>;
+		};
+
+		pinctrl_owire1: owire1grp {
+			fsl,pins = <MX27_OWIRE1_PINGRP1>;
+		};
+
+		pinctrl_uart1: uart1grp {
+			fsl,pins = <
+				MX27_UART1_PINGRP1
+				MX27_UART1_RTSCTS_PINGRP1
+			>;
+		};
+
+		pinctrl_uart2: uart2grp {
+			fsl,pins = <
+				MX27_UART2_PINGRP1
+				MX27_UART2_RTSCTS_PINGRP1
+			>;
+		};
+
+		pinctrl_uart3: uart3grp {
+			fsl,pins = <
+				MX27_UART3_PINGRP1
+				MX27_UART3_RTSCTS_PINGRP1
+			>;
+		};
+	};
+};
+
 &owire {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_owire1>;
 	status = "okay";
 };
 
@@ -79,15 +116,21 @@
 
 &uart1 {
 	fsl,uart-has-rtscts;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
 	status = "okay";
 };
 
 &uart2 {
 	fsl,uart-has-rtscts;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
 	status = "okay";
 };
 
 &uart3 {
 	fsl,uart-has-rtscts;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts b/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts
index c8d57d1..62e7fcb 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts
@@ -29,11 +29,27 @@
 	status = "okay";
 };
 
+&iomuxc {
+	imx27-phycard-s-som {
+		pinctrl_fec1: fec1grp {
+			fsl,pins = <MX27_FEC1_PINGRP1>;
+		};
+
+		pinctrl_i2c2: i2c2grp {
+			fsl,pins = <MX27_I2C2_PINGRP1>;
+		};
+	};
+};
+
 &fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec1>;
 	status = "okay";
 };
 
 &i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
 	status = "okay";
 
 	at24 at 52 {
-- 
1.8.4.2
