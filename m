From: ludovic.Barre@st.com (Ludovic Barre)
Date: Mon, 18 Dec 2017 16:17:51 +0100
Subject: [PATCH V2 8/9] ARM: dts: stm32: add stm32mp157c initial support
In-Reply-To: <1513610272-7824-1-git-send-email-ludovic.Barre@st.com>
References: <1513610272-7824-1-git-send-email-ludovic.Barre@st.com>
Message-ID: <1513610272-7824-9-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

Add stm32mp157c initial support with:
-Dual Cortex-A7
-Arm psci, timer, gic
-Pinctrl
-Uart

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 172 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/stm32mp157c.dtsi        | 139 ++++++++++++++++++++++++
 2 files changed, 311 insertions(+)
 create mode 100644 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/stm32mp157c.dtsi

diff --git a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
new file mode 100644
index 0000000..440276a
--- /dev/null
+++ b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
@@ -0,0 +1,172 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
+/*
+ * Copyright (C) STMicroelectronics 2017 - All Rights Reserved
+ * Author: Ludovic Barre <ludovic.barre@st.com> for STMicroelectronics.
+ */
+#include <dt-bindings/pinctrl/stm32-pinfunc.h>
+
+/ {
+	soc {
+		pinctrl: pin-controller {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "st,stm32mp157-pinctrl";
+			ranges = <0 0x50002000 0xa400>;
+			pins-are-numbered;
+
+			gpioa: gpio at 50002000 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				reg = <0x0 0x400>;
+				clocks = <&clk_pll3_p>;
+				st,bank-name = "GPIOA";
+				ngpios = <16>;
+				gpio-ranges = <&pinctrl 0 0 16>;
+			};
+
+			gpiob: gpio at 50003000 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				reg = <0x1000 0x400>;
+				clocks = <&clk_pll3_p>;
+				st,bank-name = "GPIOB";
+				ngpios = <16>;
+				gpio-ranges = <&pinctrl 0 16 16>;
+			};
+
+			gpioc: gpio at 50004000 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				reg = <0x2000 0x400>;
+				clocks = <&clk_pll3_p>;
+				st,bank-name = "GPIOC";
+				ngpios = <16>;
+				gpio-ranges = <&pinctrl 0 32 16>;
+			};
+
+			gpiod: gpio at 50005000 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				reg = <0x3000 0x400>;
+				clocks = <&clk_pll3_p>;
+				st,bank-name = "GPIOD";
+				ngpios = <16>;
+				gpio-ranges = <&pinctrl 0 48 16>;
+			};
+
+			gpioe: gpio at 50006000 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				reg = <0x4000 0x400>;
+				clocks = <&clk_pll3_p>;
+				st,bank-name = "GPIOE";
+				ngpios = <16>;
+				gpio-ranges = <&pinctrl 0 64 16>;
+			};
+
+			gpiof: gpio at 50007000 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				reg = <0x5000 0x400>;
+				clocks = <&clk_pll3_p>;
+				st,bank-name = "GPIOF";
+				ngpios = <16>;
+				gpio-ranges = <&pinctrl 0 80 16>;
+			};
+
+			gpiog: gpio at 50008000 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				reg = <0x6000 0x400>;
+				clocks = <&clk_pll3_p>;
+				st,bank-name = "GPIOG";
+				ngpios = <16>;
+				gpio-ranges = <&pinctrl 0 96 16>;
+			};
+
+			gpioh: gpio at 50009000 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				reg = <0x7000 0x400>;
+				clocks = <&clk_pll3_p>;
+				st,bank-name = "GPIOH";
+				ngpios = <16>;
+				gpio-ranges = <&pinctrl 0 112 16>;
+			};
+
+			gpioi: gpio at 5000a000 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				reg = <0x8000 0x400>;
+				clocks = <&clk_pll3_p>;
+				st,bank-name = "GPIOI";
+				ngpios = <16>;
+				gpio-ranges = <&pinctrl 0 128 16>;
+			};
+
+			gpioj: gpio at 5000b000 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				reg = <0x9000 0x400>;
+				clocks = <&clk_pll3_p>;
+				st,bank-name = "GPIOJ";
+				ngpios = <16>;
+				gpio-ranges = <&pinctrl 0 144 16>;
+			};
+
+			gpiok: gpio at 5000c000 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				reg = <0xa000 0x400>;
+				clocks = <&clk_pll3_p>;
+				st,bank-name = "GPIOK";
+				ngpios = <8>;
+				gpio-ranges = <&pinctrl 0 160 8>;
+			};
+		};
+
+		pinctrl_z: pin-controller-z {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "st,stm32mp157-z-pinctrl";
+			ranges = <0 0x54004000 0x400>;
+			pins-are-numbered;
+			status = "disabled";
+
+			gpioz: gpio at 54004000 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				reg = <0 0x400>;
+				clocks = <&clk_pll2_p>;
+				st,bank-name = "GPIOZ";
+				st,bank-ioport = <11>;
+				ngpios = <8>;
+				gpio-ranges = <&pinctrl_z 0 400 8>;
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
new file mode 100644
index 0000000..93dbcac
--- /dev/null
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -0,0 +1,139 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
+/*
+ * Copyright (C) STMicroelectronics 2017 - All Rights Reserved
+ * Author: Ludovic Barre <ludovic.barre@st.com> for STMicroelectronics.
+ */
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu at 0 {
+			compatible = "arm,cortex-a7";
+			device_type = "cpu";
+			reg = <0>;
+		};
+
+		cpu1: cpu at 1 {
+			compatible = "arm,cortex-a7";
+			device_type = "cpu";
+			reg = <1>;
+		};
+	};
+
+	psci {
+		compatible = "arm,psci";
+		method = "smc";
+		cpu_off = <0x84000002>;
+		cpu_on = <0x84000003>;
+	};
+
+	aliases {
+		gpio0 = &gpioa;
+		gpio1 = &gpiob;
+		gpio2 = &gpioc;
+		gpio3 = &gpiod;
+		gpio4 = &gpioe;
+		gpio5 = &gpiof;
+		gpio6 = &gpiog;
+		gpio7 = &gpioh;
+		gpio8 = &gpioi;
+		gpio9 = &gpioj;
+		gpio10 = &gpiok;
+		serial3 = &uart4;
+	};
+
+	intc: interrupt-controller at a0021000 {
+		compatible = "arm,cortex-a7-gic";
+		#interrupt-cells = <3>;
+		interrupt-controller;
+		reg = <0xa0021000 0x1000>,
+		      <0xa0022000 0x2000>;
+	};
+
+	timer {
+		compatible = "arm,armv7-timer";
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+		interrupt-parent = <&intc>;
+	};
+
+	clocks {
+		clk_hse: clk-hse {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <24000000>;
+		};
+
+		clk_pll_per: clk-pll-per {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <64000000>;
+		};
+
+		clk_hsi: clk-hsi {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <64000000>;
+		};
+
+		clk_lse: clk-lse {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <32768>;
+		};
+
+		clk_lsi: clk-lsi {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <32000>;
+		};
+
+		clk_csi: clk-csi {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <4000000>;
+		};
+
+		clk_pclk1: clk-pclk1 {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <86000000>;
+		};
+
+		clk_pll3_p: clk-pll3_p {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <172000000>;
+		};
+
+		clk_pll2_p: clk-pll2_p {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <264000000>;
+		};
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		interrupt-parent = <&intc>;
+		ranges;
+
+		uart4: serial at 40010000 {
+			compatible = "st,stm32h7-uart";
+			reg = <0x40010000 0x400>;
+			interrupts = <GIC_SPI 52 IRQ_TYPE_NONE>;
+			clocks = <&clk_pclk1>;
+			status = "disabled";
+		};
+	};
+};
-- 
2.7.4
