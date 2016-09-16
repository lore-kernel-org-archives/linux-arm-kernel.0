From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 16 Sep 2016 21:42:48 +0200
Subject: [PATCH 07/10] ARM: dts: exynos: Fix invalid GIC interrupt flags in
 exynos5250
In-Reply-To: <1474054971-16831-1-git-send-email-krzk@kernel.org>
References: <1474054971-16831-1-git-send-email-krzk@kernel.org>
Message-ID: <1474054971-16831-8-git-send-email-krzk@kernel.org>
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
 arch/arm/boot/dts/exynos5250.dtsi | 80 +++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index f7357d99b47c..4e00c0d06c67 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -181,8 +181,8 @@
 						<0x1 0 &combiner 23 4>,
 						<0x2 0 &combiner 25 2>,
 						<0x3 0 &combiner 25 3>,
-						<0x4 0 &gic 0 120 0>,
-						<0x5 0 &gic 0 121 0>;
+						<0x4 0 &gic 0 120 IRQ_TYPE_LEVEL_HIGH>,
+						<0x5 0 &gic 0 121 IRQ_TYPE_LEVEL_HIGH>;
 			};
 		};
 
@@ -195,31 +195,31 @@
 		pinctrl_0: pinctrl at 11400000 {
 			compatible = "samsung,exynos5250-pinctrl";
 			reg = <0x11400000 0x1000>;
-			interrupts = <0 46 0>;
+			interrupts = <0 46 IRQ_TYPE_LEVEL_HIGH>;
 
 			wakup_eint: wakeup-interrupt-controller {
 				compatible = "samsung,exynos4210-wakeup-eint";
 				interrupt-parent = <&gic>;
-				interrupts = <0 32 0>;
+				interrupts = <0 32 IRQ_TYPE_LEVEL_HIGH>;
 			};
 		};
 
 		pinctrl_1: pinctrl at 13400000 {
 			compatible = "samsung,exynos5250-pinctrl";
 			reg = <0x13400000 0x1000>;
-			interrupts = <0 45 0>;
+			interrupts = <0 45 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		pinctrl_2: pinctrl at 10d10000 {
 			compatible = "samsung,exynos5250-pinctrl";
 			reg = <0x10d10000 0x1000>;
-			interrupts = <0 50 0>;
+			interrupts = <0 50 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		pinctrl_3: pinctrl at 03860000 {
 			compatible = "samsung,exynos5250-pinctrl";
 			reg = <0x03860000 0x1000>;
-			interrupts = <0 47 0>;
+			interrupts = <0 47 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		pmu_system_controller: system-controller at 10040000 {
@@ -236,7 +236,7 @@
 		watchdog at 101D0000 {
 			compatible = "samsung,exynos5250-wdt";
 			reg = <0x101D0000 0x100>;
-			interrupts = <0 42 0>;
+			interrupts = <0 42 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_WDT>;
 			clock-names = "watchdog";
 			samsung,syscon-phandle = <&pmu_system_controller>;
@@ -245,7 +245,7 @@
 		g2d at 10850000 {
 			compatible = "samsung,exynos5250-g2d";
 			reg = <0x10850000 0x1000>;
-			interrupts = <0 91 0>;
+			interrupts = <0 91 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_G2D>;
 			clock-names = "fimg2d";
 			iommus = <&sysmmu_g2d>;
@@ -254,7 +254,7 @@
 		mfc: codec at 11000000 {
 			compatible = "samsung,mfc-v6";
 			reg = <0x11000000 0x10000>;
-			interrupts = <0 96 0>;
+			interrupts = <0 96 IRQ_TYPE_LEVEL_HIGH>;
 			power-domains = <&pd_mfc>;
 			clocks = <&clock CLK_MFC>;
 			clock-names = "mfc";
@@ -265,7 +265,7 @@
 		rotator: rotator at 11C00000 {
 			compatible = "samsung,exynos5250-rotator";
 			reg = <0x11C00000 0x64>;
-			interrupts = <0 84 0>;
+			interrupts = <0 84 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_ROTATOR>;
 			clock-names = "rotator";
 			iommus = <&sysmmu_rotator>;
@@ -274,7 +274,7 @@
 		tmu: tmu at 10060000 {
 			compatible = "samsung,exynos5250-tmu";
 			reg = <0x10060000 0x100>;
-			interrupts = <0 65 0>;
+			interrupts = <0 65 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TMU>;
 			clock-names = "tmu_apbif";
 			#include "exynos4412-tmu-sensor-conf.dtsi"
@@ -284,7 +284,7 @@
 			compatible = "snps,dwc-ahci";
 			samsung,sata-freq = <66>;
 			reg = <0x122F0000 0x1ff>;
-			interrupts = <0 115 0>;
+			interrupts = <0 115 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_SATA>, <&clock CLK_SCLK_SATA>;
 			clock-names = "sata", "sclk_sata";
 			phys = <&sata_phy>;
@@ -306,7 +306,7 @@
 		i2c_4: i2c at 12CA0000 {
 			compatible = "samsung,s3c2440-i2c";
 			reg = <0x12CA0000 0x100>;
-			interrupts = <0 60 0>;
+			interrupts = <0 60 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			clocks = <&clock CLK_I2C4>;
@@ -319,7 +319,7 @@
 		i2c_5: i2c at 12CB0000 {
 			compatible = "samsung,s3c2440-i2c";
 			reg = <0x12CB0000 0x100>;
-			interrupts = <0 61 0>;
+			interrupts = <0 61 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			clocks = <&clock CLK_I2C5>;
@@ -332,7 +332,7 @@
 		i2c_6: i2c at 12CC0000 {
 			compatible = "samsung,s3c2440-i2c";
 			reg = <0x12CC0000 0x100>;
-			interrupts = <0 62 0>;
+			interrupts = <0 62 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			clocks = <&clock CLK_I2C6>;
@@ -345,7 +345,7 @@
 		i2c_7: i2c at 12CD0000 {
 			compatible = "samsung,s3c2440-i2c";
 			reg = <0x12CD0000 0x100>;
-			interrupts = <0 63 0>;
+			interrupts = <0 63 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			clocks = <&clock CLK_I2C7>;
@@ -358,7 +358,7 @@
 		i2c_8: i2c at 12CE0000 {
 			compatible = "samsung,s3c2440-hdmiphy-i2c";
 			reg = <0x12CE0000 0x1000>;
-			interrupts = <0 64 0>;
+			interrupts = <0 64 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			clocks = <&clock CLK_I2C_HDMI>;
@@ -380,7 +380,7 @@
 			compatible = "samsung,exynos4210-spi";
 			status = "disabled";
 			reg = <0x12d20000 0x100>;
-			interrupts = <0 66 0>;
+			interrupts = <0 66 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&pdma0 5
 				&pdma0 4>;
 			dma-names = "tx", "rx";
@@ -396,7 +396,7 @@
 			compatible = "samsung,exynos4210-spi";
 			status = "disabled";
 			reg = <0x12d30000 0x100>;
-			interrupts = <0 67 0>;
+			interrupts = <0 67 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&pdma1 5
 				&pdma1 4>;
 			dma-names = "tx", "rx";
@@ -412,7 +412,7 @@
 			compatible = "samsung,exynos4210-spi";
 			status = "disabled";
 			reg = <0x12d40000 0x100>;
-			interrupts = <0 68 0>;
+			interrupts = <0 68 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&pdma0 7
 				&pdma0 6>;
 			dma-names = "tx", "rx";
@@ -426,7 +426,7 @@
 
 		mmc_0: mmc at 12200000 {
 			compatible = "samsung,exynos5250-dw-mshc";
-			interrupts = <0 75 0>;
+			interrupts = <0 75 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x12200000 0x1000>;
@@ -438,7 +438,7 @@
 
 		mmc_1: mmc at 12210000 {
 			compatible = "samsung,exynos5250-dw-mshc";
-			interrupts = <0 76 0>;
+			interrupts = <0 76 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x12210000 0x1000>;
@@ -450,7 +450,7 @@
 
 		mmc_2: mmc at 12220000 {
 			compatible = "samsung,exynos5250-dw-mshc";
-			interrupts = <0 77 0>;
+			interrupts = <0 77 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x12220000 0x1000>;
@@ -463,7 +463,7 @@
 		mmc_3: mmc at 12230000 {
 			compatible = "samsung,exynos5250-dw-mshc";
 			reg = <0x12230000 0x1000>;
-			interrupts = <0 78 0>;
+			interrupts = <0 78 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			clocks = <&clock CLK_SDMMC3>, <&clock CLK_SCLK_MMC3>;
@@ -526,7 +526,7 @@
 			usbdrd_dwc3: dwc3 at 12000000 {
 				compatible = "synopsys,dwc3";
 				reg = <0x12000000 0x10000>;
-				interrupts = <0 72 0>;
+				interrupts = <0 72 IRQ_TYPE_LEVEL_HIGH>;
 				phys = <&usbdrd_phy 0>, <&usbdrd_phy 1>;
 				phy-names = "usb2-phy", "usb3-phy";
 			};
@@ -544,7 +544,7 @@
 		ehci: usb at 12110000 {
 			compatible = "samsung,exynos4210-ehci";
 			reg = <0x12110000 0x100>;
-			interrupts = <0 71 0>;
+			interrupts = <0 71 IRQ_TYPE_LEVEL_HIGH>;
 
 			clocks = <&clock CLK_USB2>;
 			clock-names = "usbhost";
@@ -559,7 +559,7 @@
 		ohci: usb at 12120000 {
 			compatible = "samsung,exynos4210-ohci";
 			reg = <0x12120000 0x100>;
-			interrupts = <0 71 0>;
+			interrupts = <0 71 IRQ_TYPE_LEVEL_HIGH>;
 
 			clocks = <&clock CLK_USB2>;
 			clock-names = "usbhost";
@@ -591,7 +591,7 @@
 			pdma0: pdma at 121A0000 {
 				compatible = "arm,pl330", "arm,primecell";
 				reg = <0x121A0000 0x1000>;
-				interrupts = <0 34 0>;
+				interrupts = <0 34 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clock CLK_PDMA0>;
 				clock-names = "apb_pclk";
 				#dma-cells = <1>;
@@ -602,7 +602,7 @@
 			pdma1: pdma at 121B0000 {
 				compatible = "arm,pl330", "arm,primecell";
 				reg = <0x121B0000 0x1000>;
-				interrupts = <0 35 0>;
+				interrupts = <0 35 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clock CLK_PDMA1>;
 				clock-names = "apb_pclk";
 				#dma-cells = <1>;
@@ -613,7 +613,7 @@
 			mdma0: mdma at 10800000 {
 				compatible = "arm,pl330", "arm,primecell";
 				reg = <0x10800000 0x1000>;
-				interrupts = <0 33 0>;
+				interrupts = <0 33 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clock CLK_MDMA0>;
 				clock-names = "apb_pclk";
 				#dma-cells = <1>;
@@ -624,7 +624,7 @@
 			mdma1: mdma at 11C10000 {
 				compatible = "arm,pl330", "arm,primecell";
 				reg = <0x11C10000 0x1000>;
-				interrupts = <0 124 0>;
+				interrupts = <0 124 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clock CLK_MDMA1>;
 				clock-names = "apb_pclk";
 				#dma-cells = <1>;
@@ -636,7 +636,7 @@
 		gsc_0:  gsc at 13e00000 {
 			compatible = "samsung,exynos5-gsc";
 			reg = <0x13e00000 0x1000>;
-			interrupts = <0 85 0>;
+			interrupts = <0 85 IRQ_TYPE_LEVEL_HIGH>;
 			power-domains = <&pd_gsc>;
 			clocks = <&clock CLK_GSCL0>;
 			clock-names = "gscl";
@@ -646,7 +646,7 @@
 		gsc_1:  gsc at 13e10000 {
 			compatible = "samsung,exynos5-gsc";
 			reg = <0x13e10000 0x1000>;
-			interrupts = <0 86 0>;
+			interrupts = <0 86 IRQ_TYPE_LEVEL_HIGH>;
 			power-domains = <&pd_gsc>;
 			clocks = <&clock CLK_GSCL1>;
 			clock-names = "gscl";
@@ -656,7 +656,7 @@
 		gsc_2:  gsc at 13e20000 {
 			compatible = "samsung,exynos5-gsc";
 			reg = <0x13e20000 0x1000>;
-			interrupts = <0 87 0>;
+			interrupts = <0 87 IRQ_TYPE_LEVEL_HIGH>;
 			power-domains = <&pd_gsc>;
 			clocks = <&clock CLK_GSCL2>;
 			clock-names = "gscl";
@@ -666,7 +666,7 @@
 		gsc_3:  gsc at 13e30000 {
 			compatible = "samsung,exynos5-gsc";
 			reg = <0x13e30000 0x1000>;
-			interrupts = <0 88 0>;
+			interrupts = <0 88 IRQ_TYPE_LEVEL_HIGH>;
 			power-domains = <&pd_gsc>;
 			clocks = <&clock CLK_GSCL3>;
 			clock-names = "gscl";
@@ -677,7 +677,7 @@
 			compatible = "samsung,exynos4212-hdmi";
 			reg = <0x14530000 0x70000>;
 			power-domains = <&pd_disp1>;
-			interrupts = <0 95 0>;
+			interrupts = <0 95 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_HDMI>, <&clock CLK_SCLK_HDMI>,
 				 <&clock CLK_SCLK_PIXEL>, <&clock CLK_SCLK_HDMIPHY>,
 				 <&clock CLK_MOUT_HDMI>;
@@ -690,7 +690,7 @@
 			compatible = "samsung,exynos5250-mixer";
 			reg = <0x14450000 0x10000>;
 			power-domains = <&pd_disp1>;
-			interrupts = <0 94 0>;
+			interrupts = <0 94 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_MIXER>, <&clock CLK_HDMI>,
 				 <&clock CLK_SCLK_HDMI>;
 			clock-names = "mixer", "hdmi", "sclk_hdmi";
@@ -706,7 +706,7 @@
 		adc: adc at 12D10000 {
 			compatible = "samsung,exynos-adc-v1";
 			reg = <0x12D10000 0x100>;
-			interrupts = <0 106 0>;
+			interrupts = <0 106 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_ADC>;
 			clock-names = "adc";
 			#io-channel-cells = <1>;
@@ -718,7 +718,7 @@
 		sss at 10830000 {
 			compatible = "samsung,exynos4210-secss";
 			reg = <0x10830000 0x300>;
-			interrupts = <0 112 0>;
+			interrupts = <0 112 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_SSS>;
 			clock-names = "secss";
 		};
-- 
2.7.4
