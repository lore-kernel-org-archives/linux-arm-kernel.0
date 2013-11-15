From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 15 Nov 2013 13:53:59 -0700
Subject: [PATCH 04/31] ARM: tegra: update DT files to add reset properties
In-Reply-To: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1384548866-13141-5-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

An earlier patch updated the Tegra DT bindings to require resets and
reset-names properties to be filled in. This patch updates the DT files
to include those properties.

Note that any legacy clocks and clock-names entries that are replaced by
reset properties are not yet removed; the drivers must be updated to use
the new resets and reset-names properties first.

Cc: treding at nvidia.com
Cc: pdeschrijver at nvidia.com
Cc: linux-tegra at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: devicetree at vger.kernel.org
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra114.dtsi     |  83 ++++++++++++++++++++++++++--
 arch/arm/boot/dts/tegra20-paz00.dts |   2 +
 arch/arm/boot/dts/tegra20.dtsi      |  81 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/tegra30.dtsi      | 104 ++++++++++++++++++++++++++++++++++++
 4 files changed, 266 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index 8d42787c8ff1..c40dbdcb3741 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -43,6 +43,7 @@
 		compatible = "nvidia,tegra114-car";
 		reg = <0x60006000 0x1000>;
 		#clock-cells = <1>;
+		#reset-cells = <1>;
 	};
 
 	apbdma: dma {
@@ -81,6 +82,8 @@
 			     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA114_CLK_APBDMA>;
+		resets = <&tegra_car 34>;
+		reset-names = "dma";
 	};
 
 	ahb: ahb {
@@ -125,8 +128,10 @@
 		reg-shift = <2>;
 		interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 		nvidia,dma-request-selector = <&apbdma 8>;
-		status = "disabled";
 		clocks = <&tegra_car TEGRA114_CLK_UARTA>;
+		resets = <&tegra_car 6>;
+		reset-names = "serial";
+		status = "disabled";
 	};
 
 	uartb: serial at 70006040 {
@@ -135,8 +140,10 @@
 		reg-shift = <2>;
 		interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 		nvidia,dma-request-selector = <&apbdma 9>;
-		status = "disabled";
 		clocks = <&tegra_car TEGRA114_CLK_UARTB>;
+		resets = <&tegra_car 7>;
+		reset-names = "serial";
+		status = "disabled";
 	};
 
 	uartc: serial at 70006200 {
@@ -145,8 +152,10 @@
 		reg-shift = <2>;
 		interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
 		nvidia,dma-request-selector = <&apbdma 10>;
-		status = "disabled";
 		clocks = <&tegra_car TEGRA114_CLK_UARTC>;
+		resets = <&tegra_car 55>;
+		reset-names = "serial";
+		status = "disabled";
 	};
 
 	uartd: serial at 70006300 {
@@ -155,8 +164,10 @@
 		reg-shift = <2>;
 		interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
 		nvidia,dma-request-selector = <&apbdma 19>;
-		status = "disabled";
 		clocks = <&tegra_car TEGRA114_CLK_UARTD>;
+		resets = <&tegra_car 65>;
+		reset-names = "serial";
+		status = "disabled";
 	};
 
 	pwm: pwm {
@@ -164,6 +175,8 @@
 		reg = <0x7000a000 0x100>;
 		#pwm-cells = <2>;
 		clocks = <&tegra_car TEGRA114_CLK_PWM>;
+		resets = <&tegra_car 17>;
+		reset-names = "pwm";
 		status = "disabled";
 	};
 
@@ -175,6 +188,8 @@
 		#size-cells = <0>;
 		clocks = <&tegra_car TEGRA114_CLK_I2C1>;
 		clock-names = "div-clk";
+		resets = <&tegra_car 12>;
+		reset-names = "i2c";
 		status = "disabled";
 	};
 
@@ -186,6 +201,8 @@
 		#size-cells = <0>;
 		clocks = <&tegra_car TEGRA114_CLK_I2C2>;
 		clock-names = "div-clk";
+		resets = <&tegra_car 54>;
+		reset-names = "i2c";
 		status = "disabled";
 	};
 
@@ -197,6 +214,8 @@
 		#size-cells = <0>;
 		clocks = <&tegra_car TEGRA114_CLK_I2C3>;
 		clock-names = "div-clk";
+		resets = <&tegra_car 67>;
+		reset-names = "i2c";
 		status = "disabled";
 	};
 
@@ -208,6 +227,8 @@
 		#size-cells = <0>;
 		clocks = <&tegra_car TEGRA114_CLK_I2C4>;
 		clock-names = "div-clk";
+		resets = <&tegra_car 103>;
+		reset-names = "i2c";
 		status = "disabled";
 	};
 
@@ -219,6 +240,8 @@
 		#size-cells = <0>;
 		clocks = <&tegra_car TEGRA114_CLK_I2C5>;
 		clock-names = "div-clk";
