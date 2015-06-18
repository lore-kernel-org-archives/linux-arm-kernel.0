From: tobias.doerffel@ed-chemnitz.de (Tobias Doerffel)
Date: Thu, 18 Jun 2015 10:59:30 +0200
Subject: [PATCH] ARM: dts: imx6qdl-wandboard: Add flexcan support
Message-ID: <1434617970-15627-1-git-send-email-tobias.doerffel@ed-chemnitz.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Tobias Doerffel <tobias.doerffel@ed-chemnitz.de>
---
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
index 5fb0916..531977d 100644
--- a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
@@ -62,6 +62,18 @@
 	status = "okay";
 };
 
+&can1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan1>;
+	status = "okay";
+};
+
+&can2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan2>;
+	status = "okay";
+};
+
 &hdmi {
 	ddc-i2c-bus = <&i2c1>;
 	status = "okay";
@@ -103,6 +115,20 @@
 			>;
 		};
 
+		pinctrl_flexcan1: flexcan1grp {
+			fsl,pins = <
+				MX6QDL_PAD_KEY_COL2__FLEXCAN1_TX	0x1b0b1
+				MX6QDL_PAD_KEY_ROW2__FLEXCAN1_RX	0x1b0b1
+			>;
+		};
+
+		pinctrl_flexcan2: flexcan2grp {
+			fsl,pins = <
+				MX6QDL_PAD_KEY_COL4__FLEXCAN2_TX	0x1b0b1
+				MX6QDL_PAD_KEY_ROW4__FLEXCAN2_RX	0x1b0b1
+			>;
+		};
+
 		pinctrl_enet: enetgrp {
 			fsl,pins = <
 				MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x1b0b0
-- 
1.7.10.4
