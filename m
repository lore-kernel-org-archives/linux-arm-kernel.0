From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Wed, 20 Sep 2017 10:56:09 -0300
Subject: [PATCH 2/3] ARM: dts: imx6qdl-sabresd: Add CEC support
In-Reply-To: <1505915770-17136-1-git-send-email-fabio.estevam@nxp.com>
References: <1505915770-17136-1-git-send-email-fabio.estevam@nxp.com>
Message-ID: <1505915770-17136-2-git-send-email-fabio.estevam@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HDMI_TX_CEC_LINE pin is used for CEC, so pass it in the device tree.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 77f7b12..c6978b3 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -213,6 +213,8 @@
 };
 
 &hdmi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hdmi_cec>;
 	ddc-i2c-bus = <&i2c2>;
 	status = "okay";
 };
@@ -485,6 +487,12 @@
 			>;
 		};
 
+		pinctrl_hdmi_cec: hdmicecgrp {
+			fsl,pins = <
+				MX6QDL_PAD_KEY_ROW2__HDMI_TX_CEC_LINE	0x1f8b0
+			>;
+		};
+
 		pinctrl_i2c1: i2c1grp {
 			fsl,pins = <
 				MX6QDL_PAD_CSI0_DAT8__I2C1_SDA		0x4001b8b1
-- 
2.7.4