+		resets = <&tegra_car 47>;
+		reset-names = "i2c";
 		status = "disabled";
 	};
 
@@ -231,6 +254,8 @@
 		#size-cells = <0>;
 		clocks = <&tegra_car TEGRA114_CLK_SBC1>;
 		clock-names = "spi";
+		resets = <&tegra_car 41>;
+		reset-names = "spi";
 		status = "disabled";
 	};
 
@@ -243,6 +268,8 @@
 		#size-cells = <0>;
 		clocks = <&tegra_car TEGRA114_CLK_SBC2>;
 		clock-names = "spi";
+		resets = <&tegra_car 44>;
+		reset-names = "spi";
 		status = "disabled";
 	};
 
@@ -255,6 +282,8 @@
 		#size-cells = <0>;
 		clocks = <&tegra_car TEGRA114_CLK_SBC3>;
 		clock-names = "spi";
+		resets = <&tegra_car 46>;
+		reset-names = "spi";
 		status = "disabled";
 	};
 
@@ -267,6 +296,8 @@
 		#size-cells = <0>;
 		clocks = <&tegra_car TEGRA114_CLK_SBC4>;
 		clock-names = "spi";
+		resets = <&tegra_car 68>;
+		reset-names = "spi";
 		status = "disabled";
 	};
 
@@ -279,6 +310,8 @@
 		#size-cells = <0>;
 		clocks = <&tegra_car TEGRA114_CLK_SBC5>;
 		clock-names = "spi";
+		resets = <&tegra_car 104>;
+		reset-names = "spi";
 		status = "disabled";
 	};
 
@@ -291,6 +324,8 @@
 		#size-cells = <0>;
 		clocks = <&tegra_car TEGRA114_CLK_SBC6>;
 		clock-names = "spi";
+		resets = <&tegra_car 105>;
+		reset-names = "spi";
 		status = "disabled";
 	};
 
@@ -306,6 +341,8 @@
 		reg = <0x7000e200 0x100>;
 		interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA114_CLK_KBC>;
+		resets = <&tegra_car 36>;
+		reset-names = "kbc";
 		status = "disabled";
 	};
 
@@ -353,6 +390,22 @@
 		clock-names = "d_audio", "apbif", "i2s0", "i2s1", "i2s2",
 			      "i2s3", "i2s4", "dam0", "dam1", "dam2",
 			      "spdif_in", "amx", "adx";
+		resets = <&tegra_car 106>, /* d_audio */
+			 <&tegra_car 107>, /* apbif */
+			 <&tegra_car 30>,  /* i2s0 */
+			 <&tegra_car 11>,  /* i2s1 */
+			 <&tegra_car 18>,  /* i2s2 */
+			 <&tegra_car 101>, /* i2s3 */
+			 <&tegra_car 102>, /* i2s4 */
+			 <&tegra_car 108>, /* dam0 */
+			 <&tegra_car 109>, /* dam1 */
+			 <&tegra_car 110>, /* dam2 */
+			 <&tegra_car 10>,  /* spdif */
+			 <&tegra_car 153>, /* amx */
+			 <&tegra_car 154>; /* adx */
+		reset-names = "d_audio", "apbif", "i2s0", "i2s1", "i2s2",
+			      "i2s3", "i2s4", "dam0", "dam1", "dam2",
+			      "spdif", "amx", "adx";
 		ranges;
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -362,6 +415,8 @@
 			reg = <0x70080300 0x100>;
 			nvidia,ahub-cif-ids = <4 4>;
 			clocks = <&tegra_car TEGRA114_CLK_I2S0>;
+			resets = <&tegra_car 30>;
+			reset-names = "i2s";
 			status = "disabled";
 		};
 
@@ -370,6 +425,8 @@
 			reg = <0x70080400 0x100>;
 			nvidia,ahub-cif-ids = <5 5>;
 			clocks = <&tegra_car TEGRA114_CLK_I2S1>;
+			resets = <&tegra_car 11>;
+			reset-names = "i2s";
 			status = "disabled";
 		};
 
@@ -378,6 +435,8 @@
 			reg = <0x70080500 0x100>;
 			nvidia,ahub-cif-ids = <6 6>;
 			clocks = <&tegra_car TEGRA114_CLK_I2S2>;
+			resets = <&tegra_car 18>;
+			reset-names = "i2s";
 			status = "disabled";
 		};
 
@@ -386,6 +445,8 @@
 			reg = <0x70080600 0x100>;
 			nvidia,ahub-cif-ids = <7 7>;
 			clocks = <&tegra_car TEGRA114_CLK_I2S3>;
+			resets = <&tegra_car 101>;
+			reset-names = "i2s";
 			status = "disabled";
 		};
 
@@ -394,6 +455,8 @@
 			reg = <0x70080700 0x100>;
 			nvidia,ahub-cif-ids = <8 8>;
 			clocks = <&tegra_car TEGRA114_CLK_I2S4>;
