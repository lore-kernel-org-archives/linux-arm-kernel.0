From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 28 Oct 2013 10:00:42 +0100
Subject: [PATCH v6 7/8] ARM: dts: imx27 phycore pinctrl
In-Reply-To: <1382950843-26066-1-git-send-email-mpa@pengutronix.de>
References: <1382950843-26066-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1382950843-26066-8-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable pinctrl for phycore devices.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts | 4 ++++
 arch/arm/boot/dts/imx27-phytec-phycore-som.dts | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
index ad76d88..d4e1022 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
@@ -29,11 +29,15 @@
 
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
 
diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-som.dts b/arch/arm/boot/dts/imx27-phytec-phycore-som.dts
index 648541a..1aafc0d 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-som.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-som.dts
@@ -135,11 +135,15 @@
 
 &fec {
 	phy-reset-gpios = <&gpio3 30 0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec1_1>;
 	status = "okay";
 };
 
 &i2c2 {
 	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2_1>;
 	status = "okay";
 
 	at24 at 52 {
-- 
1.8.4.rc3
