From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Wed, 27 Aug 2014 15:14:18 +0530
Subject: [PATCH 11/14] arm64: dts: Add initial device tree support for EXYNOS7
In-Reply-To: <1409132660-1898-1-git-send-email-ch.naveen@samsung.com>
References: <1409132660-1898-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <1409132660-1898-3-git-send-email-ch.naveen@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add initial device tree nodes for EXYNOS7 SoC.
Also, includes the dt-binding definitions for clock ids.

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/boot/dts/exynos7.dtsi |  553 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 553 insertions(+)
 create mode 100644 arch/arm64/boot/dts/exynos7.dtsi

diff --git a/arch/arm64/boot/dts/exynos7.dtsi b/arch/arm64/boot/dts/exynos7.dtsi
new file mode 100644
index 0000000..6b9eaf4
--- /dev/null
+++ b/arch/arm64/boot/dts/exynos7.dtsi
@@ -0,0 +1,553 @@
+/*
+ * SAMSUNG EXYNOS7 SoC device tree source
+ *
+ * Copyright (c) 2014 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * SAMSUNG EXYNOS7 SoC device nodes are listed in this file.
+ * EXYNOS7 based board files can include this file and provide
+ * values for board specfic bindings.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <dt-bindings/clock/exynos7-clk.h>
+
+/ {
+	compatible = "samsung,exynos7";
+	interrupt-parent = <&gic>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	aliases {
+		pinctrl0 = &pinctrl_0;
+		pinctrl1 = &pinctrl_1;
+		pinctrl2 = &pinctrl_2;
+		pinctrl3 = &pinctrl_3;
+		pinctrl4 = &pinctrl_4;
+		pinctrl5 = &pinctrl_5;
+		pinctrl6 = &pinctrl_6;
+		pinctrl7 = &pinctrl_7;
+		pinctrl8 = &pinctrl_8;
+		pinctrl9 = &pinctrl_9;
+		mshc0 = &mmc_0;
+		mshc2 = &mmc_2;
+	};
+
+	chipid at 10000000 {
+		compatible = "samsung,exynos4210-chipid";
+		reg = <0x10000000 0x100>;
+	};
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57", "arm,armv8";
+			reg = <0x0 0x0>;
+		};
+	};
+
+	fin_pll: xxti {
+		compatible = "fixed-clock";
+		clock-frequency = <24000000>;
+		clock-output-names = "fin_pll";
+		#clock-cells = <0>;
+	};
+
+	gic: interrupt-controller at 11001000 {
+		compatible = "arm,gic-400";
+		#interrupt-cells = <3>;
+		#address-cells = <0>;
+		interrupt-controller;
+		reg =	<0x11001000 0x1000>,
+			<0x11002000 0x1000>,
+			<0x11004000 0x2000>,
+			<0x11006000 0x2000>;
+	};
+
+	hsi2c_0: hsi2c at 13640000 {
+		compatible = "samsung,exynos7-hsi2c";
+		reg = <0x13640000 0x1000>;
+		interrupts = <0 441 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&hs_i2c0_bus>;
+		clocks = <&clock_peric0 PCLK_HSI2C0>;
+		clock-names = "hsi2c";
+		status = "disabled";
+	};
+
+	hsi2c_1: hsi2c at 13650000 {
+		compatible = "samsung,exynos7-hsi2c";
+		reg = <0x13650000 0x1000>;
+		interrupts = <0 442 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&hs_i2c1_bus>;
+		clocks = <&clock_peric0 PCLK_HSI2C1>;
+		clock-names = "hsi2c";
+		status = "disabled";
+	};
+
+	hsi2c_2: hsi2c at 14E60000 {
+		compatible = "samsung,exynos7-hsi2c";
+		reg = <0x14E60000 0x1000>;
+		interrupts = <0 459 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&hs_i2c2_bus>;
+		clocks = <&clock_peric1 PCLK_HSI2C2>;
+		clock-names = "hsi2c";
+		status = "disabled";
+	};
+
+	hsi2c_3: hsi2c at 14E70000 {
+		compatible = "samsung,exynos7-hsi2c";
+		reg = <0x14E70000 0x1000>;
+		interrupts = <0 460 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&hs_i2c3_bus>;
+		clocks = <&clock_peric1 PCLK_HSI2C3>;
+		clock-names = "hsi2c";
+		status = "disabled";
+	};
+
+	hsi2c_4: hsi2c at 13660000 {
+		compatible = "samsung,exynos7-hsi2c";
+		reg = <0x13660000 0x1000>;
+		interrupts = <0 443 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&hs_i2c4_bus>;
+		clocks = <&clock_peric0 PCLK_HSI2C4>;
+		clock-names = "hsi2c";
+		status = "disabled";
+	};
+
+	hsi2c_5: hsi2c at 13670000 {
+		compatible = "samsung,exynos7-hsi2c";
+		reg = <0x13670000 0x1000>;
+		interrupts = <0 444 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&hs_i2c5_bus>;
+		clocks = <&clock_peric0 PCLK_HSI2C5>;
+		clock-names = "hsi2c";
+		status = "disabled";
+	};
+
+	hsi2c_6: hsi2c at 14E00000 {
+		compatible = "samsung,exynos7-hsi2c";
+		reg = <0x14E00000 0x1000>;
+		interrupts = <0 461 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&hs_i2c6_bus>;
+		clocks = <&clock_peric1 PCLK_HSI2C6>;
+		clock-names = "hsi2c";
+		status = "disabled";
+	};
+
+	hsi2c_7: hsi2c at 13E10000 {
+		compatible = "samsung,exynos7-hsi2c";
+		reg = <0x13E10000 0x1000>;
+		interrupts = <0 462 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&hs_i2c7_bus>;
+		clocks = <&clock_peric1 PCLK_HSI2C7>;
+		clock-names = "hsi2c";
+		status = "disabled";
+	};
+
+	hsi2c_8: hsi2c at 14E20000 {
+		compatible = "samsung,exynos7-hsi2c";
+		reg = <0x14E20000 0x1000>;
+		interrupts = <0 463 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&hs_i2c8_bus>;
+		clocks = <&clock_peric1 PCLK_HSI2C8>;
+		clock-names = "hsi2c";
+		status = "disabled";
+	};
+
+	hsi2c_9: hsi2c at 13680000 {
+		compatible = "samsung,exynos7-hsi2c";
+		reg = <0x13680000 0x1000>;
+		interrupts = <0 445 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&hs_i2c9_bus>;
+		clocks = <&clock_peric0 PCLK_HSI2C9>;
+		clock-names = "hsi2c";
+		status = "disabled";
+	};
+
+	hsi2c_10: hsi2c at 13690000 {
+		compatible = "samsung,exynos7-hsi2c";
+		reg = <0x13690000 0x1000>;
+		interrupts = <0 446 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&hs_i2c10_bus>;
+		clocks = <&clock_peric0 PCLK_HSI2C10>;
+		clock-names = "hsi2c";
+		status = "disabled";
+	};
+
+	hsi2c_11: hsi2c at 136A0000 {
+		compatible = "samsung,exynos7-hsi2c";
+		reg = <0x136A0000 0x1000>;
+		interrupts = <0 447 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&hs_i2c11_bus>;
+		clocks = <&clock_peric0 PCLK_HSI2C11>;
+		clock-names = "hsi2c";
+		status = "disabled";
+	};
+
+	mct at 101C0000 {
+		compatible = "samsung,exynos4210-mct";
+		reg = <0x101C0000 0x800>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		interrupt-parent = <&mct_map>;
+		interrupts =	<0>, <1>, <2>, <3>,
+				<4>, <5>, <6>, <7>,
+				<8>, <9>, <10>, <11>;
+		clocks = <&fin_pll>, <&clock_peris PCLK_MCT>;
+		clock-names = "fin_pll", "mct";
+
+		mct_map: mct-map {
+			#interrupt-cells = <1>;
+			#address-cells = <0>;
+			#size-cells = <0>;
+			interrupt-map = <0 &gic 0 112 0>,
+					<1 &gic 0 113 0>,
+					<2 &gic 0 114 0>,
+					<3 &gic 0 115 0>,
+					<4 &gic 0 116 0>,
+					<5 &gic 0 117 0>,
+					<6 &gic 0 118 0>,
+					<7 &gic 0 119 0>,
+					<8 &gic 0 120 0>,
+					<9 &gic 0 121 0>,
+					<10 &gic 0 122 0>,
+					<11 &gic 0 123 0>;
+		};
+	};
+
+	mmc_0: mmc at 15740000 {
+		compatible = "samsung,exynos7-dw-mshc-smu";
+		interrupts = <0 201 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x15740000 0x2000>;
+		clocks = <&clock_fsys1 ACLK_MMC0>,
+			<&clock_top1 CLK_SCLK_MMC0>;
+		clock-names = "biu", "ciu";
+		fifo-depth = <0x40>;
+		status = "disabled";
+	};
+
+	mmc_2: mmc at 15560000 {
+		compatible = "samsung,exynos7-dw-mshc-smu";
+		interrupts = <0 216 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x15560000 0x2000>;
+		clocks = <&clock_fsys0 ACLK_MMC2>,
+			<&clock_top1 CLK_SCLK_MMC2>;
+		clock-names = "biu", "ciu";
+		fifo-depth = <0x40>;
+		status = "disabled";
+	};
+
+	pinctrl_0: pinctrl at 10580000 {
+		compatible = "samsung,exynos7-pinctrl";
+		reg = <0x10580000 0x1000>;
+		interrupts = <0 0 0>, <0 1 0>, <0 2 0>, <0 3 0>,
+				<0 4 0>, <0 5 0>, <0 6 0>, <0 7 0>,
+				<0 8 0>, <0 9 0>, <0 10 0>, <0 11 0>,
+				<0 12 0>, <0 13 0>, <0 14 0>, <0 15 0>;
+		wakeup-interrupt-controller {
+			compatible = "samsung,exynos4210-wakeup-eint";
+			interrupt-parent = <&gic>;
+			interrupts = <0 16 0>;
+		};
+	};
+
+	pinctrl_1: pinctrl at 114B0000 {
+		compatible = "samsung,exynos7-pinctrl";
+		reg = <0x114B0000 0x1000>;
+		interrupts = <0 92 0>;
+	};
+
+	pinctrl_2: pinctrl at 13470000 {
+		compatible = "samsung,exynos7-pinctrl";
+		reg = <0x13470000 0x1000>;
+		interrupts = <0 383 0>;
+	};
+
+	pinctrl_3: pinctrl at 14870000 {
+		compatible = "samsung,exynos7-pinctrl";
+		reg = <0x14870000 0x1000>;
+		interrupts = <0 384 0>;
+	};
+
+	pinctrl_4: pinctrl at 14CD0000 {
+		compatible = "samsung,exynos7-pinctrl";
+		reg = <0x14CD0000 0x1000>;
+		interrupts = <0 473 0>;
+	};
+
+	pinctrl_5: pinctrl at 14CE0000 {
+		compatible = "samsung,exynos7-pinctrl";
+		reg = <0x14CE0000 0x1000>;
+		interrupts = <0 474 0>;
+	};
+
+	pinctrl_6: pinctrl at 14C90000 {
+		compatible = "samsung,exynos7-pinctrl";
+		reg = <0x14C90000 0x1000>;
+		interrupts = <0 475 0>;
+	};
+
+	pinctrl_7: pinctrl at 14CA0000 {
+		compatible = "samsung,exynos7-pinctrl";
+		reg = <0x14CA0000 0x1000>;
+		interrupts = <0 476 0>;
+	};
+
+	pinctrl_8: pinctrl at 10E60000 {
+		compatible = "samsung,exynos7-pinctrl";
+		reg = <0x10E60000 0x1000>;
+		interrupts = <0 221 0>;
+	};
+
+	pinctrl_9: pinctrl at 15690000 {
+		compatible = "samsung,exynos7-pinctrl";
+		reg = <0x15690000 0x1000>;
+		interrupts = <0 203 0>;
+	};
+
+	pwm: pwm at 136C0000 {
+		compatible = "samsung,exynos4210-pwm";
+		reg = <0x136C0000 0x100>;
+		samsung,pwm-outputs = <0>, <1>, <2>, <3>;
+		#pwm-cells = <3>;
+		clocks = <&clock_peric0 PCLK_PWM>;
+		clock-names = "timers";
+		status = "disabled";
+	};
+
+	rtc at 10590000 {
+		compatible = "samsung,s3c6410-rtc";
+		reg = <0x10590000 0x100>;
+		interrupts = <0 355 0>, <0 356 0>;
+		clocks = <&clock_ccore PCLK_RTC>;
+		clock-names = "rtc";
+	};
+
+	serial at 13630000 {
+		compatible = "samsung,exynos4210-uart";
+		reg = <0x13630000 0x100>;
+		interrupts = <0 440 0>;
+		clocks = <&clock_peric0 PCLK_UART0>, <&clock_peric0 SCLK_UART0>;
+		clock-names = "uart", "clk_uart_baud0";
+		status = "okay";
+	};
+
+	serial at 14C20000 {
+		compatible = "samsung,exynos4210-uart";
+		reg = <0x14C20000 0x100>;
+		interrupts = <0 456 0>;
+		clocks = <&clock_peric1 PCLK_UART1>, <&clock_peric1 SCLK_UART1>;
+		clock-names = "uart", "clk_uart_baud1";
+		status = "okay";
+	};
+
+	serial at 14C30000 {
+		compatible = "samsung,exynos4210-uart";
+		reg = <0x14C30000 0x100>;
+		interrupts = <0 457 0>;
+		clocks = <&clock_peric1 PCLK_UART2>, <&clock_peric1 SCLK_UART2>;
+		clock-names = "uart", "clk_uart_baud2";
+		status = "okay";
+	};
+
+	serial at 14C40000 {
+		compatible = "samsung,exynos4210-uart";
+		reg = <0x14C40000 0x100>;
+		interrupts = <0 458 0>;
+		clocks = <&clock_peric1 PCLK_UART3>, <&clock_peric1 SCLK_UART3>;
+		clock-names = "uart", "clk_uart_baud3";
+		status = "okay";
+	};
+
+	/* The Clock nodes are ordered as per the usermanual. */
+	clock_topc: clock-controller at 10570000 {
+		compatible = "samsung,exynos7-clock-topc";
+		reg = <0x10570000 0x10000>;
+		#clock-cells = <1>;
+	};
+
+	clock_top0: clock-controller at 105D0000 {
+		compatible = "samsung,exynos7-clock-top0";
+		reg = <0x105D0000 0xB000>;
+		#clock-cells = <1>;
+	};
+
+	clock_top1: clock-controller at 105E0000 {
+		compatible = "samsung,exynos7-clock-top1";
+		reg = <0x105E0000 0xB000>;
+		#clock-cells = <1>;
+	};
+
+	clock_atlas: clock-controller at 11800000 {
+		compatible = "samsung,exynos7-clock-atlas";
+		reg = <0x11800000 0x1100>;
+		#clock-cells = <1>;
+	};
+
+	clock_g3d: clock-controller at 14AA0000 {
+		compatible = "samsung,exynos7-clock-g3d";
+		reg = <0x14AA0000 0x1100>;
+		#clock-cells = <1>;
+	};
+
+	clock_mif0: clock-controller at 10850000 {
+		compatible = "samsung,exynos7-clock-mif0";
+		reg = <0x10850000 0x1100>;
+		#clock-cells = <1>;
+	};
+
+	clock_mif1: clock-controller at 10950000 {
+		compatible = "samsung,exynos7-clock-mif1";
+		reg = <0x10950000 0x1100>;
+		#clock-cells = <1>;
+	};
+
+	clock_mif2: clock-controller at 10A50000 {
+		compatible = "samsung,exynos7-clock-mif2";
+		reg = <0x10A50000 0x1100>;
+		#clock-cells = <1>;
+	};
+
+	clock_mif3: clock-controller at 10B50000 {
+		compatible = "samsung,exynos7-clock-mif3";
+		reg = <0x10B50000 0x1100>;
+		#clock-cells = <1>;
+	};
+
+	clock_ccore: clock-controller at 105B0000 {
+		compatible = "samsung,exynos7-clock-ccore";
+		reg = <0x105B0000 0xD00>;
+		#clock-cells = <1>;
+	};
+
+	clock_imem: clock-controller at 11060000 {
+		compatible = "samsung,exynos7-clock-imem";
+		reg = <0x11060000 0xD00>;
+		#clock-cells = <1>;
+	};
+
+	clock_peric0: clock-controller at 13610000 {
+		compatible = "samsung,exynos7-clock-peric0";
+		reg = <0x13610000 0xD00>;
+		#clock-cells = <1>;
+	};
+
+	clock_peric1: clock-controller at 14C80000 {
+		compatible = "samsung,exynos7-clock-peric1";
+		reg = <0x14C80000 0xD00>;
+		#clock-cells = <1>;
+	};
+
+	clock_peris: clock-controller at 10040000 {
+		compatible = "samsung,exynos7-clock-peris";
+		reg = <0x10040000 0xD00>;
+		#clock-cells = <1>;
+	};
+
+	clock_bus0: clock-controller at 13400000 {
+		compatible = "samsung,exynos7-clock-bus0";
+		reg = <0x13400000 0xD00>;
+		#clock-cells = <1>;
+	};
+
+	clock_bus1: clock-controller at 14800000 {
+		compatible = "samsung,exynos7-clock-bus1";
+		reg = <0x14800000 0xD00>;
+		#clock-cells = <1>;
+	};
+
+	clock_disp: clock-controller at 13AD0000 {
+		compatible = "samsung,exynos7-clock-disp";
+		reg = <0x13AD0000 0xD00>;
+		#clock-cells = <1>;
+	};
+
+	clock_aud: clock-controller at 114C0000 {
+		compatible = "samsung,exynos7-clock-aud";
+		reg = <0x114C0000 0xD00>;
+		#clock-cells = <1>;
+	};
+
+	clock_fsys0: clock-controller at 10E90000 {
+		compatible = "samsung,exynos7-clock-fsys0";
+		reg = <0x10E90000 0xD00>;
+		#clock-cells = <1>;
+	};
+
+	clock_fsys1: clock-controller at 156E0000 {
+		compatible = "samsung,exynos7-clock-fsys1";
+		reg = <0x156E0000 0xD00>;
+		#clock-cells = <1>;
+	};
+
+	clock_mscl: clock-controller at 150D0000 {
+		compatible = "samsung,exynos7-clock-mscl";
+		reg = <0x150D0000 0xD00>;
+		#clock-cells = <1>;
+	};
+
+	clock_mfc: clock-controller at 15280000 {
+		compatible = "samsung,exynos7-clock-mfc";
+		reg = <0x15280000 0xD00>;
+		#clock-cells = <1>;
+	};
+
+	timer {
+	        compatible = "arm,armv8-timer";
+	        interrupts = <1 13 0xff01>,
+	                     <1 14 0xff01>,
+	                     <1 11 0xff01>,
+	                     <1 10 0xff01>;
+	        clock-frequency = <24000000>;
+		use-clocksource-only;
+		use-physical-timer;
+	};
+};
+
+#include "exynos7-pinctrl.dtsi"
-- 
1.7.9.5
