From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 19 Aug 2013 16:07:12 +0200
Subject: [PATCH v2 5/7] ARM: dts: imx27 phyCARD-S pinctrl
In-Reply-To: <1376921234-26682-1-git-send-email-mpa@pengutronix.de>
References: <1376921234-26682-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1376921234-26682-6-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable pinctrl for phyCARD-S devices.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts | 10 ++++++++++
 arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts b/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts
index 5a31c77..5709921 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts
@@ -54,6 +54,8 @@
 };
 
 &i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c_1>;
 	status = "okay";
 
 	rtc at 51 {
@@ -69,6 +71,8 @@
 };
 
 &owire {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_owire_1>;
 	status = "okay";
 };
 
@@ -79,15 +83,21 @@
 
 &uart1 {
 	fsl,uart-has-rtscts;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart_1>;
 	status = "okay";
 };
 
 &uart2 {
 	fsl,uart-has-rtscts;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart_2>;
 	status = "okay";
 };
 
 &uart3 {
 	fsl,uart-has-rtscts;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart_3>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts b/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts
index c8d57d1..3e87d28 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts
@@ -30,10 +30,14 @@
 };
 
 &fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec_1>;
 	status = "okay";
 };
 
 &i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c_2>;
 	status = "okay";
 
 	at24 at 52 {
-- 
1.8.4.rc3
