From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 17 Jul 2018 06:38:02 +0300
Subject: [PATCH 1/2] ARM: dts: hummingboard2: describe optional rs485
Message-ID: <8c90900a5d7538d26ec93287ca4787c1dd97fbce.1531798683.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A Hummingboard assembly option provides RS-485 transceiver on UART2
(/dev/ttymxc1). Add DT node for that. Keep it disabled, since RS-485 is
not assembled by default.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
index c413f9c3540f..576437936a60 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
@@ -501,6 +501,14 @@
 			>;
 		};
 
+		pinctrl_hummingboard2_uart2: hummingboard2-uart2 {
+			fsl,pins = <
+				MX6QDL_PAD_SD4_DAT4__UART2_RX_DATA	0x1b0b1
+				MX6QDL_PAD_SD4_DAT7__UART2_TX_DATA	0x1b0b1
+				MX6QDL_PAD_SD4_DAT6__UART2_CTS_B	0x1b0b1
+			>;
+		};
+
 		pinctrl_hummingboard2_uart3: hummingboard2-uart3 {
 			fsl,pins = <
 				MX6QDL_PAD_EIM_D25__UART3_TX_DATA	0x1b0b1
@@ -565,6 +573,14 @@
 	status = "okay";
 };
 
+/* Optional RS-485 transceiver */
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hummingboard2_uart2>;
+	uart-has-rtscts;
+	status = "disabled";
+};
+
 &uart3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hummingboard2_uart3>;
-- 
2.18.0
