From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue,  4 Aug 2015 20:21:03 +0900
Subject: [PATCH 2/3] ARM: dts: UniPhier: add PH1-Pro5 SoC support
In-Reply-To: <1438687264-26538-1-git-send-email-yamada.masahiro@socionext.com>
References: <1438687264-26538-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1438687264-26538-3-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initial version of UniPhier PH1-Pro5 device tree.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-ph1-pro5.dtsi | 252 +++++++++++++++++++++++++++++++
 1 file changed, 252 insertions(+)
 create mode 100644 arch/arm/boot/dts/uniphier-ph1-pro5.dtsi

diff --git a/arch/arm/boot/dts/uniphier-ph1-pro5.dtsi b/arch/arm/boot/dts/uniphier-ph1-pro5.dtsi
new file mode 100644
index 0000000..59c2b12
--- /dev/null
+++ b/arch/arm/boot/dts/uniphier-ph1-pro5.dtsi
@@ -0,0 +1,252 @@
+/*
+ * Device Tree Source for UniPhier PH1-Pro5 SoC
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
+/include/ "skeleton.dtsi"
+
+/ {
+	compatible = "socionext,ph1-pro5";
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		enable-method = "socionext,uniphier-smp";
+
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0>;
+		};
+
+		cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <1>;
+		};
+	};
+
+	clocks {
+		arm_timer_clk: arm_timer_clk {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <50000000>;
+		};
+
+		uart_clk: uart_clk {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <73728000>;
+		};
+
+		i2c_clk: i2c_clk {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <50000000>;
+		};
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		interrupt-parent = <&intc>;
+
+		extbus: extbus {
+			compatible = "simple-bus";
+			#address-cells = <2>;
+			#size-cells = <1>;
+		};
+
+		serial0: serial at 54006800 {
+			compatible = "socionext,uniphier-uart";
+			status = "disabled";
+			reg = <0x54006800 0x40>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_uart0>;
+			interrupts = <0 33 4>;
+			clocks = <&uart_clk>;
+		};
+
+		serial1: serial at 54006900 {
+			compatible = "socionext,uniphier-uart";
+			status = "disabled";
+			reg = <0x54006900 0x40>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_uart1>;
+			interrupts = <0 35 4>;
+			clocks = <&uart_clk>;
+		};
+
+		serial2: serial at 54006a00 {
+			compatible = "socionext,uniphier-uart";
+			status = "disabled";
+			reg = <0x54006a00 0x40>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_uart2>;
+			interrupts = <0 37 4>;
+			clocks = <&uart_clk>;
+		};
+
+		serial3: serial at 54006b00 {
+			compatible = "socionext,uniphier-uart";
+			status = "disabled";
+			reg = <0x54006b00 0x40>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_uart3>;
+			interrupts = <0 177 4>;
+			clocks = <&uart_clk>;
+		};
+
+		i2c0: i2c at 58780000 {
+			compatible = "socionext,uniphier-fi2c";
+			status = "disabled";
+			reg = <0x58780000 0x80>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_i2c0>;
+			interrupts = <0 41 4>;
+			clocks = <&i2c_clk>;
+			clock-frequency = <100000>;
+		};
+
+		i2c1: i2c at 58781000 {
+			compatible = "socionext,uniphier-fi2c";
+			status = "disabled";
+			reg = <0x58781000 0x80>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_i2c1>;
+			interrupts = <0 42 4>;
+			clocks = <&i2c_clk>;
+			clock-frequency = <100000>;
+		};
+
+		i2c2: i2c at 58782000 {
+			compatible = "socionext,uniphier-fi2c";
+			status = "disabled";
+			reg = <0x58782000 0x80>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_i2c2>;
+			interrupts = <0 43 4>;
+			clocks = <&i2c_clk>;
+			clock-frequency = <100000>;
+		};
+
+		i2c3: i2c at 58783000 {
+			compatible = "socionext,uniphier-fi2c";
+			status = "disabled";
+			reg = <0x58783000 0x80>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_i2c3>;
+			interrupts = <0 44 4>;
+			clocks = <&i2c_clk>;
+			clock-frequency = <100000>;
+		};
+
+		/* i2c4 does not exist */
+
+		/* chip-internal connection for DMD */
+		i2c5: i2c at 58785000 {
+			compatible = "socionext,uniphier-fi2c";
+			reg = <0x58785000 0x80>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <0 25 4>;
+			clocks = <&i2c_clk>;
+			clock-frequency = <400000>;
+		};
+
+		/* chip-internal connection for HDMI */
+		i2c6: i2c at 58786000 {
+			compatible = "socionext,uniphier-fi2c";
+			reg = <0x58786000 0x80>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <0 26 4>;
+			clocks = <&i2c_clk>;
+			clock-frequency = <400000>;
+		};
+
+		system-bus-controller-misc at 59800000 {
+			compatible = "socionext,uniphier-system-bus-controller-misc",
+				     "syscon";
+			reg = <0x59800000 0x2000>;
+		};
+
+		pinctrl: pinctrl at 5f801000 {
+			compatible = "socionext,ph1-pro5-pinctrl", "syscon";
+			reg = <0x5f801000 0xe00>;
+		};
+
+		timer at 60000200 {
+			compatible = "arm,cortex-a9-global-timer";
+			reg = <0x60000200 0x20>;
+			interrupts = <1 11 0x304>;
+			clocks = <&arm_timer_clk>;
+		};
+
+		timer at 60000600 {
+			compatible = "arm,cortex-a9-twd-timer";
+			reg = <0x60000600 0x20>;
+			interrupts = <1 13 0x304>;
+			clocks = <&arm_timer_clk>;
+		};
+
+		intc: interrupt-controller at 60001000 {
+			compatible = "arm,cortex-a9-gic";
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			reg = <0x60001000 0x1000>,
+			      <0x60000100 0x100>;
+		};
+	};
+};
+
+/include/ "uniphier-pinctrl.dtsi"
-- 
1.9.1
