From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 16 Sep 2016 23:42:00 +0200
Subject: [PATCH 5/7] ARM: dts: exynos: Use human-friendly symbols for
 interrupt properties in exynos4415
In-Reply-To: <1474062122-22720-1-git-send-email-krzk@kernel.org>
References: <1474062122-22720-1-git-send-email-krzk@kernel.org>
Message-ID: <1474062122-22720-6-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace hard-coded values of type of GIC interrupt and its flags with
respective macros from header to increase code readability

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos4415-pinctrl.dtsi |  32 ++++-----
 arch/arm/boot/dts/exynos4415.dtsi         | 108 +++++++++++++++---------------
 2 files changed, 71 insertions(+), 69 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4415-pinctrl.dtsi b/arch/arm/boot/dts/exynos4415-pinctrl.dtsi
index 4863147be39a..f8d246cad22c 100644
--- a/arch/arm/boot/dts/exynos4415-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos4415-pinctrl.dtsi
@@ -358,14 +358,14 @@
 
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
 
@@ -375,14 +375,14 @@
 
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
 
diff --git a/arch/arm/boot/dts/exynos4415.dtsi b/arch/arm/boot/dts/exynos4415.dtsi
index 2ad6b6f9a37b..8d887ac380ab 100644
--- a/arch/arm/boot/dts/exynos4415.dtsi
+++ b/arch/arm/boot/dts/exynos4415.dtsi
@@ -18,6 +18,7 @@
 
 #include <dt-bindings/clock/exynos4415.h>
 #include <dt-bindings/clock/exynos-audss-clk.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 
 / {
@@ -106,7 +107,7 @@
 		pinctrl_2: pinctrl at 03860000 {
 			compatible = "samsung,exynos4415-pinctrl";
 			reg = <0x03860000 0x1000>;
-			interrupts = <0 242 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 242 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		chipid at 10000000 {
@@ -181,21 +182,22 @@
 		rtc: rtc at 10070000 {
 			compatible = "samsung,s3c6410-rtc";
 			reg = <0x10070000 0x100>;
-			interrupts = <0 73 IRQ_TYPE_LEVEL_HIGH>, <0 74 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
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
@@ -234,28 +236,28 @@
 		pinctrl_1: pinctrl at 11000000 {
 			compatible = "samsung,exynos4415-pinctrl";
 			reg = <0x11000000 0x1000>;
-			interrupts = <0 225 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
 
 			wakeup-interrupt-controller {
 				compatible = "samsung,exynos4210-wakeup-eint";
 				interrupt-parent = <&gic>;
-				interrupts = <0 48 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
 			};
 		};
 
 		pinctrl_0: pinctrl at 11400000 {
 			compatible = "samsung,exynos4415-pinctrl";
 			reg = <0x11400000 0x1000>;
-			interrupts = <0 240 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		fimd: fimd at 11C00000 {
 			compatible = "samsung,exynos4415-fimd";
 			reg = <0x11C00000 0x30000>;
 			interrupt-names = "fifo", "vsync", "lcd_sys";
-			interrupts = <0 84 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 85 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 86 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_SCLK_FIMD0>, <&cmu CLK_FIMD0>;
 			clock-names = "sclk_fimd", "fimd";
 			samsung,power-domain = <&pd_lcd0>;
@@ -267,7 +269,7 @@
 		dsi_0: dsi at 11C80000 {
 			compatible = "samsung,exynos4415-mipi-dsi";
 			reg = <0x11C80000 0x10000>;
-			interrupts = <0 83 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
 			samsung,phy-type = <0>;
 			samsung,power-domain = <&pd_lcd0>;
 			phys = <&mipi_phy 1>;
@@ -282,8 +284,8 @@
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
@@ -293,7 +295,7 @@
 		hsotg: hsotg at 12480000 {
 			compatible = "samsung,s3c6400-hsotg";
 			reg = <0x12480000 0x20000>;
-			interrupts = <0 141 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_USBDEVICE>;
 			clock-names = "otg";
 			phys = <&exynos_usbphy 0>;
@@ -304,7 +306,7 @@
 		mshc_0: mshc at 12510000 {
 			compatible = "samsung,exynos5250-dw-mshc";
 			reg = <0x12510000 0x1000>;
-			interrupts = <0 142 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_SDMMC0>, <&cmu CLK_SCLK_MMC0>;
 			clock-names = "biu", "ciu";
 			fifo-depth = <0x80>;
@@ -316,7 +318,7 @@
 		mshc_1: mshc at 12520000 {
 			compatible = "samsung,exynos5250-dw-mshc";
 			reg = <0x12520000 0x1000>;
-			interrupts = <0 143 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_SDMMC1>, <&cmu CLK_SCLK_MMC1>;
 			clock-names = "biu", "ciu";
 			fifo-depth = <0x80>;
@@ -328,7 +330,7 @@
 		mshc_2: mshc at 12530000 {
 			compatible = "samsung,exynos5250-dw-mshc";
 			reg = <0x12530000 0x1000>;
-			interrupts = <0 144 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_SDMMC2>, <&cmu CLK_SCLK_MMC2>;
 			clock-names = "biu", "ciu";
 			fifo-depth = <0x80>;
@@ -340,7 +342,7 @@
 		ehci: ehci at 12580000 {
 			compatible = "samsung,exynos4210-ehci";
 			reg = <0x12580000 0x100>;
-			interrupts = <0 140 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_USBHOST>;
 			clock-names = "usbhost";
 			status = "disabled";
@@ -366,7 +368,7 @@
 		ohci: ohci at 12590000 {
 			compatible = "samsung,exynos4210-ohci";
 			reg = <0x12590000 0x100>;
-			interrupts = <0 140 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_USBHOST>;
 			clock-names = "usbhost";
 			status = "disabled";
@@ -400,7 +402,7 @@
 			pdma0: pdma at 12680000 {
 				compatible = "arm,pl330", "arm,primecell";
 				reg = <0x12680000 0x1000>;
-				interrupts = <0 138 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&cmu CLK_PDMA0>;
 				clock-names = "apb_pclk";
 				#dma-cells = <1>;
@@ -411,7 +413,7 @@
 			pdma1: pdma at 12690000 {
 				compatible = "arm,pl330", "arm,primecell";
 				reg = <0x12690000 0x1000>;
-				interrupts = <0 139 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&cmu CLK_PDMA1>;
 				clock-names = "apb_pclk";
 				#dma-cells = <1>;
@@ -424,7 +426,7 @@
 			compatible = "samsung,exynos3250-adc",
 				     "samsung,exynos-adc-v2";
 			reg = <0x126C0000 0x100>, <0x10020718 0x4>;
-			interrupts = <0 137 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "adc", "sclk";
 			clocks = <&cmu CLK_TSADC>, <&cmu CLK_SCLK_TSADC>;
 			#io-channel-cells = <1>;
@@ -435,7 +437,7 @@
 		serial_0: serial at 13800000 {
 			compatible = "samsung,exynos4210-uart";
 			reg = <0x13800000 0x100>;
-			interrupts = <0 109 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_UART0>, <&cmu CLK_SCLK_UART0>;
 			clock-names = "uart", "clk_uart_baud0";
 			status = "disabled";
@@ -444,7 +446,7 @@
 		serial_1: serial at 13810000 {
 			compatible = "samsung,exynos4210-uart";
 			reg = <0x13810000 0x100>;
-			interrupts = <0 110 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_UART1>, <&cmu CLK_SCLK_UART1>;
 			clock-names = "uart", "clk_uart_baud0";
 			status = "disabled";
@@ -453,7 +455,7 @@
 		serial_2: serial at 13820000 {
 			compatible = "samsung,exynos4210-uart";
 			reg = <0x13820000 0x100>;
-			interrupts = <0 111 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_UART2>, <&cmu CLK_SCLK_UART2>;
 			clock-names = "uart", "clk_uart_baud0";
 			status = "disabled";
@@ -462,7 +464,7 @@
 		serial_3: serial at 13830000 {
 			compatible = "samsung,exynos4210-uart";
 			reg = <0x13830000 0x100>;
-			interrupts = <0 112 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_UART3>, <&cmu CLK_SCLK_UART3>;
 			clock-names = "uart", "clk_uart_baud0";
 			status = "disabled";
@@ -473,7 +475,7 @@
 			#size-cells = <0>;
 			compatible = "samsung,s3c2440-i2c";
 			reg = <0x13860000 0x100>;
-			interrupts = <0 113 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_I2C0>;
 			clock-names = "i2c";
 			pinctrl-names = "default";
@@ -486,7 +488,7 @@
 			#size-cells = <0>;
 			compatible = "samsung,s3c2440-i2c";
 			reg = <0x13870000 0x100>;
-			interrupts = <0 114 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_I2C1>;
 			clock-names = "i2c";
 			pinctrl-names = "default";
@@ -499,7 +501,7 @@
 			#size-cells = <0>;
 			compatible = "samsung,s3c2440-i2c";
 			reg = <0x13880000 0x100>;
-			interrupts = <0 115 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_I2C2>;
 			clock-names = "i2c";
 			pinctrl-names = "default";
@@ -512,7 +514,7 @@
 			#size-cells = <0>;
 			compatible = "samsung,s3c2440-i2c";
 			reg = <0x13890000 0x100>;
-			interrupts = <0 116 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_I2C3>;
 			clock-names = "i2c";
 			pinctrl-names = "default";
@@ -525,7 +527,7 @@
 			#size-cells = <0>;
 			compatible = "samsung,s3c2440-i2c";
 			reg = <0x138A0000 0x100>;
-			interrupts = <0 117 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_I2C4>;
 			clock-names = "i2c";
 			pinctrl-names = "default";
@@ -538,7 +540,7 @@
 			#size-cells = <0>;
 			compatible = "samsung,s3c2440-i2c";
 			reg = <0x138B0000 0x100>;
-			interrupts = <0 118 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_I2C5>;
 			clock-names = "i2c";
 			pinctrl-names = "default";
@@ -551,7 +553,7 @@
 			#size-cells = <0>;
 			compatible = "samsung,s3c2440-i2c";
 			reg = <0x138C0000 0x100>;
-			interrupts = <0 119 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_I2C6>;
 			clock-names = "i2c";
 			pinctrl-names = "default";
@@ -564,7 +566,7 @@
 			#size-cells = <0>;
 			compatible = "samsung,s3c2440-i2c";
 			reg = <0x138D0000 0x100>;
-			interrupts = <0 120 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_I2C7>;
 			clock-names = "i2c";
 			pinctrl-names = "default";
@@ -575,7 +577,7 @@
 		spi_0: spi at 13920000 {
 			compatible = "samsung,exynos4210-spi";
 			reg = <0x13920000 0x100>;
-			interrupts = <0 121 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&pdma0 7>, <&pdma0 6>;
 			dma-names = "tx", "rx";
 			#address-cells = <1>;
@@ -591,7 +593,7 @@
 		spi_1: spi at 13930000 {
 			compatible = "samsung,exynos4210-spi";
 			reg = <0x13930000 0x100>;
-			interrupts = <0 122 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&pdma1 7>, <&pdma1 6>;
 			dma-names = "tx", "rx";
 			#address-cells = <1>;
@@ -607,7 +609,7 @@
 		spi_2: spi at 13940000 {
 			compatible = "samsung,exynos4210-spi";
 			reg = <0x13940000 0x100>;
-			interrupts = <0 123 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&pdma0 9>, <&pdma0 8>;
 			dma-names = "tx", "rx";
 			#address-cells = <1>;
@@ -629,7 +631,7 @@
 		i2s0: i2s at 3830000 {
 			compatible = "samsung,s5pv210-i2s";
 			reg = <0x03830000 0x100>;
-			interrupts = <0 124 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock_audss EXYNOS_I2S_BUS>,
 				<&clock_audss EXYNOS_SCLK_I2S>;
 			clock-names = "iis", "i2s_opclk0";
@@ -644,21 +646,21 @@
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
 			compatible = "arm,cortex-a9-pmu";
-			interrupts = <0 18 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 19 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 20 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 21 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
 		};
 	};
 };
-- 
2.7.4
