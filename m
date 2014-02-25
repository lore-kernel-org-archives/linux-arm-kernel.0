From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 25 Feb 2014 15:22:11 -0300
Subject: [PATCH] ARM: dts: imx6qdl-sabresd: Add HDMI support
Message-ID: <1393352531-30793-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree support for HDMI.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Shawn,

Not sure if it is too early to submit this.

I have just tested against linux-next which contains Russell's latest patches
for imx-drm.

 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 04487cb..0757c86 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -82,7 +82,7 @@
 	imx_drm: imx-drm {
 		compatible = "fsl,imx-drm";
 		crtcs = <&ipu1 0>, <&ipu1 1>;
-		connectors = <&ldb>;
+		connectors = <&ldb>, <&hdmi>;
 	};
 
 	sound {
@@ -143,6 +143,14 @@
 	status = "okay";
 };
 
+&hdmi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sabresd_hdmi>;
+	ddc = <&i2c2>;
+	status = "okay";
+	crtcs = <&ipu1 1>;
+};
+
 &i2c1 {
 	clock-frequency = <100000>;
 	pinctrl-names = "default";
@@ -385,6 +393,13 @@
 			>;
 		};
 
+
+		pinctrl_sabresd_hdmi: sabresd-hdmi {
+			fsl,pins = <
+				MX6QDL_PAD_KEY_ROW2__HDMI_TX_CEC_LINE 0x1f8b0
+			>;
+		};
+
 		pinctrl_uart1: uart1grp {
 			fsl,pins = <
 				MX6QDL_PAD_CSI0_DAT10__UART1_TX_DATA	0x1b0b1
-- 
1.8.1.2
