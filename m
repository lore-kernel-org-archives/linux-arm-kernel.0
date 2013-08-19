From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 19 Aug 2013 16:07:13 +0200
Subject: [PATCH v2 6/7] ARM: dts: imx27 phycore pinctrl
In-Reply-To: <1376921234-26682-1-git-send-email-mpa@pengutronix.de>
References: <1376921234-26682-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1376921234-26682-7-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable pinctrl for phycore devices.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts | 2 ++
 arch/arm/boot/dts/imx27-phytec-phycore-som.dts | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
index 0fc6551..ef5172b 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
@@ -33,6 +33,8 @@
 
 &uart2 {
 	fsl,uart-has-rtscts;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart_2>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-som.dts b/arch/arm/boot/dts/imx27-phytec-phycore-som.dts
index aa70ad7..f52fb66 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-som.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-som.dts
@@ -120,11 +120,15 @@
 
 &fec {
 	phy-reset-gpios = <&gpio3 30 0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec_1>;
 	status = "okay";
 };
 
 &i2c2 {
 	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c_2>;
 	status = "okay";
 
 	at24 at 52 {
@@ -151,6 +155,8 @@
 };
 
 &uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart_1>;
 	status = "okay";
 };
 
-- 
1.8.4.rc3