+			resets = <&tegra_car 102>;
+			reset-names = "i2s";
 			status = "disabled";
 		};
 	};
@@ -403,6 +466,8 @@
 		reg = <0x78000000 0x200>;
 		interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA114_CLK_SDMMC1>;
+		resets = <&tegra_car 14>;
+		reset-names = "sdhci";
 		status = "disable";
 	};
 
@@ -411,6 +476,8 @@
 		reg = <0x78000200 0x200>;
 		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA114_CLK_SDMMC2>;
+		resets = <&tegra_car 9>;
+		reset-names = "sdhci";
 		status = "disable";
 	};
 
@@ -419,6 +486,8 @@
 		reg = <0x78000400 0x200>;
 		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA114_CLK_SDMMC3>;
+		resets = <&tegra_car 69>;
+		reset-names = "sdhci";
 		status = "disable";
 	};
 
@@ -427,6 +496,8 @@
 		reg = <0x78000600 0x200>;
 		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA114_CLK_SDMMC4>;
+		resets = <&tegra_car 15>;
+		reset-names = "sdhci";
 		status = "disable";
 	};
 
@@ -436,6 +507,8 @@
 		interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 		phy_type = "utmi";
 		clocks = <&tegra_car TEGRA114_CLK_USBD>;
+		resets = <&tegra_car 22>;
+		reset-names = "usb";
 		nvidia,phy = <&phy1>;
 		status = "disabled";
 	};
@@ -467,6 +540,8 @@
 		interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
 		phy_type = "utmi";
 		clocks = <&tegra_car TEGRA114_CLK_USB3>;
+		resets = <&tegra_car 59>;
+		reset-names = "usb";
 		nvidia,phy = <&phy3>;
 		status = "disabled";
 	};
diff --git a/arch/arm/boot/dts/tegra20-paz00.dts b/arch/arm/boot/dts/tegra20-paz00.dts
index 8d71fc9d8a2f..e57fb3aefc2a 100644
--- a/arch/arm/boot/dts/tegra20-paz00.dts
+++ b/arch/arm/boot/dts/tegra20-paz00.dts
@@ -280,6 +280,8 @@
 		clocks = <&tegra_car TEGRA20_CLK_I2C3>,
 		       	 <&tegra_car TEGRA20_CLK_PLL_P_OUT3>;
 		clock-names = "div-clk", "fast-clk";
+		resets = <&tegra_car 67>;
+		reset-names = "i2c";
 	};
 
 	i2c at 7000d000 {
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index df40b54fd8bc..159facbce524 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -22,6 +22,8 @@
 		interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>, /* syncpt */
 			     <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>; /* general */
 		clocks = <&tegra_car TEGRA20_CLK_HOST1X>;
+		resets = <&tegra_car 28>;
+		reset-names = "host1x";
 
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -33,6 +35,8 @@
 			reg = <0x54040000 0x00040000>;
 			interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&tegra_car TEGRA20_CLK_MPE>;
+			resets = <&tegra_car 60>;
+			reset-names = "mpe";
 		};
 
 		vi {
@@ -40,6 +44,8 @@
 			reg = <0x54080000 0x00040000>;
 			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&tegra_car TEGRA20_CLK_VI>;
+			resets = <&tegra_car 100>;
+			reset-names = "vi";
 		};
 
 		epp {
@@ -47,6 +53,8 @@
 			reg = <0x540c0000 0x00040000>;
 			interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&tegra_car TEGRA20_CLK_EPP>;
+			resets = <&tegra_car 19>;
+			reset-names = "epp";
 		};
 
 		isp {
@@ -54,6 +62,8 @@
 			reg = <0x54100000 0x00040000>;
 			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&tegra_car TEGRA20_CLK_ISP>;
+			resets = <&tegra_car 23>;
+			reset-names = "isp";
 		};
 
 		gr2d {
@@ -61,12 +71,16 @@
 			reg = <0x54140000 0x00040000>;
 			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&tegra_car TEGRA20_CLK_GR2D>;
+			resets = <&tegra_car 21>;
+			reset-names = "2d";
 		};
 
 		gr3d {
 			compatible = "nvidia,tegra20-gr3d";
 			reg = <0x54180000 0x00040000>;
 			clocks = <&tegra_car TEGRA20_CLK_GR3D>;
+			resets = <&tegra_car 24>;
+			reset-names = "3d";
 		};
 
 		dc at 54200000 {
@@ -76,6 +90,8 @@
 			clocks = <&tegra_car TEGRA20_CLK_DISP1>,
 				 <&tegra_car TEGRA20_CLK_PLL_P>;
 			clock-names = "disp1", "parent";
+			resets = <&tegra_car 27>;
+			reset-names = "dc";
 
 			rgb {
 				status = "disabled";
@@ -89,6 +105,8 @@
 			clocks = <&tegra_car TEGRA20_CLK_DISP2>,
 				 <&tegra_car TEGRA20_CLK_PLL_P>;
 			clock-names = "disp2", "parent";
+			resets = <&tegra_car 26>;
+			reset-names = "dc";
 
 			rgb {
 				status = "disabled";
@@ -102,6 +120,8 @@
 			clocks = <&tegra_car TEGRA20_CLK_HDMI>,
 				 <&tegra_car TEGRA20_CLK_PLL_D_OUT0>;
 			clock-names = "hdmi", "parent";
+			resets = <&tegra_car 51>;
+			reset-names = "hdmi";
 			status = "disabled";
 		};
 
@@ -117,6 +137,8 @@
 			compatible = "nvidia,tegra20-dsi";
 			reg = <0x54300000 0x00040000>;
 			clocks = <&tegra_car TEGRA20_CLK_DSI>;
+			resets = <&tegra_car 48>;
+			reset-names = "dsi";
 			status = "disabled";
 		};
 	};
