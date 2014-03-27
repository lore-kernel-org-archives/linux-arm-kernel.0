From: shaik.ameer@samsung.com (Shaik Ameer Basha)
Date: Thu, 27 Mar 2014 16:37:50 +0530
Subject: [PATCH v2 7/7] ARM: dts: update macros in clock bindings for
 exynos5420
In-Reply-To: <1395918470-16374-1-git-send-email-shaik.ameer@samsung.com>
References: <1395918470-16374-1-git-send-email-shaik.ameer@samsung.com>
Message-ID: <1395918470-16374-8-git-send-email-shaik.ameer@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rahul Sharma <rahul.sharma@samsung.com>

This patch updates the macros as per the latest changes and
replaces magic numbers with macros defined in DT header for
exynos5420.

Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
Signed-off-by: Shaik Ameer Basha <shaik.ameer@samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi |   90 ++++++++++++++++++-------------------
 1 file changed, 45 insertions(+), 45 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 7c53ae9..2e60c80 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -129,7 +129,7 @@
 		compatible = "samsung,mfc-v7";
 		reg = <0x11000000 0x10000>;
 		interrupts = <0 96 0>;
-		clocks = <&clock CLK_MFC>;
+		clocks = <&clock CLK_ACLK_MFC>;
 		clock-names = "mfc";
 	};
 
@@ -139,7 +139,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		reg = <0x12200000 0x2000>;
-		clocks = <&clock CLK_MMC0>, <&clock CLK_SCLK_MMC0>;
+		clocks = <&clock CLK_ACLK_MMC0>, <&clock CLK_SCLK_MMC0>;
 		clock-names = "biu", "ciu";
 		fifo-depth = <0x40>;
 		status = "disabled";
@@ -151,7 +151,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		reg = <0x12210000 0x2000>;
-		clocks = <&clock CLK_MMC1>, <&clock CLK_SCLK_MMC1>;
+		clocks = <&clock CLK_ACLK_MMC1>, <&clock CLK_SCLK_MMC1>;
 		clock-names = "biu", "ciu";
 		fifo-depth = <0x40>;
 		status = "disabled";
@@ -163,7 +163,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		reg = <0x12220000 0x1000>;
-		clocks = <&clock CLK_MMC2>, <&clock CLK_SCLK_MMC2>;
+		clocks = <&clock CLK_ACLK_MMC2>, <&clock CLK_SCLK_MMC2>;
 		clock-names = "biu", "ciu";
 		fifo-depth = <0x40>;
 		status = "disabled";
@@ -177,7 +177,7 @@
 		interrupt-parent = <&mct_map>;
 		interrupts = <0>, <1>, <2>, <3>, <4>, <5>, <6>, <7>,
 				<8>, <9>, <10>, <11>;
-		clocks = <&clock CLK_FIN_PLL>, <&clock CLK_MCT>;
+		clocks = <&clock CLK_FIN_PLL>, <&clock CLK_PCLK_MCT>;
 		clock-names = "fin_pll", "mct";
 
 		mct_map: mct-map {
@@ -271,7 +271,7 @@
 	};
 
 	rtc at 101E0000 {
-		clocks = <&clock CLK_RTC>;
+		clocks = <&clock CLK_PCLK_RTC>;
 		clock-names = "rtc";
 		status = "okay";
 	};
@@ -287,7 +287,7 @@
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x121A0000 0x1000>;
 			interrupts = <0 34 0>;
-			clocks = <&clock CLK_PDMA0>;
+			clocks = <&clock CLK_ACLK_PDMA0>;
 			clock-names = "apb_pclk";
 			#dma-cells = <1>;
 			#dma-channels = <8>;
@@ -298,7 +298,7 @@
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x121B0000 0x1000>;
 			interrupts = <0 35 0>;
-			clocks = <&clock CLK_PDMA1>;
+			clocks = <&clock CLK_ACLK_PDMA1>;
 			clock-names = "apb_pclk";
 			#dma-cells = <1>;
 			#dma-channels = <8>;
@@ -309,7 +309,7 @@
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x10800000 0x1000>;
 			interrupts = <0 33 0>;
-			clocks = <&clock CLK_MDMA0>;
+			clocks = <&clock CLK_ACLK_MDMA0>;
 			clock-names = "apb_pclk";
 			#dma-cells = <1>;
 			#dma-channels = <8>;
