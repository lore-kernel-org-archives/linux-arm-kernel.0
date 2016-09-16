From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 16 Sep 2016 21:42:49 +0200
Subject: [PATCH 08/10] ARM: dts: exynos: Fix invalid GIC interrupt flags in
 exynos5410/exynos542x
In-Reply-To: <1474054971-16831-1-git-send-email-krzk@kernel.org>
References: <1474054971-16831-1-git-send-email-krzk@kernel.org>
Message-ID: <1474054971-16831-9-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Interrupt of type IRQ_TYPE_NONE is not allowed for GIC interrupts and
generates an error:
	genirq: Setting trigger mode 0 for irq 16 failed (gic_set_type+0x0/0x68)

The GIC requires shared interrupts to be edge rising or level high.
Platform declares support for both.  Choose level high everywhere.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reported-by: Alban Browaeys <alban.browaeys@gmail.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5410.dtsi | 26 ++++++-------
 arch/arm/boot/dts/exynos5420.dtsi | 78 +++++++++++++++++++--------------------
 arch/arm/boot/dts/exynos54xx.dtsi | 34 ++++++++---------
 3 files changed, 69 insertions(+), 69 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
index 137f48464f8b..dae5715b41b9 100644
--- a/arch/arm/boot/dts/exynos5410.dtsi
+++ b/arch/arm/boot/dts/exynos5410.dtsi
@@ -85,7 +85,7 @@
 		tmu_cpu0: tmu at 10060000 {
 			compatible = "samsung,exynos5420-tmu";
 			reg = <0x10060000 0x100>;
-			interrupts = <GIC_SPI 65 0>;
+			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TMU>;
 			clock-names = "tmu_apbif";
 			#include "exynos4412-tmu-sensor-conf.dtsi"
@@ -94,7 +94,7 @@
 		tmu_cpu1: tmu at 10064000 {
 			compatible = "samsung,exynos5420-tmu";
 			reg = <0x10064000 0x100>;
-			interrupts = <GIC_SPI 183 0>;
+			interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TMU>;
 			clock-names = "tmu_apbif";
 			#include "exynos4412-tmu-sensor-conf.dtsi"
@@ -103,7 +103,7 @@
 		tmu_cpu2: tmu at 10068000 {
 			compatible = "samsung,exynos5420-tmu";
 			reg = <0x10068000 0x100>;
-			interrupts = <GIC_SPI 184 0>;
+			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TMU>;
 			clock-names = "tmu_apbif";
 			#include "exynos4412-tmu-sensor-conf.dtsi"
@@ -112,7 +112,7 @@
 		tmu_cpu3: tmu at 1006c000 {
 			compatible = "samsung,exynos5420-tmu";
 			reg = <0x1006c000 0x100>;
-			interrupts = <GIC_SPI 185 0>;
+			interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TMU>;
 			clock-names = "tmu_apbif";
 			#include "exynos4412-tmu-sensor-conf.dtsi"
@@ -121,7 +121,7 @@
 		mmc_0: mmc at 12200000 {
 			compatible = "samsung,exynos5250-dw-mshc";
 			reg = <0x12200000 0x1000>;
-			interrupts = <0 75 0>;
+			interrupts = <0 75 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			clocks = <&clock CLK_MMC0>, <&clock CLK_SCLK_MMC0>;
@@ -133,7 +133,7 @@
 		mmc_1: mmc at 12210000 {
 			compatible = "samsung,exynos5250-dw-mshc";
 			reg = <0x12210000 0x1000>;
-			interrupts = <0 76 0>;
+			interrupts = <0 76 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			clocks = <&clock CLK_MMC1>, <&clock CLK_SCLK_MMC1>;
@@ -145,7 +145,7 @@
 		mmc_2: mmc at 12220000 {
 			compatible = "samsung,exynos5250-dw-mshc";
 			reg = <0x12220000 0x1000>;
-			interrupts = <0 77 0>;
+			interrupts = <0 77 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			clocks = <&clock CLK_MMC2>, <&clock CLK_SCLK_MMC2>;
@@ -157,31 +157,31 @@
 		pinctrl_0: pinctrl at 13400000 {
 			compatible = "samsung,exynos5410-pinctrl";
 			reg = <0x13400000 0x1000>;
-			interrupts = <0 45 0>;
+			interrupts = <0 45 IRQ_TYPE_LEVEL_HIGH>;
 
 			wakeup-interrupt-controller {
 				compatible = "samsung,exynos4210-wakeup-eint";
 				interrupt-parent = <&gic>;
-				interrupts = <0 32 0>;
+				interrupts = <0 32 IRQ_TYPE_LEVEL_HIGH>;
 			};
 		};
 
 		pinctrl_1: pinctrl at 14000000 {
 			compatible = "samsung,exynos5410-pinctrl";
 			reg = <0x14000000 0x1000>;
-			interrupts = <0 46 0>;
+			interrupts = <0 46 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		pinctrl_2: pinctrl at 10d10000 {
 			compatible = "samsung,exynos5410-pinctrl";
 			reg = <0x10d10000 0x1000>;
-			interrupts = <0 50 0>;
+			interrupts = <0 50 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		pinctrl_3: pinctrl at 03860000 {
 			compatible = "samsung,exynos5410-pinctrl";
 			reg = <0x03860000 0x1000>;
-			interrupts = <0 47 0>;
+			interrupts = <0 47 IRQ_TYPE_LEVEL_HIGH>;
 		};
 	};
 
@@ -329,7 +329,7 @@
 };
 
 &usbdrd_dwc3_1 {
-	interrupts = <GIC_SPI 200 0>;
+	interrupts = <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>;
 };
 
 &usbdrd_phy1 {
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 00c4cfa54839..906a1a42a7ea 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -193,7 +193,7 @@
 		mfc: codec at 11000000 {
 			compatible = "samsung,mfc-v7";
 			reg = <0x11000000 0x10000>;
-			interrupts = <0 96 0>;
+			interrupts = <0 96 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_MFC>;
 			clock-names = "mfc";
 			power-domains = <&mfc_pd>;
@@ -203,7 +203,7 @@
 
 		mmc_0: mmc at 12200000 {
 			compatible = "samsung,exynos5420-dw-mshc-smu";
-			interrupts = <0 75 0>;
+			interrupts = <0 75 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x12200000 0x2000>;
@@ -215,7 +215,7 @@
 
 		mmc_1: mmc at 12210000 {
 			compatible = "samsung,exynos5420-dw-mshc-smu";
-			interrupts = <0 76 0>;
+			interrupts = <0 76 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x12210000 0x2000>;
@@ -227,7 +227,7 @@
 
 		mmc_2: mmc at 12220000 {
 			compatible = "samsung,exynos5420-dw-mshc";
-			interrupts = <0 77 0>;
+			interrupts = <0 77 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x12220000 0x1000>;
@@ -320,37 +320,37 @@
 		pinctrl_0: pinctrl at 13400000 {
 			compatible = "samsung,exynos5420-pinctrl";
 			reg = <0x13400000 0x1000>;
-			interrupts = <0 45 0>;
+			interrupts = <0 45 IRQ_TYPE_LEVEL_HIGH>;
 
 			wakeup-interrupt-controller {
 				compatible = "samsung,exynos4210-wakeup-eint";
 				interrupt-parent = <&gic>;
-				interrupts = <0 32 0>;
+				interrupts = <0 32 IRQ_TYPE_LEVEL_HIGH>;
 			};
 		};
 
 		pinctrl_1: pinctrl at 13410000 {
 			compatible = "samsung,exynos5420-pinctrl";
 			reg = <0x13410000 0x1000>;
-			interrupts = <0 78 0>;
+			interrupts = <0 78 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		pinctrl_2: pinctrl at 14000000 {
 			compatible = "samsung,exynos5420-pinctrl";
 			reg = <0x14000000 0x1000>;
-			interrupts = <0 46 0>;
+			interrupts = <0 46 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		pinctrl_3: pinctrl at 14010000 {
 			compatible = "samsung,exynos5420-pinctrl";
 			reg = <0x14010000 0x1000>;
-			interrupts = <0 50 0>;
+			interrupts = <0 50 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		pinctrl_4: pinctrl at 03860000 {
 			compatible = "samsung,exynos5420-pinctrl";
 			reg = <0x03860000 0x1000>;
-			interrupts = <0 47 0>;
+			interrupts = <0 47 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		amba {
@@ -363,7 +363,7 @@
 			adma: adma at 03880000 {
 				compatible = "arm,pl330", "arm,primecell";
 				reg = <0x03880000 0x1000>;
-				interrupts = <0 110 0>;
+				interrupts = <0 110 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clock_audss EXYNOS_ADMA>;
 				clock-names = "apb_pclk";
 				#dma-cells = <1>;
@@ -374,7 +374,7 @@
 			pdma0: pdma at 121A0000 {
 				compatible = "arm,pl330", "arm,primecell";
 				reg = <0x121A0000 0x1000>;
-				interrupts = <0 34 0>;
+				interrupts = <0 34 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clock CLK_PDMA0>;
 				clock-names = "apb_pclk";
 				#dma-cells = <1>;
@@ -385,7 +385,7 @@
 			pdma1: pdma at 121B0000 {
 				compatible = "arm,pl330", "arm,primecell";
 				reg = <0x121B0000 0x1000>;
-				interrupts = <0 35 0>;
+				interrupts = <0 35 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clock CLK_PDMA1>;
 				clock-names = "apb_pclk";
 				#dma-cells = <1>;
@@ -396,7 +396,7 @@
 			mdma0: mdma at 10800000 {
 				compatible = "arm,pl330", "arm,primecell";
 				reg = <0x10800000 0x1000>;
-				interrupts = <0 33 0>;
+				interrupts = <0 33 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clock CLK_MDMA0>;
 				clock-names = "apb_pclk";
 				#dma-cells = <1>;
@@ -407,7 +407,7 @@
 			mdma1: mdma at 11C10000 {
 				compatible = "arm,pl330", "arm,primecell";
 				reg = <0x11C10000 0x1000>;
-				interrupts = <0 124 0>;
+				interrupts = <0 124 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clock CLK_MDMA1>;
 				clock-names = "apb_pclk";
 				#dma-cells = <1>;
@@ -479,7 +479,7 @@
 		spi_0: spi at 12d20000 {
 			compatible = "samsung,exynos4210-spi";
 			reg = <0x12d20000 0x100>;
-			interrupts = <0 68 0>;
+			interrupts = <0 68 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&pdma0 5
 				&pdma0 4>;
 			dma-names = "tx", "rx";
@@ -495,7 +495,7 @@
 		spi_1: spi at 12d30000 {
 			compatible = "samsung,exynos4210-spi";
 			reg = <0x12d30000 0x100>;
-			interrupts = <0 69 0>;
+			interrupts = <0 69 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&pdma1 5
 				&pdma1 4>;
 			dma-names = "tx", "rx";
@@ -511,7 +511,7 @@
 		spi_2: spi at 12d40000 {
 			compatible = "samsung,exynos4210-spi";
 			reg = <0x12d40000 0x100>;
-			interrupts = <0 70 0>;
+			interrupts = <0 70 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&pdma0 7
 				&pdma0 6>;
 			dma-names = "tx", "rx";
@@ -539,7 +539,7 @@
 		dsi at 14500000 {
 			compatible = "samsung,exynos5410-mipi-dsi";
 			reg = <0x14500000 0x10000>;
-			interrupts = <0 82 0>;
+			interrupts = <0 82 IRQ_TYPE_LEVEL_HIGH>;
 			phys = <&mipi_phy 1>;
 			phy-names = "dsim";
 			clocks = <&clock CLK_DSIM1>, <&clock CLK_SCLK_MIPI1>;
@@ -552,7 +552,7 @@
 		adc: adc at 12D10000 {
 			compatible = "samsung,exynos-adc-v2";
 			reg = <0x12D10000 0x100>;
-			interrupts = <0 106 0>;
+			interrupts = <0 106 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TSADC>;
 			clock-names = "adc";
 			#io-channel-cells = <1>;
@@ -564,7 +564,7 @@
 		hsi2c_8: i2c at 12E00000 {
 			compatible = "samsung,exynos5250-hsi2c";
 			reg = <0x12E00000 0x1000>;
-			interrupts = <0 87 0>;
+			interrupts = <0 87 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			pinctrl-names = "default";
@@ -577,7 +577,7 @@
 		hsi2c_9: i2c at 12E10000 {
 			compatible = "samsung,exynos5250-hsi2c";
 			reg = <0x12E10000 0x1000>;
-			interrupts = <0 88 0>;
+			interrupts = <0 88 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			pinctrl-names = "default";
@@ -590,7 +590,7 @@
 		hsi2c_10: i2c at 12E20000 {
 			compatible = "samsung,exynos5250-hsi2c";
 			reg = <0x12E20000 0x1000>;
-			interrupts = <0 203 0>;
+			interrupts = <0 203 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			pinctrl-names = "default";
@@ -603,7 +603,7 @@
 		hdmi: hdmi at 14530000 {
 			compatible = "samsung,exynos5420-hdmi";
 			reg = <0x14530000 0x70000>;
-			interrupts = <0 95 0>;
+			interrupts = <0 95 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_HDMI>, <&clock CLK_SCLK_HDMI>,
 				 <&clock CLK_DOUT_PIXEL>, <&clock CLK_SCLK_HDMIPHY>,
 				 <&clock CLK_MOUT_HDMI>;
@@ -622,7 +622,7 @@
 		mixer: mixer at 14450000 {
 			compatible = "samsung,exynos5420-mixer";
 			reg = <0x14450000 0x10000>;
-			interrupts = <0 94 0>;
+			interrupts = <0 94 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_MIXER>, <&clock CLK_HDMI>,
 				 <&clock CLK_SCLK_HDMI>;
 			clock-names = "mixer", "hdmi", "sclk_hdmi";
@@ -633,7 +633,7 @@
 		rotator: rotator at 11C00000 {
 			compatible = "samsung,exynos5250-rotator";
 			reg = <0x11C00000 0x64>;
-			interrupts = <0 84 0>;
+			interrupts = <0 84 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_ROTATOR>;
 			clock-names = "rotator";
 			iommus = <&sysmmu_rotator>;
@@ -642,7 +642,7 @@
 		gsc_0: video-scaler at 13e00000 {
 			compatible = "samsung,exynos5-gsc";
 			reg = <0x13e00000 0x1000>;
-			interrupts = <0 85 0>;
+			interrupts = <0 85 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_GSCL0>;
 			clock-names = "gscl";
 			power-domains = <&gsc_pd>;
@@ -652,7 +652,7 @@
 		gsc_1: video-scaler at 13e10000 {
 			compatible = "samsung,exynos5-gsc";
 			reg = <0x13e10000 0x1000>;
-			interrupts = <0 86 0>;
+			interrupts = <0 86 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_GSCL1>;
 			clock-names = "gscl";
 			power-domains = <&gsc_pd>;
@@ -662,7 +662,7 @@
 		jpeg_0: jpeg at 11F50000 {
 			compatible = "samsung,exynos5420-jpeg";
 			reg = <0x11F50000 0x1000>;
-			interrupts = <0 89 0>;
+			interrupts = <0 89 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "jpeg";
 			clocks = <&clock CLK_JPEG>;
 			iommus = <&sysmmu_jpeg0>;
@@ -671,7 +671,7 @@
 		jpeg_1: jpeg at 11F60000 {
 			compatible = "samsung,exynos5420-jpeg";
 			reg = <0x11F60000 0x1000>;
-			interrupts = <0 168 0>;
+			interrupts = <0 168 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "jpeg";
 			clocks = <&clock CLK_JPEG2>;
 			iommus = <&sysmmu_jpeg1>;
@@ -691,7 +691,7 @@
 		tmu_cpu0: tmu at 10060000 {
 			compatible = "samsung,exynos5420-tmu";
 			reg = <0x10060000 0x100>;
-			interrupts = <0 65 0>;
+			interrupts = <0 65 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TMU>;
 			clock-names = "tmu_apbif";
 			#include "exynos4412-tmu-sensor-conf.dtsi"
@@ -700,7 +700,7 @@
 		tmu_cpu1: tmu at 10064000 {
 			compatible = "samsung,exynos5420-tmu";
 			reg = <0x10064000 0x100>;
-			interrupts = <0 183 0>;
+			interrupts = <0 183 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TMU>;
 			clock-names = "tmu_apbif";
 			#include "exynos4412-tmu-sensor-conf.dtsi"
@@ -709,7 +709,7 @@
 		tmu_cpu2: tmu at 10068000 {
 			compatible = "samsung,exynos5420-tmu-ext-triminfo";
 			reg = <0x10068000 0x100>, <0x1006c000 0x4>;
-			interrupts = <0 184 0>;
+			interrupts = <0 184 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TMU>, <&clock CLK_TMU>;
 			clock-names = "tmu_apbif", "tmu_triminfo_apbif";
 			#include "exynos4412-tmu-sensor-conf.dtsi"
@@ -718,7 +718,7 @@
 		tmu_cpu3: tmu at 1006c000 {
 			compatible = "samsung,exynos5420-tmu-ext-triminfo";
 			reg = <0x1006c000 0x100>, <0x100a0000 0x4>;
-			interrupts = <0 185 0>;
+			interrupts = <0 185 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TMU>, <&clock CLK_TMU_GPU>;
 			clock-names = "tmu_apbif", "tmu_triminfo_apbif";
 			#include "exynos4412-tmu-sensor-conf.dtsi"
@@ -727,7 +727,7 @@
 		tmu_gpu: tmu at 100a0000 {
 			compatible = "samsung,exynos5420-tmu-ext-triminfo";
 			reg = <0x100a0000 0x100>, <0x10068000 0x4>;
-			interrupts = <0 215 0>;
+			interrupts = <0 215 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TMU_GPU>, <&clock CLK_TMU>;
 			clock-names = "tmu_apbif", "tmu_triminfo_apbif";
 			#include "exynos4412-tmu-sensor-conf.dtsi"
@@ -799,7 +799,7 @@
 		sysmmu_scaler1r: sysmmu at 0x12890000 {
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x12890000 0x1000>;
-			interrupts = <0 186 0>;
+			interrupts = <0 186 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "sysmmu", "master";
 			clocks = <&clock CLK_SMMU_MSCL1>, <&clock CLK_MSCL1>;
 			#iommu-cells = <0>;
@@ -808,7 +808,7 @@
 		sysmmu_scaler2r: sysmmu at 0x128A0000 {
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x128A0000 0x1000>;
-			interrupts = <0 188 0>;
+			interrupts = <0 188 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "sysmmu", "master";
 			clocks = <&clock CLK_SMMU_MSCL2>, <&clock CLK_MSCL2>;
 			#iommu-cells = <0>;
@@ -867,7 +867,7 @@
 		sysmmu_jpeg1: sysmmu at 0x11F20000 {
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x11F20000 0x1000>;
-			interrupts = <0 169 0>;
+			interrupts = <0 169 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "sysmmu", "master";
 			clocks = <&clock CLK_SMMU_JPEG2>, <&clock CLK_JPEG2>;
 			#iommu-cells = <0>;
@@ -1445,7 +1445,7 @@
 };
 
 &usbdrd_dwc3_1 {
-	interrupts = <GIC_SPI 73 0>;
+	interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
 };
 
 &usbdrd_phy1 {
diff --git a/arch/arm/boot/dts/exynos54xx.dtsi b/arch/arm/boot/dts/exynos54xx.dtsi
index 9d31cdce1959..8640b01f1c94 100644
--- a/arch/arm/boot/dts/exynos54xx.dtsi
+++ b/arch/arm/boot/dts/exynos54xx.dtsi
@@ -62,34 +62,34 @@
 						<1 &combiner 23 4>,
 						<2 &combiner 25 2>,
 						<3 &combiner 25 3>,
-						<4 &gic 0 120 0>,
-						<5 &gic 0 121 0>,
-						<6 &gic 0 122 0>,
-						<7 &gic 0 123 0>,
-						<8 &gic 0 128 0>,
-						<9 &gic 0 129 0>,
-						<10 &gic 0 130 0>,
-						<11 &gic 0 131 0>;
+						<4 &gic 0 120 IRQ_TYPE_LEVEL_HIGH>,
+						<5 &gic 0 121 IRQ_TYPE_LEVEL_HIGH>,
+						<6 &gic 0 122 IRQ_TYPE_LEVEL_HIGH>,
+						<7 &gic 0 123 IRQ_TYPE_LEVEL_HIGH>,
+						<8 &gic 0 128 IRQ_TYPE_LEVEL_HIGH>,
+						<9 &gic 0 129 IRQ_TYPE_LEVEL_HIGH>,
+						<10 &gic 0 130 IRQ_TYPE_LEVEL_HIGH>,
+						<11 &gic 0 131 IRQ_TYPE_LEVEL_HIGH>;
 			};
 		};
 
 		watchdog: watchdog at 101d0000 {
 			compatible = "samsung,exynos5420-wdt";
 			reg = <0x101d0000 0x100>;
-			interrupts = <0 42 0>;
+			interrupts = <0 42 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		sss: sss at 10830000 {
 			compatible = "samsung,exynos4210-secss";
 			reg = <0x10830000 0x300>;
-			interrupts = <0 112 0>;
+			interrupts = <0 112 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		/* i2c_0-3 are defined in exynos5.dtsi */
 		hsi2c_4: i2c at 12ca0000 {
 			compatible = "samsung,exynos5250-hsi2c";
 			reg = <0x12ca0000 0x1000>;
-			interrupts = <0 60 0>;
+			interrupts = <0 60 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -98,7 +98,7 @@
 		hsi2c_5: i2c at 12cb0000 {
 			compatible = "samsung,exynos5250-hsi2c";
 			reg = <0x12cb0000 0x1000>;
-			interrupts = <0 61 0>;
+			interrupts = <0 61 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -107,7 +107,7 @@
 		hsi2c_6: i2c at 12cc0000 {
 			compatible = "samsung,exynos5250-hsi2c";
 			reg = <0x12cc0000 0x1000>;
-			interrupts = <0 62 0>;
+			interrupts = <0 62 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -116,7 +116,7 @@
 		hsi2c_7: i2c at 12cd0000 {
 			compatible = "samsung,exynos5250-hsi2c";
 			reg = <0x12cd0000 0x1000>;
-			interrupts = <0 63 0>;
+			interrupts = <0 63 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -131,7 +131,7 @@
 			usbdrd_dwc3_0: dwc3 at 12000000 {
 				compatible = "snps,dwc3";
 				reg = <0x12000000 0x10000>;
-				interrupts = <0 72 0>;
+				interrupts = <0 72 IRQ_TYPE_LEVEL_HIGH>;
 				phys = <&usbdrd_phy0 0>, <&usbdrd_phy0 1>;
 				phy-names = "usb2-phy", "usb3-phy";
 			};
@@ -166,7 +166,7 @@
 		usbhost2: usb at 12110000 {
 			compatible = "samsung,exynos4210-ehci";
 			reg = <0x12110000 0x100>;
-			interrupts = <0 71 0>;
+			interrupts = <0 71 IRQ_TYPE_LEVEL_HIGH>;
 
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -179,7 +179,7 @@
 		usbhost1: usb at 12120000 {
 			compatible = "samsung,exynos4210-ohci";
 			reg = <0x12120000 0x100>;
-			interrupts = <0 71 0>;
+			interrupts = <0 71 IRQ_TYPE_LEVEL_HIGH>;
 
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.7.4
