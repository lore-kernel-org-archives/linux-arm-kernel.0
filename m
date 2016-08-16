From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 16 Aug 2016 15:35:26 +0900
Subject: [PATCH 5/7] arm64: dts: exynos: Add dts files for Samsung Exynos5433
 64bit SoC
In-Reply-To: <1471328843-26653-1-git-send-email-cw00.choi@samsung.com>
References: <1471328843-26653-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1471329328-26842-1-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds new Exynos5433 dtsi to support 64-bit Exynos5433 SoC based on
Octa-core CPUs (quad Cortex-A57 and quad Cortex-A53). And Exynos5433 supports
PSCI (Power State Coordination Interface) v0.1.

This patch includes following Device Tree node to support Exynos5433 SoC:
1. Octa cores for big.LITTLE architecture
- Cortex-A53 LITTLE Quad-core
- Cortex-A57 big Quad-core
- Support PSCI v0.1

2. Clock controller node
- CMU_TOP   : clocks for IMEM/FSYS/G3D/GSCL/HEVC/MSCL/G2D/MFC/PERIC/PERIS
- CMU_CPIF  : clocks for LLI (Low Latency Interface)
- CMU_MIF   : clocks for DRAM Memory Controller
- CMU_PERIC : clocks for UART/I2C/SPI/I2S/PCM/SPDIF/PWM/SLIMBUS
- CMU_PERIS : clocks for PMU/TMU/MCT/WDT/RTC/SECKEY/TZPC
- CMU_FSYS  : clocks for USB/UFS/SDMMC/TSI/PDMA
- CMU_G2D   : clocks for G2D/MDMA
- CMU_DISP  : clocks for DECON/HDMI/DSIM/MIXER
- CMU_AUD   : clocks for Cortex-A5/BUS/AUDIO
- CMU_BUS{0|1|2} : clocks for global data buses and global peripheral buses
- CMU_G3D   : clocks for 3D Graphics Engine
- CMU_GSCL  : clocks for GSCALER
- CMU_APOLLO: clocks for Cortex-A53 Quad-core processor.
- CMU_ATLAS : clocks for Cortex-A57 Quad-core processor,
              CoreSight and L2 cache controller.
- CMU_MSCL  : clocks for M2M (Memory to Memory) scaler and JPEG IPs.
- CMU_MFC   : clocks for MFC (Multi-Format Codec) IP.
- CMU_HEVC  : clocks for HEVC(High Efficiency Video Codec) decoder IP.
- CMU_ISP   : clocks for FIMC-ISP/DRC/SCLC/DIS/3DNR IPs.
- CMU_CAM0  : clocks for MIPI_CSIS{0|1}/FIMC_LITE_{A|B|D}/FIMC_3AA{0|1} IPs.
- CMU_CAM1  : clocks for COrtex-A5/MIPI_CSIS2/FIMC_LITE_C/FIMC-FD IPs.

3. pinctrl node for GPIO
- alive/aud/cpif/ese/finger/fsys/imem/nfc/peric/touch pad

4. Timer
- ARM architecture timer (armv8-timer)
- MCT (Multi Core Timer) timer

5. Interrupt controller (GIC-400)

6. BUS devices
- HS-I2C (High-Speed I2C) device
- SPI (Serial Peripheral Interface) device

7. Sound devices
- I2S bus
- LPASS (Low Power Audio Subsystem)

8. Power management devices
- CPUFREQ for for Cortex-A53/A57
- TMU (Thermal Management Unit) for Cortex-A53/A57, G3D, ISP

9. Display controller devices
- DECON (Display and enhancement controller) for panel output
- DSI (Display Serial Interface)
- MIC (Mobile Image Compressor)
- IOMMU for GSCL/DECON/TV/MFC/JPEG/FLITE/3AA/FIMC

10. USB
- USB 3.0 DRD (Dual Role Device) controller
- USB 3.0 Host controller

11. Storage devices
- MSHC (Mobile Stoarage Host Controller)

