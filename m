From: tharvey@gateworks.com (Tim Harvey)
Date: Tue,  9 Aug 2016 12:18:49 -0700
Subject: [PATCH v2] ARM: dts: imx: ventana: add RS485 txen gpio support
In-Reply-To: <1467207504-5218-1-git-send-email-tharvey@gateworks.com>
References: <1467207504-5218-1-git-send-email-tharvey@gateworks.com>
Message-ID: <1470770329-25395-1-git-send-email-tharvey@gateworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
v2:
 - replace remove vendor specific property with generic property
 - replace rts-gpio with rts-gpios to match devicetree binding documentation
   (although both suffixes are supported)

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi | 3 +++
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi | 3 +++
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
index 208e3c2..a7100f9 100644
--- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
@@ -315,6 +315,8 @@
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
+	uart-has-rtscts;
+	rts-gpios = <&gpio7 1 GPIO_ACTIVE_HIGH>;
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
index 35b9e80..8953eba 100644
--- a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
@@ -312,6 +312,8 @@
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
+	uart-has-rtscts;
+	rts-gpios = <&gpio7 1 GPIO_ACTIVE_HIGH>;
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
index 5f8f1ea..6ac41c7 100644
--- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
@@ -414,6 +414,8 @@
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
+	uart-has-rtscts;
+	rts-gpios = <&gpio7 1 GPIO_ACTIVE_HIGH>;
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
