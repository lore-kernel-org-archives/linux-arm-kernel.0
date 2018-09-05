From: Anson.Huang@nxp.com (Anson Huang)
Date: Wed,  5 Sep 2018 16:10:29 +0800
Subject: [PATCH] ARM: dts: imx6qdl-sabreauto: add egalax touch screen support
Message-ID: <1536135029-22389-1-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add egalax touch screen support on i2c2 bus.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index 246af86..a6dc5c4 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -417,6 +417,15 @@
 		VLC-supply = <&reg_audio>;
 	};
 
+	touchscreen at 4 {
+		compatible = "eeti,egalax_ts";
+		reg = <0x04>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_egalax_int>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <28 IRQ_TYPE_EDGE_FALLING>;
+		wakeup-gpios = <&gpio2 28 GPIO_ACTIVE_HIGH>;
+	};
 };
 
 &i2c3 {
@@ -452,6 +461,12 @@
 			>;
 		};
 
+		pinctrl_egalax_int: egalax-intgrp {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_EB0__GPIO2_IO28		0xb0b1
+			>;
+		};
+
 		pinctrl_enet: enetgrp {
 			fsl,pins = <
 				MX6QDL_PAD_KEY_COL1__ENET_MDIO		0x1b0b0
-- 
2.7.4