@@ -160,6 +182,7 @@
 		compatible = "nvidia,tegra20-car";
 		reg = <0x60006000 0x1000>;
 		#clock-cells = <1>;
+		#reset-cells = <1>;
 	};
 
 	apbdma: dma {
@@ -182,6 +205,8 @@
 			     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA20_CLK_APBDMA>;
+		resets = <&tegra_car 34>;
+		reset-names = "dma";
 	};
 
 	ahb {
@@ -224,6 +249,8 @@
 		interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
 		nvidia,dma-request-selector = <&apbdma 12>;
 		clocks = <&tegra_car TEGRA20_CLK_AC97>;
+		resets = <&tegra_car 3>;
+		reset-names = "ac97";
 		status = "disabled";
 	};
 
@@ -233,6 +260,8 @@
 		interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
 		nvidia,dma-request-selector = <&apbdma 2>;
 		clocks = <&tegra_car TEGRA20_CLK_I2S1>;
+		resets = <&tegra_car 11>;
+		reset-names = "i2s";
 		status = "disabled";
 	};
 
@@ -242,6 +271,8 @@
 		interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 		nvidia,dma-request-selector = <&apbdma 1>;
 		clocks = <&tegra_car TEGRA20_CLK_I2S2>;
+		resets = <&tegra_car 18>;
+		reset-names = "i2s";
 		status = "disabled";
 	};
 
@@ -259,6 +290,8 @@
 		interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 		nvidia,dma-request-selector = <&apbdma 8>;
 		clocks = <&tegra_car TEGRA20_CLK_UARTA>;
+		resets = <&tegra_car 6>;
+		reset-names = "serial";
 		status = "disabled";
 	};
 
@@ -269,6 +302,8 @@
 		interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 		nvidia,dma-request-selector = <&apbdma 9>;
 		clocks = <&tegra_car TEGRA20_CLK_UARTB>;
+		resets = <&tegra_car 7>;
+		reset-names = "serial";
 		status = "disabled";
 	};
 
@@ -279,6 +314,8 @@
 		interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
 		nvidia,dma-request-selector = <&apbdma 10>;
 		clocks = <&tegra_car TEGRA20_CLK_UARTC>;
+		resets = <&tegra_car 55>;
+		reset-names = "serial";
 		status = "disabled";
 	};
 
@@ -289,6 +326,8 @@
 		interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
 		nvidia,dma-request-selector = <&apbdma 19>;
 		clocks = <&tegra_car TEGRA20_CLK_UARTD>;
+		resets = <&tegra_car 65>;
+		reset-names = "serial";
 		status = "disabled";
 	};
 
@@ -299,6 +338,8 @@
 		interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
 		nvidia,dma-request-selector = <&apbdma 20>;
 		clocks = <&tegra_car TEGRA20_CLK_UARTE>;
+		resets = <&tegra_car 66>;
+		reset-names = "serial";
 		status = "disabled";
 	};
 
@@ -307,6 +348,8 @@
 		reg = <0x7000a000 0x100>;
 		#pwm-cells = <2>;
 		clocks = <&tegra_car TEGRA20_CLK_PWM>;
+		resets = <&tegra_car 17>;
+		reset-names = "pwm";
 		status = "disabled";
 	};
 
@@ -326,6 +369,8 @@
 		clocks = <&tegra_car TEGRA20_CLK_I2C1>,
 			 <&tegra_car TEGRA20_CLK_PLL_P_OUT3>;
 		clock-names = "div-clk", "fast-clk";
+		resets = <&tegra_car 12>;
+		reset-names = "i2c";
 		status = "disabled";
 	};
 
@@ -337,6 +382,8 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		clocks = <&tegra_car TEGRA20_CLK_SPI>;
+		resets = <&tegra_car 43>;
+		reset-names = "spi";
 		status = "disabled";
 	};
 
