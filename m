From: tharvey@gateworks.com (Tim Harvey)
Date: Wed, 29 Jun 2016 06:38:24 -0700
Subject: [PATCH] ARM: dts: imx: ventana: add RS485 txen gpio support
Message-ID: <1467207504-5218-1-git-send-email-tharvey@gateworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GW54xx, GW53xx, and GW52xx all have an RS485 transceiver that uses an
IMX GPIO for the TX enable of the transceiver. Declare this properly.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi | 3 +++
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi | 3 +++
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
index 8bf1020..25ed57d 100644
--- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
@@ -315,6 +315,8 @@
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
+	fsl,uart-has-rtscts;
+	rts-gpio = <&gpio7 1 GPIO_ACTIVE_HIGH>;
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
index e5f4b6c..69e21b9 100644
--- a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
@@ -311,6 +311,8 @@
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
+	fsl,uart-has-rtscts;
+	rts-gpio = <&gpio7 1 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 };
 
@@ -481,6 +483,7 @@
 			fsl,pins = <
 				MX6QDL_PAD_SD3_DAT7__UART1_TX_DATA	0x1b0b1
 				MX6QDL_PAD_SD3_DAT6__UART1_RX_DATA	0x1b0b1
+				MX6QDL_PAD_SD3_DAT4__GPIO7_IO01		0x4001b0b1 /* TEN */
 			>;
 		};
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
index 5a8dbab..b602e2a 100644
--- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
@@ -414,6 +414,8 @@
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
+	fsl,uart-has-rtscts;
+	rts-gpio = <&gpio7 1 GPIO_ACTIVE_HIGH>;
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
