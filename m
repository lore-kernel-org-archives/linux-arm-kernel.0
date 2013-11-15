From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 15 Nov 2013 13:54:24 -0700
Subject: [PATCH 29/31] ARM: tegra: remove legacy DMA entries from DT
In-Reply-To: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1384548866-13141-30-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Now that all Tegra drivers have been converted to use DMA APIs which
retrieve DMA channel information from standard DMA DT properties, we can
remove all the legacy DT DMA-related properties.

Cc: treding at nvidia.com
Cc: linux-tegra at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: devicetree at vger.kernel.org
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra114.dtsi | 14 --------------
 arch/arm/boot/dts/tegra20.dtsi  | 13 -------------
 arch/arm/boot/dts/tegra30.dtsi  | 12 ------------
 3 files changed, 39 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index b4f2e62909a7..6d4858b2c701 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -128,7 +128,6 @@
 		reg = <0x70006000 0x40>;
 		reg-shift = <2>;
 		interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
-		nvidia,dma-request-selector = <&apbdma 8>;
 		clocks = <&tegra_car TEGRA114_CLK_UARTA>;
 		resets = <&tegra_car 6>;
 		reset-names = "serial";
@@ -142,7 +141,6 @@
 		reg = <0x70006040 0x40>;
 		reg-shift = <2>;
 		interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
-		nvidia,dma-request-selector = <&apbdma 9>;
 		clocks = <&tegra_car TEGRA114_CLK_UARTB>;
 		resets = <&tegra_car 7>;
 		reset-names = "serial";
@@ -156,7 +154,6 @@
 		reg = <0x70006200 0x100>;
 		reg-shift = <2>;
 		interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
-		nvidia,dma-request-selector = <&apbdma 10>;
 		clocks = <&tegra_car TEGRA114_CLK_UARTC>;
 		resets = <&tegra_car 55>;
 		reset-names = "serial";
@@ -170,7 +167,6 @@
 		reg = <0x70006300 0x100>;
 		reg-shift = <2>;
 		interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
-		nvidia,dma-request-selector = <&apbdma 19>;
 		clocks = <&tegra_car TEGRA114_CLK_UARTD>;
 		resets = <&tegra_car 65>;
 		reset-names = "serial";
@@ -268,7 +264,6 @@
 		compatible = "nvidia,tegra114-spi";
 		reg = <0x7000d400 0x200>;
 		interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
-		nvidia,dma-request-selector = <&apbdma 15>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		clocks = <&tegra_car TEGRA114_CLK_SBC1>;
@@ -284,7 +279,6 @@
 		compatible = "nvidia,tegra114-spi";
 		reg = <0x7000d600 0x200>;
 		interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
-		nvidia,dma-request-selector = <&apbdma 16>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		clocks = <&tegra_car TEGRA114_CLK_SBC2>;
@@ -300,7 +294,6 @@
 		compatible = "nvidia,tegra114-spi";
 		reg = <0x7000d800 0x200>;
 		interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
-		nvidia,dma-request-selector = <&apbdma 17>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		clocks = <&tegra_car TEGRA114_CLK_SBC3>;
@@ -316,7 +309,6 @@
 		compatible = "nvidia,tegra114-spi";
 		reg = <0x7000da00 0x200>;
 		interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
-		nvidia,dma-request-selector = <&apbdma 18>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		clocks = <&tegra_car TEGRA114_CLK_SBC4>;
@@ -332,7 +324,6 @@
 		compatible = "nvidia,tegra114-spi";
 		reg = <0x7000dc00 0x200>;
 		interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
-		nvidia,dma-request-selector = <&apbdma 27>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		clocks = <&tegra_car TEGRA114_CLK_SBC5>;
@@ -348,7 +339,6 @@
 		compatible = "nvidia,tegra114-spi";
 		reg = <0x7000de00 0x200>;
 		interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
-		nvidia,dma-request-selector = <&apbdma 28>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		clocks = <&tegra_car TEGRA114_CLK_SBC6>;
@@ -401,10 +391,6 @@
 		      <0x70080200 0x100>,
 		      <0x70081000 0x200>;
 		interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
