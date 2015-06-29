From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 29 Jun 2015 10:05:42 -0300
Subject: [PATCH 1/2] ARM: dts: imx6sl-warp: Add changes for rev1.12
Message-ID: <1435583143-4734-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Warp board rev1.12 is the version of the hardware that will be publicly
available for the customers.

It uses UART5 as the Bluetooth serial port as well as some
additional signals for HOSTWAKE on Wifi and Bluetooth.

Make the changes to support the rev1.12 hardware.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6sl-warp.dts | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sl-warp.dts b/arch/arm/boot/dts/imx6sl-warp.dts
index 401a6b3..10c6996 100644
--- a/arch/arm/boot/dts/imx6sl-warp.dts
+++ b/arch/arm/boot/dts/imx6sl-warp.dts
@@ -61,7 +61,9 @@
 	usdhc3_pwrseq: usdhc3_pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&gpio4 5 GPIO_ACTIVE_LOW>, 	/* WL_REG_ON */
+			      <&gpio4 7 GPIO_ACTIVE_LOW>, 	/* WL_HOSTWAKE */
 			      <&gpio3 25 GPIO_ACTIVE_LOW>, 	/* BT_REG_ON */
+			      <&gpio3 27 GPIO_ACTIVE_LOW>,	/* BT_HOSTWAKE */
 			      <&gpio4 4 GPIO_ACTIVE_LOW>, 	/* BT_WAKE */
 			      <&gpio4 6 GPIO_ACTIVE_LOW>; 	/* BT_RST_N */
 	};
@@ -73,16 +75,16 @@
 	status = "okay";
 };
 
-&uart2 {
+&uart3 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart2>;
-	fsl,uart-has-rtscts;
+	pinctrl-0 = <&pinctrl_uart3>;
 	status = "okay";
 };
 
-&uart3 {
+&uart5 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart3>;
+	pinctrl-0 = <&pinctrl_uart5>;
+	fsl,uart-has-rtscts;
 	status = "okay";
 };
 
@@ -130,14 +132,6 @@
 			>;
 		};
 
-		pinctrl_uart2: uart2grp {
-			fsl,pins = <
-				MX6SL_PAD_EPDC_D12__UART2_RX_DATA	0x41b0b1
-				MX6SL_PAD_EPDC_D13__UART2_TX_DATA	0x41b0b1
-				MX6SL_PAD_EPDC_D14__UART2_RTS_B		0x4130B1
-				MX6SL_PAD_EPDC_D15__UART2_CTS_B		0x4130B1
-			>;
-		};
 
 		pinctrl_uart3: uart3grp {
 			fsl,pins = <
@@ -146,6 +140,15 @@
 			>;
 		};
 
+		pinctrl_uart5: uart5grp {
+			fsl,pins = <
+				MX6SL_PAD_ECSPI1_SCLK__UART5_RX_DATA	0x41b0b1
+				MX6SL_PAD_ECSPI1_MOSI__UART5_TX_DATA	0x41b0b1
+				MX6SL_PAD_ECSPI1_MISO__UART5_RTS_B	0x4130b1
+				MX6SL_PAD_ECSPI1_SS0__UART5_CTS_B	0x4130b1
+			>;
+		};
+
 		pinctrl_usdhc2: usdhc2grp {
 			fsl,pins = <
 				MX6SL_PAD_SD2_CMD__SD2_CMD		0x417059
-- 
1.9.1