@@ -320,7 +320,7 @@
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x11C10000 0x1000>;
 			interrupts = <0 124 0>;
-			clocks = <&clock CLK_MDMA1>;
+			clocks = <&clock CLK_ACLK_MDMA1>;
 			clock-names = "apb_pclk";
 			#dma-cells = <1>;
 			#dma-channels = <8>;
@@ -351,7 +351,7 @@
 		dmas = <&pdma1 12
 			&pdma1 11>;
 		dma-names = "tx", "rx";
-		clocks = <&clock CLK_I2S1>, <&clock CLK_SCLK_I2S1>;
+		clocks = <&clock CLK_PCLK_I2S1>, <&clock CLK_SCLK_I2S1>;
 		clock-names = "iis", "i2s_opclk0";
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2s1_bus>;
@@ -364,7 +364,7 @@
 		dmas = <&pdma0 12
 			&pdma0 11>;
 		dma-names = "tx", "rx";
-		clocks = <&clock CLK_I2S2>, <&clock CLK_SCLK_I2S2>;
+		clocks = <&clock CLK_PCLK_I2S2>, <&clock CLK_SCLK_I2S2>;
 		clock-names = "iis", "i2s_opclk0";
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2s2_bus>;
@@ -382,7 +382,7 @@
 		#size-cells = <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&spi0_bus>;
-		clocks = <&clock CLK_SPI0>, <&clock CLK_SCLK_SPI0>;
+		clocks = <&clock CLK_PCLK_SPI0>, <&clock CLK_SCLK_SPI0>;
 		clock-names = "spi", "spi_busclk0";
 		status = "disabled";
 	};
@@ -398,7 +398,7 @@
 		#size-cells = <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&spi1_bus>;
-		clocks = <&clock CLK_SPI1>, <&clock CLK_SCLK_SPI1>;
+		clocks = <&clock CLK_PCLK_SPI1>, <&clock CLK_SCLK_SPI1>;
 		clock-names = "spi", "spi_busclk0";
 		status = "disabled";
 	};
@@ -414,28 +414,28 @@
 		#size-cells = <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&spi2_bus>;
-		clocks = <&clock CLK_SPI2>, <&clock CLK_SCLK_SPI2>;
+		clocks = <&clock CLK_PCLK_SPI2>, <&clock CLK_SCLK_SPI2>;
 		clock-names = "spi", "spi_busclk0";
 		status = "disabled";
 	};
 
 	serial at 12C00000 {
-		clocks = <&clock CLK_UART0>, <&clock CLK_SCLK_UART0>;
+		clocks = <&clock CLK_PCLK_UART0>, <&clock CLK_SCLK_UART0>;
 		clock-names = "uart", "clk_uart_baud0";
 	};
 
 	serial at 12C10000 {
-		clocks = <&clock CLK_UART1>, <&clock CLK_SCLK_UART1>;
+		clocks = <&clock CLK_PCLK_UART1>, <&clock CLK_SCLK_UART1>;
 		clock-names = "uart", "clk_uart_baud0";
 	};
 
 	serial at 12C20000 {
-		clocks = <&clock CLK_UART2>, <&clock CLK_SCLK_UART2>;
+		clocks = <&clock CLK_PCLK_UART2>, <&clock CLK_SCLK_UART2>;
 		clock-names = "uart", "clk_uart_baud0";
 	};
 
 	serial at 12C30000 {
-		clocks = <&clock CLK_UART3>, <&clock CLK_SCLK_UART3>;
+		clocks = <&clock CLK_PCLK_UART3>, <&clock CLK_SCLK_UART3>;
 		clock-names = "uart", "clk_uart_baud0";
 	};
 
@@ -444,7 +444,7 @@
 		reg = <0x12dd0000 0x100>;
 		samsung,pwm-outputs = <0>, <1>, <2>, <3>;
 		#pwm-cells = <3>;
-		clocks = <&clock CLK_PWM>;
+		clocks = <&clock CLK_PCLK_PWM>;
 		clock-names = "timers";
 	};
 