@@ -349,6 +396,8 @@
 		clocks = <&tegra_car TEGRA20_CLK_I2C2>,
 			 <&tegra_car TEGRA20_CLK_PLL_P_OUT3>;
 		clock-names = "div-clk", "fast-clk";
+		resets = <&tegra_car 54>;
+		reset-names = "i2c";
 		status = "disabled";
 	};
 
@@ -361,6 +410,8 @@
 		clocks = <&tegra_car TEGRA20_CLK_I2C3>,
 			 <&tegra_car TEGRA20_CLK_PLL_P_OUT3>;
 		clock-names = "div-clk", "fast-clk";
+		resets = <&tegra_car 67>;
+		reset-names = "i2c";
 		status = "disabled";
 	};
 
@@ -373,6 +424,8 @@
 		clocks = <&tegra_car TEGRA20_CLK_DVC>,
 			 <&tegra_car TEGRA20_CLK_PLL_P_OUT3>;
 		clock-names = "div-clk", "fast-clk";
+		resets = <&tegra_car 47>;
+		reset-names = "i2c";
 		status = "disabled";
 	};
 
@@ -384,6 +437,8 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		clocks = <&tegra_car TEGRA20_CLK_SBC1>;
+		resets = <&tegra_car 41>;
+		reset-names = "spi";
 		status = "disabled";
 	};
 
@@ -395,6 +450,8 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		clocks = <&tegra_car TEGRA20_CLK_SBC2>;
+		resets = <&tegra_car 44>;
+		reset-names = "spi";
 		status = "disabled";
 	};
 
@@ -406,6 +463,8 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		clocks = <&tegra_car TEGRA20_CLK_SBC3>;
+		resets = <&tegra_car 46>;
+		reset-names = "spi";
 		status = "disabled";
 	};
 
@@ -417,6 +476,8 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		clocks = <&tegra_car TEGRA20_CLK_SBC4>;
+		resets = <&tegra_car 68>;
+		reset-names = "spi";
 		status = "disabled";
 	};
 
@@ -425,6 +486,8 @@
 		reg = <0x7000e200 0x100>;
 		interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA20_CLK_KBC>;
+		resets = <&tegra_car 36>;
+		reset-names = "kbc";
 		status = "disabled";
 	};
 
@@ -481,6 +544,10 @@
 			 <&tegra_car TEGRA20_CLK_PCIE_XCLK>,
 			 <&tegra_car TEGRA20_CLK_PLL_E>;
 		clock-names = "pex", "afi", "pcie_xclk", "pll_e";
+		resets = <&tegra_car 70>,
+		         <&tegra_car 72>,
+		         <&tegra_car 74>;
+		reset-names = "pex", "afi", "pcie_x";
 		status = "disabled";
 
 		pci at 1,0 {
@@ -517,6 +584,8 @@
 		phy_type = "utmi";
 		nvidia,has-legacy-mode;
 		clocks = <&tegra_car TEGRA20_CLK_USBD>;
+		resets = <&tegra_car 22>;
+		reset-names = "usb";
 		nvidia,needs-double-reset;
 		nvidia,phy = <&phy1>;
 		status = "disabled";
@@ -548,6 +617,8 @@
 		interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
 		phy_type = "ulpi";
 		clocks = <&tegra_car TEGRA20_CLK_USB2>;
+		resets = <&tegra_car 58>;
+		reset-names = "usb";
 		nvidia,phy = <&phy2>;
 		status = "disabled";
 	};
@@ -569,6 +640,8 @@
 		interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
 		phy_type = "utmi";
 		clocks = <&tegra_car TEGRA20_CLK_USB3>;
+		resets = <&tegra_car 59>;
+		reset-names = "usb";
 		nvidia,phy = <&phy3>;
 		status = "disabled";
 	};
@@ -597,6 +670,8 @@
 		reg = <0xc8000000 0x200>;
 		interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA20_CLK_SDMMC1>;
+		resets = <&tegra_car 14>;
+		reset-names = "sdhci";
 		status = "disabled";
 	};
 
@@ -605,6 +680,8 @@
 		reg = <0xc8000200 0x200>;
 		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA20_CLK_SDMMC2>;
+		resets = <&tegra_car 9>;
+		reset-names = "sdhci";
 		status = "disabled";
 	};
 
@@ -613,6 +690,8 @@
 		reg = <0xc8000400 0x200>;
 		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA20_CLK_SDMMC3>;
+		resets = <&tegra_car 69>;
+		reset-names = "sdhci";
 		status = "disabled";
 	};
 
@@ -621,6 +700,8 @@
 		reg = <0xc8000600 0x200>;
 		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA20_CLK_SDMMC4>;
