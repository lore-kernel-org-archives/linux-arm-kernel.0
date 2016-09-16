From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 16 Sep 2016 23:41:57 +0200
Subject: [PATCH 2/7] ARM: dts: exynos: Use human-friendly symbols for
 interrupt properties in exynos3250
In-Reply-To: <1474062122-22720-1-git-send-email-krzk@kernel.org>
References: <1474062122-22720-1-git-send-email-krzk@kernel.org>
Message-ID: <1474062122-22720-3-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace hard-coded values of type of GIC interrupt and its flags with
respective macros from header to increase code readability.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos3250-pinctrl.dtsi |  32 ++++-----
 arch/arm/boot/dts/exynos3250.dtsi         | 112 +++++++++++++++---------------
 2 files changed, 73 insertions(+), 71 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250-pinctrl.dtsi b/arch/arm/boot/dts/exynos3250-pinctrl.dtsi
index 9ee16ab30608..a5b65ed12d61 100644
--- a/arch/arm/boot/dts/exynos3250-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos3250-pinctrl.dtsi
@@ -374,14 +374,14 @@
 
 		interrupt-controller;
 		interrupt-parent = <&gic>;
-		interrupts = <0 32 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 33 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 34 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 35 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 36 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 37 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 38 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 39 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
 		#interrupt-cells = <2>;
 	};
 
@@ -391,14 +391,14 @@
 
 		interrupt-controller;
 		interrupt-parent = <&gic>;
-		interrupts = <0 40 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 41 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 42 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 43 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 44 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 45 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 46 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 47 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
 		#interrupt-cells = <2>;
 	};
 
diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 9703d81d1eb3..ba17ee1eb749 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -20,6 +20,7 @@
 #include "exynos4-cpu-thermal.dtsi"
 #include "exynos-syscon-restart.dtsi"
 #include <dt-bindings/clock/exynos3250.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 
 / {
@@ -212,8 +213,8 @@
 		rtc: rtc at 10070000 {
 			compatible = "samsung,s3c6410-rtc";
 			reg = <0x10070000 0x100>;
-			interrupts = <0 73 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 74 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-parent = <&pmu_system_controller>;
 			status = "disabled";
 		};
@@ -221,7 +222,7 @@
 		tmu: tmu at 100C0000 {
 			compatible = "samsung,exynos3250-tmu";
 			reg = <0x100C0000 0x100>;
-			interrupts = <0 216 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_TMU_APBIF>;
 			clock-names = "tmu_apbif";
 			#include "exynos4412-tmu-sensor-conf.dtsi"
@@ -236,20 +237,21 @@
 			      <0x10482000 0x1000>,
 			      <0x10484000 0x2000>,
 			      <0x10486000 0x2000>;
-			interrupts = <1 9 0xf04>;
+			interrupts = <GIC_PPI 9
+					(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 		};
 
 		mct at 10050000 {
 			compatible = "samsung,exynos4210-mct";
 			reg = <0x10050000 0x800>;
-			interrupts = <0 218 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 219 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 220 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 221 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 223 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 226 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 227 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 228 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_FIN_PLL>, <&cmu CLK_MCT>;
 			clock-names = "fin_pll", "mct";
 		};
@@ -257,24 +259,24 @@
 		pinctrl_1: pinctrl at 11000000 {
 			compatible = "samsung,exynos3250-pinctrl";
 			reg = <0x11000000 0x1000>;
-			interrupts = <0 225 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
 
 			wakeup-interrupt-controller {
 				compatible = "samsung,exynos4210-wakeup-eint";
-				interrupts = <0 48 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
 			};
 		};
 
 		pinctrl_0: pinctrl at 11400000 {
 			compatible = "samsung,exynos3250-pinctrl";
 			reg = <0x11400000 0x1000>;
-			interrupts = <0 240 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		jpeg: codec at 11830000 {
 			compatible = "samsung,exynos3250-jpeg";
 			reg = <0x11830000 0x1000>;
-			interrupts = <0 171 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_JPEG>, <&cmu CLK_SCLK_JPEG>;
 			clock-names = "jpeg", "sclk";
 			power-domains = <&pd_cam>;
@@ -288,8 +290,8 @@
 		sysmmu_jpeg: sysmmu at 11A60000 {
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x11a60000 0x1000>;
-			interrupts = <0 156 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 161 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "sysmmu", "master";
 			clocks = <&cmu CLK_SMMUJPEG>, <&cmu CLK_JPEG>;
 			power-domains = <&pd_cam>;
@@ -300,9 +302,9 @@
 			compatible = "samsung,exynos3250-fimd";
 			reg = <0x11c00000 0x30000>;
 			interrupt-names = "fifo", "vsync", "lcd_sys";
-			interrupts = <0 84 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 85 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 86 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_SCLK_FIMD0>, <&cmu CLK_FIMD0>;
 			clock-names = "sclk_fimd", "fimd";
 			power-domains = <&pd_lcd0>;
@@ -314,7 +316,7 @@
 		dsi_0: dsi at 11C80000 {
 			compatible = "samsung,exynos3250-mipi-dsi";
 			reg = <0x11C80000 0x10000>;
-			interrupts = <0 83 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
 			samsung,phy-type = <0>;
 			power-domains = <&pd_lcd0>;
 			phys = <&mipi_phy 1>;
@@ -329,8 +331,8 @@
 		sysmmu_fimd0: sysmmu at 11E20000 {
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x11e20000 0x1000>;
-			interrupts = <0 80 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 81 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "sysmmu", "master";
 			clocks = <&cmu CLK_SMMUFIMD0>, <&cmu CLK_FIMD0>;
 			power-domains = <&pd_lcd0>;
@@ -340,7 +342,7 @@
 		hsotg: hsotg at 12480000 {
 			compatible = "snps,dwc2";
 			reg = <0x12480000 0x20000>;
-			interrupts = <0 141 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_USBOTG>;
 			clock-names = "otg";
 			phys = <&exynos_usbphy 0>;
@@ -351,7 +353,7 @@
 		mshc_0: mshc at 12510000 {
 			compatible = "samsung,exynos5420-dw-mshc";
 			reg = <0x12510000 0x1000>;
-			interrupts = <0 142 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_SDMMC0>, <&cmu CLK_SCLK_MMC0>;
 			clock-names = "biu", "ciu";
 			fifo-depth = <0x80>;
@@ -363,7 +365,7 @@
 		mshc_1: mshc at 12520000 {
 			compatible = "samsung,exynos5420-dw-mshc";
 			reg = <0x12520000 0x1000>;
-			interrupts = <0 143 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_SDMMC1>, <&cmu CLK_SCLK_MMC1>;
 			clock-names = "biu", "ciu";
 			fifo-depth = <0x80>;
@@ -375,7 +377,7 @@
 		mshc_2: mshc at 12530000 {
 			compatible = "samsung,exynos5250-dw-mshc";
 			reg = <0x12530000 0x1000>;
-			interrupts = <0 144 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_SDMMC2>, <&cmu CLK_SCLK_MMC2>;
 			clock-names = "biu", "ciu";
 			fifo-depth = <0x80>;
@@ -403,7 +405,7 @@
 			pdma0: pdma at 12680000 {
 				compatible = "arm,pl330", "arm,primecell";
 				reg = <0x12680000 0x1000>;
-				interrupts = <0 138 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&cmu CLK_PDMA0>;
 				clock-names = "apb_pclk";
 				#dma-cells = <1>;
@@ -414,7 +416,7 @@
 			pdma1: pdma at 12690000 {
 				compatible = "arm,pl330", "arm,primecell";
 				reg = <0x12690000 0x1000>;
-				interrupts = <0 139 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&cmu CLK_PDMA1>;
 				clock-names = "apb_pclk";
 				#dma-cells = <1>;
@@ -427,7 +429,7 @@
 			compatible = "samsung,exynos3250-adc",
 				     "samsung,exynos-adc-v2";
 			reg = <0x126C0000 0x100>;
-			interrupts = <0 137 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "adc", "sclk";
 			clocks = <&cmu CLK_TSADC>, <&cmu CLK_SCLK_TSADC>;
 			#io-channel-cells = <1>;
@@ -439,7 +441,7 @@
 		mfc: codec at 13400000 {
 			compatible = "samsung,mfc-v7";
 			reg = <0x13400000 0x10000>;
-			interrupts = <0 102 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "mfc", "sclk_mfc";
 			clocks = <&cmu CLK_MFC>, <&cmu CLK_SCLK_MFC>;
 			power-domains = <&pd_mfc>;
@@ -449,8 +451,8 @@
 		sysmmu_mfc: sysmmu at 13620000 {
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x13620000 0x1000>;
-			interrupts = <0 96 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 98 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "sysmmu", "master";
 			clocks = <&cmu CLK_SMMUMFC_L>, <&cmu CLK_MFC>;
 			power-domains = <&pd_mfc>;
@@ -460,7 +462,7 @@
 		serial_0: serial at 13800000 {
 			compatible = "samsung,exynos4210-uart";
 			reg = <0x13800000 0x100>;
-			interrupts = <0 109 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_UART0>, <&cmu CLK_SCLK_UART0>;
 			clock-names = "uart", "clk_uart_baud0";
 			pinctrl-names = "default";
@@ -471,7 +473,7 @@
 		serial_1: serial at 13810000 {
 			compatible = "samsung,exynos4210-uart";
 			reg = <0x13810000 0x100>;
-			interrupts = <0 110 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_UART1>, <&cmu CLK_SCLK_UART1>;
 			clock-names = "uart", "clk_uart_baud0";
 			pinctrl-names = "default";
@@ -482,7 +484,7 @@
 		serial_2: serial at 13820000 {
 			compatible = "samsung,exynos4210-uart";
 			reg = <0x13820000 0x100>;
-			interrupts = <0 111 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_UART2>, <&cmu CLK_SCLK_UART2>;
 			clock-names = "uart", "clk_uart_baud0";
 			pinctrl-names = "default";
@@ -495,7 +497,7 @@
 			#size-cells = <0>;
 			compatible = "samsung,s3c2440-i2c";
 			reg = <0x13860000 0x100>;
-			interrupts = <0 113 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_I2C0>;
 			clock-names = "i2c";
 			pinctrl-names = "default";
@@ -508,7 +510,7 @@
 			#size-cells = <0>;
 			compatible = "samsung,s3c2440-i2c";
 			reg = <0x13870000 0x100>;
-			interrupts = <0 114 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_I2C1>;
 			clock-names = "i2c";
 			pinctrl-names = "default";
@@ -521,7 +523,7 @@
 			#size-cells = <0>;
 			compatible = "samsung,s3c2440-i2c";
 			reg = <0x13880000 0x100>;
-			interrupts = <0 115 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_I2C2>;
 			clock-names = "i2c";
 			pinctrl-names = "default";
@@ -534,7 +536,7 @@
 			#size-cells = <0>;
 			compatible = "samsung,s3c2440-i2c";
 			reg = <0x13890000 0x100>;
-			interrupts = <0 116 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_I2C3>;
 			clock-names = "i2c";
 			pinctrl-names = "default";
@@ -547,7 +549,7 @@
 			#size-cells = <0>;
 			compatible = "samsung,s3c2440-i2c";
 			reg = <0x138A0000 0x100>;
-			interrupts = <0 117 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_I2C4>;
 			clock-names = "i2c";
 			pinctrl-names = "default";
@@ -560,7 +562,7 @@
 			#size-cells = <0>;
 			compatible = "samsung,s3c2440-i2c";
 			reg = <0x138B0000 0x100>;
-			interrupts = <0 118 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_I2C5>;
 			clock-names = "i2c";
 			pinctrl-names = "default";
@@ -573,7 +575,7 @@
 			#size-cells = <0>;
 			compatible = "samsung,s3c2440-i2c";
 			reg = <0x138C0000 0x100>;
-			interrupts = <0 119 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_I2C6>;
 			clock-names = "i2c";
 			pinctrl-names = "default";
@@ -586,7 +588,7 @@
 			#size-cells = <0>;
 			compatible = "samsung,s3c2440-i2c";
 			reg = <0x138D0000 0x100>;
-			interrupts = <0 120 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_I2C7>;
 			clock-names = "i2c";
 			pinctrl-names = "default";
@@ -597,7 +599,7 @@
 		spi_0: spi at 13920000 {
 			compatible = "samsung,exynos4210-spi";
 			reg = <0x13920000 0x100>;
-			interrupts = <0 121 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&pdma0 7>, <&pdma0 6>;
 			dma-names = "tx", "rx";
 			#address-cells = <1>;
@@ -613,7 +615,7 @@
 		spi_1: spi at 13930000 {
 			compatible = "samsung,exynos4210-spi";
 			reg = <0x13930000 0x100>;
-			interrupts = <0 122 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&pdma1 7>, <&pdma1 6>;
 			dma-names = "tx", "rx";
 			#address-cells = <1>;
@@ -629,7 +631,7 @@
 		i2s2: i2s at 13970000 {
 			compatible = "samsung,s3c6410-i2s";
 			reg = <0x13970000 0x100>;
-			interrupts = <0 126 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_I2S>, <&cmu CLK_SCLK_I2S>;
 			clock-names = "iis", "i2s_opclk0";
 			dmas = <&pdma0 14>, <&pdma0 13>;
@@ -642,19 +644,19 @@
 		pwm: pwm at 139D0000 {
 			compatible = "samsung,exynos4210-pwm";
 			reg = <0x139D0000 0x1000>;
-			interrupts = <0 104 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 105 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 106 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 107 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 108 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
 			#pwm-cells = <3>;
 			status = "disabled";
 		};
 
 		pmu {
 			compatible = "arm,cortex-a7-pmu";
-			interrupts = <0 18 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 19 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		ppmu_dmc0: ppmu_dmc0 at 106a0000 {
-- 
2.7.4