@@ -455,7 +455,7 @@
 	};
 
 	dp-controller at 145B0000 {
-		clocks = <&clock CLK_DP1>;
+		clocks = <&clock CLK_PCLK_DP1>;
 		clock-names = "dp";
 		phys = <&dp_phy>;
 		phy-names = "dp";
@@ -463,7 +463,7 @@
 
 	fimd at 14400000 {
 		samsung,power-domain = <&disp_pd>;
-		clocks = <&clock CLK_SCLK_FIMD1>, <&clock CLK_FIMD1>;
+		clocks = <&clock CLK_SCLK_FIMD1>, <&clock CLK_ACLK_FIMD1>;
 		clock-names = "sclk_fimd", "fimd";
 	};
 
@@ -471,7 +471,7 @@
 		compatible = "samsung,exynos-adc-v2";
 		reg = <0x12D10000 0x100>, <0x10040720 0x4>;
 		interrupts = <0 106 0>;
-		clocks = <&clock CLK_TSADC>;
+		clocks = <&clock CLK_PCLK_TSADC>;
 		clock-names = "adc";
 		#io-channel-cells = <1>;
 		io-channel-ranges;
@@ -484,7 +484,7 @@
 		interrupts = <0 56 0>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		clocks = <&clock CLK_I2C0>;
+		clocks = <&clock CLK_PCLK_I2C0>;
 		clock-names = "i2c";
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c0_bus>;
@@ -497,7 +497,7 @@
 		interrupts = <0 57 0>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		clocks = <&clock CLK_I2C1>;
+		clocks = <&clock CLK_PCLK_I2C1>;
 		clock-names = "i2c";
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c1_bus>;
@@ -510,7 +510,7 @@
 		interrupts = <0 58 0>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		clocks = <&clock CLK_I2C2>;
+		clocks = <&clock CLK_PCLK_I2C2>;
 		clock-names = "i2c";
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c2_bus>;
@@ -523,7 +523,7 @@
 		interrupts = <0 59 0>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		clocks = <&clock CLK_I2C3>;
+		clocks = <&clock CLK_PCLK_I2C3>;
 		clock-names = "i2c";
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c3_bus>;
@@ -538,7 +538,7 @@
 		#size-cells = <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c4_hs_bus>;
-		clocks = <&clock CLK_I2C4>;
+		clocks = <&clock CLK_PCLK_USI0>;
 		clock-names = "hsi2c";
 		status = "disabled";
 	};
@@ -551,7 +551,7 @@
 		#size-cells = <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c5_hs_bus>;
-		clocks = <&clock CLK_I2C5>;
+		clocks = <&clock CLK_PCLK_USI1>;
 		clock-names = "hsi2c";
 		status = "disabled";
 	};
@@ -564,7 +564,7 @@
 		#size-cells = <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c6_hs_bus>;
-		clocks = <&clock CLK_I2C6>;
+		clocks = <&clock CLK_PCLK_USI2>;
 		clock-names = "hsi2c";
 		status = "disabled";
 	};
@@ -577,7 +577,7 @@
 		#size-cells = <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c7_hs_bus>;
-		clocks = <&clock CLK_I2C7>;
+		clocks = <&clock CLK_PCLK_USI3>;
 		clock-names = "hsi2c";
 		status = "disabled";
 	};
@@ -590,7 +590,7 @@
 		#size-cells = <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c8_hs_bus>;
-		clocks = <&clock CLK_I2C8>;
+		clocks = <&clock CLK_PCLK_USI4>;
 		clock-names = "hsi2c";
 		status = "disabled";
 	};
@@ -603,7 +603,7 @@
 		#size-cells = <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c9_hs_bus>;
-		clocks = <&clock CLK_I2C9>;
+		clocks = <&clock CLK_PCLK_USI5>;
 		clock-names = "hsi2c";
 		status = "disabled";
 	};
@@ -616,7 +616,7 @@
 		#size-cells = <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c10_hs_bus>;
-		clocks = <&clock CLK_I2C10>;
+		clocks = <&clock CLK_PCLK_USI6>;
 		clock-names = "hsi2c";
 		status = "disabled";
 	};
@@ -625,7 +625,7 @@
 		compatible = "samsung,exynos4212-hdmi";
 		reg = <0x14530000 0x70000>;
 		interrupts = <0 95 0>;
-		clocks = <&clock CLK_HDMI>, <&clock CLK_SCLK_HDMI>,
+		clocks = <&clock CLK_PCLK_HDMI>, <&clock CLK_SCLK_HDMI>,
 			 <&clock CLK_DOUT_PIXEL>, <&clock CLK_SCLK_HDMIPHY>,
 			 <&clock CLK_MOUT_HDMI>;
 		clock-names = "hdmi", "sclk_hdmi", "sclk_pixel",