+		resets = <&tegra_car 15>;
+		reset-names = "sdhci";
 		status = "disabled";
 	};
 
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 2bd55cfd88ad..95635e54bd34 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -44,6 +44,10 @@
 			 <&tegra_car TEGRA30_CLK_PLL_E>,
 			 <&tegra_car TEGRA30_CLK_CML0>;
 		clock-names = "pex", "afi", "pcie_xclk", "pll_e", "cml";
+		resets = <&tegra_car 70>,
+		         <&tegra_car 72>,
+		         <&tegra_car 74>;
+		reset-names = "pex", "afi", "pcie_x";
 		status = "disabled";
 
 		pci at 1,0 {
@@ -92,6 +96,8 @@
 		interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>, /* syncpt */
 			     <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>; /* general */
 		clocks = <&tegra_car TEGRA30_CLK_HOST1X>;
+		resets = <&tegra_car 28>;
+		reset-names = "host1x";
 
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -103,6 +109,8 @@
 			reg = <0x54040000 0x00040000>;
 			interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&tegra_car TEGRA30_CLK_MPE>;
+			resets = <&tegra_car 60>;
+			reset-names = "mpe";
 		};
 
 		vi {
@@ -110,6 +118,8 @@
 			reg = <0x54080000 0x00040000>;
 			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&tegra_car TEGRA30_CLK_VI>;
+			resets = <&tegra_car 164>;
+			reset-names = "vi";
 		};
 
 		epp {
@@ -117,6 +127,8 @@
 			reg = <0x540c0000 0x00040000>;
 			interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&tegra_car TEGRA30_CLK_EPP>;
+			resets = <&tegra_car 19>;
+			reset-names = "epp";
 		};
 
 		isp {
@@ -124,12 +136,16 @@
 			reg = <0x54100000 0x00040000>;
 			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&tegra_car TEGRA30_CLK_ISP>;
+			resets = <&tegra_car 23>;
+			reset-names = "isp";
 		};
 
 		gr2d {
 			compatible = "nvidia,tegra30-gr2d";
 			reg = <0x54140000 0x00040000>;
 			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&tegra_car 21>;
+			reset-names = "2d";
 			clocks = <&tegra_car TEGRA30_CLK_GR2D>;
 		};
 
@@ -139,6 +155,9 @@
 			clocks = <&tegra_car TEGRA30_CLK_GR3D
 				  &tegra_car TEGRA30_CLK_GR3D2>;
 			clock-names = "3d", "3d2";
+			resets = <&tegra_car 24>,
+			         <&tegra_car 98>;
+			reset-names = "3d", "3d2";
 		};
 
 		dc at 54200000 {
@@ -148,6 +167,8 @@
 			clocks = <&tegra_car TEGRA30_CLK_DISP1>,
 				 <&tegra_car TEGRA30_CLK_PLL_P>;
 			clock-names = "disp1", "parent";
+			resets = <&tegra_car 27>;
+			reset-names = "dc";
 
 			rgb {
 				status = "disabled";
@@ -161,6 +182,8 @@
 			clocks = <&tegra_car TEGRA30_CLK_DISP2>,
 				 <&tegra_car TEGRA30_CLK_PLL_P>;
 			clock-names = "disp2", "parent";
+			resets = <&tegra_car 26>;
+			reset-names = "dc";
 
 			rgb {
 				status = "disabled";
@@ -174,6 +197,8 @@
 			clocks = <&tegra_car TEGRA30_CLK_HDMI>,
 				 <&tegra_car TEGRA30_CLK_PLL_D2_OUT0>;
 			clock-names = "hdmi", "parent";
+			resets = <&tegra_car 51>;
+			reset-names = "hdmi";
 			status = "disabled";
 		};
 
@@ -189,6 +214,8 @@
 			compatible = "nvidia,tegra30-dsi";
 			reg = <0x54300000 0x00040000>;
 			clocks = <&tegra_car TEGRA30_CLK_DSIA>;
+			resets = <&tegra_car 48>;
+			reset-names = "dsi";
 			status = "disabled";
 		};
 	};
@@ -234,6 +261,7 @@
 		compatible = "nvidia,tegra30-car";
 		reg = <0x60006000 0x1000>;
 		#clock-cells = <1>;
+		#reset-cells = <1>;
 	};
 
 	apbdma: dma {
@@ -272,6 +300,8 @@
 			     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA30_CLK_APBDMA>;
+		resets = <&tegra_car 34>;
+		reset-names = "dma";
 	};
 
 	ahb: ahb {
@@ -317,6 +347,8 @@
 		interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 		nvidia,dma-request-selector = <&apbdma 8>;
 		clocks = <&tegra_car TEGRA30_CLK_UARTA>;
+		resets = <&tegra_car 6>;
+		reset-names = "serial";
 		status = "disabled";
 	};
 
@@ -327,6 +359,8 @@
 		interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 		nvidia,dma-request-selector = <&apbdma 9>;
 		clocks = <&tegra_car TEGRA30_CLK_UARTB>;
