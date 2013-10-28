From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 28 Oct 2013 10:00:40 +0100
Subject: [PATCH v6 5/8] ARM: dts: imx27 phyCARD-S pinctrl
In-Reply-To: <1382950843-26066-1-git-send-email-mpa@pengutronix.de>
References: <1382950843-26066-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1382950843-26066-6-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable pinctrl for phyCARD-S devices.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts | 10 ++++++++++
 arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts b/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts
index 5a31c77..505e688 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts
@@ -54,6 +54,8 @@
 };
 
 &i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1_1>;
 	status = "okay";
 
 	rtc at 51 {
@@ -69,6 +71,8 @@
 };
 
 &owire {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_owire1_1>;
 	status = "okay";
 };
 
@@ -79,15 +83,21 @@
 
 &uart1 {
 	fsl,uart-has-rtscts;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1_1 &pinctrl_uart1_rtscts_1>;
 	status = "okay";
 };
 
 &uart2 {
 	fsl,uart-has-rtscts;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2_1 &pinctrl_uart2_rtscts_1>;
 	status = "okay";
 };
 
 &uart3 {
 	fsl,uart-has-rtscts;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3_1 &pinctrl_uart3_rtscts_1>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts b/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts
index c8d57d1..0cee738 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts
@@ -30,10 +30,14 @@
 };
 
 &fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec1_1>;
 	status = "okay";
 };
 
 &i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2_1>;
 	status = "okay";
 
 	at24 at 52 {
-- 
1.8.4.rc3
