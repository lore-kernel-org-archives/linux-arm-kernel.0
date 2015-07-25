From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat, 25 Jul 2015 16:23:23 +0900
Subject: [PATCH 2/3] ARM: dts: UniPhier: add UART and USB pinmux nodes
In-Reply-To: <1437809004-16806-1-git-send-email-yamada.masahiro@socionext.com>
References: <1437809004-16806-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1437809004-16806-3-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DT nodes in uniphier-pinctrl.dtsi provide the default pinctrl
settings that would be suitable for most boards.  You can still
override them in your board DTS file if necessary.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-ph1-ld4.dtsi  | 16 ++++++
 arch/arm/boot/dts/uniphier-ph1-pro4.dtsi | 14 ++++++
 arch/arm/boot/dts/uniphier-ph1-sld8.dtsi | 16 ++++++
 arch/arm/boot/dts/uniphier-pinctrl.dtsi  | 85 ++++++++++++++++++++++++++++++++
 4 files changed, 131 insertions(+)
 create mode 100644 arch/arm/boot/dts/uniphier-pinctrl.dtsi

diff --git a/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi b/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi
index 518eab7..4add90b 100644
--- a/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi
+++ b/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi
@@ -89,6 +89,8 @@
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
 			reg = <0x54006800 0x40>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_uart0>;
 			interrupts = <0 33 4>;
 			clocks = <&uart_clk>;
 			fifo-size = <64>;
@@ -98,6 +100,8 @@
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
 			reg = <0x54006900 0x40>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_uart1>;
 			interrupts = <0 35 4>;
 			clocks = <&uart_clk>;
 			fifo-size = <64>;
@@ -107,6 +111,8 @@
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
 			reg = <0x54006a00 0x40>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_uart2>;
 			interrupts = <0 37 4>;
 			clocks = <&uart_clk>;
 			fifo-size = <64>;
@@ -116,6 +122,8 @@
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
 			reg = <0x54006b00 0x40>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_uart3>;
 			interrupts = <0 29 4>;
 			clocks = <&uart_clk>;
 			fifo-size = <64>;
@@ -131,6 +139,8 @@
 			compatible = "socionext,uniphier-ehci", "generic-ehci";
 			status = "disabled";
 			reg = <0x5a800100 0x100>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_usb0>;
 			interrupts = <0 80 4>;
 		};
 
@@ -138,6 +148,8 @@
 			compatible = "socionext,uniphier-ehci", "generic-ehci";
 			status = "disabled";
 			reg = <0x5a810100 0x100>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_usb1>;
 			interrupts = <0 81 4>;
 		};
 
@@ -145,6 +157,8 @@
 			compatible = "socionext,uniphier-ehci", "generic-ehci";
 			status = "disabled";
 			reg = <0x5a820100 0x100>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_usb2>;
 			interrupts = <0 82 4>;
 		};
 
@@ -177,3 +191,5 @@
 		};
 	};
 };
+
+/include/ "uniphier-pinctrl.dtsi"
diff --git a/arch/arm/boot/dts/uniphier-ph1-pro4.dtsi b/arch/arm/boot/dts/uniphier-ph1-pro4.dtsi
index 789bd48..d0ca4c8 100644
--- a/arch/arm/boot/dts/uniphier-ph1-pro4.dtsi
+++ b/arch/arm/boot/dts/uniphier-ph1-pro4.dtsi
@@ -96,6 +96,8 @@
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
 			reg = <0x54006800 0x40>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_uart0>;
 			interrupts = <0 33 4>;
 			clocks = <&uart_clk>;
 			fifo-size = <64>;
@@ -105,6 +107,8 @@
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
 			reg = <0x54006900 0x40>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_uart1>;
 			interrupts = <0 35 4>;
 			clocks = <&uart_clk>;
 			fifo-size = <64>;
@@ -114,6 +118,8 @@
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
 			reg = <0x54006a00 0x40>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_uart2>;
 			interrupts = <0 37 4>;
 			clocks = <&uart_clk>;
 			fifo-size = <64>;
@@ -123,6 +129,8 @@
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
 			reg = <0x54006b00 0x40>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_uart3>;
 			interrupts = <0 29 4>;
 			clocks = <&uart_clk>;
 			fifo-size = <64>;
