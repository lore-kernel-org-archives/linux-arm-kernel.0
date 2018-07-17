From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 17 Jul 2018 06:38:03 +0300
Subject: [PATCH 2/2] ARM: dts: hummingboard2: describe optional can bus
In-Reply-To: <8c90900a5d7538d26ec93287ca4787c1dd97fbce.1531798683.git.baruch@tkos.co.il>
References: <8c90900a5d7538d26ec93287ca4787c1dd97fbce.1531798683.git.baruch@tkos.co.il>
Message-ID: <f198734e0b4c8b8e64650401833de26eab9946db.1531798683.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A Hummingboard assembly option provides CAN bus connector for the i.MX6
provided FlexCAN peripheral. Keep disabled by default.

Note the conflict with HDMI pin mux.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
index 576437936a60..8b32a7abf2da 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
@@ -206,6 +206,7 @@
 	status = "okay";
 };
 
+/* Conflicts with the CAN bus option */
 &hdmi {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hummingboard2_hdmi>;
@@ -515,6 +516,13 @@
 				MX6QDL_PAD_EIM_D24__UART3_RX_DATA	0x40013000
 			>;
 		};
+
+		pinctrl_hummingboard2_flexcan1: hummingboard2-flexcan1 {
+			fsl,pins = <
+				MX6QDL_PAD_KEY_ROW2__FLEXCAN1_RX	0x1b0b1
+				MX6QDL_PAD_KEY_COL2__FLEXCAN1_TX	0x1b0b1
+			>;
+		};
 	};
 };
 
@@ -587,6 +595,13 @@
 	status = "okay";
 };
 
+/* Optional CAN bus. Conflicts with HDMI CEC. */
+&can1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hummingboard2_flexcan1>;
+	status = "disabled";
+};
+
 &vcc_3v3 {
 	vin-supply = <&v_3v2>;
 };
-- 
2.18.0
