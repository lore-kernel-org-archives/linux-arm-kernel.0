From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue,  4 Mar 2014 10:15:57 -0700
Subject: [PATCH] ARM: tegra: use 2 address cells for Tegra124 DT
Message-ID: <1393953357-32673-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Tegra124 can support 4GB of RAM. With that much RAM (plus some memory-
mapped IO peripherals), more than 32-bits of physical address space is
required. Hence, convert all Tegra124 DTs to use 2 DT cells for address
space.

(I think this was suggested by Olof Johansson, but I'm not 100% sure)

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra124-venice2.dts |  54 ++++-----
 arch/arm/boot/dts/tegra124.dtsi        | 215 +++++++++++++++++----------------
 2 files changed, 137 insertions(+), 132 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-venice2.dts b/arch/arm/boot/dts/tegra124-venice2.dts
index 1ad686154286..86536d919ed2 100644
--- a/arch/arm/boot/dts/tegra124-venice2.dts
+++ b/arch/arm/boot/dts/tegra124-venice2.dts
@@ -8,29 +8,29 @@
 	compatible = "nvidia,venice2", "nvidia,tegra124";
 
 	aliases {
-		rtc0 = "/i2c at 7000d000/pmic at 40";
-		rtc1 = "/rtc at 7000e000";
+		rtc0 = "/i2c at 0,7000d000/pmic at 40";
+		rtc1 = "/rtc at 0,7000e000";
 	};
 
 	memory {
-		reg = <0x80000000 0x80000000>;
+		reg = <0x0 0x80000000 0x0 0x80000000>;
 	};
 
-	host1x at 50000000 {
-		sor at 54540000 {
+	host1x at 0,50000000 {
+		sor at 0,54540000 {
 			status = "okay";
 
 			nvidia,dpaux = <&dpaux>;
 			nvidia,panel = <&panel>;
 		};
 
-		dpaux: dpaux at 545c0000 {
+		dpaux: dpaux at 0,545c0000 {
 			vdd-supply = <&vdd_3v3_panel>;
 			status = "okay";
 		};
 	};
 
-	pinmux: pinmux at 70000868 {
+	pinmux: pinmux at 0,70000868 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinmux_default>;
 
@@ -578,15 +578,15 @@
 		};
 	};
 
-	serial at 70006000 {
+	serial at 0,70006000 {
 		status = "okay";
 	};
 
-	pwm: pwm at 7000a000 {
+	pwm: pwm at 0,7000a000 {
 		status = "okay";
 	};
 
-	i2c at 7000c000 {
+	i2c at 0,7000c000 {
 		status = "okay";
 		clock-frequency = <100000>;
 
@@ -598,22 +598,22 @@
 		};
 	};
 
-	i2c at 7000c400 {
+	i2c at 0,7000c400 {
 		status = "okay";
 		clock-frequency = <100000>;
 	};
 
-	i2c at 7000c500 {
+	i2c at 0,7000c500 {
 		status = "okay";
 		clock-frequency = <100000>;
 	};
 
-	i2c at 7000c700 {
+	i2c at 0,7000c700 {
 		status = "okay";
 		clock-frequency = <100000>;
 	};
 
-	i2c at 7000d000 {
+	i2c at 0,7000d000 {
 		status = "okay";
 		clock-frequency = <400000>;
 
@@ -808,7 +808,7 @@
 		};
 	};
 
-	spi at 7000d400 {
+	spi at 0,7000d400 {
 		status = "okay";
 
 		cros-ec at 0 {
@@ -914,7 +914,7 @@
 		};
 	};
 
-	spi at 7000da00 {
+	spi at 0,7000da00 {
 		status = "okay";
 		spi-max-frequency = <25000000>;
 		spi-flash at 0 {
@@ -924,7 +924,7 @@
 		};
 	};
 
-	pmc at 7000e400 {
+	pmc at 0,7000e400 {
 		nvidia,invert-interrupt;
 		nvidia,suspend-mode = <1>;
 		nvidia,cpu-pwr-good-time = <500>;
@@ -935,7 +935,7 @@
 		nvidia,sys-clock-req-active-high;
 	};
 
-	sdhci at 700b0400 {
+	sdhci at 0,700b0400 {
 		cd-gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_HIGH>;
 		power-gpios = <&gpio TEGRA_GPIO(R, 0) GPIO_ACTIVE_HIGH>;
 		status = "okay";
@@ -943,40 +943,40 @@
 		vmmc-supply = <&vddio_sdmmc3>;
 	};
 
-	sdhci at 700b0600 {
+	sdhci at 0,700b0600 {
 		status = "okay";
 		bus-width = <8>;
 	};
 
-	ahub at 70300000 {
-		i2s at 70301100 {
+	ahub at 0,70300000 {
+		i2s at 0,70301100 {
 			status = "okay";
 		};
 	};
 
-	usb at 7d000000 {
+	usb at 0,7d000000 {
 		status = "okay";
 	};
 
-	usb-phy at 7d000000 {
+	usb-phy at 0,7d000000 {
 		status = "okay";
 		vbus-supply = <&vdd_usb1_vbus>;
 	};
 
-	usb at 7d004000 {
+	usb at 0,7d004000 {
 		status = "okay";
 	};
 
-	usb-phy at 7d004000 {
+	usb-phy at 0,7d004000 {
 		status = "okay";
 		vbus-supply = <&vdd_run_cam>;
 	};
 
-	usb at 7d008000 {
+	usb at 0,7d008000 {
 		status = "okay";
 	};
 
-	usb-phy at 7d008000 {
+	usb-phy at 0,7d008000 {
 		status = "okay";
 		vbus-supply = <&vdd_usb3_vbus>;
 	};
diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index b1459844ef09..cf45a1a39483 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -8,24 +8,26 @@
 / {
 	compatible = "nvidia,tegra124";
 	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
 
-	host1x at 50000000 {
+	host1x at 0,50000000 {
 		compatible = "nvidia,tegra124-host1x", "simple-bus";
-		reg = <0x50000000 0x00034000>;
+		reg = <0x0 0x50000000 0x0 0x00034000>;
 		interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>, /* syncpt */
 			     <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>; /* general */
 		clocks = <&tegra_car TEGRA124_CLK_HOST1X>;
 		resets = <&tegra_car 28>;
 		reset-names = "host1x";
 
-		#address-cells = <1>;
-		#size-cells = <1>;
+		#address-cells = <2>;
+		#size-cells = <2>;
 
-		ranges = <0x54000000 0x54000000 0x01000000>;
+		ranges = <0 0x54000000 0 0x54000000 0 0x01000000>;
 
-		dc at 54200000 {
+		dc at 0,54200000 {
 			compatible = "nvidia,tegra124-dc";
-			reg = <0x54200000 0x00040000>;
+			reg = <0x0 0x54200000 0x0 0x00040000>;
 			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&tegra_car TEGRA124_CLK_DISP1>,
 				 <&tegra_car TEGRA124_CLK_PLL_P>;
@@ -36,9 +38,9 @@
 			nvidia,head = <0>;
 		};
 
-		dc at 54240000 {
+		dc at 0,54240000 {
 			compatible = "nvidia,tegra124-dc";
-			reg = <0x54240000 0x00040000>;
+			reg = <0x0 0x54240000 0x0 0x00040000>;
 			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&tegra_car TEGRA124_CLK_DISP2>,
 				 <&tegra_car TEGRA124_CLK_PLL_P>;
@@ -49,9 +51,9 @@
 			nvidia,head = <1>;
 		};
 
-		sor at 54540000 {
+		sor at 0,54540000 {
 			compatible = "nvidia,tegra124-sor";
-			reg = <0x54540000 0x00040000>;
+			reg = <0x0 0x54540000 0x0 0x00040000>;
 			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&tegra_car TEGRA124_CLK_SOR0>,
 				 <&tegra_car TEGRA124_CLK_PLL_D_OUT0>,
@@ -63,9 +65,9 @@
 			status = "disabled";
 		};
 
-		dpaux at 545c0000 {
+		dpaux at 0,545c0000 {
 			compatible = "nvidia,tegra124-dpaux";
-			reg = <0x545c0000 0x00040000>;
+			reg = <0x0 0x545c0000 0x0 0x00040000>;
 			interrupts = <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&tegra_car TEGRA124_CLK_DPAUX>,
 				 <&tegra_car TEGRA124_CLK_PLL_DP>;
@@ -76,21 +78,21 @@
 		};
 	};
 
-	gic: interrupt-controller at 50041000 {
+	gic: interrupt-controller at 0,50041000 {
 		compatible = "arm,cortex-a15-gic";
 		#interrupt-cells = <3>;
 		interrupt-controller;
-		reg = <0x50041000 0x1000>,
-		      <0x50042000 0x1000>,
-		      <0x50044000 0x2000>,
-		      <0x50046000 0x2000>;
+		reg = <0x0 0x50041000 0x0 0x1000>,
+		      <0x0 0x50042000 0x0 0x1000>,
+		      <0x0 0x50044000 0x0 0x2000>,
+		      <0x0 0x50046000 0x0 0x2000>;
 		interrupts = <GIC_PPI 9
 			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
-	timer at 60005000 {
+	timer at 0,60005000 {
 		compatible = "nvidia,tegra124-timer", "nvidia,tegra20-timer";
-		reg = <0x60005000 0x400>;
+		reg = <0x0 0x60005000 0x0 0x400>;
 		interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
@@ -100,16 +102,16 @@
 		clocks = <&tegra_car TEGRA124_CLK_TIMER>;
 	};
 
-	tegra_car: clock at 60006000 {
+	tegra_car: clock at 0,60006000 {
 		compatible = "nvidia,tegra124-car";
-		reg = <0x60006000 0x1000>;
+		reg = <0x0 0x60006000 0x0 0x1000>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
 	};
 
-	gpio: gpio at 6000d000 {
+	gpio: gpio at 0,6000d000 {
 		compatible = "nvidia,tegra124-gpio", "nvidia,tegra30-gpio";
-		reg = <0x6000d000 0x1000>;
+		reg = <0x0 0x6000d000 0x0 0x1000>;
 		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>,
@@ -124,9 +126,9 @@
 		interrupt-controller;
 	};
 
-	apbdma: dma at 60020000 {
+	apbdma: dma at 0,60020000 {
 		compatible = "nvidia,tegra124-apbdma", "nvidia,tegra148-apbdma";
-		reg = <0x60020000 0x1400>;
+		reg = <0x0 0x60020000 0x0 0x1400>;
 		interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
@@ -165,10 +167,10 @@
 		#dma-cells = <1>;
 	};
 
-	pinmux: pinmux at 70000868 {
+	pinmux: pinmux at 0,70000868 {
 		compatible = "nvidia,tegra124-pinmux";
-		reg = <0x70000868 0x164>,	/* Pad control registers */
-		      <0x70003000 0x434>;	/* Mux registers */
+		reg = <0x0 0x70000868 0x0 0x164>, /* Pad control registers */
+		      <0x0 0x70003000 0x0 0x434>; /* Mux registers */
 	};
 
 	/*
@@ -179,9 +181,9 @@
 	 * the APB DMA based serial driver, the comptible is
 	 * "nvidia,tegra124-hsuart", "nvidia,tegra30-hsuart".
 	 */
-	serial at 70006000 {
+	serial at 0,70006000 {
 		compatible = "nvidia,tegra124-uart", "nvidia,tegra20-uart";
-		reg = <0x70006000 0x40>;
+		reg = <0x0 0x70006000 0x0 0x40>;
 		reg-shift = <2>;
 		interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA124_CLK_UARTA>;
@@ -192,9 +194,9 @@
 		status = "disabled";
 	};
 
-	serial at 70006040 {
+	serial at 0,70006040 {
 		compatible = "nvidia,tegra124-uart", "nvidia,tegra20-uart";
-		reg = <0x70006040 0x40>;
+		reg = <0x0 0x70006040 0x0 0x40>;
 		reg-shift = <2>;
 		interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA124_CLK_UARTB>;
@@ -205,9 +207,9 @@
 		status = "disabled";
 	};
 
-	serial at 70006200 {
+	serial at 0,70006200 {
 		compatible = "nvidia,tegra124-uart", "nvidia,tegra20-uart";
-		reg = <0x70006200 0x40>;
+		reg = <0x0 0x70006200 0x0 0x40>;
 		reg-shift = <2>;
 		interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA124_CLK_UARTC>;
@@ -218,9 +220,9 @@
 		status = "disabled";
 	};
 
-	serial at 70006300 {
+	serial at 0,70006300 {
 		compatible = "nvidia,tegra124-uart", "nvidia,tegra20-uart";
-		reg = <0x70006300 0x40>;
+		reg = <0x0 0x70006300 0x0 0x40>;
 		reg-shift = <2>;
 		interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA124_CLK_UARTD>;
@@ -231,9 +233,9 @@
 		status = "disabled";
 	};
 
-	serial at 70006400 {
+	serial at 0,70006400 {
 		compatible = "nvidia,tegra124-uart", "nvidia,tegra20-uart";
-		reg = <0x70006400 0x40>;
+		reg = <0x0 0x70006400 0x0 0x40>;
 		reg-shift = <2>;
 		interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA124_CLK_UARTE>;
@@ -244,9 +246,9 @@
 		status = "disabled";
 	};
 
-	pwm at 7000a000 {
+	pwm at 0,7000a000 {
 		compatible = "nvidia,tegra124-pwm", "nvidia,tegra20-pwm";
-		reg = <0x7000a000 0x100>;
+		reg = <0x0 0x7000a000 0x0 0x100>;
 		#pwm-cells = <2>;
 		clocks = <&tegra_car TEGRA124_CLK_PWM>;
 		resets = <&tegra_car 17>;
@@ -254,9 +256,9 @@
 		status = "disabled";
 	};
 
-	i2c at 7000c000 {
+	i2c at 0,7000c000 {
 		compatible = "nvidia,tegra124-i2c", "nvidia,tegra114-i2c";
-		reg = <0x7000c000 0x100>;
+		reg = <0x0 0x7000c000 0x0 0x100>;
 		interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -269,9 +271,9 @@
 		status = "disabled";
 	};
 
-	i2c at 7000c400 {
+	i2c at 0,7000c400 {
 		compatible = "nvidia,tegra124-i2c", "nvidia,tegra114-i2c";
-		reg = <0x7000c400 0x100>;
+		reg = <0x0 0x7000c400 0x0 0x100>;
 		interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -284,9 +286,9 @@
 		status = "disabled";
 	};
 
-	i2c at 7000c500 {
+	i2c at 0,7000c500 {
 		compatible = "nvidia,tegra124-i2c", "nvidia,tegra114-i2c";
-		reg = <0x7000c500 0x100>;
+		reg = <0x0 0x7000c500 0x0 0x100>;
 		interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -299,9 +301,9 @@
 		status = "disabled";
 	};
 
-	i2c at 7000c700 {
+	i2c at 0,7000c700 {
 		compatible = "nvidia,tegra124-i2c", "nvidia,tegra114-i2c";
-		reg = <0x7000c700 0x100>;
+		reg = <0x0 0x7000c700 0x0 0x100>;
 		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -314,9 +316,9 @@
 		status = "disabled";
 	};
 
-	i2c at 7000d000 {
+	i2c at 0,7000d000 {
 		compatible = "nvidia,tegra124-i2c", "nvidia,tegra114-i2c";
-		reg = <0x7000d000 0x100>;
+		reg = <0x0 0x7000d000 0x0 0x100>;
 		interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -329,9 +331,9 @@
 		status = "disabled";
 	};
 
-	i2c at 7000d100 {
+	i2c at 0,7000d100 {
 		compatible = "nvidia,tegra124-i2c", "nvidia,tegra114-i2c";
-		reg = <0x7000d100 0x100>;
+		reg = <0x0 0x7000d100 0x0 0x100>;
 		interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -344,9 +346,9 @@
 		status = "disabled";
 	};
 
-	spi at 7000d400 {
+	spi at 0,7000d400 {
 		compatible = "nvidia,tegra124-spi", "nvidia,tegra114-spi";
-		reg = <0x7000d400 0x200>;
+		reg = <0x0 0x7000d400 0x0 0x200>;
 		interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -359,9 +361,9 @@
 		status = "disabled";
 	};
 
-	spi at 7000d600 {
+	spi at 0,7000d600 {
 		compatible = "nvidia,tegra124-spi", "nvidia,tegra114-spi";
-		reg = <0x7000d600 0x200>;
+		reg = <0x0 0x7000d600 0x0 0x200>;
 		interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -374,9 +376,9 @@
 		status = "disabled";
 	};
 
-	spi at 7000d800 {
+	spi at 0,7000d800 {
 		compatible = "nvidia,tegra124-spi", "nvidia,tegra114-spi";
-		reg = <0x7000d800 0x200>;
+		reg = <0x0 0x7000d800 0x0 0x200>;
 		interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -389,9 +391,9 @@
 		status = "disabled";
 	};
 
-	spi at 7000da00 {
+	spi at 0,7000da00 {
 		compatible = "nvidia,tegra124-spi", "nvidia,tegra114-spi";
-		reg = <0x7000da00 0x200>;
+		reg = <0x0 0x7000da00 0x0 0x200>;
 		interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -404,9 +406,9 @@
 		status = "disabled";
 	};
 
-	spi at 7000dc00 {
+	spi at 0,7000dc00 {
 		compatible = "nvidia,tegra124-spi", "nvidia,tegra114-spi";
-		reg = <0x7000dc00 0x200>;
+		reg = <0x0 0x7000dc00 0x0 0x200>;
 		interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -419,9 +421,9 @@
 		status = "disabled";
 	};
 
-	spi at 7000de00 {
+	spi at 0,7000de00 {
 		compatible = "nvidia,tegra124-spi", "nvidia,tegra114-spi";
-		reg = <0x7000de00 0x200>;
+		reg = <0x0 0x7000de00 0x0 0x200>;
 		interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -434,23 +436,23 @@
 		status = "disabled";
 	};
 
-	rtc at 7000e000 {
+	rtc at 0,7000e000 {
 		compatible = "nvidia,tegra124-rtc", "nvidia,tegra20-rtc";
-		reg = <0x7000e000 0x100>;
+		reg = <0x0 0x7000e000 0x0 0x100>;
 		interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA124_CLK_RTC>;
 	};
 
-	pmc at 7000e400 {
+	pmc at 0,7000e400 {
 		compatible = "nvidia,tegra124-pmc";
-		reg = <0x7000e400 0x400>;
+		reg = <0x0 0x7000e400 0x0 0x400>;
 		clocks = <&tegra_car TEGRA124_CLK_PCLK>, <&clk32k_in>;
 		clock-names = "pclk", "clk32k_in";
 	};
 
-	sdhci at 700b0000 {
+	sdhci at 0,700b0000 {
 		compatible = "nvidia,tegra124-sdhci";
-		reg = <0x700b0000 0x200>;
+		reg = <0x0 0x700b0000 0x0 0x200>;
 		interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA124_CLK_SDMMC1>;
 		resets = <&tegra_car 14>;
@@ -458,9 +460,9 @@
 		status = "disabled";
 	};
 
-	sdhci at 700b0200 {
+	sdhci at 0,700b0200 {
 		compatible = "nvidia,tegra124-sdhci";
-		reg = <0x700b0200 0x200>;
+		reg = <0x0 0x700b0200 0x0 0x200>;
 		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA124_CLK_SDMMC2>;
 		resets = <&tegra_car 9>;
@@ -468,9 +470,9 @@
 		status = "disabled";
 	};
 
-	sdhci at 700b0400 {
+	sdhci at 0,700b0400 {
 		compatible = "nvidia,tegra124-sdhci";
-		reg = <0x700b0400 0x200>;
+		reg = <0x0 0x700b0400 0x0 0x200>;
 		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA124_CLK_SDMMC3>;
 		resets = <&tegra_car 69>;
@@ -478,9 +480,9 @@
 		status = "disabled";
 	};
 
-	sdhci at 700b0600 {
+	sdhci at 0,700b0600 {
 		compatible = "nvidia,tegra124-sdhci";
-		reg = <0x700b0600 0x200>;
+		reg = <0x0 0x700b0600 0x0 0x200>;
 		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA124_CLK_SDMMC4>;
 		resets = <&tegra_car 15>;
@@ -488,11 +490,11 @@
 		status = "disabled";
 	};
 
-	ahub at 70300000 {
+	ahub at 0,70300000 {
 		compatible = "nvidia,tegra124-ahub";
-		reg = <0x70300000 0x200>,
-		      <0x70300800 0x800>,
-		      <0x70300200 0x600>;
+		reg = <0x0 0x70300000 0x0 0x200>,
+		      <0x0 0x70300800 0x0 0x800>,
+		      <0x0 0x70300200 0x0 0x600>;
 		interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA124_CLK_D_AUDIO>,
 			 <&tegra_car TEGRA124_CLK_APBIF>;
@@ -537,12 +539,12 @@
 			    "rx6", "tx6", "rx7", "tx7", "rx8", "tx8",
 			    "rx9", "tx9";
 		ranges;
-		#address-cells = <1>;
-		#size-cells = <1>;
+		#address-cells = <2>;
+		#size-cells = <2>;
 
-		tegra_i2s0: i2s at 70301000 {
+		tegra_i2s0: i2s at 0,70301000 {
 			compatible = "nvidia,tegra124-i2s";
-			reg = <0x70301000 0x100>;
+			reg = <0x0 0x70301000 0x0 0x100>;
 			nvidia,ahub-cif-ids = <4 4>;
 			clocks = <&tegra_car TEGRA124_CLK_I2S0>;
 			resets = <&tegra_car 30>;
@@ -550,9 +552,9 @@
 			status = "disabled";
 		};
 
-		tegra_i2s1: i2s at 70301100 {
+		tegra_i2s1: i2s at 0,70301100 {
 			compatible = "nvidia,tegra124-i2s";
-			reg = <0x70301100 0x100>;
+			reg = <0x0 0x70301100 0x0 0x100>;
 			nvidia,ahub-cif-ids = <5 5>;
 			clocks = <&tegra_car TEGRA124_CLK_I2S1>;
 			resets = <&tegra_car 11>;
@@ -560,9 +562,9 @@
 			status = "disabled";
 		};
 
-		tegra_i2s2: i2s at 70301200 {
+		tegra_i2s2: i2s at 0,70301200 {
 			compatible = "nvidia,tegra124-i2s";
-			reg = <0x70301200 0x100>;
+			reg = <0x0 0x70301200 0x0 0x100>;
 			nvidia,ahub-cif-ids = <6 6>;
 			clocks = <&tegra_car TEGRA124_CLK_I2S2>;
 			resets = <&tegra_car 18>;
@@ -570,9 +572,9 @@
 			status = "disabled";
 		};
 
-		tegra_i2s3: i2s at 70301300 {
+		tegra_i2s3: i2s at 0,70301300 {
 			compatible = "nvidia,tegra124-i2s";
-			reg = <0x70301300 0x100>;
+			reg = <0x0 0x70301300 0x0 0x100>;
 			nvidia,ahub-cif-ids = <7 7>;
 			clocks = <&tegra_car TEGRA124_CLK_I2S3>;
 			resets = <&tegra_car 101>;
@@ -580,9 +582,9 @@
 			status = "disabled";
 		};
 
-		tegra_i2s4: i2s at 70301400 {
+		tegra_i2s4: i2s at 0,70301400 {
 			compatible = "nvidia,tegra124-i2s";
-			reg = <0x70301400 0x100>;
+			reg = <0x0 0x70301400 0x0 0x100>;
 			nvidia,ahub-cif-ids = <8 8>;
 			clocks = <&tegra_car TEGRA124_CLK_I2S4>;
 			resets = <&tegra_car 102>;
@@ -591,9 +593,9 @@
 		};
 	};
 
-	usb at 7d000000 {
+	usb at 0,7d000000 {
 		compatible = "nvidia,tegra124-ehci", "nvidia,tegra30-ehci", "usb-ehci";
-		reg = <0x7d000000 0x4000>;
+		reg = <0x0 0x7d000000 0x0 0x4000>;
 		interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 		phy_type = "utmi";
 		clocks = <&tegra_car TEGRA124_CLK_USBD>;
@@ -603,9 +605,10 @@
 		status = "disabled";
 	};
 
-	phy1: usb-phy at 7d000000 {
+	phy1: usb-phy at 0,7d000000 {
 		compatible = "nvidia,tegra124-usb-phy", "nvidia,tegra30-usb-phy";
-		reg = <0x7d000000 0x4000 0x7d000000 0x4000>;
+		reg = <0x0 0x7d000000 0x0 0x4000>,
+		      <0x0 0x7d000000 0x0 0x4000>;
 		phy_type = "utmi";
 		clocks = <&tegra_car TEGRA124_CLK_USBD>,
 			 <&tegra_car TEGRA124_CLK_PLL_U>,
@@ -624,9 +627,9 @@
 		status = "disabled";
 	};
 
-	usb at 7d004000 {
+	usb at 0,7d004000 {
 		compatible = "nvidia,tegra124-ehci", "nvidia,tegra30-ehci", "usb-ehci";
-		reg = <0x7d004000 0x4000>;
+		reg = <0x0 0x7d004000 0x0 0x4000>;
 		interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
 		phy_type = "utmi";
 		clocks = <&tegra_car TEGRA124_CLK_USB2>;
@@ -636,9 +639,10 @@
 		status = "disabled";
 	};
 
-	phy2: usb-phy at 7d004000 {
+	phy2: usb-phy at 0,7d004000 {
 		compatible = "nvidia,tegra124-usb-phy", "nvidia,tegra30-usb-phy";
-		reg = <0x7d004000 0x4000 0x7d000000 0x4000>;
+		reg = <0x0 0x7d004000 0x0 0x4000>,
+		      <0x0 0x7d000000 0x0 0x4000>;
 		phy_type = "utmi";
 		clocks = <&tegra_car TEGRA124_CLK_USB2>,
 			 <&tegra_car TEGRA124_CLK_PLL_U>,
@@ -657,9 +661,9 @@
 		status = "disabled";
 	};
 
-	usb at 7d008000 {
+	usb at 0,7d008000 {
 		compatible = "nvidia,tegra124-ehci", "nvidia,tegra30-ehci", "usb-ehci";
-		reg = <0x7d008000 0x4000>;
+		reg = <0x0 0x7d008000 0x0 0x4000>;
 		interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
 		phy_type = "utmi";
 		clocks = <&tegra_car TEGRA124_CLK_USB3>;
@@ -669,9 +673,10 @@
 		status = "disabled";
 	};
 
-	phy3: usb-phy at 7d008000 {
+	phy3: usb-phy at 0,7d008000 {
 		compatible = "nvidia,tegra124-usb-phy", "nvidia,tegra30-usb-phy";
-		reg = <0x7d008000 0x4000 0x7d000000 0x4000>;
+		reg = <0x0 0x7d008000 0x0 0x4000>,
+		      <0x0 0x7d000000 0x0 0x4000>;
 		phy_type = "utmi";
 		clocks = <&tegra_car TEGRA124_CLK_USB3>,
 			 <&tegra_car TEGRA124_CLK_PLL_U>,
-- 
1.8.1.5