+		resets = <&tegra_car 7>;
+		reset-names = "serial";
 		status = "disabled";
 	};
 
@@ -337,6 +371,8 @@
 		interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
 		nvidia,dma-request-selector = <&apbdma 10>;
 		clocks = <&tegra_car TEGRA30_CLK_UARTC>;
+		resets = <&tegra_car 55>;
+		reset-names = "serial";
 		status = "disabled";
 	};
 
@@ -347,6 +383,8 @@
 		interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
 		nvidia,dma-request-selector = <&apbdma 19>;
 		clocks = <&tegra_car TEGRA30_CLK_UARTD>;
+		resets = <&tegra_car 65>;
+		reset-names = "serial";
 		status = "disabled";
 	};
 
@@ -357,6 +395,8 @@
 		interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
 		nvidia,dma-request-selector = <&apbdma 20>;
 		clocks = <&tegra_car TEGRA30_CLK_UARTE>;
+		resets = <&tegra_car 66>;
+		reset-names = "serial";
 		status = "disabled";
 	};
 
@@ -365,6 +405,8 @@
 		reg = <0x7000a000 0x100>;
 		#pwm-cells = <2>;
 		clocks = <&tegra_car TEGRA30_CLK_PWM>;
+		resets = <&tegra_car 17>;
+		reset-names = "pwm";
 		status = "disabled";
 	};
 
@@ -384,6 +426,8 @@
 		clocks = <&tegra_car TEGRA30_CLK_I2C1>,
 			 <&tegra_car TEGRA30_CLK_PLL_P_OUT3>;
 		clock-names = "div-clk", "fast-clk";
+		resets = <&tegra_car 12>;
+		reset-names = "i2c";
 		status = "disabled";
 	};
 
@@ -396,6 +440,8 @@
 		clocks = <&tegra_car TEGRA30_CLK_I2C2>,
 			 <&tegra_car TEGRA30_CLK_PLL_P_OUT3>;
 		clock-names = "div-clk", "fast-clk";
+		resets = <&tegra_car 54>;
+		reset-names = "i2c";
 		status = "disabled";
 	};
 
@@ -408,6 +454,8 @@
 		clocks = <&tegra_car TEGRA30_CLK_I2C3>,
 			 <&tegra_car TEGRA30_CLK_PLL_P_OUT3>;
 		clock-names = "div-clk", "fast-clk";
+		resets = <&tegra_car 67>;
+		reset-names = "i2c";
 		status = "disabled";
 	};
 
@@ -419,6 +467,8 @@
 		#size-cells = <0>;
 		clocks = <&tegra_car TEGRA30_CLK_I2C4>,
 			 <&tegra_car TEGRA30_CLK_PLL_P_OUT3>;
+		resets = <&tegra_car 103>;
+		reset-names = "i2c";
 		clock-names = "div-clk", "fast-clk";
 		status = "disabled";
 	};
@@ -432,6 +482,8 @@
 		clocks = <&tegra_car TEGRA30_CLK_I2C5>,
 			 <&tegra_car TEGRA30_CLK_PLL_P_OUT3>;
 		clock-names = "div-clk", "fast-clk";
+		resets = <&tegra_car 47>;
+		reset-names = "i2c";
 		status = "disabled";
 	};
 
@@ -443,6 +495,8 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		clocks = <&tegra_car TEGRA30_CLK_SBC1>;
+		resets = <&tegra_car 41>;
+		reset-names = "spi";
 		status = "disabled";
 	};
 
@@ -454,6 +508,8 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		clocks = <&tegra_car TEGRA30_CLK_SBC2>;
+		resets = <&tegra_car 44>;
+		reset-names = "spi";
 		status = "disabled";
 	};
 
@@ -465,6 +521,8 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		clocks = <&tegra_car TEGRA30_CLK_SBC3>;
+		resets = <&tegra_car 46>;
+		reset-names = "spi";
 		status = "disabled";
 	};
 
@@ -476,6 +534,8 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		clocks = <&tegra_car TEGRA30_CLK_SBC4>;
+		resets = <&tegra_car 68>;
+		reset-names = "spi";
 		status = "disabled";
 	};
 
@@ -487,6 +547,8 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		clocks = <&tegra_car TEGRA30_CLK_SBC5>;
+		resets = <&tegra_car 104>;
+		reset-names = "spi";
 		status = "disabled";
 	};
 
@@ -498,6 +560,8 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		clocks = <&tegra_car TEGRA30_CLK_SBC6>;
+		resets = <&tegra_car 106>;
+		reset-names = "spi";
 		status = "disabled";
 	};
 
@@ -506,6 +570,8 @@
 		reg = <0x7000e200 0x100>;
 		interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA30_CLK_KBC>;