@@ -637,7 +637,7 @@
 		compatible = "samsung,exynos5420-mixer";
 		reg = <0x14450000 0x10000>;
 		interrupts = <0 94 0>;
-		clocks = <&clock CLK_MIXER>, <&clock CLK_SCLK_HDMI>;
+		clocks = <&clock CLK_ACLK_MIXER>, <&clock CLK_SCLK_HDMI>;
 		clock-names = "mixer", "sclk_hdmi";
 	};
 
@@ -645,7 +645,7 @@
 		compatible = "samsung,exynos5-gsc";
 		reg = <0x13e00000 0x1000>;
 		interrupts = <0 85 0>;
-		clocks = <&clock CLK_GSCL0>;
+		clocks = <&clock CLK_ACLK_GSCL0>;
 		clock-names = "gscl";
 		samsung,power-domain = <&gsc_pd>;
 	};
@@ -654,7 +654,7 @@
 		compatible = "samsung,exynos5-gsc";
 		reg = <0x13e10000 0x1000>;
 		interrupts = <0 86 0>;
-		clocks = <&clock CLK_GSCL1>;
+		clocks = <&clock CLK_ACLK_GSCL1>;
 		clock-names = "gscl";
 		samsung,power-domain = <&gsc_pd>;
 	};
@@ -668,7 +668,7 @@
 		compatible = "samsung,exynos5420-tmu";
 		reg = <0x10060000 0x100>;
 		interrupts = <0 65 0>;
-		clocks = <&clock CLK_TMU>;
+		clocks = <&clock CLK_PCLK_TMU>;
 		clock-names = "tmu_apbif";
 	};
 
@@ -676,7 +676,7 @@
 		compatible = "samsung,exynos5420-tmu";
 		reg = <0x10064000 0x100>;
 		interrupts = <0 183 0>;
-		clocks = <&clock CLK_TMU>;
+		clocks = <&clock CLK_PCLK_TMU>;
 		clock-names = "tmu_apbif";
 	};
 
@@ -684,7 +684,7 @@
 		compatible = "samsung,exynos5420-tmu-ext-triminfo";
 		reg = <0x10068000 0x100>, <0x1006c000 0x4>;
 		interrupts = <0 184 0>;
-		clocks = <&clock CLK_TMU>, <&clock CLK_TMU>;
+		clocks = <&clock CLK_PCLK_TMU>, <&clock CLK_PCLK_TMU>;
 		clock-names = "tmu_apbif", "tmu_triminfo_apbif";
 	};
 
@@ -692,7 +692,7 @@
 		compatible = "samsung,exynos5420-tmu-ext-triminfo";
 		reg = <0x1006c000 0x100>, <0x100a0000 0x4>;
 		interrupts = <0 185 0>;
-		clocks = <&clock CLK_TMU>, <&clock CLK_TMU_GPU>;
+		clocks = <&clock CLK_PCLK_TMU>, <&clock CLK_PCLK_TMU_GPU>;
 		clock-names = "tmu_apbif", "tmu_triminfo_apbif";
 	};
 
@@ -700,7 +700,7 @@
 		compatible = "samsung,exynos5420-tmu-ext-triminfo";
 		reg = <0x100a0000 0x100>, <0x10068000 0x4>;
 		interrupts = <0 215 0>;
-		clocks = <&clock CLK_TMU_GPU>, <&clock CLK_TMU>;
+		clocks = <&clock CLK_PCLK_TMU_GPU>, <&clock CLK_PCLK_TMU>;
 		clock-names = "tmu_apbif", "tmu_triminfo_apbif";
 	};
 
@@ -708,7 +708,7 @@
 		compatible = "samsung,exynos5420-wdt";
 		reg = <0x101D0000 0x100>;
 		interrupts = <0 42 0>;
-		clocks = <&clock CLK_WDT>;
+		clocks = <&clock CLK_PCLK_WDT>;
 		clock-names = "watchdog";
 		samsung,syscon-phandle = <&pmu_system_controller>;
         };
@@ -717,7 +717,7 @@
 		compatible = "samsung,exynos4210-secss";
 		reg = <0x10830000 0x10000>;
 		interrupts = <0 112 0>;
-		clocks = <&clock 471>;
+		clocks = <&clock CLK_ACLK_SSS>;
 		clock-names = "secss";
 		samsung,power-domain = <&g2d_pd>;
 	};
-- 
1.7.9.5
