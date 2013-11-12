From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 12 Nov 2013 09:50:09 +0100
Subject: [PATCH v7 6/7] ARM: dts: imx27 phycore pinctrl
In-Reply-To: <1384246210-9257-1-git-send-email-mpa@pengutronix.de>
References: <1384246210-9257-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1384246210-9257-7-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable pinctrl for phycore devices.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts | 22 ++++++++++++++++++++++
 arch/arm/boot/dts/imx27-phytec-phycore-som.dts | 16 ++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
index ad76d88..e792469 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
@@ -19,6 +19,24 @@
 	cs-gpios = <&gpio4 28 0>, <&gpio4 27 0>;
 };
 
+&iomuxc {
+	imx27_phycore_rdk {
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
+	};
+};
+
 &sdhci2 {
 	bus-width = <4>;
 	cd-gpios = <&gpio3 29 0>;
@@ -29,11 +47,15 @@
 
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
 
diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-som.dts b/arch/arm/boot/dts/imx27-phytec-phycore-som.dts
index 648541a..56960c7 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-som.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-som.dts
@@ -135,11 +135,15 @@
 
 &fec {
 	phy-reset-gpios = <&gpio3 30 0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec1>;
 	status = "okay";
 };
 
 &i2c2 {
 	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
 	status = "okay";
 
 	at24 at 52 {
@@ -159,6 +163,18 @@
 	};
 };
 
+&iomuxc {
+	imx27_phycard_s_som {
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
 &nfc {
 	nand-bus-width = <8>;
 	nand-ecc-mode = "hw";
-- 
1.8.4.2
