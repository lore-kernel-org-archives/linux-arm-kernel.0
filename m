From: tharvey@gateworks.com (Tim Harvey)
Date: Thu, 14 Apr 2016 06:19:09 -0700
Subject: [PATCH] ARM: dts: imx: ventana: add RS485 txen gpio support
Message-ID: <1460639949-26392-1-git-send-email-tharvey@gateworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GW52xx/GW53xx/GW54xx have an on-board RS485 transceiver for half-duplex
RS485 using uart1. The active-high TXEN is GPIO7__IO1 which we can configure
as the rts-gpio as long as we specify it as active-low to invert the polarity
managed by mctrl_gpio helpers. This allows for RS485 to be used from
userspace by setting flags to SER_RS485_RTS_ON_SEND in the serial_rs485
struct when using the TIOCGRS485 ioctl.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi | 3 +++
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi | 3 +++
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
index 8cccc4a..50d6039 100644
--- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
@@ -315,6 +315,8 @@
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
+	fsl,uart-has-rtscts;
+	rts-gpio = <&gpio7 1 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
@@ -493,6 +495,7 @@
 			fsl,pins = <
 				MX6QDL_PAD_SD3_DAT7__UART1_TX_DATA	0x1b0b1
 				MX6QDL_PAD_SD3_DAT6__UART1_RX_DATA	0x1b0b1
+				MX6QDL_PAD_SD3_DAT4__GPIO7_IO01		0x4001b0b1 /* TEN */
 			>;
 		};
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
index 5f700cc..60b0ae9 100644
--- a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
@@ -312,6 +312,8 @@
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
+	fsl,uart-has-rtscts;
+	rts-gpio = <&gpio7 1 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
@@ -482,6 +484,7 @@
 			fsl,pins = <
 				MX6QDL_PAD_SD3_DAT7__UART1_TX_DATA	0x1b0b1
 				MX6QDL_PAD_SD3_DAT6__UART1_RX_DATA	0x1b0b1
+				MX6QDL_PAD_SD3_DAT4__GPIO7_IO01		0x4001b0b1 /* TEN */
 			>;
 		};
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
index d19b4cc..c217ecc 100644
--- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
@@ -414,6 +414,8 @@
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
+	fsl,uart-has-rtscts;
+	rts-gpio = <&gpio7 1 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
@@ -603,6 +605,7 @@
 			fsl,pins = <
 				MX6QDL_PAD_SD3_DAT7__UART1_TX_DATA	0x1b0b1
 				MX6QDL_PAD_SD3_DAT6__UART1_RX_DATA	0x1b0b1
+				MX6QDL_PAD_SD3_DAT4__GPIO7_IO01		0x4001b0b1 /* TEN */
 			>;
 		};
 
-- 
1.9.1