+		resets = <&tegra_car 36>;
+		reset-names = "kbc";
 		status = "disabled";
 	};
 
@@ -555,6 +621,20 @@
 		clock-names = "d_audio", "apbif", "i2s0", "i2s1", "i2s2",
 			      "i2s3", "i2s4", "dam0", "dam1", "dam2",
 			      "spdif_in";
+		resets = <&tegra_car 106>, /* d_audio */
+			 <&tegra_car 107>, /* apbif */
+			 <&tegra_car 30>,  /* i2s0 */
+			 <&tegra_car 11>,  /* i2s1 */
+			 <&tegra_car 18>,  /* i2s2 */
+			 <&tegra_car 101>, /* i2s3 */
+			 <&tegra_car 102>, /* i2s4 */
+			 <&tegra_car 108>, /* dam0 */
+			 <&tegra_car 109>, /* dam1 */
+			 <&tegra_car 110>, /* dam2 */
+			 <&tegra_car 10>;  /* spdif */
+		reset-names = "d_audio", "apbif", "i2s0", "i2s1", "i2s2",
+			      "i2s3", "i2s4", "dam0", "dam1", "dam2",
+			      "spdif";
 		ranges;
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -564,6 +644,8 @@
 			reg = <0x70080300 0x100>;
 			nvidia,ahub-cif-ids = <4 4>;
 			clocks = <&tegra_car TEGRA30_CLK_I2S0>;
+			resets = <&tegra_car 30>;
+			reset-names = "i2s";
 			status = "disabled";
 		};
 
@@ -572,6 +654,8 @@
 			reg = <0x70080400 0x100>;
 			nvidia,ahub-cif-ids = <5 5>;
 			clocks = <&tegra_car TEGRA30_CLK_I2S1>;
+			resets = <&tegra_car 11>;
+			reset-names = "i2s";
 			status = "disabled";
 		};
 
@@ -580,6 +664,8 @@
 			reg = <0x70080500 0x100>;
 			nvidia,ahub-cif-ids = <6 6>;
 			clocks = <&tegra_car TEGRA30_CLK_I2S2>;
+			resets = <&tegra_car 18>;
+			reset-names = "i2s";
 			status = "disabled";
 		};
 
@@ -588,6 +674,8 @@
 			reg = <0x70080600 0x100>;
 			nvidia,ahub-cif-ids = <7 7>;
 			clocks = <&tegra_car TEGRA30_CLK_I2S3>;
+			resets = <&tegra_car 101>;
+			reset-names = "i2s";
 			status = "disabled";
 		};
 
@@ -596,6 +684,8 @@
 			reg = <0x70080700 0x100>;
 			nvidia,ahub-cif-ids = <8 8>;
 			clocks = <&tegra_car TEGRA30_CLK_I2S4>;
+			resets = <&tegra_car 102>;
+			reset-names = "i2s";
 			status = "disabled";
 		};
 	};
@@ -605,6 +695,8 @@
 		reg = <0x78000000 0x200>;
 		interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA30_CLK_SDMMC1>;
+		resets = <&tegra_car 14>;
+		reset-names = "sdhci";
 		status = "disabled";
 	};
 
@@ -613,6 +705,8 @@
 		reg = <0x78000200 0x200>;
 		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA30_CLK_SDMMC2>;
+		resets = <&tegra_car 9>;
+		reset-names = "sdhci";
 		status = "disabled";
 	};
 
@@ -621,6 +715,8 @@
 		reg = <0x78000400 0x200>;
 		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA30_CLK_SDMMC3>;
+		resets = <&tegra_car 69>;
+		reset-names = "sdhci";
 		status = "disabled";
 	};
 
@@ -629,6 +725,8 @@
 		reg = <0x78000600 0x200>;
 		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA30_CLK_SDMMC4>;
+		resets = <&tegra_car 15>;
+		reset-names = "sdhci";
 		status = "disabled";
 	};
 
@@ -638,6 +736,8 @@
 		interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 		phy_type = "utmi";
 		clocks = <&tegra_car TEGRA30_CLK_USBD>;
+		resets = <&tegra_car 22>;
+		reset-names = "usb";
 		nvidia,needs-double-reset;
 		nvidia,phy = <&phy1>;
 		status = "disabled";
@@ -671,6 +771,8 @@
 		interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
 		phy_type = "ulpi";
 		clocks = <&tegra_car TEGRA30_CLK_USB2>;
+		resets = <&tegra_car 58>;
+		reset-names = "usb";
 		nvidia,phy = <&phy2>;
 		status = "disabled";
 	};
@@ -692,6 +794,8 @@
 		interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
 		phy_type = "utmi";
 		clocks = <&tegra_car TEGRA30_CLK_USB3>;
+		resets = <&tegra_car 59>;
+		reset-names = "usb";
 		nvidia,phy = <&phy3>;
 		status = "disabled";
 	};
-- 
1.8.1.5
