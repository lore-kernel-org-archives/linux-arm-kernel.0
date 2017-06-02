From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri,  2 Jun 2017 20:13:46 +0200
Subject: [PATCH 2/2] ARM: dts: exynos: Use human-friendly symbols for GIC
 interrupt properties
In-Reply-To: <20170602181346.32166-1-krzk@kernel.org>
References: <20170602181346.32166-1-krzk@kernel.org>
Message-ID: <20170602181346.32166-3-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace hard-coded values of type of GIC interrupt and its flags with
respective macros from header to increase code readability.

Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5.dtsi    | 84 +++++++++++++++++++--------------------
 arch/arm/boot/dts/exynos5250.dtsi |  8 ++--
 arch/arm/boot/dts/exynos5420.dtsi | 76 +++++++++++++++++------------------
 arch/arm/boot/dts/exynos5440.dtsi |  2 +-
 4 files changed, 85 insertions(+), 85 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
index b74c5379ca26..66d22521c976 100644
--- a/arch/arm/boot/dts/exynos5.dtsi
+++ b/arch/arm/boot/dts/exynos5.dtsi
@@ -55,38 +55,38 @@
 			interrupt-controller;
 			samsung,combiner-nr = <32>;
 			reg = <0x10440000 0x1000>;
-			interrupts = <0 0 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 1 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 2 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 3 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 4 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 5 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 6 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 7 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 8 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 9 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 10 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 11 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 12 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 13 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 14 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 15 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 16 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 17 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 18 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 19 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 20 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 21 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 22 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 23 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 24 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 25 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 26 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 27 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 28 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 29 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 30 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 31 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		gic: interrupt-controller at 10481000 {
@@ -109,31 +109,31 @@
 		serial_0: serial at 12C00000 {
 			compatible = "samsung,exynos4210-uart";
 			reg = <0x12C00000 0x100>;
-			interrupts = <0 51 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		serial_1: serial at 12C10000 {
 			compatible = "samsung,exynos4210-uart";
 			reg = <0x12C10000 0x100>;
-			interrupts = <0 52 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		serial_2: serial at 12C20000 {
 			compatible = "samsung,exynos4210-uart";
 			reg = <0x12C20000 0x100>;
-			interrupts = <0 53 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		serial_3: serial at 12C30000 {
 			compatible = "samsung,exynos4210-uart";
 			reg = <0x12C30000 0x100>;
-			interrupts = <0 54 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		i2c_0: i2c at 12C60000 {
 			compatible = "samsung,s3c2440-i2c";
 			reg = <0x12C60000 0x100>;
-			interrupts = <0 56 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			samsung,sysreg-phandle = <&sysreg_system_controller>;
@@ -143,7 +143,7 @@
 		i2c_1: i2c at 12C70000 {
 			compatible = "samsung,s3c2440-i2c";
 			reg = <0x12C70000 0x100>;
-			interrupts = <0 57 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			samsung,sysreg-phandle = <&sysreg_system_controller>;
@@ -153,7 +153,7 @@
 		i2c_2: i2c at 12C80000 {
 			compatible = "samsung,s3c2440-i2c";
 			reg = <0x12C80000 0x100>;
-			interrupts = <0 58 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			samsung,sysreg-phandle = <&sysreg_system_controller>;
@@ -163,7 +163,7 @@
 		i2c_3: i2c at 12C90000 {
 			compatible = "samsung,s3c2440-i2c";
 			reg = <0x12C90000 0x100>;
-			interrupts = <0 59 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			samsung,sysreg-phandle = <&sysreg_system_controller>;
@@ -180,8 +180,8 @@
 		rtc: rtc at 101E0000 {
 			compatible = "samsung,s3c6410-rtc";
 			reg = <0x101E0000 0x100>;
-			interrupts = <0 43 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 44 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
 
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 79c9c885613a..f35f00464631 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -153,10 +153,10 @@
 
 		timer {
 			compatible = "arm,armv7-timer";
-			interrupts = <1 13 0xf08>,
-				     <1 14 0xf08>,
-				     <1 11 0xf08>,
-				     <1 10 0xf08>;
+			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+				     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+				     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+				     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 			/*
 			 * Unfortunately we need this since some versions
 			 * of U-Boot on Exynos don't set the CNTFRQ register,
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 0db0bcf8da36..e8c6acfbb751 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -193,7 +193,7 @@
 		mfc: codec at 11000000 {
 			compatible = "samsung,mfc-v7";
 			reg = <0x11000000 0x10000>;
-			interrupts = <0 96 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_MFC>;
 			clock-names = "mfc";
 			power-domains = <&mfc_pd>;
@@ -203,7 +203,7 @@
 
 		mmc_0: mmc at 12200000 {
 			compatible = "samsung,exynos5420-dw-mshc-smu";
-			interrupts = <0 75 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x12200000 0x2000>;
@@ -215,7 +215,7 @@
 
 		mmc_1: mmc at 12210000 {
 			compatible = "samsung,exynos5420-dw-mshc-smu";
-			interrupts = <0 76 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x12210000 0x2000>;
@@ -227,7 +227,7 @@
 
 		mmc_2: mmc at 12220000 {
 			compatible = "samsung,exynos5420-dw-mshc";
-			interrupts = <0 77 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x12220000 0x1000>;
@@ -325,37 +325,37 @@
 		pinctrl_0: pinctrl at 13400000 {
 			compatible = "samsung,exynos5420-pinctrl";
 			reg = <0x13400000 0x1000>;
-			interrupts = <0 45 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
 
 			wakeup-interrupt-controller {
 				compatible = "samsung,exynos4210-wakeup-eint";
 				interrupt-parent = <&gic>;
-				interrupts = <0 32 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 			};
 		};
 
 		pinctrl_1: pinctrl at 13410000 {
 			compatible = "samsung,exynos5420-pinctrl";
 			reg = <0x13410000 0x1000>;
-			interrupts = <0 78 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		pinctrl_2: pinctrl at 14000000 {
 			compatible = "samsung,exynos5420-pinctrl";
 			reg = <0x14000000 0x1000>;
-			interrupts = <0 46 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		pinctrl_3: pinctrl at 14010000 {
 			compatible = "samsung,exynos5420-pinctrl";
 			reg = <0x14010000 0x1000>;
-			interrupts = <0 50 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		pinctrl_4: pinctrl at 03860000 {
 			compatible = "samsung,exynos5420-pinctrl";
 			reg = <0x03860000 0x1000>;
-			interrupts = <0 47 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		amba {
@@ -368,7 +368,7 @@
 			adma: adma at 03880000 {
 				compatible = "arm,pl330", "arm,primecell";
 				reg = <0x03880000 0x1000>;
-				interrupts = <0 110 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clock_audss EXYNOS_ADMA>;
 				clock-names = "apb_pclk";
 				#dma-cells = <1>;
@@ -379,7 +379,7 @@
 			pdma0: pdma at 121A0000 {
 				compatible = "arm,pl330", "arm,primecell";
 				reg = <0x121A0000 0x1000>;
-				interrupts = <0 34 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clock CLK_PDMA0>;
 				clock-names = "apb_pclk";
 				#dma-cells = <1>;
@@ -390,7 +390,7 @@
 			pdma1: pdma at 121B0000 {
 				compatible = "arm,pl330", "arm,primecell";
 				reg = <0x121B0000 0x1000>;
-				interrupts = <0 35 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clock CLK_PDMA1>;
 				clock-names = "apb_pclk";
 				#dma-cells = <1>;
@@ -401,7 +401,7 @@
 			mdma0: mdma at 10800000 {
 				compatible = "arm,pl330", "arm,primecell";
 				reg = <0x10800000 0x1000>;
-				interrupts = <0 33 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clock CLK_MDMA0>;
 				clock-names = "apb_pclk";
 				#dma-cells = <1>;
@@ -412,7 +412,7 @@
 			mdma1: mdma at 11C10000 {
 				compatible = "arm,pl330", "arm,primecell";
 				reg = <0x11C10000 0x1000>;
-				interrupts = <0 124 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clock CLK_MDMA1>;
 				clock-names = "apb_pclk";
 				#dma-cells = <1>;
@@ -484,7 +484,7 @@
 		spi_0: spi at 12d20000 {
 			compatible = "samsung,exynos4210-spi";
 			reg = <0x12d20000 0x100>;
-			interrupts = <0 68 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&pdma0 5
 				&pdma0 4>;
 			dma-names = "tx", "rx";
@@ -500,7 +500,7 @@
 		spi_1: spi at 12d30000 {
 			compatible = "samsung,exynos4210-spi";
 			reg = <0x12d30000 0x100>;
-			interrupts = <0 69 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&pdma1 5
 				&pdma1 4>;
 			dma-names = "tx", "rx";
@@ -516,7 +516,7 @@
 		spi_2: spi at 12d40000 {
 			compatible = "samsung,exynos4210-spi";
 			reg = <0x12d40000 0x100>;
-			interrupts = <0 70 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&pdma0 7
 				&pdma0 6>;
 			dma-names = "tx", "rx";
@@ -544,7 +544,7 @@
 		dsi at 14500000 {
 			compatible = "samsung,exynos5410-mipi-dsi";
 			reg = <0x14500000 0x10000>;
-			interrupts = <0 82 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
 			phys = <&mipi_phy 1>;
 			phy-names = "dsim";
 			clocks = <&clock CLK_DSIM1>, <&clock CLK_SCLK_MIPI1>;
@@ -557,7 +557,7 @@
 		adc: adc at 12D10000 {
 			compatible = "samsung,exynos-adc-v2";
 			reg = <0x12D10000 0x100>;
-			interrupts = <0 106 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TSADC>;
 			clock-names = "adc";
 			#io-channel-cells = <1>;
@@ -569,7 +569,7 @@
 		hsi2c_8: i2c at 12E00000 {
 			compatible = "samsung,exynos5250-hsi2c";
 			reg = <0x12E00000 0x1000>;
-			interrupts = <0 87 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			pinctrl-names = "default";
@@ -582,7 +582,7 @@
 		hsi2c_9: i2c at 12E10000 {
 			compatible = "samsung,exynos5250-hsi2c";
 			reg = <0x12E10000 0x1000>;
-			interrupts = <0 88 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			pinctrl-names = "default";
@@ -595,7 +595,7 @@
 		hsi2c_10: i2c at 12E20000 {
 			compatible = "samsung,exynos5250-hsi2c";
 			reg = <0x12E20000 0x1000>;
-			interrupts = <0 203 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			pinctrl-names = "default";
@@ -608,7 +608,7 @@
 		hdmi: hdmi at 14530000 {
 			compatible = "samsung,exynos5420-hdmi";
 			reg = <0x14530000 0x70000>;
-			interrupts = <0 95 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_HDMI>, <&clock CLK_SCLK_HDMI>,
 				 <&clock CLK_DOUT_PIXEL>, <&clock CLK_SCLK_HDMIPHY>,
 				 <&clock CLK_MOUT_HDMI>;
@@ -627,7 +627,7 @@
 		mixer: mixer at 14450000 {
 			compatible = "samsung,exynos5420-mixer";
 			reg = <0x14450000 0x10000>;
-			interrupts = <0 94 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_MIXER>, <&clock CLK_HDMI>,
 				 <&clock CLK_SCLK_HDMI>;
 			clock-names = "mixer", "hdmi", "sclk_hdmi";
@@ -638,7 +638,7 @@
 		rotator: rotator at 11C00000 {
 			compatible = "samsung,exynos5250-rotator";
 			reg = <0x11C00000 0x64>;
-			interrupts = <0 84 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_ROTATOR>;
 			clock-names = "rotator";
 			iommus = <&sysmmu_rotator>;
@@ -647,7 +647,7 @@
 		gsc_0: video-scaler at 13e00000 {
 			compatible = "samsung,exynos5-gsc";
 			reg = <0x13e00000 0x1000>;
-			interrupts = <0 85 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_GSCL0>;
 			clock-names = "gscl";
 			power-domains = <&gsc_pd>;
@@ -657,7 +657,7 @@
 		gsc_1: video-scaler at 13e10000 {
 			compatible = "samsung,exynos5-gsc";
 			reg = <0x13e10000 0x1000>;
-			interrupts = <0 86 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_GSCL1>;
 			clock-names = "gscl";
 			power-domains = <&gsc_pd>;
@@ -667,7 +667,7 @@
 		jpeg_0: jpeg at 11F50000 {
 			compatible = "samsung,exynos5420-jpeg";
 			reg = <0x11F50000 0x1000>;
-			interrupts = <0 89 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "jpeg";
 			clocks = <&clock CLK_JPEG>;
 			iommus = <&sysmmu_jpeg0>;
@@ -676,7 +676,7 @@
 		jpeg_1: jpeg at 11F60000 {
 			compatible = "samsung,exynos5420-jpeg";
 			reg = <0x11F60000 0x1000>;
-			interrupts = <0 168 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "jpeg";
 			clocks = <&clock CLK_JPEG2>;
 			iommus = <&sysmmu_jpeg1>;
@@ -696,7 +696,7 @@
 		tmu_cpu0: tmu at 10060000 {
 			compatible = "samsung,exynos5420-tmu";
 			reg = <0x10060000 0x100>;
-			interrupts = <0 65 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TMU>;
 			clock-names = "tmu_apbif";
 			#include "exynos5420-tmu-sensor-conf.dtsi"
@@ -705,7 +705,7 @@
 		tmu_cpu1: tmu at 10064000 {
 			compatible = "samsung,exynos5420-tmu";
 			reg = <0x10064000 0x100>;
-			interrupts = <0 183 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TMU>;
 			clock-names = "tmu_apbif";
 			#include "exynos5420-tmu-sensor-conf.dtsi"
@@ -714,7 +714,7 @@
 		tmu_cpu2: tmu at 10068000 {
 			compatible = "samsung,exynos5420-tmu-ext-triminfo";
 			reg = <0x10068000 0x100>, <0x1006c000 0x4>;
-			interrupts = <0 184 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TMU>, <&clock CLK_TMU>;
 			clock-names = "tmu_apbif", "tmu_triminfo_apbif";
 			#include "exynos5420-tmu-sensor-conf.dtsi"
@@ -723,7 +723,7 @@
 		tmu_cpu3: tmu at 1006c000 {
 			compatible = "samsung,exynos5420-tmu-ext-triminfo";
 			reg = <0x1006c000 0x100>, <0x100a0000 0x4>;
-			interrupts = <0 185 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TMU>, <&clock CLK_TMU_GPU>;
 			clock-names = "tmu_apbif", "tmu_triminfo_apbif";
 			#include "exynos5420-tmu-sensor-conf.dtsi"
@@ -732,7 +732,7 @@
 		tmu_gpu: tmu at 100a0000 {
 			compatible = "samsung,exynos5420-tmu-ext-triminfo";
 			reg = <0x100a0000 0x100>, <0x10068000 0x4>;
-			interrupts = <0 215 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TMU_GPU>, <&clock CLK_TMU>;
 			clock-names = "tmu_apbif", "tmu_triminfo_apbif";
 			#include "exynos5420-tmu-sensor-conf.dtsi"
@@ -804,7 +804,7 @@
 		sysmmu_scaler1r: sysmmu at 0x12890000 {
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x12890000 0x1000>;
-			interrupts = <0 186 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "sysmmu", "master";
 			clocks = <&clock CLK_SMMU_MSCL1>, <&clock CLK_MSCL1>;
 			#iommu-cells = <0>;
@@ -813,7 +813,7 @@
 		sysmmu_scaler2r: sysmmu at 0x128A0000 {
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x128A0000 0x1000>;
-			interrupts = <0 188 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "sysmmu", "master";
 			clocks = <&clock CLK_SMMU_MSCL2>, <&clock CLK_MSCL2>;
 			#iommu-cells = <0>;
@@ -872,7 +872,7 @@
 		sysmmu_jpeg1: sysmmu at 0x11F20000 {
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x11F20000 0x1000>;
-			interrupts = <0 169 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "sysmmu", "master";
 			clocks = <&clock CLK_SMMU_JPEG2>, <&clock CLK_JPEG2>;
 			#iommu-cells = <0>;
diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
index a4ea018464fc..bc4954e69f7b 100644
--- a/arch/arm/boot/dts/exynos5440.dtsi
+++ b/arch/arm/boot/dts/exynos5440.dtsi
@@ -200,7 +200,7 @@
 		compatible = "snps,dwmac-3.70a", "snps,dwmac";
 		reg = <0x00230000 0x8000>;
 		interrupt-parent = <&gic>;
-		interrupts = <GIC_SPI 31 4>;
+		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "macirq";
 		phy-mode = "sgmii";
 		clocks = <&clock CLK_GMAC0>;
-- 
2.9.3