@@ -138,6 +146,8 @@
 			compatible = "socionext,uniphier-ehci", "generic-ehci";
 			status = "disabled";
 			reg = <0x5a800100 0x100>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_usb2>;
 			interrupts = <0 80 4>;
 		};
 
@@ -145,6 +155,8 @@
 			compatible = "socionext,uniphier-ehci", "generic-ehci";
 			status = "disabled";
 			reg = <0x5a810100 0x100>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_usb3>;
 			interrupts = <0 81 4>;
 		};
 
@@ -177,3 +189,5 @@
 		};
 	};
 };
+
+/include/ "uniphier-pinctrl.dtsi"
diff --git a/arch/arm/boot/dts/uniphier-ph1-sld8.dtsi b/arch/arm/boot/dts/uniphier-ph1-sld8.dtsi
index 8dff3c4..3ead910 100644
--- a/arch/arm/boot/dts/uniphier-ph1-sld8.dtsi
+++ b/arch/arm/boot/dts/uniphier-ph1-sld8.dtsi
@@ -89,6 +89,8 @@
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
 			reg = <0x54006800 0x40>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_uart0>;
 			interrupts = <0 33 4>;
 			clocks = <&uart_clk>;
 			fifo-size = <64>;
@@ -98,6 +100,8 @@
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
 			reg = <0x54006900 0x40>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_uart1>;
 			interrupts = <0 35 4>;
 			clocks = <&uart_clk>;
 			fifo-size = <64>;
@@ -107,6 +111,8 @@
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
 			reg = <0x54006a00 0x40>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_uart2>;
 			interrupts = <0 37 4>;
 			clocks = <&uart_clk>;
 			fifo-size = <64>;
@@ -116,6 +122,8 @@
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
 			reg = <0x54006b00 0x40>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_uart3>;
 			interrupts = <0 29 4>;
 			clocks = <&uart_clk>;
 			fifo-size = <64>;
@@ -131,6 +139,8 @@
 			compatible = "socionext,uniphier-ehci", "generic-ehci";
 			status = "disabled";
 			reg = <0x5a800100 0x100>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_usb0>;
 			interrupts = <0 80 4>;
 		};
 
@@ -138,6 +148,8 @@
 			compatible = "socionext,uniphier-ehci", "generic-ehci";
 			status = "disabled";
 			reg = <0x5a810100 0x100>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_usb1>;
 			interrupts = <0 81 4>;
 		};
 
@@ -145,6 +157,8 @@
 			compatible = "socionext,uniphier-ehci", "generic-ehci";
 			status = "disabled";
 			reg = <0x5a820100 0x100>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_usb2>;
 			interrupts = <0 82 4>;
 		};
 
@@ -177,3 +191,5 @@
 		};
 	};
 };
+
+/include/ "uniphier-pinctrl.dtsi"
diff --git a/arch/arm/boot/dts/uniphier-pinctrl.dtsi b/arch/arm/boot/dts/uniphier-pinctrl.dtsi
new file mode 100644
index 0000000..1b5b4fe
--- /dev/null
+++ b/arch/arm/boot/dts/uniphier-pinctrl.dtsi
@@ -0,0 +1,85 @@
+/*
+ * Device Tree Source for UniPhier SoCs default pinctrl settings
+ *
+ * Copyright (C) 2015 Masahiro Yamada <yamada.masahiro@socionext.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+&pinctrl {
+	pinctrl_uart0: uart0_grp {
+		groups = "uart0";
+		function = "uart0";
+	};
+
+	pinctrl_uart1: uart1_grp {
+		groups = "uart1";
+		function = "uart1";
+	};
+
+	pinctrl_uart2: uart2_grp {
+		groups = "uart2";
+		function = "uart2";
+	};
+
+	pinctrl_uart3: uart3_grp {
+		groups = "uart3";
+		function = "uart3";
+	};
+
+	pinctrl_usb0: usb0_grp {
+		groups = "usb0";
+		function = "usb0";
+	};
+
+	pinctrl_usb1: usb1_grp {
+		groups = "usb1";
+		function = "usb1";
+	};
+
+	pinctrl_usb2: usb2_grp {
+		groups = "usb2";
+		function = "usb2";
+	};
+
+	pinctrl_usb3: usb3_grp {
+		groups = "usb3";
+		function = "usb3";
+	};
+};
-- 
1.9.1
