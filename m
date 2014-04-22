From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 22 Apr 2014 11:26:22 -0300
Subject: [PATCH] ARM: dts: imx6qdl-wandboard: Add HDMI support
Message-ID: <1398176782-22794-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
index bdfdf89..5c6f10c 100644
--- a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
@@ -62,6 +62,18 @@
 	status = "okay";
 };
 
+&hdmi {
+	ddc-i2c-bus = <&i2c1>;
+	status = "okay";
+};
+
+&i2c1 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+};
+
 &i2c2 {
 	clock-frequency = <100000>;
 	pinctrl-names = "default";
@@ -127,6 +139,13 @@
 			>;
 		};
 
+		pinctrl_i2c1: i2c1grp {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_D21__I2C1_SCL 		0x4001b8b1
+				MX6QDL_PAD_EIM_D28__I2C1_SDA 		0x4001b8b1
+			>;
+		};
+
 		pinctrl_i2c2: i2c2grp {
 			fsl,pins = <
 				MX6QDL_PAD_KEY_COL3__I2C2_SCL		0x4001b8b1
-- 
1.8.3.2