-		nvidia,dma-request-selector = <&apbdma 1>, <&apbdma 2>,
-			<&apbdma 3>, <&apbdma 4>, <&apbdma 6>, <&apbdma 7>,
-			<&apbdma 12>, <&apbdma 13>, <&apbdma 14>,
-			<&apbdma 29>;
 		clocks = <&tegra_car TEGRA114_CLK_D_AUDIO>,
 			 <&tegra_car TEGRA114_CLK_APBIF>,
 			 <&tegra_car TEGRA114_CLK_I2S0>,
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 61d2f3868f4f..f780f7bed7bf 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -248,7 +248,6 @@
 		compatible = "nvidia,tegra20-ac97";
 		reg = <0x70002000 0x200>;
 		interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
-		nvidia,dma-request-selector = <&apbdma 12>;
 		clocks = <&tegra_car TEGRA20_CLK_AC97>;
 		resets = <&tegra_car 3>;
 		reset-names = "ac97";
@@ -261,7 +260,6 @@
 		compatible = "nvidia,tegra20-i2s";
 		reg = <0x70002800 0x200>;
 		interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
-		nvidia,dma-request-selector = <&apbdma 2>;
 		clocks = <&tegra_car TEGRA20_CLK_I2S1>;
 		resets = <&tegra_car 11>;
 		reset-names = "i2s";
@@ -274,7 +272,6 @@
 		compatible = "nvidia,tegra20-i2s";
 		reg = <0x70002a00 0x200>;
 		interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
-		nvidia,dma-request-selector = <&apbdma 1>;
 		clocks = <&tegra_car TEGRA20_CLK_I2S2>;
 		resets = <&tegra_car 18>;
 		reset-names = "i2s";
@@ -295,7 +292,6 @@
 		reg = <0x70006000 0x40>;
 		reg-shift = <2>;
 		interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
-		nvidia,dma-request-selector = <&apbdma 8>;
 		clocks = <&tegra_car TEGRA20_CLK_UARTA>;
 		resets = <&tegra_car 6>;
 		reset-names = "serial";
@@ -309,7 +305,6 @@
 		reg = <0x70006040 0x40>;
 		reg-shift = <2>;
 		interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
-		nvidia,dma-request-selector = <&apbdma 9>;
 		clocks = <&tegra_car TEGRA20_CLK_UARTB>;
 		resets = <&tegra_car 7>;
 		reset-names = "serial";
@@ -323,7 +318,6 @@
 		reg = <0x70006200 0x100>;
 		reg-shift = <2>;
 		interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
-		nvidia,dma-request-selector = <&apbdma 10>;
 		clocks = <&tegra_car TEGRA20_CLK_UARTC>;
 		resets = <&tegra_car 55>;
 		reset-names = "serial";
@@ -337,7 +331,6 @@
 		reg = <0x70006300 0x100>;
 		reg-shift = <2>;
 		interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
-		nvidia,dma-request-selector = <&apbdma 19>;
 		clocks = <&tegra_car TEGRA20_CLK_UARTD>;
 		resets = <&tegra_car 65>;
 		reset-names = "serial";
@@ -351,7 +344,6 @@
 		reg = <0x70006400 0x100>;
 		reg-shift = <2>;
 		interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
-		nvidia,dma-request-selector = <&apbdma 20>;
 		clocks = <&tegra_car TEGRA20_CLK_UARTE>;
 		resets = <&tegra_car 66>;
 		reset-names = "serial";
@@ -397,7 +389,6 @@
 		compatible = "nvidia,tegra20-sflash";
 		reg = <0x7000c380 0x80>;
 		interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
-		nvidia,dma-request-selector = <&apbdma 11>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		clocks = <&tegra_car TEGRA20_CLK_SPI>;
@@ -460,7 +451,6 @@
 		compatible = "nvidia,tegra20-slink";
 		reg = <0x7000d400 0x200>;
 		interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
-		nvidia,dma-request-selector = <&apbdma 15>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		clocks = <&tegra_car TEGRA20_CLK_SBC1>;
@@ -475,7 +465,6 @@
 		compatible = "nvidia,tegra20-slink";
 		reg = <0x7000d600 0x200>;
 		interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
-		nvidia,dma-request-selector = <&apbdma 16>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		clocks = <&tegra_car TEGRA20_CLK_SBC2>;
@@ -490,7 +479,6 @@
 		compatible = "nvidia,tegra20-slink";
 		reg = <0x7000d800 0x200>;
 		interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
-		nvidia,dma-request-selector = <&apbdma 17>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		clocks = <&tegra_car TEGRA20_CLK_SBC3>;
@@ -505,7 +493,6 @@
 		compatible = "nvidia,tegra20-slink";
 		reg = <0x7000da00 0x200>;
 		interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
