From: patrice.chotard@st.com (Patrice CHOTARD)
Date: Thu, 30 Jan 2014 15:55:43 +0100
Subject: [PATCH 3/4] ARM: dts: Add support of STid127 Soc.
In-Reply-To: <1391093744-19905-1-git-send-email-patrice.chotard@st.com>
References: <1391093744-19905-1-git-send-email-patrice.chotard@st.com>
Message-ID: <1391093744-19905-4-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexandre TORGUE <alexandre.torgue@st.com>

The STid127 integrates all harware components to function as a cable modem
or, in combination with a back end device, as a Gateway set top boxe.

Supported devices:
	-UART0
	-UART2

Signed-off-by: alexandre torgue <alexandre.torgue@st.com>
---
 arch/arm/boot/dts/stid127-clock.dtsi   |   31 ++++
 arch/arm/boot/dts/stid127-pinctrl.dtsi |  245 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/stid127.dtsi         |  130 +++++++++++++++++
 3 files changed, 406 insertions(+)
 create mode 100644 arch/arm/boot/dts/stid127-clock.dtsi
 create mode 100644 arch/arm/boot/dts/stid127-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/stid127.dtsi

diff --git a/arch/arm/boot/dts/stid127-clock.dtsi b/arch/arm/boot/dts/stid127-clock.dtsi
new file mode 100644
index 0000000..c6cafa9
--- /dev/null
+++ b/arch/arm/boot/dts/stid127-clock.dtsi
@@ -0,0 +1,31 @@
+/*
+ * Copyright (C) 2013 STMicroelectronics (R&D) Limited
+ * Author(s): Giuseppe Cavallaro <peppe.cavallaro@st.com>
+ *	      Alexandre Torgue <alexandre.torgue@st.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+/ {
+	clocks {
+		/*
+		 * ARM Peripheral clock for timers
+		 */
+		arm_periph_clk: arm_periph_clk {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <100000000>;
+		};
+		/*
+		 * Bootloader initialized system infrastructure clock for
+		 * serial devices.
+		 */
+		CLK_IC_LP_HD: clockgenA0 at 29 {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <100000000>;
+			clock-output-names = "CLK_IC_LP_HD";
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/stid127-pinctrl.dtsi b/arch/arm/boot/dts/stid127-pinctrl.dtsi
new file mode 100644
index 0000000..3fa66f3
--- /dev/null
+++ b/arch/arm/boot/dts/stid127-pinctrl.dtsi
@@ -0,0 +1,245 @@
+/*
+ * Copyright (C) 2012 STMicroelectronics Limited.
+ * Author(s): Giuseppe Cavallaro <peppe.cavallaro@st.com>
+ *	      Alexandre Torgue <alexandre.torgue@st.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * publishhed by the Free Software Foundation.
+ */
+#include "st-pincfg.h"
+/ {
+	aliases {
+		gpio0	= &PIO0;
+		gpio1	= &PIO1;
+		gpio2	= &PIO2;
+		gpio3	= &PIO3;
+		gpio4	= &PIO4;
+		gpio5	= &PIO5;
+		gpio6	= &PIO6;
+		gpio7	= &PIO7;
+		gpio8	= &PIO8;
+		gpio9	= &PIO9;
+		gpio10	= &PIO10;
+		gpio11	= &PIO11;
+		gpio12	= &PIO12;
+		gpio13	= &PIO13;
+		gpio14	= &PIO14;
+		gpio15	= &PIO15;
+		gpio16	= &PIO16;
+		gpio17	= &PIO17;
+		gpio18	= &PIO18;
+		gpio19	= &PIO19;
+		gpio20	= &PIO20;
+		gpio21	= &PIO21;
+		gpio22	= &PIO22;
+
+	};
+
+	soc {
+		pin-controller-pwest {
+			#address-cells	= <1>;
+			#size-cells	= <1>;
+			compatible	= "st,stid127-pwest-pinctrl";
+			st,syscfg	= <&syscfg_pwest>;
+			ranges		= <0 0xfebe0000 0x8000>;
+
+			PIO0: gpio at febe0000 {
+				gpio-controller;
+				#gpio-cells = <1>;
+				reg = <0 0x100>;
+				interrupts =  <0 149 0>;
+				st,bank-name  = "PIO0";
+			};
+			PIO1: gpio at febe1000 {
+				gpio-controller;
+				#gpio-cells = <1>;
+				reg = <0x1000 0x100>;
+				interrupts =  <0 150 0>;
+				st,bank-name  = "PIO1";
+			};
+			PIO2: gpio at febe2000 {
+				gpio-controller;
+				#gpio-cells = <1>;
+				reg = <0x2000 0x100>;
+				interrupts =  <0 151 0>;
+				st,bank-name  = "PIO2";
+			};
+			PIO3: gpio at febe3000 {
+				gpio-controller;
+				#gpio-cells = <1>;
+				reg = <0x3000 0x100>;
+				interrupts =  <0 152 0>;
+				st,bank-name  = "PIO3";
+			};
+			PIO4: gpio at febe4000 {
+				gpio-controller;
+				#gpio-cells = <1>;
+				reg = <0x4000 0x100>;
+				interrupts =  <0 153 0>;
+				st,bank-name  = "PIO4";
+			};
+			PIO5: gpio at febe5000 {
+				gpio-controller;
+				#gpio-cells = <1>;
+				reg = <0x5000 0x100>;
+				interrupts =  <0 154 0>;
+				st,bank-name  = "PIO5";
+			};
+			PIO6: gpio at febe6000 {
+				gpio-controller;
+				#gpio-cells = <1>;
+				reg = <0x6000 0x100>;
+				interrupts =  <0 155 0>;
+				st,bank-name  = "PIO6";
+			};
+			PIO7: gpio at febe7000 {
+				gpio-controller;
+				#gpio-cells = <1>;
+				reg = <0x7000 0x100>;
+				interrupts =  <0 156 0>;
+				st,bank-name  = "PIO7";
+			};
+			uart0 {
+				pinctrl_uart0: uart0 {
+					st,pins {
+						tx	= <&PIO3 2 ALT2	OUT>;
+						rx	= <&PIO3 0 ALT2	IN>;
+					};
+				};
+			};
+
+		};
+
+		pin-controller-psouth {
+			#address-cells	= <1>;
+			#size-cells	= <1>;
+			compatible	= "st,stid127-psouth-pinctrl";
+			st,syscfg	= <&syscfg_psouth>;
+			ranges		= <0 0xfef70000 0x7000>;
+
+			PIO8: gpio at fef70000 {
+				gpio-controller;
+				#gpio-cells = <1>;
+				reg = <0 0x100>;
+				interrupts =  <0 157 0>;
+				st,bank-name  = "PIO8";
+			};
+			PIO9: gpio at fef71000 {
+				gpio-controller;
+				#gpio-cells = <1>;
+				reg = <0x1000 0x100>;
+				interrupts =  <0 158 0>;
+				st,bank-name  = "PIO9";
+			};
+			PIO10: gpio at fef72000 {
+				gpio-controller;
+				#gpio-cells = <1>;
+				reg = <0x2000 0x100>;
+				interrupts =  <0 159 0>;
+				st,bank-name  = "PIO10";
+			};
+			PIO11: gpio at fef73000 {
+				gpio-controller;
+				#gpio-cells = <1>;
+				reg = <0x3000 0x100>;
+				interrupts =  <0 160 0>;
+				st,bank-name  = "PIO11";
+			};
+			PIO12: gpio at fef74000 {
+				gpio-controller;
+				#gpio-cells = <1>;
+				reg = <0x4000 0x100>;
+				interrupts =  <0 161 0>;
+				st,bank-name  = "PIO12";
+			};
+			PIO13: gpio at fef75000 {
+				gpio-controller;
+				#gpio-cells = <1>;
+				reg = <0x5000 0x100>;
+				interrupts =  <0 162 0>;
+				st,bank-name  = "PIO13";
+			};
+			PIO14: gpio at fef76000 {
+				gpio-controller;
+				#gpio-cells = <1>;
+				reg = <0x6000 0x100>;
+				interrupts =  <0 163 0>;
+				st,bank-name  = "PIO14";
+			};
+		};
+
+		pin-controller-peast {
+			#address-cells	= <1>;
+			#size-cells	= <1>;
+			compatible	= "st,stid127-peast-pinctrl";
+			st,syscfg	= <&syscfg_peast>;
+			ranges		= <0 0xfebc0000 0x8000>;
+
+			PIO15: gpio at febc0000 {
+				gpio-controller;
+				#gpio-cells = <1>;
+				reg = < 0 0x100>;
+				interrupts =  <0 164 0>;
+				st,bank-name  = "PIO15";
+			};
+			PIO16: gpio at febc1000 {
+				gpio-controller;
+				#gpio-cells = <1>;
+				reg = <0x1000 0x100>;
+				interrupts =  <0 165 0>;
+				st,bank-name  = "PIO16";
+			};
+			PIO17: gpio at febc2000 {
+				gpio-controller;
+				#gpio-cells = <1>;
+				reg = <0x2000 0x100>;
+				interrupts =  <0 166 0>;
+				st,bank-name  = "PIO17";
+			};
+			PIO18: gpio at febc3000 {
+				gpio-controller;
+				#gpio-cells = <1>;
+				reg = <0x3000 0x100>;
+				interrupts =  <0 167 0>;
+				st,bank-name  = "PIO18";
+			};
+			PIO19: gpio at febc4000 {
+				gpio-controller;
+				#gpio-cells = <1>;
+				reg = <0x4000 0x100>;
+				interrupts =  <0 168 0>;
+				st,bank-name  = "PIO19";
+			};
+			PIO20: gpio at febc5000 {
+				gpio-controller;
+				#gpio-cells = <1>;
+				reg = <0x5000 0x100>;
+				interrupts =  <0 169 0>;
+				st,bank-name  = "PIO20";
+			};
+			PIO21: gpio at febc6000 {
+				gpio-controller;
+				#gpio-cells = <1>;
+				reg = <0x6000 0x100>;
+				interrupts =  <0 170 0>;
+				st,bank-name  = "PIO21";
+			};
+			PIO22: gpio at febc7000 {
+				gpio-controller;
+				#gpio-cells = <1>;
+				reg = <0x7000 0x100>;
+				interrupts =  <0 171 0>;
+				st,bank-name  = "PIO22";
+			};
+			uart2 {
+				pinctrl_uart2: uart2-0 {
+					st,pins {
+						tx	= <&PIO20 1 ALT3 OUT>;
+						rx	= <&PIO20 2 ALT3 IN>;
+					};
+				};
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/stid127.dtsi b/arch/arm/boot/dts/stid127.dtsi
new file mode 100644
index 0000000..a6f0b8fe
--- /dev/null
+++ b/arch/arm/boot/dts/stid127.dtsi
@@ -0,0 +1,130 @@
+/*
+ * Copyright (C) 2013 STMicroelectronics Limited.
+ * Author(s): Giuseppe Cavallaro <peppe.cavallaro@st.com>
+ *	      Alexandre Torgue <alexandre.torgue@st.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * publishhed by the Free Software Foundation.
+ */
+#include "stid127-pinctrl.dtsi"
+#include "stid127-clock.dtsi"
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0>;
+		};
+		cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <1>;
+		};
+	};
+
+	intc: interrupt-controller at fffe1000 {
+		compatible = "arm,cortex-a9-gic";
+		#interrupt-cells = <3>;
+		interrupt-controller;
+		reg = <0xfffe1000 0x1000>,
+		      <0xfffe0100 0x100>;
+	};
+
+	scu at fffe0000 {
+		compatible = "arm,cortex-a9-scu";
+		reg = <0xfffe0000 0x1000>;
+	};
+
+	timer at fffe0200 {
+			interrupt-parent = <&intc>;
+			compatible = "arm,cortex-a9-global-timer";
+			reg = <0xfffe0200 0x100>;
+			interrupts = <1 11 0x04>;
+			clocks = <&arm_periph_clk>;
+	};
+
+	L2: cache-controller {
+		compatible = "arm,pl310-cache";
+		reg = <0xfffe2000 0x1000>;
+		arm,data-latency = <3 2 2>;
+		arm,tag-latency = <1 1 1>;
+		cache-unified;
+		cache-level = <2>;
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		interrupt-parent = <&intc>;
+		ranges;
+		compatible	= "simple-bus";
+
+		syscfg_west:west-syscfg at febf0000{
+			compatible	= "st,stid127-west-syscfg", "syscon";
+			reg		= <0xfebf0000 0x1000>;
+		};
+
+		syscfg_south:south-syscfg at fefa0000{
+			compatible	= "st,stid127-south-syscfg", "syscon";
+			reg		= <0xfefa0000 0x1000>;
+		};
+
+		syscfg_docsis:docsis-syscfg at fef90000{
+			compatible	= "st,stid127-docsys-syscfg", "syscon";
+			reg		= <0xfef90000 0x1000>;
+		};
+
+		syscfg_cpu:cpu-syscfg at fe9a0000{
+			compatible	= "st,stid127-cpu-syscfg", "syscon";
+			reg		= <0xfe9a0000 0x1000>;
+		};
+
+		syscfg_hd:hd-syscfg at fe930000{
+			compatible	= "st,stid127-hd-syscfg", "syscon";
+			reg		= <0xfe930000 0x1000>;
+		};
+
+		syscfg_pwest:pwest-syscfg at fec00000{
+			compatible	= "st,stid127-pwest-syscfg", "syscon";
+			reg		= <0xfec00000 0x1000>;
+		};
+
+		syscfg_psouth:psouth-syscfg at fefd0000{
+			compatible	= "st,stid127-psouth-syscfg", "syscon";
+			reg		= <0xfefd0000 0x1000>;
+		};
+
+		syscfg_peast:peast-syscfg at febd0000{
+			compatible	= "st,stid127-peast-syscfg", "syscon";
+			reg		= <0xfebd0000 0x1000>;
+		};
+
+		/* Comms block ASCs in SASG2 */
+		uart0: serial at fe530000{
+			compatible	= "st,asc";
+			status = "disabled";
+			reg		= <0xfe530000 0x2c>;
+			interrupts	=  <0 25 0>;
+			pinctrl-names 	= "default";
+			pinctrl-0 	= <&pinctrl_uart0>;
+			clocks		= <&CLK_IC_LP_HD>;
+		};
+
+		uart2: serial at fe532000{
+			compatible	= "st,asc";
+			status = "disabled";
+			reg		= <0xfe532000 0x2c>;
+			interrupts	=  <0 27 0>;
+			pinctrl-names 	= "default";
+			pinctrl-0 	= <&pinctrl_uart2>;
+			clocks		= <&CLK_IC_LP_HD>;
+		};
+	};
+};
-- 
1.7.9.5
