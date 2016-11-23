From: christopher.spinrath@rwth-aachen.de (christopher.spinrath at rwth-aachen.de)
Date: Wed, 23 Nov 2016 01:07:57 +0100
Subject: [PATCH] ARM: dts: imx6q-cm-fx6: enable S/PDIF support
Message-ID: <5da612fbab7a4064993790702550fa77@rwthex-s1-b.rwth-ad.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>

Enable the S/PDIF transceiver present on the cm-fx6 module.

Signed-off-by: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>
---
 arch/arm/boot/dts/imx6q-cm-fx6.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-cm-fx6.dts b/arch/arm/boot/dts/imx6q-cm-fx6.dts
index cad1dc5..42b1031 100644
--- a/arch/arm/boot/dts/imx6q-cm-fx6.dts
+++ b/arch/arm/boot/dts/imx6q-cm-fx6.dts
@@ -89,6 +89,14 @@
 		gpio = <&gpio3 22 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
+
+	sound-spdif {
+		compatible = "fsl,imx-audio-spdif";
+		model = "imx-spdif";
+		spdif-controller = <&spdif>;
+		spdif-out;
+		spdif-in;
+	};
 };
 
 &cpu0 {
@@ -222,6 +230,13 @@
 		>;
 	};
 
+	pinctrl_spdif: spdifgrp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_16__SPDIF_IN  0x1b0b0
+			MX6QDL_PAD_GPIO_19__SPDIF_OUT 0x1b0b0
+		>;
+	};
+
 	pinctrl_uart4: uart4grp {
 		fsl,pins = <
 			MX6QDL_PAD_KEY_COL0__UART4_TX_DATA	0x1b0b1
@@ -259,6 +274,12 @@
 	status = "okay";
 };
 
+&spdif {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spdif>;
+	status = "okay";
+};
+
 &uart4 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart4>;
-- 
2.10.2
