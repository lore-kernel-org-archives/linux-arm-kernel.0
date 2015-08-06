From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu,  6 Aug 2015 19:37:48 +0900
Subject: [PATCH v2 4/4] ARM: dts: UniPhier: add ProXstream2 and PH1-LD6b
 SoC/board support
In-Reply-To: <1438857468-9740-1-git-send-email-yamada.masahiro@socionext.com>
References: <1438857468-9740-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1438857468-9740-5-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initial version of DTSI for ProXstream2 and PH1-LD6b and DTS for
PH1-LD6b reference board.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---
 arch/arm/boot/dts/Makefile                  |   3 +-
 arch/arm/boot/dts/uniphier-ph1-ld6b-ref.dts | 105 +++++++++++
 arch/arm/boot/dts/uniphier-ph1-ld6b.dtsi    |  67 +++++++
 arch/arm/boot/dts/uniphier-proxstream2.dtsi | 273 ++++++++++++++++++++++++++++
 4 files changed, 447 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/uniphier-ph1-ld6b-ref.dts
 create mode 100644 arch/arm/boot/dts/uniphier-ph1-ld6b.dtsi
 create mode 100644 arch/arm/boot/dts/uniphier-proxstream2.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 246473a..6eb3f2f 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -645,7 +645,8 @@ dtb-$(CONFIG_ARCH_UNIPHIER) += \
 	uniphier-ph1-sld3-ref.dtb \
 	uniphier-ph1-ld4-ref.dtb \
 	uniphier-ph1-pro4-ref.dtb \
-	uniphier-ph1-sld8-ref.dtb
+	uniphier-ph1-sld8-ref.dtb \
+	uniphier-ph1-ld6b-ref.dtb
 dtb-$(CONFIG_ARCH_VERSATILE) += \
 	versatile-ab.dtb \
 	versatile-pb.dtb
diff --git a/arch/arm/boot/dts/uniphier-ph1-ld6b-ref.dts b/arch/arm/boot/dts/uniphier-ph1-ld6b-ref.dts
new file mode 100644
index 0000000..33963ac
--- /dev/null
+++ b/arch/arm/boot/dts/uniphier-ph1-ld6b-ref.dts
@@ -0,0 +1,105 @@
+/*
+ * Device Tree Source for UniPhier PH1-LD6b Reference Board
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
+/dts-v1/;
+/include/ "uniphier-ph1-ld6b.dtsi"
+/include/ "uniphier-ref-daughter.dtsi"
+/include/ "uniphier-support-card.dtsi"
+
+/ {
+	model = "UniPhier PH1-LD6b Reference Board";
+	compatible = "socionext,ph1-ld6b-ref", "socionext,ph1-ld6b";
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x80000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200";
+		stdout-path = &serial0;
+	};
+
+	aliases {
+		serial0 = &serial0;
+		serial1 = &serial1;
+		serial2 = &serial2;
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+		i2c4 = &i2c4;
+		i2c5 = &i2c5;
+		i2c6 = &i2c6;
+	};
+};
+
+&extbus {
+	ranges = <0 0x00000000 0x0f000000 0x01000000
+		  1 0x00000000 0x00000000 0x08000000>;
+};
+
+&support_card {
+	ranges = <0x00000000 1 0x03f00000 0x00100000>;
+};
+
+&ethsc {
+	interrupts = <0 50 4>;
+};
+
+&serial0 {
+	status = "okay";
+};
+
+&serial1 {
+	status = "okay";
+};
+
+&serial2 {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/uniphier-ph1-ld6b.dtsi b/arch/arm/boot/dts/uniphier-ph1-ld6b.dtsi
new file mode 100644
index 0000000..c6499ee
--- /dev/null
+++ b/arch/arm/boot/dts/uniphier-ph1-ld6b.dtsi
@@ -0,0 +1,67 @@
+/*
+ * Device Tree Source for UniPhier PH1-LD6b SoC
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
+/*
+ * PH1-LD6b consists of two silicon dies: D-chip and A-chip.
+ * The D-chip (digital chip) is the same as the ProXstream2 die.
+ * Reuse the ProXstream2 device tree with some properties overridden.
+ */
+/include/ "uniphier-proxstream2.dtsi"
+
+/ {
+	compatible = "socionext,ph1-ld6b";
+};
+
+/* UART3 unavilable: the pads are not wired to the package balls */
+&serial3 {
+	status = "disabled";
+};
+
+/*
+ * PH1-LD6b and ProXstream2 have completely different packages,
+ * which makes the pinctrl driver unshareable.
+ */
+&pinctrl {
+	compatible = "socionext,ph1-ld6b-pinctrl", "syscon";
+};
diff --git a/arch/arm/boot/dts/uniphier-proxstream2.dtsi b/arch/arm/boot/dts/uniphier-proxstream2.dtsi
new file mode 100644
index 0000000..ccf795a
--- /dev/null
+++ b/arch/arm/boot/dts/uniphier-proxstream2.dtsi
@@ -0,0 +1,273 @@
+/*
+ * Device Tree Source for UniPhier ProXstream2 SoC
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
+	compatible = "socionext,proxstream2";
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
+
+		cpu at 2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <2>;
+		};
+
+		cpu at 3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <3>;
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
+			clock-frequency = <88900000>;
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
+		/* chip-internal connection for DMD */
+		i2c4: i2c at 58784000 {
+			compatible = "socionext,uniphier-fi2c";
+			reg = <0x58784000 0x80>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <0 45 4>;
+			clocks = <&i2c_clk>;
+			clock-frequency = <400000>;
+		};
+
+		/* chip-internal connection for STM */
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
+			compatible = "socionext,proxstream2-pinctrl", "syscon";
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
