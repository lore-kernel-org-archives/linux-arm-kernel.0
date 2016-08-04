From: kbeldan@baylibre.com (Karl Beldan)
Date: Thu,  4 Aug 2016 11:06:56 +0000
Subject: [PATCH] ARM: dts: da850: Add missing pin muxing for the UARTs
Message-ID: <20160804110656.25318-1-kbeldan@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds 2 pinctrl groups (rtscts, rxtx) for each of the 3 UARTs.

Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
---
 arch/arm/boot/dts/da850.dtsi | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 25f0f8e..bc10e7e 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -41,6 +41,42 @@
 			pinctrl-single,function-mask = <0xf>;
 			status = "disabled";
 
+			serial0_rtscts_pins: pinmux_serial0_rtscts_pins {
+				pinctrl-single,bits = <
+					/* UART0_RTS UART0_CTS */
+					0x0c 0x22000000 0xff000000
+				>;
+			};
+			serial0_rxtx_pins: pinmux_serial0_rxtx_pins {
+				pinctrl-single,bits = <
+					/* UART0_TXD UART0_RXD */
+					0x0c 0x00220000 0x00ff0000
+				>;
+			};
+			serial1_rtscts_pins: pinmux_serial1_rtscts_pins {
+				pinctrl-single,bits = <
+					/* UART1_CTS UART1_RTS */
+					0x00 0x00440000 0x00ff0000
+				>;
+			};
+			serial1_rxtx_pins: pinmux_serial1_rxtx_pins {
+				pinctrl-single,bits = <
+					/* UART1_TXD UART1_RXD */
+					0x10 0x22000000 0xff000000
+				>;
+			};
+			serial2_rtscts_pins: pinmux_serial2_rtscts_pins {
+				pinctrl-single,bits = <
+					/* UART2_CTS UART2_RTS */
+					0x00 0x44000000 0xff000000
+				>;
+			};
+			serial2_rxtx_pins: pinmux_serial2_rxtx_pins {
+				pinctrl-single,bits = <
+					/* UART2_TXD UART2_RXD */
+					0x10 0x00220000 0x00ff0000
+				>;
+			};
 			nand_cs3_pins: pinmux_nand_pins {
 				pinctrl-single,bits = <
 					/* EMA_OE, EMA_WE */
-- 
2.9.0.rc1