-		nvidia,dma-request-selector = <&apbdma 18>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		clocks = <&tegra_car TEGRA20_CLK_SBC4>;
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 348b0f07f675..03ec194e832f 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -345,7 +345,6 @@
 		reg = <0x70006000 0x40>;
 		reg-shift = <2>;
 		interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
-		nvidia,dma-request-selector = <&apbdma 8>;
 		clocks = <&tegra_car TEGRA30_CLK_UARTA>;
 		resets = <&tegra_car 6>;
 		reset-names = "serial";
@@ -359,7 +358,6 @@
 		reg = <0x70006040 0x40>;
 		reg-shift = <2>;
 		interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
-		nvidia,dma-request-selector = <&apbdma 9>;
 		clocks = <&tegra_car TEGRA30_CLK_UARTB>;
 		resets = <&tegra_car 7>;
 		reset-names = "serial";
@@ -373,7 +371,6 @@
 		reg = <0x70006200 0x100>;
 		reg-shift = <2>;
 		interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
-		nvidia,dma-request-selector = <&apbdma 10>;
 		clocks = <&tegra_car TEGRA30_CLK_UARTC>;
 		resets = <&tegra_car 55>;
 		reset-names = "serial";
@@ -387,7 +384,6 @@
 		reg = <0x70006300 0x100>;
 		reg-shift = <2>;
 		interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
-		nvidia,dma-request-selector = <&apbdma 19>;
 		clocks = <&tegra_car TEGRA30_CLK_UARTD>;
 		resets = <&tegra_car 65>;
 		reset-names = "serial";
@@ -401,7 +397,6 @@
 		reg = <0x70006400 0x100>;
 		reg-shift = <2>;
 		interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
-		nvidia,dma-request-selector = <&apbdma 20>;
 		clocks = <&tegra_car TEGRA30_CLK_UARTE>;
 		resets = <&tegra_car 66>;
 		reset-names = "serial";
@@ -511,7 +506,6 @@
 		compatible = "nvidia,tegra30-slink", "nvidia,tegra20-slink";
 		reg = <0x7000d400 0x200>;
 		interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
-		nvidia,dma-request-selector = <&apbdma 15>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		clocks = <&tegra_car TEGRA30_CLK_SBC1>;
@@ -526,7 +520,6 @@
 		compatible = "nvidia,tegra30-slink", "nvidia,tegra20-slink";
 		reg = <0x7000d600 0x200>;
 		interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
-		nvidia,dma-request-selector = <&apbdma 16>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		clocks = <&tegra_car TEGRA30_CLK_SBC2>;
@@ -541,7 +534,6 @@
 		compatible = "nvidia,tegra30-slink", "nvidia,tegra20-slink";
 		reg = <0x7000d800 0x200>;
 		interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
-		nvidia,dma-request-selector = <&apbdma 17>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		clocks = <&tegra_car TEGRA30_CLK_SBC3>;
@@ -556,7 +548,6 @@
 		compatible = "nvidia,tegra30-slink", "nvidia,tegra20-slink";
 		reg = <0x7000da00 0x200>;
 		interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
-		nvidia,dma-request-selector = <&apbdma 18>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		clocks = <&tegra_car TEGRA30_CLK_SBC4>;
@@ -571,7 +562,6 @@
 		compatible = "nvidia,tegra30-slink", "nvidia,tegra20-slink";
 		reg = <0x7000dc00 0x200>;
 		interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
-		nvidia,dma-request-selector = <&apbdma 27>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		clocks = <&tegra_car TEGRA30_CLK_SBC5>;
@@ -586,7 +576,6 @@
 		compatible = "nvidia,tegra30-slink", "nvidia,tegra20-slink";
 		reg = <0x7000de00 0x200>;
 		interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
-		nvidia,dma-request-selector = <&apbdma 28>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		clocks = <&tegra_car TEGRA30_CLK_SBC6>;
@@ -638,7 +627,6 @@
 		reg = <0x70080000 0x200
 		       0x70080200 0x100>;
 		interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
-		nvidia,dma-request-selector = <&apbdma 1>;
 		clocks = <&tegra_car TEGRA30_CLK_D_AUDIO>,
 			 <&tegra_car TEGRA30_CLK_APBIF>;
 		clock-names = "d_audio", "apbif";
-- 
1.8.1.5