12. Misc devices
- UART device
- ADC (Analog Digital Converter)
- PWM (Pulse Width Modulation)
- ADMA (Advanced DMA) and PDMA (Peripheral DMA)

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
Signed-off-by: Inki Dae <inki.dae@samsung.com>
Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
Signed-off-by: Hyungwon Hwang <human.hwang@samsung.com>
Signed-off-by: Inha Song <ideal.song@samsung.com>
Signed-off-by: Ingi kim <ingi2.kim@samsung.com>
Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi |  794 ++++++++++
 .../dts/exynos/exynos5433-tmu-g3d-sensor-conf.dtsi |   23 +
 .../dts/exynos/exynos5433-tmu-sensor-conf.dtsi     |   22 +
 arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi     |  306 ++++
 arch/arm64/boot/dts/exynos/exynos5433.dtsi         | 1580 ++++++++++++++++++++
 5 files changed, 2725 insertions(+)
 create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tmu-g3d-sensor-conf.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tmu-sensor-conf.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/exynos5433.dtsi

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi
new file mode 100644
index 000000000000..2bf94face3f7
--- /dev/null
+++ b/arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi
@@ -0,0 +1,794 @@
+/*
+ * Samsung's Exynos5433 SoC pin-mux and pin-config device tree source
+ *
+ * Copyright (c) 2016 Samsung Electronics Co., Ltd.
+ * Chanwoo Choi <cw00.choi@samsung.com>
+ *
+ * Samsung's Exynos5433 SoC pin-mux and pin-config options are listed as device
+ * tree nodes are listed in this file.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#define PIN_PULL_NONE		0
+#define PIN_PULL_DOWN		1
+#define PIN_PULL_UP		3
+
+#define PIN_DRV_LV1		0
+#define PIN_DRV_LV2		2
+#define PIN_DRV_LV3		1
+#define PIN_DRV_LV4		3
+
+#define PIN_IN			0
+#define PIN_OUT			1
+#define PIN_FUNC1		2
+
+#define PIN(_func, _pin, _pull, _drv)			\
+	_pin {						\
+		samsung,pins = #_pin;			\
+		samsung,pin-function = <PIN_ ##_func>;	\
+		samsung,pin-pud = <PIN_PULL_ ##_pull>;	\
+		samsung,pin-drv = <PIN_DRV_ ##_drv>;	\
+	}
+
+&pinctrl_alive {
+	gpa0: gpa0 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		interrupt-parent = <&gic>;
+		interrupts = <0 0 0>, <0 1 0>, <0 2 0>, <0 3 0>,
+				<0 4 0>, <0 5 0>, <0 6 0>, <0 7 0>;
+		#interrupt-cells = <2>;
+	};
+
+	gpa1: gpa1 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		interrupt-parent = <&gic>;
+		interrupts = <0 8 0>, <0 9 0>, <0 10 0>, <0 11 0>,
+				<0 12 0>, <0 13 0>, <0 14 0>, <0 15 0>;
+		#interrupt-cells = <2>;
+	};
+
+	gpa2: gpa2 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpa3: gpa3 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpf1: gpf1 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpf2: gpf2 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpf3: gpf3 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpf4: gpf4 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpf5: gpf5 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+};
+
+&pinctrl_aud {
+	gpz0: gpz0 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpz1: gpz1 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	i2s0_bus: i2s0-bus {
+		samsung,pins = "gpz0-0", "gpz0-1", "gpz0-2", "gpz0-3",
+				"gpz0-4", "gpz0-5", "gpz0-6";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <1>;
+		samsung,pin-drv = <0>;
+	};
+
+	pcm0_bus: pcm0-bus {
+		samsung,pins = "gpz1-0", "gpz1-1", "gpz1-2", "gpz1-3";
+		samsung,pin-function = <3>;
+		samsung,pin-pud = <1>;
+		samsung,pin-drv = <0>;
+	};
+
+	uart_aud_bus: uart-aud-bus {
+		samsung,pins = "gpz1-3", "gpz1-2", "gpz1-1", "gpz1-0";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
+};
+
+&pinctrl_cpif {
+	gpv6: gpv6 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+};
+
+&pinctrl_ese {
+	gpj2: gpj2 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+};
+
+&pinctrl_finger {
+	gpd5: gpd5 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	spi2_bus: spi2-bus {
+		samsung,pins = "gpd5-0", "gpd5-2", "gpd5-3";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <0>;
+	};
+
+	hs_i2c6_bus: hs-i2c6-bus {
+		samsung,pins = "gpd5-3", "gpd5-2";
+		samsung,pin-function = <4>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <0>;
+	};
+
+};
+
+&pinctrl_fsys {
+	gph1: gph1 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpr4: gpr4 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpr0: gpr0 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpr1: gpr1 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpr2: gpr2 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpr3: gpr3 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+	sd0_clk: sd0-clk {
+		samsung,pins = "gpr0-0";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <3>;
+	};
+
+	sd0_cmd: sd0-cmd {
+		samsung,pins = "gpr0-1";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <3>;
+	};
+
+	sd0_rdqs: sd0-rdqs {
+		samsung,pins = "gpr0-2";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <1>;
+		samsung,pin-drv = <3>;
+	};
+
+	sd0_qrdy: sd0-qrdy {
+		samsung,pins = "gpr0-3";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <1>;
+		samsung,pin-drv = <3>;
+	};
+
+	sd0_bus1: sd0-bus-width1 {
+		samsung,pins = "gpr1-0";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <3>;
+	};
+
+	sd0_bus4: sd0-bus-width4 {
+		samsung,pins = "gpr1-1", "gpr1-2", "gpr1-3";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <3>;
+	};
+
+	sd0_bus8: sd0-bus-width8 {
+		samsung,pins = "gpr1-4", "gpr1-5", "gpr1-6", "gpr1-7";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <3>;
+	};
+
+	sd1_clk: sd1-clk {
+		samsung,pins = "gpr2-0";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <3>;
+	};
+
+	sd1_cmd: sd1-cmd {
+		samsung,pins = "gpr2-1";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <3>;
+	};
+
+	sd1_bus1: sd1-bus-width1 {
+		samsung,pins = "gpr3-0";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <3>;
+	};
+
+	sd1_bus4: sd1-bus-width4 {
+		samsung,pins = "gpr3-1", "gpr3-2", "gpr3-3";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <3>;
+	};
+
+	sd1_bus8: sd1-bus-width8 {
+		samsung,pins = "gpr3-4", "gpr3-5", "gpr3-6", "gpr3-7";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <3>;
+	};
+
+	pcie_bus: pcie_bus {
+		samsung,pins = "gpr3-4", "gpr3-5", "gpr3-6", "gpr3-7";
+		samsung,pin-function = <3>;
+		samsung,pin-pud = <3>;
+	};
+
+	sd2_clk: sd2-clk {
+		samsung,pins = "gpr4-0";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <3>;
+	};
+
+	sd2_cmd: sd2-cmd {
+		samsung,pins = "gpr4-1";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <3>;
+	};
+
+	sd2_cd: sd2-cd {
+		samsung,pins = "gpr4-2";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <3>;
+	};
+
+	sd2_bus1: sd2-bus-width1 {
+		samsung,pins = "gpr4-3";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <3>;
+	};
+
+	sd2_bus4: sd2-bus-width4 {
+		samsung,pins = "gpr4-4", "gpr4-5", "gpr4-6";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <3>;
+	};
+
+	sd2_clk_output: sd2-clk-output {
+		samsung,pins = "gpr4-0";
+		samsung,pin-function = <1>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <2>;
+	};
+
+	sd2_cmd_output: sd2-cmd-output {
+		samsung,pins = "gpr4-1";
+		samsung,pin-function = <1>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <2>;
+	};
+};
+
+&pinctrl_imem {
+	gpf0: gpf0 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+};
+
+&pinctrl_nfc {
+	gpj0: gpj0 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	hs_i2c4_bus: hs-i2c4-bus {
+		samsung,pins = "gpj0-1", "gpj0-0";
+		samsung,pin-function = <4>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <0>;
+	};
+
+};
+
+&pinctrl_peric {
+	gpv7: gpv7 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpb0: gpb0 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpc0: gpc0 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpc1: gpc1 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpc2: gpc2 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpc3: gpc3 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpg0: gpg0 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpd0: gpd0 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpd1: gpd1 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpd2: gpd2 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpd4: gpd4 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpd8: gpd8 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpd6: gpd6 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpd7: gpd7 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpg1: gpg1 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpg2: gpg2 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpg3: gpg3 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	hs_i2c8_bus: hs-i2c8-bus {
+		samsung,pins = "gpb0-1", "gpb0-0";
+		samsung,pin-function = <4>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <0>;
+	};
+
+	hs_i2c9_bus: hs-i2c9-bus {
+		samsung,pins = "gpb0-3", "gpb0-2";
+		samsung,pin-function = <4>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <0>;
+	};
+
+	i2s1_bus: i2s1-bus {
+		samsung,pins = "gpd4-0", "gpd4-1", "gpd4-2",
+				"gpd4-3", "gpd4-4";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <1>;
+		samsung,pin-drv = <0>;
+	};
+
+	pcm1_bus: pcm1-bus {
+		samsung,pins = "gpd4-0", "gpd4-1", "gpd4-2",
+				"gpd4-3", "gpd4-4";
+		samsung,pin-function = <3>;
+		samsung,pin-pud = <1>;
+		samsung,pin-drv = <0>;
+	};
+
+	spdif_bus: spdif-bus {
+		samsung,pins = "gpd4-3", "gpd4-4";
+		samsung,pin-function = <4>;
+		samsung,pin-pud = <1>;
+		samsung,pin-drv = <0>;
+	};
+
+	fimc_is_spi_pin0: fimc-is-spi-pin0 {
+		samsung,pins = "gpc3-3", "gpc3-2", "gpc3-1", "gpc3-0";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
+
+	fimc_is_spi_pin1: fimc-is-spi-pin1 {
+		samsung,pins = "gpc3-7", "gpc3-6", "gpc3-5", "gpc3-4";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
+
+	uart0_bus: uart0-bus {
+		samsung,pins = "gpd0-3", "gpd0-2", "gpd0-1", "gpd0-0";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <0>;
+	};
+
+	hs_i2c2_bus: hs-i2c2-bus {
+		samsung,pins = "gpd0-3", "gpd0-2";
+		samsung,pin-function = <3>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <0>;
+	};
+
+	uart2_bus: uart2-bus {
+		samsung,pins = "gpd1-5", "gpd1-4";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <0>;
+	};
+
+	uart1_bus: uart1-bus {
+		samsung,pins = "gpd1-3", "gpd1-2", "gpd1-1", "gpd1-0";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <0>;
+	};
+
+	hs_i2c3_bus: hs-i2c3-bus {
+		samsung,pins = "gpd1-3", "gpd1-2";
+		samsung,pin-function = <3>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <0>;
+	};
+
+
+	hs_i2c0_bus: hs-i2c0-bus {
+		samsung,pins = "gpd2-1", "gpd2-0";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <0>;
+	};
+
+	hs_i2c1_bus: hs-i2c1-bus {
+		samsung,pins = "gpd2-3", "gpd2-2";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <0>;
+	};
+
+	pwm0_out: pwm0-out {
+		samsung,pins = "gpd2-4";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
+
+	pwm1_out: pwm1-out {
+		samsung,pins = "gpd2-5";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
+
+	pwm2_out: pwm2-out {
+		samsung,pins = "gpd2-6";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
+
+	pwm3_out: pwm3-out {
+		samsung,pins = "gpd2-7";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
+
+	spi1_bus: spi1-bus {
+		samsung,pins = "gpd6-2", "gpd6-4", "gpd6-5";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <0>;
+	};
+
+	hs_i2c7_bus: hs-i2c7-bus {
+		samsung,pins = "gpd2-7", "gpd2-6";
+		samsung,pin-function = <4>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <0>;
+	};
+
+	spi0_bus: spi0-bus {
+		samsung,pins = "gpd8-0", "gpd6-0", "gpd6-1";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <0>;
+	};
+
+	hs_i2c10_bus: hs-i2c10-bus {
+		samsung,pins = "gpg3-1", "gpg3-0";
+		samsung,pin-function = <4>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <0>;
+	};
+
+	hs_i2c11_bus: hs-i2c11-bus {
+		samsung,pins = "gpg3-3", "gpg3-2";
+		samsung,pin-function = <4>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <0>;
+	};
+
+	spi3_bus: spi3-bus {
+		samsung,pins = "gpg3-4", "gpg3-6", "gpg3-7";
+		samsung,pin-function = <3>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <0>;
+	};
+
+	spi4_bus: spi4-bus {
+		samsung,pins = "gpv7-1", "gpv7-3", "gpv7-4";
+		samsung,pin-function = <3>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <0>;
+	};
+
+	fimc_is_uart: fimc-is-uart {
+		samsung,pins = "gpc1-1", "gpc0-7";
+		samsung,pin-function = <3>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
+
+	fimc_is_ch0_i2c: fimc-is-ch0_i2c {
+		samsung,pins = "gpc2-1", "gpc2-0";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
+
+	fimc_is_ch0_mclk: fimc-is-ch0_mclk {
+		samsung,pins = "gpd7-0";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
+
+	fimc_is_ch1_i2c: fimc-is-ch1-i2c {
+		samsung,pins = "gpc2-3", "gpc2-2";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
+
+	fimc_is_ch1_mclk: fimc-is-ch1-mclk {
+		samsung,pins = "gpd7-1";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
+
+	fimc_is_ch2_i2c: fimc-is-ch2-i2c {
+		samsung,pins = "gpc2-5", "gpc2-4";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
+
+	fimc_is_ch2_mclk: fimc-is-ch2-mclk {
+		samsung,pins = "gpd7-2";
+		samsung,pin-function = <2>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
+};
+
+&pinctrl_touch {
+	gpj1: gpj1 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	hs_i2c5_bus: hs-i2c5-bus {
+		samsung,pins = "gpj1-1", "gpj1-0";
+		samsung,pin-function = <4>;
+		samsung,pin-pud = <3>;
+		samsung,pin-drv = <0>;
+	};
+};
diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tmu-g3d-sensor-conf.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tmu-g3d-sensor-conf.dtsi
new file mode 100644
index 000000000000..9be2978f1b9a
--- /dev/null
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tmu-g3d-sensor-conf.dtsi
@@ -0,0 +1,23 @@
+/*
+ * Device tree sources for Exynos5433 TMU sensor configuration
+ *
+ * Copyright (c) 2016 Jonghwa Lee <jonghwa3.lee@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <dt-bindings/thermal/thermal_exynos.h>
+
+#thermal-sensor-cells = <0>;
+samsung,tmu_gain = <8>;
+samsung,tmu_reference_voltage = <23>;
+samsung,tmu_noise_cancel_mode = <4>;
+samsung,tmu_efuse_value = <75>;
+samsung,tmu_min_efuse_value = <40>;
+samsung,tmu_max_efuse_value = <150>;
+samsung,tmu_first_point_trim = <25>;
+samsung,tmu_second_point_trim = <85>;
+samsung,tmu_default_temp_offset = <50>;
+samsung,tmu_mux_addr = <6>;
diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tmu-sensor-conf.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tmu-sensor-conf.dtsi
new file mode 100644
index 000000000000..125fe58d77ce
--- /dev/null
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tmu-sensor-conf.dtsi
@@ -0,0 +1,22 @@
+/*
+ * Device tree sources for Exynos5433 TMU sensor configuration
+ *
+ * Copyright (c) 2016 Chanwoo Choi <cw00.choi@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <dt-bindings/thermal/thermal_exynos.h>
+
+#thermal-sensor-cells = <0>;
+samsung,tmu_gain = <8>;
+samsung,tmu_reference_voltage = <16>;
+samsung,tmu_noise_cancel_mode = <4>;
+samsung,tmu_efuse_value = <75>;
+samsung,tmu_min_efuse_value = <40>;
+samsung,tmu_max_efuse_value = <150>;
+samsung,tmu_first_point_trim = <25>;
+samsung,tmu_second_point_trim = <85>;
+samsung,tmu_default_temp_offset = <50>;
diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi
new file mode 100644
index 000000000000..175121db367e
--- /dev/null
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi
@@ -0,0 +1,306 @@
+/*
+ * Device tree sources for Exynos5433 thermal zone
+ *
+ * Copyright (c) 2016 Chanwoo Choi <cw00.choi@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <dt-bindings/thermal/thermal.h>
+
+/ {
+thermal-zones {
+	atlas0_thermal: atlas0-thermal {
+		thermal-sensors = <&tmu_atlas0>;
+		polling-delay-passive = <0>;
+		polling-delay = <0>;
+		trips {
+			atlas0_alert_0: atlas0-alert-0 {
+				temperature = <50000>;	/* millicelsius */
+				hysteresis = <1000>;	/* millicelsius */
+				type = "active";
+			};
+			atlas0_alert_1: atlas0-alert-1 {
+				temperature = <55000>;	/* millicelsius */
+				hysteresis = <1000>;	/* millicelsius */
+				type = "active";
+			};
+			atlas0_alert_2: atlas0-alert-2 {
+				temperature = <60000>;	/* millicelsius */
+				hysteresis = <1000>;	/* millicelsius */
+				type = "active";
+			};
+			atlas0_alert_3: atlas0-alert-3 {
+				temperature = <70000>;	/* millicelsius */
+				hysteresis = <1000>;	/* millicelsius */
+				type = "active";
+			};
+			atlas0_alert_4: atlas0-alert-4 {
+				temperature = <80000>;	/* millicelsius */
+				hysteresis = <1000>;	/* millicelsius */
+				type = "active";
+			};
+			atlas0_alert_5: atlas0-alert-5 {
+				temperature = <90000>;	/* millicelsius */
+				hysteresis = <1000>;	/* millicelsius */
+				type = "active";
+			};
+			atlas0_alert_6: atlas0-alert-6 {
+				temperature = <95000>;	/* millicelsius */
+				hysteresis = <1000>;	/* millicelsius */
+				type = "active";
+			};
+		};
+
+		cooling-maps {
+			map0 {
+				/* Set maximum frequency as 1800MHz  */
+				trip = <&atlas0_alert_0>;
+				cooling-device = <&cpu4 1 1>;
+			};
+			map1 {
+				/* Set maximum frequency as 1700MHz  */
+				trip = <&atlas0_alert_1>;
+				cooling-device = <&cpu4 2 2>;
+			};
+			map2 {
+				/* Set maximum frequency as 1600MHz  */
+				trip = <&atlas0_alert_2>;
+				cooling-device = <&cpu4 3 3>;
+			};
+			map3 {
+				/* Set maximum frequency as 1500MHz  */
+				trip = <&atlas0_alert_3>;
+				cooling-device = <&cpu4 4 4>;
+			};
+			map4 {
+				/* Set maximum frequency as 1400MHz  */
+				trip = <&atlas0_alert_4>;
+				cooling-device = <&cpu4 5 5>;
+			};
+			map5 {
+				/* Set maximum frequencyas 1200MHz  */
+				trip = <&atlas0_alert_5>;
+				cooling-device = <&cpu4 7 7>;
+			};
+			map6 {
+				/* Set maximum frequency as 800MHz  */
+				trip = <&atlas0_alert_6>;
+				cooling-device = <&cpu4 11 11>;
+			};
+		};
+	};
+
+	atlas1_thermal: atlas1-thermal {
+		thermal-sensors = <&tmu_atlas1>;
+		polling-delay-passive = <0>;
+		polling-delay = <0>;
+		trips {
+			atlas1_alert_0: atlas1-alert-0 {
+				temperature = <50000>;	/* millicelsius */
+				hysteresis = <1000>;	/* millicelsius */
+				type = "active";
+			};
+			atlas1_alert_1: atlas1-alert-1 {
+				temperature = <55000>;	/* millicelsius */
+				hysteresis = <1000>;	/* millicelsius */
+				type = "active";
+			};
+			atlas1_alert_2: atlas1-alert-2 {
+				temperature = <60000>;	/* millicelsius */
+				hysteresis = <1000>;	/* millicelsius */
+				type = "active";
+			};
+			atlas1_alert_3: atlas1-alert-3 {
+				temperature = <70000>;	/* millicelsius */
+				hysteresis = <1000>;	/* millicelsius */
+				type = "active";
+			};
+			atlas1_alert_4: atlas1-alert-4 {
+				temperature = <80000>;	/* millicelsius */
+				hysteresis = <1000>;	/* millicelsius */
+				type = "active";
+			};
+			atlas1_alert_5: atlas1-alert-5 {
+				temperature = <90000>;	/* millicelsius */
+				hysteresis = <1000>;	/* millicelsius */
+				type = "active";
+			};
+			atlas1_alert_6: atlas1-alert-6 {
+				temperature = <95000>;	/* millicelsius */
+				hysteresis = <1000>;	/* millicelsius */
+				type = "active";
+			};
+		};
+	};
+
+	g3d_thermal: g3d-thermal {
+		thermal-sensors = <&tmu_g3d>;
+		polling-delay-passive = <0>;
+		polling-delay = <0>;
+		trips {
+			g3d_alert_0: g3d-alert-0 {
+				temperature = <70000>;	/* millicelsius */
+				hysteresis = <1000>;	/* millicelsius */
+				type = "active";
+			};
+			g3d_alert_1: g3d-alert-1 {
+				temperature = <75000>;	/* millicelsius */
+				hysteresis = <1000>;	/* millicelsius */
+				type = "active";
+			};
+			g3d_alert_2: g3d-alert-2 {
+				temperature = <80000>;	/* millicelsius */
+				hysteresis = <1000>;	/* millicelsius */
+				type = "active";
+			};
+			g3d_alert_3: g3d-alert-3 {
+				temperature = <85000>;	/* millicelsius */
+				hysteresis = <1000>;	/* millicelsius */
+				type = "active";
+			};
+			g3d_alert_4: g3d-alert-4 {
+				temperature = <90000>;	/* millicelsius */
+				hysteresis = <1000>;	/* millicelsius */
+				type = "active";
+			};
+			g3d_alert_5: g3d-alert-5 {
+				temperature = <95000>;	/* millicelsius */
+				hysteresis = <1000>;	/* millicelsius */
+				type = "active";
+			};
+			g3d_alert_6: g3d-alert-6 {
+				temperature = <100000>;	/* millicelsius */
+				hysteresis = <1000>;	/* millicelsius */
+				type = "active";
+			};
+		};
+	};
+
+	apollo_thermal: apollo-thermal {
+		thermal-sensors = <&tmu_apollo>;
+		polling-delay-passive = <0>;
+		polling-delay = <0>;
+		trips {
+			apollo_alert_0: apollo-alert-0 {
+				temperature = <50000>;	/* millicelsius */
+				hysteresis = <10000>;	/* millicelsius */
+				type = "active";
+			};
+			apollo_alert_1: apollo-alert-1 {
+				temperature = <55000>;	/* millicelsius */
+				hysteresis = <1000>;	/* millicelsius */
+				type = "active";
+			};
+			apollo_alert_2: apollo-alert-2 {
+				temperature = <60000>;	/* millicelsius */
+				hysteresis = <1000>;	/* millicelsius */
+				type = "active";
+			};
+			apollo_alert_3: apollo-alert-3 {
+				temperature = <70000>;	/* millicelsius */
+				hysteresis = <1000>;	/* millicelsius */
+				type = "active";
+			};
+			apollo_alert_4: apollo-alert-4 {
+				temperature = <80000>;	/* millicelsius */
+				hysteresis = <1000>;	/* millicelsius */
+				type = "active";
+			};
+			apollo_alert_5: apollo-alert-5 {
+				temperature = <90000>;	/* millicelsius */
+				hysteresis = <1000>;	/* millicelsius */
+				type = "active";
+			};
+			apollo_alert_6: apollo-alert-6 {
+				temperature = <95000>;	/* millicelsius */
+				hysteresis = <1000>;	/* millicelsius */
+				type = "active";
+			};
+		};
+
+		cooling-maps {
+			map0 {
+				/* Set maximum frequency as 1200MHz  */
+				trip = <&apollo_alert_0>;
+				cooling-device = <&cpu0 1 1>;
+			};
+			map1 {
+				/* Set maximum frequency as 1100MHz  */
+				trip = <&apollo_alert_1>;
+				cooling-device = <&cpu0 2 2>;
+			};
+			map2 {
+				/* Set maximum frequency as 1000MHz  */
+				trip = <&apollo_alert_2>;
+				cooling-device = <&cpu0 3 3>;
+			};
+			map3 {
+				/* Set maximum frequency as 900MHz  */
+				trip = <&apollo_alert_3>;
+				cooling-device = <&cpu0 4 4>;
+			};
+			map4 {
+				/* Set maximum frequency as 800MHz  */
+				trip = <&apollo_alert_4>;
+				cooling-device = <&cpu0 5 5>;
+			};
+			map5 {
+				/* Set maximum frequency as 700MHz  */
+				trip = <&apollo_alert_5>;
+				cooling-device = <&cpu0 6 6>;
+			};
+			map6 {
+				/* Set maximum frequency as 500MHz  */
+				trip = <&apollo_alert_6>;
+				cooling-device = <&cpu0 8 8>;
+			};
+		};
+	};
+
+	isp_thermal: isp-thermal {
+		thermal-sensors = <&tmu_isp>;
+		polling-delay-passive = <0>;
+		polling-delay = <0>;
+		trips {
+			isp_alert_0: isp-alert-0 {
+				temperature = <80000>;	/* millicelsius */
+				hysteresis = <1000>;	/* millicelsius */
+				type = "active";
+			};
+			isp_alert_1: isp-alert-1 {
+				temperature = <85000>;	/* millicelsius */
+				hysteresis = <1000>;	/* millicelsius */
+				type = "active";
+			};
+			isp_alert_2: isp-alert-2 {
+				temperature = <90000>;	/* millicelsius */
+				hysteresis = <1000>;	/* millicelsius */
+				type = "active";
+			};
+			isp_alert_3: isp-alert-3 {
+				temperature = <95000>;	/* millicelsius */
+				hysteresis = <1000>;	/* millicelsius */
+				type = "active";
+			};
+			isp_alert_4: isp-alert-4 {
+				temperature = <100000>;	/* millicelsius */
+				hysteresis = <1000>;	/* millicelsius */
+				type = "active";
+			};
+			isp_alert_5: isp-alert-5 {
+				temperature = <105000>;	/* millicelsius */
+				hysteresis = <1000>;	/* millicelsius */
+				type = "active";
+			};
+			isp_alert_6: isp-alert-6 {
+				temperature = <110000>;	/* millicelsius */
+				hysteresis = <1000>;	/* millicelsius */
+				type = "active";
+			};
+		};
+	};
+};
+};
diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
new file mode 100644
index 000000000000..2a5b05744533
--- /dev/null
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -0,0 +1,1580 @@
+/*
+ * Samsung's Exynos5433 SoC device tree source
+ *
+ * Copyright (c) 2016 Samsung Electronics Co., Ltd.
+ *
+ * Samsung's Exynos5433 SoC device nodes are listed in this file.
+ * Exynos5433 based board files can include this file and provide
+ * values for board specific bindings.
+ *
+ * Note: This file does not include device nodes for all the controllers in
+ * Exynos5433 SoC. As device tree coverage for Exynos5433 increases,
+ * additional nodes can be added to this file.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <dt-bindings/clock/exynos5433.h>
+
+/ {
+	compatible = "samsung,exynos5433";
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	interrupt-parent = <&gic>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu at 100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			enable-method = "psci";
+			reg = <0x100>;
+			clock-frequency = <1300000000>;
+			clocks = <&cmu_apollo CLK_SCLK_APOLLO>;
+			clock-names = "apolloclk";
+			operating-points-v2 = <&cluster_a53_opp_table>;
+			#cooling-cells = <2>;
+		};
+
+		cpu1: cpu at 101 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			enable-method = "psci";
+			reg = <0x101>;
+			clock-frequency = <1300000000>;
+			operating-points-v2 = <&cluster_a53_opp_table>;
+			#cooling-cells = <2>;
+		};
+
+		cpu2: cpu at 102 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			enable-method = "psci";
+			reg = <0x102>;
+			clock-frequency = <1300000000>;
+			operating-points-v2 = <&cluster_a53_opp_table>;
+			#cooling-cells = <2>;
+		};
+
+		cpu3: cpu at 103 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			enable-method = "psci";
+			reg = <0x103>;
+			clock-frequency = <1300000000>;
+			operating-points-v2 = <&cluster_a53_opp_table>;
+			#cooling-cells = <2>;
+		};
+
+		cpu4: cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57", "arm,armv8";
+			enable-method = "psci";
+			reg = <0x0>;
+			clock-frequency = <1900000000>;
+			clocks = <&cmu_atlas CLK_SCLK_ATLAS>;
+			clock-names = "atlasclk";
+			operating-points-v2 = <&cluster_a57_opp_table>;
+			#cooling-cells = <2>;
+		};
+
+		cpu5: cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57", "arm,armv8";
+			enable-method = "psci";
+			reg = <0x1>;
+			clock-frequency = <1900000000>;
+			operating-points-v2 = <&cluster_a57_opp_table>;
+			#cooling-cells = <2>;
+		};
+
+		cpu6: cpu at 2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57", "arm,armv8";
+			enable-method = "psci";
+			reg = <0x2>;
+			clock-frequency = <1900000000>;
+			operating-points-v2 = <&cluster_a57_opp_table>;
+			#cooling-cells = <2>;
+		};
+
+		cpu7: cpu at 3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57", "arm,armv8";
+			enable-method = "psci";
+			reg = <0x3>;
+			clock-frequency = <1900000000>;
+			operating-points-v2 = <&cluster_a57_opp_table>;
+			#cooling-cells = <2>;
+		};
+	};
+
+	cluster_a53_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp at 400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <900000>;
+		};
+		opp at 500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <925000>;
+		};
+		opp at 600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <950000>;
+		};
+		opp at 700000000 {
+			opp-hz = /bits/ 64 <700000000>;
+			opp-microvolt = <975000>;
+		};
+		opp at 800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <1000000>;
+		};
+		opp at 900000000 {
+			opp-hz = /bits/ 64 <900000000>;
+			opp-microvolt = <1050000>;
+		};
+		opp at 1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <1075000>;
+		};
+		opp at 1100000000 {
+			opp-hz = /bits/ 64 <1100000000>;
+			opp-microvolt = <1112500>;
+		};
+		opp at 1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <1112500>;
+		};
+		opp at 1300000000 {
+			opp-hz = /bits/ 64 <1300000000>;
+			opp-microvolt = <1150000>;
+		};
+	};
+
+	cluster_a57_opp_table: opp_table1 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp at 500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <900000>;
+		};
+		opp at 600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <900000>;
+		};
+		opp at 700000000 {
+			opp-hz = /bits/ 64 <700000000>;
+			opp-microvolt = <912500>;
+		};
+		opp at 800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <912500>;
+		};
+		opp at 900000000 {
+			opp-hz = /bits/ 64 <900000000>;
+			opp-microvolt = <937500>;
+		};
+		opp at 1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <975000>;
+		};
+		opp at 1100000000 {
+			opp-hz = /bits/ 64 <1100000000>;
+			opp-microvolt = <1012500>;
+		};
+		opp at 1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <1037500>;
+		};
+		opp at 1300000000 {
+			opp-hz = /bits/ 64 <1300000000>;
+			opp-microvolt = <1062500>;
+		};
+		opp at 1400000000 {
+			opp-hz = /bits/ 64 <1400000000>;
+			opp-microvolt = <1087500>;
+		};
+		opp at 1500000000 {
+			opp-hz = /bits/ 64 <1500000000>;
+			opp-microvolt = <1125000>;
+		};
+		opp at 1600000000 {
+			opp-hz = /bits/ 64 <1600000000>;
+			opp-microvolt = <1137500>;
+		};
+		opp at 1700000000 {
+			opp-hz = /bits/ 64 <1700000000>;
+			opp-microvolt = <1175000>;
+		};
+		opp at 1800000000 {
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <1212500>;
+		};
+		opp at 1900000000 {
+			opp-hz = /bits/ 64 <1900000000>;
+			opp-microvolt = <1262500>;
+		};
+	};
+
+	psci {
+		compatible = "arm,psci";
+		method = "smc";
+		cpu_off = <0x84000002>;
+		cpu_on = <0xC4000003>;
+	};
+
+	reboot: syscon-reboot {
+		compatible = "syscon-reboot";
+		regmap = <&pmu_system_controller>;
+		offset = <0x400>;
+		mask = <0x1>;
+	};
+
+	soc: soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0x0 0x18000000>;
+
+		chipid at 10000000 {
+			compatible = "samsung,exynos4210-chipid";
+			reg = <0x10000000 0x100>;
+		};
+
+		xxti: xxti {
+			compatible = "fixed-clock";
+			clock-output-names = "oscclk";
+			#clock-cells = <0>;
+		};
+
+		cmu_top: clock-controller at 10030000 {
+			compatible = "samsung,exynos5433-cmu-top";
+			reg = <0x10030000 0x1000>;
+			#clock-cells = <1>;
+
+			clock-names = "oscclk",
+				"sclk_mphy_pll",
+				"sclk_mfc_pll",
+				"sclk_bus_pll";
+			clocks = <&xxti>,
+			       <&cmu_cpif CLK_SCLK_MPHY_PLL>,
+			       <&cmu_mif CLK_SCLK_MFC_PLL>,
+			       <&cmu_mif CLK_SCLK_BUS_PLL>;
+		};
+
+		cmu_cpif: clock-controller at 10fc0000 {
+			compatible = "samsung,exynos5433-cmu-cpif";
+			reg = <0x10fc0000 0x1000>;
+			#clock-cells = <1>;
+
+			clock-names = "oscclk";
+			clocks = <&xxti>;
+		};
+
+		cmu_mif: clock-controller at 105b0000 {
+			compatible = "samsung,exynos5433-cmu-mif";
+			reg = <0x105b0000 0x2000>;
+			#clock-cells = <1>;
+
+			clock-names = "oscclk",
+				"sclk_mphy_pll";
+			clocks = <&xxti>,
+			       <&cmu_cpif CLK_SCLK_MPHY_PLL>;
+		};
+
+		cmu_peric: clock-controller at 14c80000 {
+			compatible = "samsung,exynos5433-cmu-peric";
+			reg = <0x14c80000 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		cmu_peris: clock-controller at 0x10040000 {
+			compatible = "samsung,exynos5433-cmu-peris";
+			reg = <0x10040000 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		cmu_fsys: clock-controller at 156e0000 {
+			compatible = "samsung,exynos5433-cmu-fsys";
+			reg = <0x156e0000 0x1000>;
+			#clock-cells = <1>;
+
+			clock-names = "oscclk",
+				"sclk_ufs_mphy",
+				"div_aclk_fsys_200",
+				"sclk_pcie_100_fsys",
+				"sclk_ufsunipro_fsys",
+				"sclk_mmc2_fsys",
+				"sclk_mmc1_fsys",
+				"sclk_mmc0_fsys",
+				"sclk_usbhost30_fsys",
+				"sclk_usbdrd30_fsys";
+			clocks = <&xxti>,
+			       <&cmu_cpif CLK_SCLK_UFS_MPHY>,
+			       <&cmu_top CLK_DIV_ACLK_FSYS_200>,
+			       <&cmu_top CLK_SCLK_PCIE_100_FSYS>,
+			       <&cmu_top CLK_SCLK_UFSUNIPRO_FSYS>,
+			       <&cmu_top CLK_SCLK_MMC2_FSYS>,
+			       <&cmu_top CLK_SCLK_MMC1_FSYS>,
+			       <&cmu_top CLK_SCLK_MMC0_FSYS>,
+			       <&cmu_top CLK_SCLK_USBHOST30_FSYS>,
+			       <&cmu_top CLK_SCLK_USBDRD30_FSYS>;
+		};
+
+		cmu_g2d: clock-controller at 12460000 {
+			compatible = "samsung,exynos5433-cmu-g2d";
+			reg = <0x12460000 0x1000>;
+			#clock-cells = <1>;
+
+			clock-names = "oscclk",
+				"aclk_g2d_266",
+				"aclk_g2d_400";
+			clocks = <&xxti>,
+			       <&cmu_top CLK_ACLK_G2D_266>,
+			       <&cmu_top CLK_ACLK_G2D_400>;
+		};
+
+		cmu_disp: clock-controller at 13b90000 {
+			compatible = "samsung,exynos5433-cmu-disp";
+			reg = <0x13b90000 0x1000>;
+			#clock-cells = <1>;
+
+			clock-names = "oscclk",
+				"sclk_dsim1_disp",
+				"sclk_dsim0_disp",
+				"sclk_dsd_disp",
+				"sclk_decon_tv_eclk_disp",
+				"sclk_decon_vclk_disp",
+				"sclk_decon_eclk_disp",
+				"sclk_decon_tv_vclk_disp",
+				"aclk_disp_333";
+			clocks = <&xxti>,
+			       <&cmu_mif CLK_SCLK_DSIM1_DISP>,
+			       <&cmu_mif CLK_SCLK_DSIM0_DISP>,
+			       <&cmu_mif CLK_SCLK_DSD_DISP>,
+			       <&cmu_mif CLK_SCLK_DECON_TV_ECLK_DISP>,
+			       <&cmu_mif CLK_SCLK_DECON_VCLK_DISP>,
+			       <&cmu_mif CLK_SCLK_DECON_ECLK_DISP>,
+			       <&cmu_mif CLK_SCLK_DECON_TV_VCLK_DISP>,
+			       <&cmu_mif CLK_ACLK_DISP_333>;
+		};
+
+		cmu_aud: clock-controller at 114c0000 {
+			compatible = "samsung,exynos5433-cmu-aud";
+			reg = <0x114c0000 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		cmu_bus0: clock-controller at 13600000 {
+			compatible = "samsung,exynos5433-cmu-bus0";
+			reg = <0x13600000 0x1000>;
+			#clock-cells = <1>;
+
+			clock-names = "aclk_bus0_400";
+			clocks = <&cmu_top CLK_ACLK_BUS0_400>;
+		};
+
+		cmu_bus1: clock-controller at 14800000 {
+			compatible = "samsung,exynos5433-cmu-bus1";
+			reg = <0x14800000 0x1000>;
+			#clock-cells = <1>;
+
+			clock-names = "aclk_bus1_400";
+			clocks = <&cmu_top CLK_ACLK_BUS1_400>;
+		};
+
+		cmu_bus2: clock-controller at 13400000 {
+			compatible = "samsung,exynos5433-cmu-bus2";
+			reg = <0x13400000 0x1000>;
+			#clock-cells = <1>;
+
+			clock-names = "oscclk", "aclk_bus2_400";
+			clocks = <&xxti>, <&cmu_mif CLK_ACLK_BUS2_400>;
+		};
+
+		cmu_g3d: clock-controller at 14aa0000 {
+			compatible = "samsung,exynos5433-cmu-g3d";
+			reg = <0x14aa0000 0x2000>;
+			#clock-cells = <1>;
+
+			clock-names = "oscclk", "aclk_g3d_400";
+			clocks = <&xxti>, <&cmu_top CLK_ACLK_G3D_400>;
+		};
+
+		cmu_gscl: clock-controller at 13cf0000 {
+			compatible = "samsung,exynos5433-cmu-gscl";
+			reg = <0x13cf0000 0x1000>;
+			#clock-cells = <1>;
+
+			clock-names = "oscclk",
+				"aclk_gscl_111",
+				"aclk_gscl_333";
+			clocks = <&xxti>,
+				<&cmu_top CLK_ACLK_GSCL_111>,
+				<&cmu_top CLK_ACLK_GSCL_333>;
+		};
+
+		cmu_apollo: clock-controller at 11900000 {
+			compatible = "samsung,exynos5433-cmu-apollo";
+			reg = <0x11900000 0x2000>;
+			#clock-cells = <1>;
+
+			clock-names = "oscclk", "sclk_bus_pll_apollo";
+			clocks = <&xxti>, <&cmu_mif CLK_SCLK_BUS_PLL_APOLLO>;
+		};
+
+		cmu_atlas: clock-controller at 11800000 {
+			compatible = "samsung,exynos5433-cmu-atlas";
+			reg = <0x11800000 0x2000>;
+			#clock-cells = <1>;
+
+			clock-names = "oscclk", "sclk_bus_pll_atlas";
+			clocks = <&xxti>, <&cmu_mif CLK_SCLK_BUS_PLL_ATLAS>;
+		};
+
+		cmu_mscl: clock-controller at 105d0000 {
+			compatible = "samsung,exynos5433-cmu-mscl";
+			reg = <0x150d0000 0x1000>;
+			#clock-cells = <1>;
+
+			clock-names = "oscclk",
+				"sclk_jpeg_mscl",
+				"aclk_mscl_400";
+			clocks = <&xxti>,
+			       <&cmu_top CLK_SCLK_JPEG_MSCL>,
+			       <&cmu_top CLK_ACLK_MSCL_400>;
+		};
+
+		cmu_mfc: clock-controller at 15280000 {
+			compatible = "samsung,exynos5433-cmu-mfc";
+			reg = <0x15280000 0x1000>;
+			#clock-cells = <1>;
+
+			clock-names = "oscclk", "aclk_mfc_400";
+			clocks = <&xxti>, <&cmu_top CLK_ACLK_MFC_400>;
+		};
+
+		cmu_hevc: clock-controller at 14f80000 {
+			compatible = "samsung,exynos5433-cmu-hevc";
+			reg = <0x14f80000 0x1000>;
+			#clock-cells = <1>;
+
+			clock-names = "oscclk", "aclk_hevc_400";
+			clocks = <&xxti>, <&cmu_top CLK_ACLK_HEVC_400>;
+		};
+
+		cmu_isp: clock-controller at 146d0000 {
+			compatible = "samsung,exynos5433-cmu-isp";
+			reg = <0x146d0000 0x1000>;
+			#clock-cells = <1>;
+
+			clock-names = "oscclk",
+				"aclk_isp_dis_400",
+				"aclk_isp_400";
+			clocks = <&xxti>,
+			       <&cmu_top CLK_ACLK_ISP_DIS_400>,
+			       <&cmu_top CLK_ACLK_ISP_400>;
+		};
+
+		cmu_cam0: clock-controller at 120d0000 {
+			compatible = "samsung,exynos5433-cmu-cam0";
+			reg = <0x120d0000 0x1000>;
+			#clock-cells = <1>;
+
+			clock-names = "oscclk",
+				"aclk_cam0_333",
+				"aclk_cam0_400",
+				"aclk_cam0_552";
+			clocks = <&xxti>,
+			       <&cmu_top CLK_ACLK_CAM0_333>,
+			       <&cmu_top CLK_ACLK_CAM0_400>,
+			       <&cmu_top CLK_ACLK_CAM0_552>;
+		};
+
+		cmu_cam1: clock-controller at 145d0000 {
+			compatible = "samsung,exynos5433-cmu-cam1";
+			reg = <0x145d0000 0x1000>;
+			#clock-cells = <1>;
+
+			clock-names = "oscclk",
+				"sclk_isp_uart_cam1",
+				"sclk_isp_spi1_cam1",
+				"sclk_isp_spi0_cam1",
+				"aclk_cam1_333",
+				"aclk_cam1_400",
+				"aclk_cam1_552";
+			clocks = <&xxti>,
+			       <&cmu_top CLK_SCLK_ISP_UART_CAM1>,
+			       <&cmu_top CLK_SCLK_ISP_SPI1_CAM1>,
+			       <&cmu_top CLK_SCLK_ISP_SPI0_CAM1>,
+			       <&cmu_top CLK_ACLK_CAM1_333>,
+			       <&cmu_top CLK_ACLK_CAM1_400>,
+			       <&cmu_top CLK_ACLK_CAM1_552>;
+		};
+
+		tmu_atlas0: tmu at 10060000 {
+			compatible = "samsung,exynos5433-tmu";
+			reg = <0x10060000 0x200>;
+			interrupts = <0 95 0>;
+			clocks = <&cmu_peris CLK_PCLK_TMU0_APBIF>,
+				 <&cmu_peris CLK_SCLK_TMU0>;
+			clock-names = "tmu_apbif", "tmu_sclk";
+			#include "exynos5433-tmu-sensor-conf.dtsi"
+			status = "disabled";
+		};
+
+		tmu_atlas1: tmu at 10068000 {
+			compatible = "samsung,exynos5433-tmu";
+			reg = <0x10068000 0x200>;
+			interrupts = <0 96 0>;
+			clocks = <&cmu_peris CLK_PCLK_TMU0_APBIF>,
+				 <&cmu_peris CLK_SCLK_TMU0>;
+			clock-names = "tmu_apbif", "tmu_sclk";
+			#include "exynos5433-tmu-sensor-conf.dtsi"
+			status = "disabled";
+		};
+
+		tmu_g3d: tmu at 10070000 {
+			compatible = "samsung,exynos5433-tmu";
+			reg = <0x10070000 0x200>;
+			interrupts = <0 99 0>;
+			clocks = <&cmu_peris CLK_PCLK_TMU1_APBIF>,
+				 <&cmu_peris CLK_SCLK_TMU1>;
+			clock-names = "tmu_apbif", "tmu_sclk";
+			#include "exynos5433-tmu-g3d-sensor-conf.dtsi"
+			status = "disabled";
+		};
+
+		tmu_apollo: tmu at 10078000 {
+			compatible = "samsung,exynos5433-tmu";
+			reg = <0x10078000 0x200>;
+			interrupts = <0 115 0>;
+			clocks = <&cmu_peris CLK_PCLK_TMU1_APBIF>,
+				 <&cmu_peris CLK_SCLK_TMU1>;
+			clock-names = "tmu_apbif", "tmu_sclk";
+			#include "exynos5433-tmu-sensor-conf.dtsi"
+			status = "disabled";
+		};
+
+		tmu_isp: tmu at 1007c000 {
+			compatible = "samsung,exynos5433-tmu";
+			reg = <0x1007c000 0x200>;
+			interrupts = <0 94 0>;
+			clocks = <&cmu_peris CLK_PCLK_TMU1_APBIF>,
+				 <&cmu_peris CLK_SCLK_TMU1>;
+			clock-names = "tmu_apbif", "tmu_sclk";
+			#include "exynos5433-tmu-sensor-conf.dtsi"
+			status = "disabled";
+		};
+
+		mct at 101c0000 {
+			compatible = "samsung,exynos5433-mct",
+				     "samsung,exynos4210-mct";
+			reg = <0x101c0000 0x800>;
+			interrupts = <0 102 0>, <0 103 0>, <0 104 0>, <0 105 0>,
+				<0 106 0>, <0 107 0>, <0 108 0>, <0 109 0>,
+				<0 110 0>, <0 111 0>, <0 112 0>, <0 113 0>;
+			clocks = <&xxti>,
+			         <&cmu_peris CLK_PCLK_MCT>;
+			clock-names = "fin_pll", "mct";
+		};
+
+		pinctrl_alive: pinctrl at 10580000 {
+			compatible = "samsung,exynos5433-pinctrl";
+			reg = <0x10580000 0x1A20>, <0x11090000 0x100>;
+
+			wakeup-interrupt-controller {
+				compatible = "samsung,exynos7-wakeup-eint";
+				interrupts = <0 16 0>;
+			};
+		};
+
+		pinctrl_aud: pinctrl at 114b0000 {
+			compatible = "samsung,exynos5433-pinctrl";
+			reg = <0x114b0000 0x1000>;
+			interrupts = <0 68 0>;
+		};
+
+		pinctrl_cpif: pinctrl at 10fe0000 {
+			compatible = "samsung,exynos5433-pinctrl";
+			reg = <0x10fe0000 0x1000>;
+			interrupts = <0 179 0>;
+		};
+
+		pinctrl_ese: pinctrl at 14ca0000 {
+			compatible = "samsung,exynos5433-pinctrl";
+			reg = <0x14ca0000 0x1000>;
+			interrupts = <0 413 0>;
+		};
+
+		pinctrl_finger: pinctrl at 14cb0000 {
+			compatible = "samsung,exynos5433-pinctrl";
+			reg = <0x14cb0000 0x1000>;
+			interrupts = <0 414 0>;
+		};
+
+		pinctrl_fsys: pinctrl at 15690000 {
+			compatible = "samsung,exynos5433-pinctrl";
+			reg = <0x15690000 0x1000>;
+			interrupts = <0 229 0>;
+		};
+
+		pinctrl_imem: pinctrl at 11090000 {
+			compatible = "samsung,exynos5433-pinctrl";
+			reg = <0x11090000 0x1000>;
+			interrupts = <0 325 0>;
+		};
+
+		pinctrl_nfc: pinctrl at 14cd0000 {
+			compatible = "samsung,exynos5433-pinctrl";
+			reg = <0x14cd0000 0x1000>;
+			interrupts = <0 441 0>;
+		};
+
+		pinctrl_peric: pinctrl at 14cc0000 {
+			compatible = "samsung,exynos5433-pinctrl";
+			reg = <0x14cc0000 0x1100>;
+			interrupts = <0 440 0>;
+		};
+
+		pinctrl_touch: pinctrl at 14ce0000 {
+			compatible = "samsung,exynos5433-pinctrl";
+			reg = <0x14ce0000 0x1100>;
+			interrupts = <0 442 0>;
+		};
+
+		rtc: rtc at 10590000 {
+			compatible = "samsung,exynos3250-rtc";
+			reg = <0x10590000 0x100>;
+			interrupts = <0 385 0>, <0 386 0>;
+			status = "disabled";
+		};
+
+		pmu_system_controller: system-controller at 105c0000 {
+			compatible = "samsung,exynos5433-pmu", "syscon";
+			reg = <0x105c0000 0x5008>;
+			#clock-cells = <1>;
+			clock-names = "clkout16";
+			clocks = <&xxti>;
+		};
+
+		gic: interrupt-controller at 11001000 {
+			compatible = "arm,gic-400";
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			reg =	<0x11001000 0x1000>,
+				<0x11002000 0x2000>,
+				<0x11004000 0x2000>,
+				<0x11006000 0x2000>;
+			interrupts = <1 9 0xf04>;
+		};
+
+		lpass: lpass at 11400000 {
+			compatible = "samsung,exynos5433-lpass";
+			reg = <0x11400000 0x100>;
+			samsung,pmu-syscon = <&pmu_system_controller>;
+			status = "disabled";
+		};
+
+		i2s0: i2s0 at 11440000 {
+			compatible = "samsung,exynos7-i2s";
+			reg = <0x11440000 0x100>;
+			dmas = <&adma 0 &adma 2>;
+			dma-names = "tx", "rx";
+			interrupts = <0 70 0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&cmu_aud CLK_PCLK_AUD_I2S>,
+				 <&cmu_aud CLK_SCLK_AUD_I2S>,
+				 <&cmu_aud CLK_SCLK_I2S_BCLK>;
+			clock-names = "iis", "i2s_opclk0", "i2s_opclk1";
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2s0_bus>;
+			status = "disabled";
+		};
+
+		mipi_phy: video-phy at 105C0708 {
+			compatible = "samsung,exynos5433-mipi-video-phy";
+			#phy-cells = <1>;
+			samsung,pmu-syscon = <&pmu_system_controller>;
+			samsung,cam0-sysreg = <&syscon_cam0>;
+			samsung,cam1-sysreg = <&syscon_cam1>;
+			samsung,disp-sysreg = <&syscon_disp>;
+		};
+
+		decon: decon at 13800000 {
+			compatible = "samsung,exynos5433-decon";
+			reg = <0x13800000 0x2104>;
+			clocks = <&cmu_disp CLK_PCLK_DECON>,
+				 <&cmu_disp CLK_ACLK_DECON>,
+				 <&cmu_disp CLK_ACLK_SMMU_DECON0X>,
+				 <&cmu_disp CLK_ACLK_XIU_DECON0X>,
+				 <&cmu_disp CLK_PCLK_SMMU_DECON0X>,
+				 <&cmu_disp CLK_SCLK_DECON_VCLK>,
+				 <&cmu_disp CLK_SCLK_DECON_ECLK>;
+			clock-names = "pclk", "aclk_decon", "aclk_smmu_decon0x",
+				      "aclk_xiu_decon0x", "pclk_smmu_decon0x",
+				      "sclk_decon_vclk", "sclk_decon_eclk";
+			interrupt-names = "fifo", "vsync", "lcd_sys";
+			interrupts = <0 201 0>, <0 202 0>, <0 203 0>;
+			samsung,disp-sysreg = <&syscon_disp>;
+			status = "disabled";
+			iommus = <&sysmmu_decon0x>, <&sysmmu_decon1x>;
+			iommu-names = "m0", "m1";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 0 {
+					reg = <0>;
+					decon_to_mic: endpoint {
+						remote-endpoint = <&mic_to_decon>;
+					};
+				};
+			};
+		};
+
+		dsi: dsi at 13900000 {
+			compatible = "samsung,exynos5433-mipi-dsi";
+			reg = <0x13900000 0xC0>;
+			interrupts = <0 205 0>;
+			phys = <&mipi_phy 1>;
+			phy-names = "dsim";
+			clocks = <&cmu_disp CLK_PCLK_DSIM0>,
+				 <&cmu_disp CLK_PHYCLK_MIPIDPHY0_BITCLKDIV8>,
+				 <&cmu_disp CLK_PHYCLK_MIPIDPHY0_RXCLKESC0>,
+				 <&cmu_disp CLK_SCLK_RGB_VCLK_TO_DSIM0>,
+				 <&cmu_disp CLK_SCLK_DSIM0>;
+			clock-names = "bus_clk",
+				      "phyclk_mipidphy0_bitclkdiv8",
+				      "phyclk_mipidphy0_rxclkesc0",
+				      "sclk_rgb_vclk_to_dsim0",
+				      "sclk_mipi";
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 0 {
+					reg = <0>;
+					dsi_to_mic: endpoint {
+						remote-endpoint = <&mic_to_dsi>;
+					};
+				};
+			};
+		};
+
+		mic: mic at 13930000 {
+			compatible = "samsung,exynos5433-mic";
+			reg = <0x13930000 0x48>;
+			clocks = <&cmu_disp CLK_PCLK_MIC0>,
+				 <&cmu_disp CLK_SCLK_RGB_VCLK_TO_MIC0>;
+			clock-names = "pclk_mic0", "sclk_rgb_vclk_to_mic0";
+			samsung,disp-syscon = <&syscon_disp>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 0 {
+					reg = <0>;
+					mic_to_decon: endpoint {
+						remote-endpoint = <&decon_to_mic>;
+					};
+				};
+
+				port at 1 {
+					reg = <1>;
+					mic_to_dsi: endpoint {
+						remote-endpoint = <&dsi_to_mic>;
+					};
+				};
+			};
+		};
+
+		syscon_disp: syscon at 13B80000 {
+			compatible = "samsung,exynos5433-sysreg", "syscon";
+			reg = <0x13B80000 0x1010>;
+		};
+
+		syscon_cam0: syscon at 120F0000 {
+			compatible = "samsung,exynos5433-sysreg", "syscon";
+			reg = <0x120F0000 0x1020>;
+		};
+
+		syscon_cam1: syscon at 145F0000 {
+			compatible = "samsung,exynos5433-sysreg", "syscon";
+			reg = <0x145F0000 0x1038>;
+		};
+
+		sysmmu_gscl0: sysmmu at 0x13C80000 {
+			compatible = "samsung,exynos-sysmmu";
+			reg = <0x13C80000 0x1000>;
+			interrupts = <0 288 0>;
+			clock-names = "aclk", "pclk";
+			clocks = <&cmu_gscl CLK_ACLK_SMMU_GSCL0>,
+				<&cmu_gscl CLK_PCLK_SMMU_GSCL0>;
+			#iommu-cells = <0>;
+		};
+
+		sysmmu_gscl1: sysmmu at 0x13C90000 {
+			compatible = "samsung,exynos-sysmmu";
+			reg = <0x13C90000 0x1000>;
+			interrupts = <0 290 0>;
+			clock-names = "aclk", "pclk";
+			clocks = <&cmu_gscl CLK_ACLK_SMMU_GSCL1>,
+			       <&cmu_gscl CLK_PCLK_SMMU_GSCL1>;
+			#iommu-cells = <0>;
+		};
+
+		sysmmu_gscl2: sysmmu at 0x13CA0000 {
+			compatible = "samsung,exynos-sysmmu";
+			reg = <0x13CA0000 0x1000>;
+			interrupts = <0 292 0>;
+			clock-names = "aclk", "pclk";
+			clocks = <&cmu_gscl CLK_ACLK_SMMU_GSCL2>,
+			       <&cmu_gscl CLK_PCLK_SMMU_GSCL2>;
+			#iommu-cells = <0>;
+		};
+
+		sysmmu_decon0x: sysmmu at 0x13A00000 {
+			compatible = "samsung,exynos-sysmmu";
+			reg = <0x13A00000 0x1000>;
+			interrupts = <0 192 0>;
+			clock-names = "pclk", "aclk";
+			clocks = <&cmu_disp CLK_PCLK_SMMU_DECON0X>,
+			       <&cmu_disp CLK_ACLK_SMMU_DECON0X>;
+			#iommu-cells = <0>;
+		};
+
+		sysmmu_decon1x: sysmmu at 0x13A10000 {
+			compatible = "samsung,exynos-sysmmu";
+			reg = <0x13A10000 0x1000>;
+			interrupts = <0 194 0>;
+			clock-names = "pclk", "aclk";
+			clocks = <&cmu_disp CLK_PCLK_SMMU_DECON1X>,
+			       <&cmu_disp CLK_ACLK_SMMU_DECON1X>;
+			#iommu-cells = <0>;
+		};
+
+		sysmmu_tv0x: sysmmu at 0x13A20000 {
+			compatible = "samsung,exynos-sysmmu";
+			reg = <0x13A20000 0x1000>;
+			interrupts = <0 214 0>;
+			clock-names = "pclk", "aclk";
+			clocks = <&cmu_disp CLK_PCLK_SMMU_TV0X>,
+			       <&cmu_disp CLK_ACLK_SMMU_TV0X>;
+			#iommu-cells = <0>;
+		};
+
+		sysmmu_tv1x: sysmmu at 0x13A30000 {
+			compatible = "samsung,exynos-sysmmu";
+			reg = <0x13A30000 0x1000>;
+			interrupts = <0 216 0>;
+			clock-names = "pclk", "aclk";
+			clocks = <&cmu_disp CLK_PCLK_SMMU_TV1X>,
+			       <&cmu_disp CLK_ACLK_SMMU_TV1X>;
+			#iommu-cells = <0>;
+		};
+
+		sysmmu_mfc_0: sysmmu at 0x15200000 {
+			compatible = "samsung,exynos-sysmmu";
+			reg = <0x15200000 0x1000>;
+			interrupts = <0 352 0>;
+			clock-names = "pclk", "aclk";
+			clocks = <&cmu_mfc CLK_PCLK_SMMU_MFC_0>,
+			       <&cmu_mfc CLK_ACLK_SMMU_MFC_0>;
+			#iommu-cells = <0>;
+		};
+
+		sysmmu_mfc_1: sysmmu at 0x15210000 {
+			compatible = "samsung,exynos-sysmmu";
+			reg = <0x15210000 0x1000>;
+			interrupts = <0 354 0>;
+			clock-names = "pclk", "aclk";
+			clocks = <&cmu_mfc CLK_PCLK_SMMU_MFC_1>,
+			       <&cmu_mfc CLK_ACLK_SMMU_MFC_1>;
+			#iommu-cells = <0>;
+		};
+
+		sysmmu_jpeg: sysmmu at 0x15060000 {
+			compatible = "samsung,exynos-sysmmu";
+			reg = <0x15060000 0x1000>;
+			interrupts = <0 408 0>;
+			clock-names = "pclk", "aclk";
+			clocks = <&cmu_mscl CLK_PCLK_SMMU_JPEG>,
+			       <&cmu_mscl CLK_ACLK_SMMU_JPEG>;
+			#iommu-cells = <0>;
+		};
+
+		sysmmu_flite_a: sysmmu at 0x12150000 {
+			compatible = "samsung,exynos-sysmmu";
+			reg = <0x12150000 0x1000>;
+			interrupts = <0 128 0>;
+			clock-names = "pclk", "aclk";
+			clocks = <&cmu_cam0 CLK_PCLK_SMMU_LITE_A>,
+				<&cmu_cam0 CLK_ACLK_SMMU_LITE_A>;
+			#iommu-cells = <0>;
+		};
+
+		sysmmu_flite_b: sysmmu at 0x12160000 {
+			compatible = "samsung,exynos-sysmmu";
+			reg = <0x12160000 0x1000>;
+			interrupts = <0 130 0>;
+			clock-names = "pclk", "aclk";
+			clocks = <&cmu_cam0 CLK_PCLK_SMMU_LITE_B>,
+				<&cmu_cam0 CLK_ACLK_SMMU_LITE_B>;
+			#iommu-cells = <0>;
+		};
+
+		sysmmu_flite_d: sysmmu at 0x12170000 {
+			compatible = "samsung,exynos-sysmmu";
+			reg = <0x12170000 0x1000>;
+			interrupts = <0 132 0>;
+			clock-names = "pclk", "aclk";
+			clocks = <&cmu_cam0 CLK_PCLK_SMMU_LITE_D>,
+				<&cmu_cam0 CLK_ACLK_SMMU_LITE_D>;
+			#iommu-cells = <0>;
+		};
+
+		sysmmu_3aa0: sysmmu at 0x12180000 {
+			compatible = "samsung,exynos-sysmmu";
+			reg = <0x12180000 0x1000>;
+			interrupts = <0 137 0>;
+			clock-names = "pclk", "aclk";
+			clocks = <&cmu_cam0 CLK_PCLK_SMMU_3AA0>,
+				<&cmu_cam0 CLK_ACLK_SMMU_3AA0>;
+			#iommu-cells = <0>;
+		};
+
+		sysmmu_3aa1: sysmmu at 0x121A0000 {
+			compatible = "samsung,exynos-sysmmu";
+			reg = <0x121A0000 0x1000>;
+			interrupts = <0 147 0>;
+			clock-names = "pclk", "aclk";
+			clocks = <&cmu_cam0 CLK_PCLK_SMMU_3AA1>,
+				<&cmu_cam0 CLK_ACLK_SMMU_3AA1>;
+			#iommu-cells = <0>;
+		};
+
+		sysmmu_flite_c: sysmmu at 0x142B0000 {
+			compatible = "samsung,exynos-sysmmu";
+			reg = <0x142B0000 0x1000>;
+			interrupts = <0 160 0>;
+			clock-names = "pclk", "aclk";
+			clocks = <&cmu_cam1 CLK_PCLK_SMMU_LITE_C>,
+				<&cmu_cam1 CLK_ACLK_SMMU_LITE_C>;
+			#iommu-cells = <0>;
+		};
+
+		sysmmu_fimc_fd: sysmmu at 0x142C0000 {
+			compatible = "samsung,exynos-sysmmu";
+			reg = <0x142C0000 0x1000>;
+			interrupts = <0 162 0>;
+			clock-names = "pclk", "aclk";
+			clocks = <&cmu_cam1 CLK_PCLK_SMMU_FD>,
+				<&cmu_cam1 CLK_ACLK_SMMU_FD>;
+			#iommu-cells = <0>;
+		};
+
+		sysmmu_fimc_cpu: sysmmu at 0x142D0000 {
+			compatible = "samsung,exynos-sysmmu";
+			reg = <0x142D0000 0x1000>;
+			interrupts = <0 169 0>;
+			clock-names = "pclk", "aclk";
+			clocks = <&cmu_isp CLK_PCLK_SMMU_ISPCPU>,
+				<&cmu_isp CLK_ACLK_SMMU_ISPCPU>;
+			#iommu-cells = <0>;
+		};
+
+		sysmmu_fimc_isp: sysmmu at 0x14320000 {
+			compatible = "samsung,exynos-sysmmu";
+			reg = <0x14320000 0x1000>;
+			interrupts = <0 346 0>;
+			clock-names = "pclk", "aclk";
+			clocks = <&cmu_isp CLK_PCLK_SMMU_ISP>,
+				<&cmu_isp CLK_ACLK_SMMU_ISP>;
+			#iommu-cells = <0>;
+		};
+
+		sysmmu_fimc_drc: sysmmu at 0x14330000 {
+			compatible = "samsung,exynos-sysmmu";
+			reg = <0x14330000 0x1000>;
+			interrupts = <0 338 0>;
+			clock-names = "pclk", "aclk";
+			clocks = <&cmu_isp CLK_PCLK_SMMU_DRC>,
+				<&cmu_isp CLK_ACLK_SMMU_DRC>;
+			#iommu-cells = <0>;
+		};
+
+		sysmmu_fimc_scc: sysmmu at 0x14340000 {
+			compatible = "samsung,exynos-sysmmu";
+			reg = <0x14340000 0x1000>;
+			interrupts = <0 340 0>;
+			clock-names = "pclk", "aclk";
+			clocks = <&cmu_isp CLK_PCLK_SMMU_SCALERC>,
+				<&cmu_isp CLK_ACLK_SMMU_SCALERC>;
+			#iommu-cells = <0>;
+		};
+
+		sysmmu_fimc_dis0: sysmmu at 0x143A0000 {
+			compatible = "samsung,exynos-sysmmu";
+			reg = <0x143A0000 0x1000>;
+			interrupts = <0 342 0>;
+			clock-names = "pclk", "aclk";
+			clocks = <&cmu_isp CLK_PCLK_SMMU_DIS0>,
+				<&cmu_isp CLK_ACLK_SMMU_DIS0>;
+			#iommu-cells = <0>;
+		};
+
+		sysmmu_fimc_dis1: sysmmu at 0x143B0000 {
+			compatible = "samsung,exynos-sysmmu";
+			reg = <0x143B0000 0x1000>;
+			interrupts = <0 344 0>;
+			clock-names = "pclk", "aclk";
+			clocks = <&cmu_isp CLK_PCLK_SMMU_DIS1>,
+				<&cmu_isp CLK_ACLK_SMMU_DIS1>;
+			#iommu-cells = <0>;
+		};
+
+		sysmmu_fimc_scp: sysmmu at 0x143C0000 {
+			compatible = "samsung,exynos-sysmmu";
+			reg = <0x143C0000 0x1000>;
+			interrupts = <0 336 0>;
+			clock-names = "pclk", "aclk";
+			clocks = <&cmu_isp CLK_PCLK_SMMU_SCALERP>,
+				<&cmu_isp CLK_ACLK_SMMU_SCALERP>;
+			#iommu-cells = <0>;
+		};
+
+		sysmmu_fimc_3dnr: sysmmu at 0x143D0000 {
+			compatible = "samsung,exynos-sysmmu";
+			reg = <0x143D0000 0x1000>;
+			interrupts = <0 349 0>;
+			clock-names = "pclk", "aclk";
+			clocks = <&cmu_isp CLK_PCLK_SMMU_3DNR>,
+				<&cmu_isp CLK_ACLK_SMMU_3DNR>;
+			#iommu-cells = <0>;
+		};
+
+		serial_0: serial at 14c10000 {
+			compatible = "samsung,exynos5433-uart";
+			reg = <0x14c10000 0x100>;
+			interrupts = <0 421 0>;
+			clocks = <&cmu_peric CLK_PCLK_UART0>,
+				<&cmu_peric CLK_SCLK_UART0>;
+			clock-names = "uart", "clk_uart_baud0";
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart0_bus>;
+			status = "disabled";
+		};
+
+		serial_1: serial at 14c20000 {
+			compatible = "samsung,exynos5433-uart";
+			reg = <0x14c20000 0x100>;
+			interrupts = <0 422 0>;
+			clocks = <&cmu_peric CLK_PCLK_UART1>,
+				<&cmu_peric CLK_SCLK_UART1>;
+			clock-names = "uart", "clk_uart_baud0";
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart1_bus>;
+			status = "disabled";
+		};
+
+		serial_2: serial at 14c30000 {
+			compatible = "samsung,exynos5433-uart";
+			reg = <0x14c30000 0x100>;
+			interrupts = <0 423 0>;
+			clocks = <&cmu_peric CLK_PCLK_UART2>,
+				<&cmu_peric CLK_SCLK_UART2>;
+			clock-names = "uart", "clk_uart_baud0";
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart2_bus>;
+		};
+
+		serial_3: serial at 11460000 {
+			compatible = "samsung,exynos5433-uart";
+			reg = <0x11460000 0x100>;
+			interrupts = <0 67 0>;
+			clocks = <&cmu_aud CLK_PCLK_AUD_UART>,
+				<&cmu_aud CLK_SCLK_AUD_UART>;
+			clock-names = "uart", "clk_uart_baud0";
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart_aud_bus>;
+			status = "disabled";
+		};
+
+		spi_0: spi at 14d20000 {
+			compatible = "samsung,exynos5433-spi";
+			reg = <0x14d20000 0x100>;
+			interrupts = <0 432 0>;
+			dmas = <&pdma0 9>, <&pdma0 8>;
+			dma-names = "tx", "rx";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&cmu_peric CLK_PCLK_SPI0>,
+				<&cmu_peric CLK_SCLK_SPI0>,
+				<&cmu_peric CLK_SCLK_IOCLK_SPI0>;
+			clock-names = "spi", "spi_busclk0", "spi_ioclk";
+			samsung,spi-src-clk = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&spi0_bus>;
+			num-cs = <1>;
+			status = "disabled";
+		};
+
+		spi_1: spi at 14d30000 {
+			compatible = "samsung,exynos5433-spi";
+			reg = <0x14d30000 0x100>;
+			interrupts = <0 433 0>;
+			dmas = <&pdma0 11>, <&pdma0 10>;
+			dma-names = "tx", "rx";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&cmu_peric CLK_PCLK_SPI1>,
+				<&cmu_peric CLK_SCLK_SPI1>,
+				<&cmu_peric CLK_SCLK_IOCLK_SPI1>;
+			clock-names = "spi", "spi_busclk0", "spi_ioclk";
+			samsung,spi-src-clk = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&spi1_bus>;
+			num-cs = <1>;
+			status = "disabled";
+		};
+
+		spi_2: spi at 14d40000 {
+			compatible = "samsung,exynos5433-spi";
+			reg = <0x14d40000 0x100>;
+			interrupts = <0 434 0>;
+			dmas = <&pdma0 13>, <&pdma0 12>;
+			dma-names = "tx", "rx";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&cmu_peric CLK_PCLK_SPI2>,
+				 <&cmu_peric CLK_SCLK_SPI2>,
+				 <&cmu_peric CLK_SCLK_IOCLK_SPI2>;
+			clock-names = "spi", "spi_busclk0", "spi_ioclk";
+			samsung,spi-src-clk = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&spi2_bus>;
+			num-cs = <1>;
+			status = "disabled";
+		};
+
+		spi_3: spi at 14d50000 {
+			compatible = "samsung,exynos5433-spi";
+			reg = <0x14d50000 0x100>;
+			interrupts = <0 447 0>;
+			dmas = <&pdma0 23>, <&pdma0 22>;
+			dma-names = "tx", "rx";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&cmu_peric CLK_PCLK_SPI3>,
+				<&cmu_peric CLK_SCLK_SPI3>,
+				<&cmu_peric CLK_SCLK_IOCLK_SPI3>;
+			clock-names = "spi", "spi_busclk0", "spi_ioclk";
+			samsung,spi-src-clk = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&spi3_bus>;
+			num-cs = <1>;
+			status = "disabled";
+		};
+
+		spi_4: spi at 14d00000 {
+			compatible = "samsung,exynos5433-spi";
+			reg = <0x14d00000 0x100>;
+			interrupts = <0 412 0>;
+			dmas = <&pdma0 25>, <&pdma0 24>;
+			dma-names = "tx", "rx";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&cmu_peric CLK_PCLK_SPI4>,
+				<&cmu_peric CLK_SCLK_SPI4>,
+				<&cmu_peric CLK_SCLK_IOCLK_SPI4>;
+			clock-names = "spi", "spi_busclk0", "spi_ioclk";
+			samsung,spi-src-clk = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&spi4_bus>;
+			num-cs = <1>;
+			status = "disabled";
+		};
+
+		adc: adc at 14d10000 {
+			compatible = "samsung,exynos7-adc";
+			reg = <0x14d10000 0x100>;
+			interrupts = <0 438 0>;
+			clock-names = "adc";
+			clocks = <&cmu_peric CLK_PCLK_ADCIF>;
+			#io-channel-cells = <1>;
+			io-channel-ranges;
+			status = "disabled";
+		};
+
+		pwm: pwm at 14dd0000 {
+			compatible = "samsung,exynos4210-pwm";
+			reg = <0x14dd0000 0x100>;
+			interrupts = <0 416 0>, <0 417 0>,
+				<0 418 0>, <0 419 0>, <0 420 0>;
+			samsung,pwm-outputs = <0>, <1>, <2>, <3>;
+			clocks = <&cmu_peric CLK_PCLK_PWM>;
+			clock-names = "timers";
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
+		hsi2c_0: hsi2c at 14e40000 {
+			compatible = "samsung,exynos7-hsi2c";
+			reg = <0x14e40000 0x1000>;
+			interrupts = <0 428 0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&hs_i2c0_bus>;
+			clocks = <&cmu_peric CLK_PCLK_HSI2C0>;
+			clock-names = "hsi2c";
+			status = "disabled";
+		};
+
+		hsi2c_1: hsi2c at 14e50000 {
+			compatible = "samsung,exynos7-hsi2c";
+			reg = <0x14e50000 0x1000>;
+			interrupts = <0 429 0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&hs_i2c1_bus>;
+			clocks = <&cmu_peric CLK_PCLK_HSI2C1>;
+			clock-names = "hsi2c";
+			status = "disabled";
+		};
+
+		hsi2c_2: hsi2c at 14e60000 {
+			compatible = "samsung,exynos7-hsi2c";
+			reg = <0x14e60000 0x1000>;
+			interrupts = <0 430 0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&hs_i2c2_bus>;
+			clocks = <&cmu_peric CLK_PCLK_HSI2C2>;
+			clock-names = "hsi2c";
+			status = "disabled";
+		};
+
+		hsi2c_3: hsi2c at 14e70000 {
+			compatible = "samsung,exynos7-hsi2c";
+			reg = <0x14e70000 0x1000>;
+			interrupts = <0 431 0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&hs_i2c3_bus>;
+			clocks = <&cmu_peric CLK_PCLK_HSI2C3>;
+			clock-names = "hsi2c";
+			status = "disabled";
+		};
+
+		hsi2c_4: hsi2c at 14ec0000 {
+			compatible = "samsung,exynos7-hsi2c";
+			reg = <0x14ec0000 0x1000>;
+			interrupts = <0 424 0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&hs_i2c4_bus>;
+			clocks = <&cmu_peric CLK_PCLK_HSI2C4>;
+			clock-names = "hsi2c";
+			status = "disabled";
+		};
+
+		hsi2c_5: hsi2c at 14ed0000 {
+			compatible = "samsung,exynos7-hsi2c";
+			reg = <0x14ed0000 0x1000>;
+			interrupts = <0 425 0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&hs_i2c5_bus>;
+			clocks = <&cmu_peric CLK_PCLK_HSI2C5>;
+			clock-names = "hsi2c";
+			status = "disabled";
+		};
+
+		hsi2c_6: hsi2c at 14ee0000 {
+			compatible = "samsung,exynos7-hsi2c";
+			reg = <0x14ee0000 0x1000>;
+			interrupts = <0 426 0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&hs_i2c6_bus>;
+			clocks = <&cmu_peric CLK_PCLK_HSI2C6>;
+			clock-names = "hsi2c";
+			status = "disabled";
+		};
+
+		hsi2c_7: hsi2c at 14ef0000 {
+			compatible = "samsung,exynos7-hsi2c";
+			reg = <0x14ef0000 0x1000>;
+			interrupts = <0 427 0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&hs_i2c7_bus>;
+			clocks = <&cmu_peric CLK_PCLK_HSI2C7>;
+			clock-names = "hsi2c";
+			status = "disabled";
+		};
+
+		hsi2c_8: hsi2c at 14d90000 {
+			compatible = "samsung,exynos7-hsi2c";
+			reg = <0x14d90000 0x1000>;
+			interrupts = <0 443 0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&hs_i2c8_bus>;
+			clocks = <&cmu_peric CLK_PCLK_HSI2C8>;
+			clock-names = "hsi2c";
+			status = "disabled";
+		};
+
+		hsi2c_9: hsi2c at 14da0000 {
+			compatible = "samsung,exynos7-hsi2c";
+			reg = <0x14da0000 0x1000>;
+			interrupts = <0 444 0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&hs_i2c9_bus>;
+			clocks = <&cmu_peric CLK_PCLK_HSI2C9>;
+			clock-names = "hsi2c";
+			status = "disabled";
+		};
+
+		hsi2c_10: hsi2c at 14de0000 {
+			compatible = "samsung,exynos7-hsi2c";
+			reg = <0x14de0000 0x1000>;
+			interrupts = <0 445 0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&hs_i2c10_bus>;
+			clocks = <&cmu_peric CLK_PCLK_HSI2C10>;
+			clock-names = "hsi2c";
+			status = "disabled";
+		};
+
+		hsi2c_11: hsi2c at 14df0000 {
+			compatible = "samsung,exynos7-hsi2c";
+			reg = <0x14df0000 0x1000>;
+			interrupts = <0 446 0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&hs_i2c11_bus>;
+			clocks = <&cmu_peric CLK_PCLK_HSI2C11>;
+			clock-names = "hsi2c";
+			status = "disabled";
+		};
+
+		usbdrd30: usb at 15400000 {
+			compatible = "samsung,exynos5250-dwusb3";
+			clocks = <&cmu_fsys CLK_ACLK_USBDRD30>,
+				<&cmu_fsys CLK_SCLK_USBDRD30>;
+			clock-names = "usbdrd30", "usbdrd30_susp_clk";
+			assigned-clocks =
+				<&cmu_fsys CLK_MOUT_SCLK_USBDRD30_USER>,
+				<&cmu_top CLK_MOUT_SCLK_USBDRD30>,
+				<&cmu_top CLK_DIV_SCLK_USBDRD30>;
+			assigned-clock-parents =
+				<&cmu_top CLK_SCLK_USBDRD30_FSYS>,
+				<&cmu_top CLK_MOUT_BUS_PLL_USER>;
+			assigned-clock-rates = <0>, <0>, <66700000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			status = "disabled";
+
+			dwc3 {
+				compatible = "snps,dwc3";
+				reg = <0x15400000 0x10000>;
+				interrupts = <0 231 0>;
+				phys = <&usbdrd30_phy 0>, <&usbdrd30_phy 1>;
+				phy-names = "usb2-phy", "usb3-phy";
+			};
+
+		};
+
+		usbdrd30_phy: phy at 15500000 {
+			compatible = "samsung,exynos5433-usbdrd-phy";
+			reg = <0x15500000 0x100>;
+			clocks = <&cmu_fsys CLK_ACLK_USBDRD30>, <&xxti>,
+				<&cmu_fsys CLK_PHYCLK_USBDRD30_UDRD30_PHYCLOCK>,
+				<&cmu_fsys CLK_PHYCLK_USBDRD30_UDRD30_PIPE_PCLK>,
+				<&cmu_fsys CLK_SCLK_USBDRD30>;
+			clock-names = "phy", "ref", "phy_utmi", "phy_pipe", "itp";
+			assigned-clocks =
+				<&cmu_fsys CLK_MOUT_PHYCLK_USBDRD30_UDRD30_PIPE_PCLK_USER>,
+				<&cmu_fsys CLK_MOUT_PHYCLK_USBDRD30_UDRD30_PHYCLOCK_USER>;
+			assigned-clock-parents =
+				<&cmu_fsys CLK_PHYCLK_USBDRD30_UDRD30_PIPE_PCLK_PHY>,
+				<&cmu_fsys CLK_PHYCLK_USBDRD30_UDRD30_PHYCLOCK_PHY>;
+			#phy-cells = <1>;
+			samsung,pmu-syscon = <&pmu_system_controller>;
+			status = "disabled";
+		};
+
+		usbhost30_phy: phy at 15580000 {
+			compatible = "samsung,exynos5433-usbdrd-phy";
+			reg = <0x15580000 0x100>;
+			clocks = <&cmu_fsys CLK_ACLK_USBHOST30>, <&xxti>,
+				<&cmu_fsys CLK_PHYCLK_USBHOST30_UHOST30_PHYCLOCK>,
+				<&cmu_fsys CLK_PHYCLK_USBHOST30_UHOST30_PIPE_PCLK>,
+				<&cmu_fsys CLK_SCLK_USBHOST30>;
+			clock-names = "phy", "ref", "phy_utmi", "phy_pipe",
+					"itp";
+			assigned-clocks =
+				<&cmu_fsys CLK_MOUT_PHYCLK_USBHOST30_UHOST30_PIPE_PCLK_USER>,
+				<&cmu_fsys CLK_MOUT_PHYCLK_USBHOST30_UHOST30_PHYCLOCK_USER>;
+			assigned-clock-parents =
+				<&cmu_fsys CLK_PHYCLK_USBHOST30_UHOST30_PIPE_PCLK_PHY>,
+				<&cmu_fsys CLK_PHYCLK_USBHOST30_UHOST30_PHYCLOCK_PHY>;
+			#phy-cells = <1>;
+			samsung,pmu-syscon = <&pmu_system_controller>;
+			status = "disabled";
+		};
+
+		usbhost30: usb at 15a00000 {
+			compatible = "samsung,exynos5250-dwusb3";
+			clocks = <&cmu_fsys CLK_ACLK_USBHOST30>,
+				<&cmu_fsys CLK_SCLK_USBHOST30>;
+			clock-names = "usbdrd30", "usbdrd30_susp_clk";
+			assigned-clocks =
+				<&cmu_fsys CLK_MOUT_SCLK_USBHOST30_USER>,
+				<&cmu_top CLK_MOUT_SCLK_USBHOST30>,
+				<&cmu_top CLK_DIV_SCLK_USBHOST30>;
+			assigned-clock-parents =
+				<&cmu_top CLK_SCLK_USBHOST30_FSYS>,
+				<&cmu_top CLK_MOUT_BUS_PLL_USER>;
+			assigned-clock-rates = <0>, <0>, <66700000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			status = "disabled";
+
+			usbdrd_dwc3_0: dwc3 {
+				compatible = "snps,dwc3";
+				reg = <0x15a00000 0x10000>;
+				interrupts = <0 244 0>;
+				phys = <&usbhost30_phy 0>, <&usbhost30_phy 1>;
+				phy-names = "usb2-phy", "usb3-phy";
+			};
+		};
+
+		mshc_0: mshc at 15540000 {
+			compatible = "samsung,exynos7-dw-mshc-smu";
+			interrupts = <0 225 0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x15540000 0x2000>;
+			clocks = <&cmu_fsys CLK_ACLK_MMC0>,
+				<&cmu_fsys CLK_SCLK_MMC0>;
+			clock-names = "biu", "ciu";
+			fifo-depth = <0x40>;
+			status = "disabled";
+		};
+
+		mshc_1: mshc at 15550000 {
+			compatible = "samsung,exynos7-dw-mshc-smu";
+			interrupts = <0 226 0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x15550000 0x2000>;
+			clocks = <&cmu_fsys CLK_ACLK_MMC1>,
+				<&cmu_fsys CLK_SCLK_MMC1>;
+			clock-names = "biu", "ciu";
+			fifo-depth = <0x40>;
+			status = "disabled";
+		};
+
+		mshc_2: mshc at 15560000 {
+			compatible = "samsung,exynos7-dw-mshc-smu";
+			interrupts = <0 227 0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x15560000 0x2000>;
+			clocks = <&cmu_fsys CLK_ACLK_MMC2>,
+				<&cmu_fsys CLK_SCLK_MMC2>;
+			clock-names = "biu", "ciu";
+			fifo-depth = <0x40>;
+			status = "disabled";
+		};
+
+		amba {
+			compatible = "arm,amba-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			pdma0: pdma at 15610000 {
+				compatible = "arm,pl330", "arm,primecell";
+				reg = <0x15610000 0x1000>;
+				interrupts = <0 228 0>;
+				clocks = <&cmu_fsys CLK_PDMA0>;
+				clock-names = "apb_pclk";
+				#dma-cells = <1>;
+				#dma-channels = <8>;
+				#dma-requests = <32>;
+			};
+
+			pdma1: pdma at 15600000 {
+				compatible = "arm,pl330", "arm,primecell";
+				reg = <0x15600000 0x1000>;
+				interrupts = <0 246 0>;
+				clocks = <&cmu_fsys CLK_PDMA1>;
+				clock-names = "apb_pclk";
+				#dma-cells = <1>;
+				#dma-channels = <8>;
+				#dma-requests = <32>;
+			};
+
+			adma: adma at 11420000 {
+				compatible = "arm,pl330", "arm,primecell";
+				reg = <0x11420000 0x1000>;
+				interrupts = <0 73 0>;
+				clocks = <&cmu_aud CLK_ACLK_DMAC>;
+				clock-names = "apb_pclk";
+				#dma-cells = <1>;
+				#dma-channels = <8>;
+				#dma-requests = <32>;
+			};
+		};
+	};
+
+	timer: timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <1 13 0xff04>,
+			     <1 14 0xff04>,
+			     <1 11 0xff04>,
+			     <1 10 0xff04>;
+	};
+};
+
+#include "exynos5433-pinctrl.dtsi"
+#include "exynos5433-tmu.dtsi"
-- 
1.9.1
