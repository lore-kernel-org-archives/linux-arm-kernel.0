From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 16 Sep 2016 23:41:58 +0200
Subject: [PATCH 3/7] ARM: dts: exynos: Use human-friendly symbols for
 interrupt properties in exynos4
In-Reply-To: <1474062122-22720-1-git-send-email-krzk@kernel.org>
References: <1474062122-22720-1-git-send-email-krzk@kernel.org>
Message-ID: <1474062122-22720-4-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace hard-coded values of type of GIC interrupt and its flags with
respective macros from header to increase code readability

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos4.dtsi            | 99 ++++++++++++++++---------------
 arch/arm/boot/dts/exynos4210-pinctrl.dtsi | 32 +++++-----
 arch/arm/boot/dts/exynos4210.dtsi         | 40 ++++++-------
 arch/arm/boot/dts/exynos4x12-pinctrl.dtsi | 32 +++++-----
 arch/arm/boot/dts/exynos4x12.dtsi         | 60 +++++++++----------
 5 files changed, 132 insertions(+), 131 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index e6f4da7f0038..3cbfc14b6b02 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -21,6 +21,7 @@
 
 #include <dt-bindings/clock/exynos4.h>
 #include <dt-bindings/clock/exynos-audss-clk.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include "exynos-syscon-restart.dtsi"
 
