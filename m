From: niklas.cassel@axis.com (Niklas Cassel)
Date: Wed, 21 Feb 2018 09:59:57 +0100
Subject: [PATCH v2 5/8] ARM: dts: artpec: add and utilize artpec6 pin
 controller
In-Reply-To: <20180221090000.18091-1-niklas.cassel@axis.com>
References: <20180221090000.18091-1-niklas.cassel@axis.com>
Message-ID: <20180221090000.18091-6-niklas.cassel@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add node for the pin controller used in the artpec6 SoC,
and start using it for the exising UARTs.

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 arch/arm/boot/dts/artpec6.dtsi | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/artpec6.dtsi b/arch/arm/boot/dts/artpec6.dtsi
index 981aecd27b0b..7a6d8f39823a 100644
--- a/arch/arm/boot/dts/artpec6.dtsi
+++ b/arch/arm/boot/dts/artpec6.dtsi
@@ -180,6 +180,32 @@
 		status = "disabled";
 	};
 
+	pinctrl: pinctrl at f801d000 {
+		compatible = "axis,artpec6-pinctrl";
+		reg = <0xf801d000 0x400>;
+
+		pinctrl_uart0: uart0grp {
+			function = "uart0";
+			groups = "uart0grp2";
+			bias-pull-up;
+		};
+		pinctrl_uart1: uart1grp {
+			function = "uart1";
+			groups = "uart1grp0";
+			bias-pull-up;
+		};
+		pinctrl_uart2: uart2grp {
+			function = "uart2";
+			groups = "uart2grp1";
+			bias-pull-up;
+		};
+		pinctrl_uart3: uart3grp {
+			function = "uart3";
+			groups = "uart3grp0";
+			bias-pull-up;
+		};
+	};
+
 	amba at 0 {
 		compatible = "simple-bus";
 		#address-cells = <0x1>;
@@ -238,6 +264,8 @@
 			clocks = <&clkctrl ARTPEC6_CLK_UART_REFCLK>,
 				<&clkctrl ARTPEC6_CLK_UART_PCLK>;
 			clock-names = "uart_clk", "apb_pclk";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_uart0>;
 			status = "disabled";
 		};
 		uart1: serial at f8037000 {
@@ -247,6 +275,8 @@
 			clocks = <&clkctrl ARTPEC6_CLK_UART_REFCLK>,
 				<&clkctrl ARTPEC6_CLK_UART_PCLK>;
 			clock-names = "uart_clk", "apb_pclk";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_uart1>;
 			status = "disabled";
 		};
 		uart2: serial at f8038000 {
@@ -256,6 +286,8 @@
 			clocks = <&clkctrl ARTPEC6_CLK_UART_REFCLK>,
 				<&clkctrl ARTPEC6_CLK_UART_PCLK>;
 			clock-names = "uart_clk", "apb_pclk";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_uart2>;
 			status = "disabled";
 		};
 		uart3: serial at f8039000 {
@@ -265,6 +297,8 @@
 			clocks = <&clkctrl ARTPEC6_CLK_UART_REFCLK>,
 				<&clkctrl ARTPEC6_CLK_UART_PCLK>;
 			clock-names = "uart_clk", "apb_pclk";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_uart3>;
 			status = "disabled";
 		};
 	};
-- 
2.14.2
