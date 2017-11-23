From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Thu, 23 Nov 2017 13:00:13 -0200
Subject: [PATCH 2/2] ARM: dts: imx6qdl-sabreauto: Add CEC support
In-Reply-To: <1511449213-13855-1-git-send-email-fabio.estevam@nxp.com>
References: <1511449213-13855-1-git-send-email-fabio.estevam@nxp.com>
Message-ID: <1511449213-13855-2-git-send-email-fabio.estevam@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HDMI_TX_CEC_LINE pin is used for CEC, so pass it in the device tree.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index de9bf47..82d6ccb 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -235,6 +235,8 @@
 };
 
 &hdmi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hdmi_cec>;
 	ddc-i2c-bus = <&i2c2>;
 	status = "okay";
 };
@@ -454,6 +456,12 @@
 			>;
 		};
 
+		pinctrl_hdmi_cec: hdmicecgrp {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_A25__HDMI_TX_CEC_LINE	0x1f8b0
+			>;
+		};
+
 		pinctrl_i2c2: i2c2grp {
 			fsl,pins = <
 				MX6QDL_PAD_EIM_EB2__I2C2_SCL	0x4001b8b1
-- 
2.7.4
