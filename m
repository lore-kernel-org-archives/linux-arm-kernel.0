From: christopher.spinrath@rwth-aachen.de (christopher.spinrath at rwth-aachen.de)
Date: Wed, 20 Sep 2017 18:48:34 +0200
Subject: [PATCH] ARM: dts: imx6q-utilite-pro: add HDMI CEC pinctrl
Message-ID: <8c5150c5-3aff-4068-a548-05eb02b73138@rwthex-s3-b.rwth-ad.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>

On the Utilite Pro the CEC line is wired up to the HDMI connector.
Add the required pinctrl setting.

Signed-off-by: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>
---
 arch/arm/boot/dts/imx6q-utilite-pro.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-utilite-pro.dts b/arch/arm/boot/dts/imx6q-utilite-pro.dts
index 16d5be1aeb3c..f5d9c34b0d39 100644
--- a/arch/arm/boot/dts/imx6q-utilite-pro.dts
+++ b/arch/arm/boot/dts/imx6q-utilite-pro.dts
@@ -188,6 +188,8 @@
 /delete-node/&hdmi_mux_1;
 
 &hdmi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hdmicec>;
 	ddc-i2c-bus = <&i2c2>;
 	status = "okay";
 };
@@ -211,6 +213,12 @@
 		>;
 	};
 
+	pinctrl_hdmicec: hdmicecgrp {
+		fsl,pins = <
+			MX6QDL_PAD_KEY_ROW2__HDMI_TX_CEC_LINE 0x1f8b0
+		>;
+	};
+
 	pinctrl_hpd: hpdgrp {
 		fsl,pins = <
 			MX6QDL_PAD_GPIO_4__GPIO1_IO04 0x1b0b0
-- 
2.14.1