@@ -169,7 +170,7 @@
 	dsi_0: dsi at 11C80000 {
 		compatible = "samsung,exynos4210-mipi-dsi";
 		reg = <0x11C80000 0x10000>;
-		interrupts = <0 79 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
 		power-domains = <&pd_lcd0>;
 		phys = <&mipi_phy 1>;
 		phy-names = "dsim";
@@ -192,7 +193,7 @@
 		fimc_0: fimc at 11800000 {
 			compatible = "samsung,exynos4210-fimc";
 			reg = <0x11800000 0x1000>;
-			interrupts = <0 84 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_FIMC0>, <&clock CLK_SCLK_FIMC0>;
 			clock-names = "fimc", "sclk_fimc";
 			power-domains = <&pd_cam>;
@@ -204,7 +205,7 @@
 		fimc_1: fimc at 11810000 {
 			compatible = "samsung,exynos4210-fimc";
 			reg = <0x11810000 0x1000>;
-			interrupts = <0 85 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_FIMC1>, <&clock CLK_SCLK_FIMC1>;
 			clock-names = "fimc", "sclk_fimc";
 			power-domains = <&pd_cam>;
@@ -216,7 +217,7 @@
 		fimc_2: fimc at 11820000 {
 			compatible = "samsung,exynos4210-fimc";
 			reg = <0x11820000 0x1000>;
-			interrupts = <0 86 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_FIMC2>, <&clock CLK_SCLK_FIMC2>;
 			clock-names = "fimc", "sclk_fimc";
 			power-domains = <&pd_cam>;
@@ -228,7 +229,7 @@
 		fimc_3: fimc at 11830000 {
 			compatible = "samsung,exynos4210-fimc";
 			reg = <0x11830000 0x1000>;
-			interrupts = <0 87 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_FIMC3>, <&clock CLK_SCLK_FIMC3>;
 			clock-names = "fimc", "sclk_fimc";
 			power-domains = <&pd_cam>;
@@ -240,7 +241,7 @@
 		csis_0: csis at 11880000 {
 			compatible = "samsung,exynos4210-csis";
 			reg = <0x11880000 0x4000>;
-			interrupts = <0 78 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_CSIS0>, <&clock CLK_SCLK_CSIS0>;
 			clock-names = "csis", "sclk_csis";
 			bus-width = <4>;
@@ -255,7 +256,7 @@
 		csis_1: csis at 11890000 {
 			compatible = "samsung,exynos4210-csis";
 			reg = <0x11890000 0x4000>;
-			interrupts = <0 80 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_CSIS1>, <&clock CLK_SCLK_CSIS1>;
 			clock-names = "csis", "sclk_csis";
 			bus-width = <2>;
@@ -271,7 +272,7 @@
 	watchdog: watchdog at 10060000 {
 		compatible = "samsung,s3c2410-wdt";
 		reg = <0x10060000 0x100>;
-		interrupts = <0 43 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_WDT>;
 		clock-names = "watchdog";
 		status = "disabled";
@@ -281,8 +282,8 @@
 		compatible = "samsung,s3c6410-rtc";
 		reg = <0x10070000 0x100>;
 		interrupt-parent = <&pmu_system_controller>;
-		interrupts = <0 44 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 45 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_RTC>;
 		clock-names = "rtc";
 		status = "disabled";
@@ -291,7 +292,7 @@
 	keypad: keypad at 100A0000 {
 		compatible = "samsung,s5pv210-keypad";
 		reg = <0x100A0000 0x100>;
-		interrupts = <0 109 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_KEYIF>;
 		clock-names = "keypad";
 		status = "disabled";
@@ -300,7 +301,7 @@
 	sdhci_0: sdhci at 12510000 {
 		compatible = "samsung,exynos4210-sdhci";
 		reg = <0x12510000 0x100>;
-		interrupts = <0 73 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_SDMMC0>, <&clock CLK_SCLK_MMC0>;
 		clock-names = "hsmmc", "mmc_busclk.2";
 		status = "disabled";
@@ -309,7 +310,7 @@
 	sdhci_1: sdhci at 12520000 {
 		compatible = "samsung,exynos4210-sdhci";
 		reg = <0x12520000 0x100>;
-		interrupts = <0 74 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_SDMMC1>, <&clock CLK_SCLK_MMC1>;
 		clock-names = "hsmmc", "mmc_busclk.2";
 		status = "disabled";
@@ -318,7 +319,7 @@
 	sdhci_2: sdhci at 12530000 {
 		compatible = "samsung,exynos4210-sdhci";
 		reg = <0x12530000 0x100>;
-		interrupts = <0 75 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_SDMMC2>, <&clock CLK_SCLK_MMC2>;
 		clock-names = "hsmmc", "mmc_busclk.2";
 		status = "disabled";
@@ -327,7 +328,7 @@
 	sdhci_3: sdhci at 12540000 {
 		compatible = "samsung,exynos4210-sdhci";
 		reg = <0x12540000 0x100>;
-		interrupts = <0 76 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_SDMMC3>, <&clock CLK_SCLK_MMC3>;
 		clock-names = "hsmmc", "mmc_busclk.2";
 		status = "disabled";
@@ -346,7 +347,7 @@
 	hsotg: hsotg at 12480000 {
 		compatible = "samsung,s3c6400-hsotg";
 		reg = <0x12480000 0x20000>;
-		interrupts = <0 71 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_USB_DEVICE>;
 		clock-names = "otg";
 		phys = <&exynos_usbphy 0>;
@@ -357,7 +358,7 @@
 	ehci: ehci at 12580000 {
 		compatible = "samsung,exynos4210-ehci";
 		reg = <0x12580000 0x100>;
-		interrupts = <0 70 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_USB_HOST>;
 		clock-names = "usbhost";
 		status = "disabled";
@@ -383,7 +384,7 @@
 	ohci: ohci at 12590000 {
 		compatible = "samsung,exynos4210-ohci";
 		reg = <0x12590000 0x100>;
-		interrupts = <0 70 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_USB_HOST>;
 		clock-names = "usbhost";
 		status = "disabled";
@@ -425,7 +426,7 @@
 	mfc: codec at 13400000 {
 		compatible = "samsung,mfc-v5";
 		reg = <0x13400000 0x10000>;
-		interrupts = <0 94 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
 		power-domains = <&pd_mfc>;
 		clocks = <&clock CLK_MFC>, <&clock CLK_SCLK_MFC>;
 		clock-names = "mfc", "sclk_mfc";
@@ -436,7 +437,7 @@
 	serial_0: serial at 13800000 {
 		compatible = "samsung,exynos4210-uart";
 		reg = <0x13800000 0x100>;
-		interrupts = <0 52 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_UART0>, <&clock CLK_SCLK_UART0>;
 		clock-names = "uart", "clk_uart_baud0";
 		dmas = <&pdma0 15>, <&pdma0 16>;
@@ -447,7 +448,7 @@
 	serial_1: serial at 13810000 {
 		compatible = "samsung,exynos4210-uart";
 		reg = <0x13810000 0x100>;
-		interrupts = <0 53 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_UART1>, <&clock CLK_SCLK_UART1>;
 		clock-names = "uart", "clk_uart_baud0";
 		dmas = <&pdma1 15>, <&pdma1 16>;
@@ -458,7 +459,7 @@
 	serial_2: serial at 13820000 {
 		compatible = "samsung,exynos4210-uart";
 		reg = <0x13820000 0x100>;
-		interrupts = <0 54 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_UART2>, <&clock CLK_SCLK_UART2>;
 		clock-names = "uart", "clk_uart_baud0";
 		dmas = <&pdma0 17>, <&pdma0 18>;
@@ -469,7 +470,7 @@
 	serial_3: serial at 13830000 {
 		compatible = "samsung,exynos4210-uart";
 		reg = <0x13830000 0x100>;
-		interrupts = <0 55 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_UART3>, <&clock CLK_SCLK_UART3>;
 		clock-names = "uart", "clk_uart_baud0";
 		dmas = <&pdma1 17>, <&pdma1 18>;
@@ -482,7 +483,7 @@
 		#size-cells = <0>;
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x13860000 0x100>;
-		interrupts = <0 58 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_I2C0>;
 		clock-names = "i2c";
 		pinctrl-names = "default";
@@ -495,7 +496,7 @@
 		#size-cells = <0>;
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x13870000 0x100>;
-		interrupts = <0 59 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_I2C1>;
 		clock-names = "i2c";
 		pinctrl-names = "default";
@@ -508,7 +509,7 @@
 		#size-cells = <0>;
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x13880000 0x100>;
-		interrupts = <0 60 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_I2C2>;
 		clock-names = "i2c";
 		pinctrl-names = "default";
@@ -521,7 +522,7 @@
 		#size-cells = <0>;
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x13890000 0x100>;
-		interrupts = <0 61 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_I2C3>;
 		clock-names = "i2c";
 		pinctrl-names = "default";
@@ -534,7 +535,7 @@
 		#size-cells = <0>;
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x138A0000 0x100>;
-		interrupts = <0 62 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_I2C4>;
 		clock-names = "i2c";
 		pinctrl-names = "default";
@@ -547,7 +548,7 @@
 		#size-cells = <0>;
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x138B0000 0x100>;
-		interrupts = <0 63 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_I2C5>;
 		clock-names = "i2c";
 		pinctrl-names = "default";
@@ -560,7 +561,7 @@
 		#size-cells = <0>;
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x138C0000 0x100>;
-		interrupts = <0 64 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_I2C6>;
 		clock-names = "i2c";
 		pinctrl-names = "default";
@@ -573,7 +574,7 @@
 		#size-cells = <0>;
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x138D0000 0x100>;
-		interrupts = <0 65 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_I2C7>;
 		clock-names = "i2c";
 		pinctrl-names = "default";
@@ -586,7 +587,7 @@
 		#size-cells = <0>;
 		compatible = "samsung,s3c2440-hdmiphy-i2c";
 		reg = <0x138E0000 0x100>;
-		interrupts = <0 93 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_I2C_HDMI>;
 		clock-names = "i2c";
 		status = "disabled";
@@ -600,7 +601,7 @@
 	spi_0: spi at 13920000 {
 		compatible = "samsung,exynos4210-spi";
 		reg = <0x13920000 0x100>;
-		interrupts = <0 66 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
 		dmas = <&pdma0 7>, <&pdma0 6>;
 		dma-names = "tx", "rx";
 		#address-cells = <1>;
@@ -615,7 +616,7 @@
 	spi_1: spi at 13930000 {
 		compatible = "samsung,exynos4210-spi";
 		reg = <0x13930000 0x100>;
-		interrupts = <0 67 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
 		dmas = <&pdma1 7>, <&pdma1 6>;
 		dma-names = "tx", "rx";
 		#address-cells = <1>;
@@ -630,7 +631,7 @@
 	spi_2: spi at 13940000 {
 		compatible = "samsung,exynos4210-spi";
 		reg = <0x13940000 0x100>;
-		interrupts = <0 68 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
 		dmas = <&pdma0 9>, <&pdma0 8>;
 		dma-names = "tx", "rx";
 		#address-cells = <1>;
@@ -645,11 +646,11 @@
 	pwm: pwm at 139D0000 {
 		compatible = "samsung,exynos4210-pwm";
 		reg = <0x139D0000 0x1000>;
-		interrupts = <0 37 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 38 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 39 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 40 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 41 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_PWM>;
 		clock-names = "timers";
 		#pwm-cells = <3>;
@@ -666,7 +667,7 @@
 		pdma0: pdma at 12680000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x12680000 0x1000>;
-			interrupts = <0 35 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_PDMA0>;
 			clock-names = "apb_pclk";
 			#dma-cells = <1>;
@@ -677,7 +678,7 @@
 		pdma1: pdma at 12690000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x12690000 0x1000>;
-			interrupts = <0 36 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_PDMA1>;
 			clock-names = "apb_pclk";
 			#dma-cells = <1>;
@@ -688,7 +689,7 @@
 		mdma1: mdma at 12850000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x12850000 0x1000>;
-			interrupts = <0 34 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_MDMA>;
 			clock-names = "apb_pclk";
 			#dma-cells = <1>;
@@ -718,7 +719,7 @@
 	jpeg_codec: jpeg-codec at 11840000 {
 		compatible = "samsung,exynos4210-jpeg";
 		reg = <0x11840000 0x1000>;
-		interrupts = <0 88 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_JPEG>;
 		clock-names = "jpeg";
 		power-domains = <&pd_cam>;
@@ -728,7 +729,7 @@
 	rotator: rotator at 12810000 {
 		compatible = "samsung,exynos4210-rotator";
 		reg = <0x12810000 0x64>;
-		interrupts = <0 83 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_ROTATOR>;
 		clock-names = "rotator";
 		iommus = <&sysmmu_rotator>;
@@ -737,7 +738,7 @@
 	hdmi: hdmi at 12D00000 {
 		compatible = "samsung,exynos4210-hdmi";
 		reg = <0x12D00000 0x70000>;
-		interrupts = <0 92 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
 		clock-names = "hdmi", "sclk_hdmi", "sclk_pixel", "sclk_hdmiphy",
 			"mout_hdmi";
 		clocks = <&clock CLK_HDMI>, <&clock CLK_SCLK_HDMI>,
@@ -752,7 +753,7 @@
 	hdmicec: cec at 100B0000 {
 		compatible = "samsung,s5p-cec";
 		reg = <0x100B0000 0x200>;
-		interrupts = <0 114 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_HDMI_CEC>;
 		clock-names = "hdmicec";
 		samsung,syscon-phandle = <&pmu_system_controller>;
@@ -763,7 +764,7 @@
 
 	mixer: mixer at 12C10000 {
 		compatible = "samsung,exynos4210-mixer";
-		interrupts = <0 91 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
 		reg = <0x12C10000 0x2100>, <0x12c00000 0x300>;
 		power-domains = <&pd_tv>;
 		iommus = <&sysmmu_tv>;
@@ -990,7 +991,7 @@
 	sss: sss at 10830000 {
 		compatible = "samsung,exynos4210-secss";
 		reg = <0x10830000 0x300>;
-		interrupts = <0 112 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_SSS>;
 		clock-names = "secss";
 	};
diff --git a/arch/arm/boot/dts/exynos4210-pinctrl.dtsi b/arch/arm/boot/dts/exynos4210-pinctrl.dtsi
index 152f324f44c7..1857c7469c46 100644
--- a/arch/arm/boot/dts/exynos4210-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos4210-pinctrl.dtsi
@@ -535,14 +535,14 @@
 
 			interrupt-controller;
 			interrupt-parent = <&gic>;
-			interrupts = <0 16 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 17 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 18 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 19 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 20 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 21 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 22 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 23 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
 			#interrupt-cells = <2>;
 		};
 
@@ -552,14 +552,14 @@
 
 			interrupt-controller;
 			interrupt-parent = <&gic>;
-			interrupts = <0 24 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 25 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 26 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 27 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 28 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 29 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 30 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 31 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
 			#interrupt-cells = <2>;
 		};
 
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index 736ab8587ab0..7f3a18c8f60f 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -127,18 +127,18 @@
 	pinctrl_0: pinctrl at 11400000 {
 		compatible = "samsung,exynos4210-pinctrl";
 		reg = <0x11400000 0x1000>;
-		interrupts = <0 47 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
 	pinctrl_1: pinctrl at 11000000 {
 		compatible = "samsung,exynos4210-pinctrl";
 		reg = <0x11000000 0x1000>;
-		interrupts = <0 46 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
 
 		wakup_eint: wakeup-interrupt-controller {
 			compatible = "samsung,exynos4210-wakeup-eint";
 			interrupt-parent = <&gic>;
-			interrupts = <0 32 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 		};
 	};
 
@@ -182,7 +182,7 @@
 	g2d: g2d at 12800000 {
 		compatible = "samsung,s5pv210-g2d";
 		reg = <0x12800000 0x1000>;
-		interrupts = <0 89 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_SCLK_FIMG2D>, <&clock CLK_G2D>;
 		clock-names = "sclk_fimg2d", "fimg2d";
 		power-domains = <&pd_lcd0>;
@@ -424,22 +424,22 @@
 
 &combiner {
 	samsung,combiner-nr = <16>;
-	interrupts = <0 0 IRQ_TYPE_LEVEL_HIGH>,
-		     <0 1 IRQ_TYPE_LEVEL_HIGH>,
-		     <0 2 IRQ_TYPE_LEVEL_HIGH>,
-		     <0 3 IRQ_TYPE_LEVEL_HIGH>,
-		     <0 4 IRQ_TYPE_LEVEL_HIGH>,
-		     <0 5 IRQ_TYPE_LEVEL_HIGH>,
-		     <0 6 IRQ_TYPE_LEVEL_HIGH>,
-		     <0 7 IRQ_TYPE_LEVEL_HIGH>,
-		     <0 8 IRQ_TYPE_LEVEL_HIGH>,
-		     <0 9 IRQ_TYPE_LEVEL_HIGH>,
-		     <0 10 IRQ_TYPE_LEVEL_HIGH>,
-		     <0 11 IRQ_TYPE_LEVEL_HIGH>,
-		     <0 12 IRQ_TYPE_LEVEL_HIGH>,
-		     <0 13 IRQ_TYPE_LEVEL_HIGH>,
-		     <0 14 IRQ_TYPE_LEVEL_HIGH>,
-		     <0 15 IRQ_TYPE_LEVEL_HIGH>;
+	interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
 };
 
 &mdma1 {
diff --git a/arch/arm/boot/dts/exynos4x12-pinctrl.dtsi b/arch/arm/boot/dts/exynos4x12-pinctrl.dtsi
index d579accc95db..f74e74e3263e 100644
--- a/arch/arm/boot/dts/exynos4x12-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos4x12-pinctrl.dtsi
@@ -579,14 +579,14 @@
 
 			interrupt-controller;
 			interrupt-parent = <&gic>;
-			interrupts = <0 16 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 17 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 18 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 19 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 20 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 21 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 22 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 23 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
 			#interrupt-cells = <2>;
 		};
 
@@ -596,14 +596,14 @@
 
 			interrupt-controller;
 			interrupt-parent = <&gic>;
-			interrupts = <0 24 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 25 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 26 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 27 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 28 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 29 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 30 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 31 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
 			#interrupt-cells = <2>;
 		};
 
diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
index 2f52b685daf9..505f047e81c6 100644
--- a/arch/arm/boot/dts/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -112,7 +112,7 @@
 	g2d: g2d at 10800000 {
 		compatible = "samsung,exynos4212-g2d";
 		reg = <0x10800000 0x1000>;
-		interrupts = <0 89 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_SCLK_FIMG2D>, <&clock CLK_G2D>;
 		clock-names = "sclk_fimg2d", "fimg2d";
 		iommus = <&sysmmu_g2d>;
@@ -127,7 +127,7 @@
 		fimc_lite_0: fimc-lite at 12390000 {
 			compatible = "samsung,exynos4212-fimc-lite";
 			reg = <0x12390000 0x1000>;
-			interrupts = <0 105 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
 			power-domains = <&pd_isp>;
 			clocks = <&clock CLK_FIMC_LITE0>;
 			clock-names = "flite";
@@ -138,7 +138,7 @@
 		fimc_lite_1: fimc-lite at 123A0000 {
 			compatible = "samsung,exynos4212-fimc-lite";
 			reg = <0x123A0000 0x1000>;
-			interrupts = <0 106 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
 			power-domains = <&pd_isp>;
 			clocks = <&clock CLK_FIMC_LITE1>;
 			clock-names = "flite";
@@ -149,8 +149,8 @@
 		fimc_is: fimc-is at 12000000 {
 			compatible = "samsung,exynos4212-fimc-is", "simple-bus";
 			reg = <0x12000000 0x260000>;
-			interrupts = <0 90 IRQ_TYPE_LEVEL_HIGH>,
-				     <0 95 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
 			power-domains = <&pd_isp>;
 			clocks = <&clock CLK_FIMC_LITE0>,
 				 <&clock CLK_FIMC_LITE1>, <&clock CLK_PPMUISPX>,
@@ -201,7 +201,7 @@
 	mshc_0: mmc at 12550000 {
 		compatible = "samsung,exynos4412-dw-mshc";
 		reg = <0x12550000 0x1000>;
-		interrupts = <0 77 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		fifo-depth = <0x80>;
@@ -462,26 +462,26 @@
 };
 
 &combiner {
-	interrupts = <0 0 IRQ_TYPE_LEVEL_HIGH>,
-		     <0 1 IRQ_TYPE_LEVEL_HIGH>,
-		     <0 2 IRQ_TYPE_LEVEL_HIGH>,
-		     <0 3 IRQ_TYPE_LEVEL_HIGH>,
-		     <0 4 IRQ_TYPE_LEVEL_HIGH>,
-		     <0 5 IRQ_TYPE_LEVEL_HIGH>,
-		     <0 6 IRQ_TYPE_LEVEL_HIGH>,
-		     <0 7 IRQ_TYPE_LEVEL_HIGH>,
-		     <0 8 IRQ_TYPE_LEVEL_HIGH>,
-		     <0 9 IRQ_TYPE_LEVEL_HIGH>,
-		     <0 10 IRQ_TYPE_LEVEL_HIGH>,
-		     <0 11 IRQ_TYPE_LEVEL_HIGH>,
-		     <0 12 IRQ_TYPE_LEVEL_HIGH>,
-		     <0 13 IRQ_TYPE_LEVEL_HIGH>,
-		     <0 14 IRQ_TYPE_LEVEL_HIGH>,
-		     <0 15 IRQ_TYPE_LEVEL_HIGH>,
-		     <0 107 IRQ_TYPE_LEVEL_HIGH>,
-		     <0 108 IRQ_TYPE_LEVEL_HIGH>,
-		     <0 48 IRQ_TYPE_LEVEL_HIGH>,
-		     <0 42 IRQ_TYPE_LEVEL_HIGH>;
+	interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
 };
 
 &exynos_usbphy {
@@ -545,18 +545,18 @@
 &pinctrl_0 {
 	compatible = "samsung,exynos4x12-pinctrl";
 	reg = <0x11400000 0x1000>;
-	interrupts = <0 47 IRQ_TYPE_LEVEL_HIGH>;
+	interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
 };
 
 &pinctrl_1 {
 	compatible = "samsung,exynos4x12-pinctrl";
 	reg = <0x11000000 0x1000>;
-	interrupts = <0 46 IRQ_TYPE_LEVEL_HIGH>;
+	interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
 
 	wakup_eint: wakeup-interrupt-controller {
 		compatible = "samsung,exynos4210-wakeup-eint";
 		interrupt-parent = <&gic>;
-		interrupts = <0 32 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 	};
 };
 
@@ -570,7 +570,7 @@
 &pinctrl_3 {
 	compatible = "samsung,exynos4x12-pinctrl";
 	reg = <0x106E0000 0x1000>;
-	interrupts = <0 72 IRQ_TYPE_LEVEL_HIGH>;
+	interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
 };
 
 &pmu_system_controller {
-- 
2.7.4
