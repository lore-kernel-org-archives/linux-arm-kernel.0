From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Mon, 8 Jan 2018 06:54:37 +0200
Subject: [PATCH 5/6] arm64: tegra: Add Tegra194 chip device tree
In-Reply-To: <1515387278-29777-1-git-send-email-mperttunen@nvidia.com>
References: <1515387278-29777-1-git-send-email-mperttunen@nvidia.com>
Message-ID: <1515387278-29777-6-git-send-email-mperttunen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the chip-level device tree, including binding headers, for the
NVIDIA Tegra194 "Xavier" system-on-chip. Only a small subset of devices
are initially available, enough to boot to UART console.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi   | 334 +++++++++++++++++++++++++++++
 include/dt-bindings/clock/tegra194-clock.h |  59 +++++
 include/dt-bindings/gpio/tegra194-gpio.h   |  59 +++++
 include/dt-bindings/reset/tegra194-reset.h |  40 ++++
 4 files changed, 492 insertions(+)
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra194.dtsi
 create mode 100644 include/dt-bindings/clock/tegra194-clock.h
 create mode 100644 include/dt-bindings/gpio/tegra194-gpio.h
 create mode 100644 include/dt-bindings/reset/tegra194-reset.h

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
new file mode 100644
index 000000000000..51eff420816d
--- /dev/null
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -0,0 +1,334 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <dt-bindings/clock/tegra194-clock.h>
+#include <dt-bindings/gpio/tegra194-gpio.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/mailbox/tegra186-hsp.h>
+#include <dt-bindings/reset/tegra194-reset.h>
+
+/ {
+	compatible = "nvidia,tegra194";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	uarta: serial at 3100000 {
+		compatible = "nvidia,tegra194-uart", "nvidia,tegra20-uart";
+		reg = <0x0 0x03100000 0x0 0x40>;
+		reg-shift = <2>;
+		interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&bpmp TEGRA194_CLK_UARTA>;
+		clock-names = "serial";
+		resets = <&bpmp TEGRA194_RESET_UARTA>;
+		reset-names = "serial";
+		status = "disabled";
+	};
+
+	uartb: serial at 3110000 {
+		compatible = "nvidia,tegra194-uart", "nvidia,tegra20-uart";
+		reg = <0x0 0x03110000 0x0 0x40>;
+		reg-shift = <2>;
+		interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&bpmp TEGRA194_CLK_UARTB>;
+		clock-names = "serial";
+		resets = <&bpmp TEGRA194_RESET_UARTB>;
+		reset-names = "serial";
+		status = "disabled";
+	};
+
+	uartd: serial at 3130000 {
+		compatible = "nvidia,tegra194-uart", "nvidia,tegra20-uart";
+		reg = <0x0 0x03130000 0x0 0x40>;
+		reg-shift = <2>;
+		interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&bpmp TEGRA194_CLK_UARTD>;
+		clock-names = "serial";
+		resets = <&bpmp TEGRA194_RESET_UARTD>;
+		reset-names = "serial";
+		status = "disabled";
+	};
+
+	uarte: serial at 3140000 {
+		compatible = "nvidia,tegra194-uart", "nvidia,tegra20-uart";
+		reg = <0x0 0x03140000 0x0 0x40>;
+		reg-shift = <2>;
+		interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&bpmp TEGRA194_CLK_UARTE>;
+		clock-names = "serial";
+		resets = <&bpmp TEGRA194_RESET_UARTE>;
+		reset-names = "serial";
+		status = "disabled";
+	};
+
+	uartf: serial at 3150000 {
+		compatible = "nvidia,tegra194-uart", "nvidia,tegra20-uart";
+		reg = <0x0 0x03150000 0x0 0x40>;
+		reg-shift = <2>;
+		interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&bpmp TEGRA194_CLK_UARTF>;
+		clock-names = "serial";
+		resets = <&bpmp TEGRA194_RESET_UARTF>;
+		reset-names = "serial";
+		status = "disabled";
+	};
+
+	gen1_i2c: i2c at 3160000 {
+		compatible = "nvidia,tegra194-i2c", "nvidia,tegra114-i2c";
+		reg = <0x0 0x03160000 0x0 0x10000>;
+		interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&bpmp TEGRA194_CLK_I2C1>;
+		clock-names = "div-clk";
+		resets = <&bpmp TEGRA194_RESET_I2C1>;
+		reset-names = "i2c";
+		status = "disabled";
+	};
+
+	uarth: serial at 3170000 {
+		compatible = "nvidia,tegra194-uart", "nvidia,tegra20-uart";
+		reg = <0x0 0x03170000 0x0 0x40>;
+		reg-shift = <2>;
+		interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&bpmp TEGRA194_CLK_UARTH>;
+		clock-names = "serial";
+		resets = <&bpmp TEGRA194_RESET_UARTH>;
+		reset-names = "serial";
+		status = "disabled";
+	};
+
+	cam_i2c: i2c at 3180000 {
+		compatible = "nvidia,tegra194-i2c", "nvidia,tegra114-i2c";
+		reg = <0x0 0x03180000 0x0 0x10000>;
+		interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&bpmp TEGRA194_CLK_I2C3>;
+		clock-names = "div-clk";
+		resets = <&bpmp TEGRA194_RESET_I2C3>;
+		reset-names = "i2c";
+		status = "disabled";
+	};
+
+	/* shares pads with dpaux1 */
+	dp_aux_ch1_i2c: i2c at 3190000 {
+		compatible = "nvidia,tegra194-i2c", "nvidia,tegra114-i2c";
+		reg = <0x0 0x03190000 0x0 0x10000>;
+		interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&bpmp TEGRA194_CLK_I2C4>;
+		clock-names = "div-clk";
+		resets = <&bpmp TEGRA194_RESET_I2C4>;
+		reset-names = "i2c";
+		status = "disabled";
+	};
+
+	/* shares pads with dpaux0 */
+	dp_aux_ch0_i2c: i2c at 31b0000 {
+		compatible = "nvidia,tegra194-i2c", "nvidia,tegra114-i2c";
+		reg = <0x0 0x031b0000 0x0 0x10000>;
+		interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&bpmp TEGRA194_CLK_I2C6>;
+		clock-names = "div-clk";
+		resets = <&bpmp TEGRA194_RESET_I2C6>;
+		reset-names = "i2c";
+		status = "disabled";
+	};
+
+	gen7_i2c: i2c at 31c0000 {
+		compatible = "nvidia,tegra194-i2c", "nvidia,tegra114-i2c";
+		reg = <0x0 0x031c0000 0x0 0x10000>;
+		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&bpmp TEGRA194_CLK_I2C7>;
+		clock-names = "div-clk";
+		resets = <&bpmp TEGRA194_RESET_I2C7>;
+		reset-names = "i2c";
+		status = "disabled";
+	};
+
+	gen9_i2c: i2c at 31e0000 {
+		compatible = "nvidia,tegra194-i2c", "nvidia,tegra114-i2c";
+		reg = <0x0 0x031e0000 0x0 0x10000>;
+		interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&bpmp TEGRA194_CLK_I2C9>;
+		clock-names = "div-clk";
+		resets = <&bpmp TEGRA194_RESET_I2C9>;
+		reset-names = "i2c";
+		status = "disabled";
+	};
+
+	sdmmc1: sdhci at 3400000 {
+		compatible = "nvidia,tegra194-sdhci", "nvidia,tegra186-sdhci";
+		reg = <0x0 0x03400000 0x0 0x10000>;
+		interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&bpmp TEGRA194_CLK_SDMMC1>;
+		clock-names = "sdhci";
+		resets = <&bpmp TEGRA194_RESET_SDMMC1>;
+		reset-names = "sdhci";
+		status = "disabled";
+	};
+
+	sdmmc3: sdhci at 3440000 {
+		compatible = "nvidia,tegra194-sdhci", "nvidia,tegra186-sdhci";
+		reg = <0x0 0x03440000 0x0 0x10000>;
+		interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&bpmp TEGRA194_CLK_SDMMC3>;
+		clock-names = "sdhci";
+		resets = <&bpmp TEGRA194_RESET_SDMMC3>;
+		reset-names = "sdhci";
+		status = "disabled";
+	};
+
+	sdmmc4: sdhci at 3460000 {
+		compatible = "nvidia,tegra194-sdhci", "nvidia,tegra186-sdhci";
+		reg = <0x0 0x03460000 0x0 0x10000>;
+		interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&bpmp TEGRA194_CLK_SDMMC4>;
+		clock-names = "sdhci";
+		resets = <&bpmp TEGRA194_RESET_SDMMC4>;
+		reset-names = "sdhci";
+		status = "disabled";
+	};
+
+	gic: interrupt-controller at 3881000 {
+		compatible = "arm,gic-400";
+		#interrupt-cells = <3>;
+		interrupt-controller;
+		reg = <0x0 0x03881000 0x0 0x1000>,
+		      <0x0 0x03882000 0x0 0x2000>;
+		interrupts = <GIC_PPI 9
+			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+		interrupt-parent = <&gic>;
+	};
+
+	hsp_top0: hsp at 3c00000 {
+		compatible = "nvidia,tegra186-hsp";
+		reg = <0x0 0x03c00000 0x0 0xa0000>;
+		interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "doorbell";
+		#mbox-cells = <2>;
+	};
+
+	gen2_i2c: i2c at c240000 {
+		compatible = "nvidia,tegra194-i2c", "nvidia,tegra114-i2c";
+		reg = <0x0 0x0c240000 0x0 0x10000>;
+		interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&bpmp TEGRA194_CLK_I2C2>;
+		clock-names = "div-clk";
+		resets = <&bpmp TEGRA194_RESET_I2C2>;
+		reset-names = "i2c";
+		status = "disabled";
+	};
+
+	gen8_i2c: i2c at c250000 {
+		compatible = "nvidia,tegra194-i2c", "nvidia,tegra114-i2c";
+		reg = <0x0 0x0c250000 0x0 0x10000>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&bpmp TEGRA194_CLK_I2C8>;
+		clock-names = "div-clk";
+		resets = <&bpmp TEGRA194_RESET_I2C8>;
+		reset-names = "i2c";
+		status = "disabled";
+	};
+
+	uartc: serial at c280000 {
+		compatible = "nvidia,tegra194-uart", "nvidia,tegra20-uart";
+		reg = <0x0 0x0c280000 0x0 0x40>;
+		reg-shift = <2>;
+		interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&bpmp TEGRA194_CLK_UARTC>;
+		clock-names = "serial";
+		resets = <&bpmp TEGRA194_RESET_UARTC>;
+		reset-names = "serial";
+		status = "disabled";
+	};
+
+	uartg: serial at c290000 {
+		compatible = "nvidia,tegra194-uart", "nvidia,tegra20-uart";
+		reg = <0x0 0x0c290000 0x0 0x40>;
+		reg-shift = <2>;
+		interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&bpmp TEGRA194_CLK_UARTG>;
+		clock-names = "serial";
+		resets = <&bpmp TEGRA194_RESET_UARTG>;
+		reset-names = "serial";
+		status = "disabled";
+	};
+
+	pmc at c360000 {
+		compatible = "nvidia,tegra194-pmc";
+		reg = <0 0x0c360000 0 0x10000>,
+		      <0 0x0c370000 0 0x10000>,
+		      <0 0x0c380000 0 0x10000>,
+		      <0 0x0c390000 0 0x10000>,
+		      <0 0x0c3a0000 0 0x10000>;
+		reg-names = "pmc", "wake", "aotag", "scratch", "misc";
+	};
+
+	sysram at 40000000 {
+		compatible = "nvidia,tegra194-sysram", "mmio-sram";
+		reg = <0x0 0x40000000 0x0 0x50000>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0 0x0 0x0 0x40000000 0x0 0x50000>;
+
+		cpu_bpmp_tx: shmem at 4e000 {
+			compatible = "nvidia,tegra194-bpmp-shmem";
+			reg = <0x0 0x4e000 0x0 0x1000>;
+			label = "cpu-bpmp-tx";
+			pool;
+		};
+
+		cpu_bpmp_rx: shmem at 4f000 {
+			compatible = "nvidia,tegra194-bpmp-shmem";
+			reg = <0x0 0x4f000 0x0 0x1000>;
+			label = "cpu-bpmp-rx";
+			pool;
+		};
+	};
+
+	bpmp: bpmp {
+		compatible = "nvidia,tegra186-bpmp";
+		mboxes = <&hsp_top0 TEGRA_HSP_MBOX_TYPE_DB
+				    TEGRA_HSP_DB_MASTER_BPMP>;
+		shmem = <&cpu_bpmp_tx &cpu_bpmp_rx>;
+		#clock-cells = <1>;
+		#reset-cells = <1>;
+		#power-domain-cells = <1>;
+
+		bpmp_i2c: i2c {
+			compatible = "nvidia,tegra186-bpmp-i2c";
+			nvidia,bpmp-bus-id = <5>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		bpmp_thermal: thermal {
+			compatible = "nvidia,tegra186-bpmp-thermal";
+			#thermal-sensor-cells = <1>;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+		interrupt-parent = <&gic>;
+	};
+};
diff --git a/include/dt-bindings/clock/tegra194-clock.h b/include/dt-bindings/clock/tegra194-clock.h
new file mode 100644
index 000000000000..7eba4763e375
--- /dev/null
+++ b/include/dt-bindings/clock/tegra194-clock.h
@@ -0,0 +1,59 @@
+/*
+ * Copyright (c) 2018, NVIDIA CORPORATION.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __ABI_MACH_T194_CLOCK_H
+#define __ABI_MACH_T194_CLOCK_H
+
+/** @clkdesc{i2c_clks, out, mux, CLK_RST_CONTROLLER_CLK_SOURCE_I2C1} */
+#define TEGRA194_CLK_I2C1			48
+/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_I2C2 */
+#define TEGRA194_CLK_I2C2			49
+/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_I2C3 */
+#define TEGRA194_CLK_I2C3			50
+/** output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_I2C4 */
+#define TEGRA194_CLK_I2C4			51
+/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_I2C6 */
+#define TEGRA194_CLK_I2C6			52
+/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_I2C7 */
+#define TEGRA194_CLK_I2C7			53
+/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_I2C8 */
+#define TEGRA194_CLK_I2C8			54
+/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_I2C9 */
+#define TEGRA194_CLK_I2C9			55
+/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_SDMMC1 */
+#define TEGRA194_CLK_SDMMC1			120
+/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_SDMMC3 */
+#define TEGRA194_CLK_SDMMC3			122
+/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_SDMMC4 */
+#define TEGRA194_CLK_SDMMC4			123
+/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_UARTA */
+#define TEGRA194_CLK_UARTA			155
+/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_UARTB */
+#define TEGRA194_CLK_UARTB			156
+/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_UARTC */
+#define TEGRA194_CLK_UARTC			157
+/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_UARTD */
+#define TEGRA194_CLK_UARTD			158
+/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_UARTE */
+#define TEGRA194_CLK_UARTE			159
+/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_UARTF */
+#define TEGRA194_CLK_UARTF			160
+/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_UARTG */
+#define TEGRA194_CLK_UARTG			161
+/** @brief CLK_RST_CONTROLLER_CLK_SOURCE_UARTH switch divider output */
+#define TEGRA194_CLK_UARTH			190
+
+#endif
diff --git a/include/dt-bindings/gpio/tegra194-gpio.h b/include/dt-bindings/gpio/tegra194-gpio.h
new file mode 100644
index 000000000000..86435a73ef9e
--- /dev/null
+++ b/include/dt-bindings/gpio/tegra194-gpio.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This header provides constants for binding nvidia,tegra194-gpio*.
+ *
+ * The first cell in Tegra's GPIO specifier is the GPIO ID. The macros below
+ * provide names for this.
+ *
+ * The second cell contains standard flag values specified in gpio.h.
+ */
+
+#ifndef _DT_BINDINGS_GPIO_TEGRA194_GPIO_H
+#define _DT_BINDINGS_GPIO_TEGRA194_GPIO_H
+
+#include <dt-bindings/gpio/gpio.h>
+
+/* GPIOs implemented by main GPIO controller */
+#define TEGRA194_MAIN_GPIO_PORT_A 0
+#define TEGRA194_MAIN_GPIO_PORT_B 1
+#define TEGRA194_MAIN_GPIO_PORT_C 2
+#define TEGRA194_MAIN_GPIO_PORT_D 3
+#define TEGRA194_MAIN_GPIO_PORT_E 4
+#define TEGRA194_MAIN_GPIO_PORT_F 5
+#define TEGRA194_MAIN_GPIO_PORT_G 6
+#define TEGRA194_MAIN_GPIO_PORT_H 7
+#define TEGRA194_MAIN_GPIO_PORT_I 8
+#define TEGRA194_MAIN_GPIO_PORT_J 9
+#define TEGRA194_MAIN_GPIO_PORT_K 10
+#define TEGRA194_MAIN_GPIO_PORT_L 11
+#define TEGRA194_MAIN_GPIO_PORT_M 12
+#define TEGRA194_MAIN_GPIO_PORT_N 13
+#define TEGRA194_MAIN_GPIO_PORT_O 14
+#define TEGRA194_MAIN_GPIO_PORT_P 15
+#define TEGRA194_MAIN_GPIO_PORT_Q 16
+#define TEGRA194_MAIN_GPIO_PORT_R 17
+#define TEGRA194_MAIN_GPIO_PORT_S 18
+#define TEGRA194_MAIN_GPIO_PORT_T 19
+#define TEGRA194_MAIN_GPIO_PORT_U 20
+#define TEGRA194_MAIN_GPIO_PORT_V 21
+#define TEGRA194_MAIN_GPIO_PORT_W 22
+#define TEGRA194_MAIN_GPIO_PORT_X 23
+#define TEGRA194_MAIN_GPIO_PORT_Y 24
+#define TEGRA194_MAIN_GPIO_PORT_Z 25
+#define TEGRA194_MAIN_GPIO_PORT_FF 26
+#define TEGRA194_MAIN_GPIO_PORT_GG 27
+
+#define TEGRA194_MAIN_GPIO(port, offset) \
+	((TEGRA194_MAIN_GPIO_PORT_##port * 8) + offset)
+
+/* GPIOs implemented by AON GPIO controller */
+#define TEGRA194_AON_GPIO_PORT_AA 0
+#define TEGRA194_AON_GPIO_PORT_BB 1
+#define TEGRA194_AON_GPIO_PORT_CC 2
+#define TEGRA194_AON_GPIO_PORT_DD 3
+#define TEGRA194_AON_GPIO_PORT_EE 4
+
+#define TEGRA194_AON_GPIO(port, offset) \
+	((TEGRA194_AON_GPIO_PORT_##port * 8) + offset)
+
+#endif
diff --git a/include/dt-bindings/reset/tegra194-reset.h b/include/dt-bindings/reset/tegra194-reset.h
new file mode 100644
index 000000000000..7c6afac99c4a
--- /dev/null
+++ b/include/dt-bindings/reset/tegra194-reset.h
@@ -0,0 +1,40 @@
+/*
+ * Copyright (c) 2018, NVIDIA CORPORATION.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __ABI_MACH_T194_RESET_H
+#define __ABI_MACH_T194_RESET_H
+
+#define TEGRA194_RESET_I2C1			24
+#define TEGRA194_RESET_I2C2			29
+#define TEGRA194_RESET_I2C3			30
+#define TEGRA194_RESET_I2C4			31
+#define TEGRA194_RESET_I2C6			32
+#define TEGRA194_RESET_I2C7			33
+#define TEGRA194_RESET_I2C8			34
+#define TEGRA194_RESET_I2C9			35
+#define TEGRA194_RESET_SDMMC1			82
+#define TEGRA194_RESET_SDMMC3			84
+#define TEGRA194_RESET_SDMMC4			85
+#define TEGRA194_RESET_UARTA			100
+#define TEGRA194_RESET_UARTB			101
+#define TEGRA194_RESET_UARTC			102
+#define TEGRA194_RESET_UARTD			103
+#define TEGRA194_RESET_UARTE			104
+#define TEGRA194_RESET_UARTF			105
+#define TEGRA194_RESET_UARTG			106
+#define TEGRA194_RESET_UARTH                    107
+
+#endif
-- 
2.1.4
