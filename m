From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 15 Nov 2013 13:54:00 -0700
Subject: [PATCH 05/31] ARM: tegra: update DT files to add DMA properties
In-Reply-To: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1384548866-13141-6-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

This patch switches the Tegra DT files to use the standard DMA DT bindings
rather than custom properties. Note that the legacy properties are not yet
removed; the drivers must be updated to use the new properties first.

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
 arch/arm/boot/dts/tegra114.dtsi | 45 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/tegra20.dtsi  | 35 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/tegra30.dtsi  | 39 +++++++++++++++++++++++++++++++++++
 3 files changed, 119 insertions(+)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index c40dbdcb3741..b4f2e62909a7 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -84,6 +84,7 @@
 		clocks = <&tegra_car TEGRA114_CLK_APBDMA>;
 		resets = <&tegra_car 34>;
 		reset-names = "dma";
+		#dma-cells = <1>;
 	};
 
 	ahb: ahb {
@@ -131,6 +132,8 @@
 		clocks = <&tegra_car TEGRA114_CLK_UARTA>;
 		resets = <&tegra_car 6>;
 		reset-names = "serial";
+		dmas = <&apbdma 8>, <&apbdma 8>;
+		dma-names = "rx", "tx";
 		status = "disabled";
 	};
 
@@ -143,6 +146,8 @@
 		clocks = <&tegra_car TEGRA114_CLK_UARTB>;
 		resets = <&tegra_car 7>;
 		reset-names = "serial";
+		dmas = <&apbdma 9>, <&apbdma 9>;
+		dma-names = "rx", "tx";
 		status = "disabled";
 	};
 
@@ -155,6 +160,8 @@
 		clocks = <&tegra_car TEGRA114_CLK_UARTC>;
 		resets = <&tegra_car 55>;
 		reset-names = "serial";
+		dmas = <&apbdma 10>, <&apbdma 10>;
+		dma-names = "rx", "tx";
 		status = "disabled";
 	};
 
@@ -167,6 +174,8 @@
 		clocks = <&tegra_car TEGRA114_CLK_UARTD>;
 		resets = <&tegra_car 65>;
 		reset-names = "serial";
+		dmas = <&apbdma 19>, <&apbdma 19>;
+		dma-names = "rx", "tx";
 		status = "disabled";
 	};
 
@@ -190,6 +199,8 @@
 		clock-names = "div-clk";
 		resets = <&tegra_car 12>;
 		reset-names = "i2c";
+		dmas = <&apbdma 21>, <&apbdma 21>;
+		dma-names = "rx", "tx";
 		status = "disabled";
 	};
 
@@ -203,6 +214,8 @@
 		clock-names = "div-clk";
 		resets = <&tegra_car 54>;
 		reset-names = "i2c";
+		dmas = <&apbdma 22>, <&apbdma 22>;
+		dma-names = "rx", "tx";
 		status = "disabled";
 	};
 
@@ -216,6 +229,8 @@
 		clock-names = "div-clk";
 		resets = <&tegra_car 67>;
 		reset-names = "i2c";
+		dmas = <&apbdma 23>, <&apbdma 23>;
+		dma-names = "rx", "tx";
 		status = "disabled";
 	};
 
@@ -229,6 +244,8 @@
 		clock-names = "div-clk";
 		resets = <&tegra_car 103>;
 		reset-names = "i2c";
+		dmas = <&apbdma 26>, <&apbdma 26>;
+		dma-names = "rx", "tx";
 		status = "disabled";
 	};
 
@@ -242,6 +259,8 @@
 		clock-names = "div-clk";
 		resets = <&tegra_car 47>;
 		reset-names = "i2c";
+		dmas = <&apbdma 24>, <&apbdma 24>;
+		dma-names = "rx", "tx";
 		status = "disabled";
 	};
 
@@ -256,6 +275,8 @@
 		clock-names = "spi";
 		resets = <&tegra_car 41>;
 		reset-names = "spi";
+		dmas = <&apbdma 15>, <&apbdma 15>;
+		dma-names = "rx", "tx";
 		status = "disabled";
 	};
 
@@ -270,6 +291,8 @@
 		clock-names = "spi";
 		resets = <&tegra_car 44>;
 		reset-names = "spi";
+		dmas = <&apbdma 16>, <&apbdma 16>;
+		dma-names = "rx", "tx";
 		status = "disabled";
 	};
 
@@ -284,6 +307,8 @@
 		clock-names = "spi";
 		resets = <&tegra_car 46>;
 		reset-names = "spi";
+		dmas = <&apbdma 17>, <&apbdma 17>;
+		dma-names = "rx", "tx";
 		status = "disabled";
 	};
 
@@ -298,6 +323,8 @@
 		clock-names = "spi";
 		resets = <&tegra_car 68>;
 		reset-names = "spi";
+		dmas = <&apbdma 18>, <&apbdma 18>;
+		dma-names = "rx", "tx";
 		status = "disabled";
 	};
 
@@ -312,6 +339,8 @@
 		clock-names = "spi";
 		resets = <&tegra_car 104>;
 		reset-names = "spi";
+		dmas = <&apbdma 27>, <&apbdma 27>;
+		dma-names = "rx", "tx";
 		status = "disabled";
 	};
 
@@ -326,6 +355,8 @@
 		clock-names = "spi";
 		resets = <&tegra_car 105>;
 		reset-names = "spi";
+		dmas = <&apbdma 28>, <&apbdma 28>;
+		dma-names = "rx", "tx";
 		status = "disabled";
 	};
 
@@ -406,6 +437,20 @@
 		reset-names = "d_audio", "apbif", "i2s0", "i2s1", "i2s2",
 			      "i2s3", "i2s4", "dam0", "dam1", "dam2",
 			      "spdif", "amx", "adx";
+		dmas = <&apbdma 1>, <&apbdma 1>,
+		       <&apbdma 2>, <&apbdma 2>,
+		       <&apbdma 3>, <&apbdma 3>,
+		       <&apbdma 4>, <&apbdma 4>,
+		       <&apbdma 6>, <&apbdma 6>,
+		       <&apbdma 7>, <&apbdma 7>,
+		       <&apbdma 12>, <&apbdma 12>,
+		       <&apbdma 13>, <&apbdma 13>,
+		       <&apbdma 14>, <&apbdma 14>,
+		       <&apbdma 29>, <&apbdma 29>;
+		dma-names = "rx0", "tx0", "rx1", "tx1", "rx2", "tx2",
+			    "rx3", "tx3", "rx4", "tx4", "rx5", "tx5",
+			    "rx6", "tx6", "rx7", "tx7", "rx8", "tx8",
+			    "rx9", "tx9";
 		ranges;
 		#address-cells = <1>;
 		#size-cells = <1>;
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 159facbce524..c53e02e08310 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -207,6 +207,7 @@
 		clocks = <&tegra_car TEGRA20_CLK_APBDMA>;
 		resets = <&tegra_car 34>;
 		reset-names = "dma";
+		#dma-cells = <1>;
 	};
 
 	ahb {
@@ -251,6 +252,8 @@
 		clocks = <&tegra_car TEGRA20_CLK_AC97>;
 		resets = <&tegra_car 3>;
 		reset-names = "ac97";
+		dmas = <&apbdma 12>, <&apbdma 12>;
+		dma-names = "rx", "tx";
 		status = "disabled";
 	};
 
@@ -262,6 +265,8 @@
 		clocks = <&tegra_car TEGRA20_CLK_I2S1>;
 		resets = <&tegra_car 11>;
 		reset-names = "i2s";
+		dmas = <&apbdma 2>, <&apbdma 2>;
+		dma-names = "rx", "tx";
 		status = "disabled";
 	};
 
@@ -273,6 +278,8 @@
 		clocks = <&tegra_car TEGRA20_CLK_I2S2>;
 		resets = <&tegra_car 18>;
 		reset-names = "i2s";
+		dmas = <&apbdma 1>, <&apbdma 1>;
+		dma-names = "rx", "tx";
 		status = "disabled";
 	};
 
@@ -292,6 +299,8 @@
 		clocks = <&tegra_car TEGRA20_CLK_UARTA>;
 		resets = <&tegra_car 6>;
 		reset-names = "serial";
+		dmas = <&apbdma 8>, <&apbdma 8>;
+		dma-names = "rx", "tx";
 		status = "disabled";
 	};
 
@@ -304,6 +313,8 @@
 		clocks = <&tegra_car TEGRA20_CLK_UARTB>;
 		resets = <&tegra_car 7>;
 		reset-names = "serial";
+		dmas = <&apbdma 9>, <&apbdma 9>;
+		dma-names = "rx", "tx";
 		status = "disabled";
 	};
 
@@ -316,6 +327,8 @@
 		clocks = <&tegra_car TEGRA20_CLK_UARTC>;
 		resets = <&tegra_car 55>;
 		reset-names = "serial";
+		dmas = <&apbdma 10>, <&apbdma 10>;
+		dma-names = "rx", "tx";
 		status = "disabled";
 	};
 
@@ -328,6 +341,8 @@
 		clocks = <&tegra_car TEGRA20_CLK_UARTD>;
 		resets = <&tegra_car 65>;
 		reset-names = "serial";
+		dmas = <&apbdma 19>, <&apbdma 19>;
+		dma-names = "rx", "tx";
 		status = "disabled";
 	};
 
@@ -340,6 +355,8 @@
 		clocks = <&tegra_car TEGRA20_CLK_UARTE>;
 		resets = <&tegra_car 66>;
 		reset-names = "serial";
+		dmas = <&apbdma 20>, <&apbdma 20>;
+		dma-names = "rx", "tx";
 		status = "disabled";
 	};
 
@@ -371,6 +388,8 @@
 		clock-names = "div-clk", "fast-clk";
 		resets = <&tegra_car 12>;
 		reset-names = "i2c";
+		dmas = <&apbdma 21>, <&apbdma 21>;
+		dma-names = "rx", "tx";
 		status = "disabled";
 	};
 
@@ -384,6 +403,8 @@
 		clocks = <&tegra_car TEGRA20_CLK_SPI>;
 		resets = <&tegra_car 43>;
 		reset-names = "spi";
+		dmas = <&apbdma 11>, <&apbdma 11>;
+		dma-names = "rx", "tx";
 		status = "disabled";
 	};
 
@@ -398,6 +419,8 @@
 		clock-names = "div-clk", "fast-clk";
 		resets = <&tegra_car 54>;
 		reset-names = "i2c";
+		dmas = <&apbdma 22>, <&apbdma 22>;
+		dma-names = "rx", "tx";
 		status = "disabled";
 	};
 
@@ -412,6 +435,8 @@
 		clock-names = "div-clk", "fast-clk";
 		resets = <&tegra_car 67>;
 		reset-names = "i2c";
+		dmas = <&apbdma 23>, <&apbdma 23>;
+		dma-names = "rx", "tx";
 		status = "disabled";
 	};
 
@@ -426,6 +451,8 @@
 		clock-names = "div-clk", "fast-clk";
 		resets = <&tegra_car 47>;
 		reset-names = "i2c";
+		dmas = <&apbdma 24>, <&apbdma 24>;
+		dma-names = "rx", "tx";
 		status = "disabled";
 	};
 
@@ -439,6 +466,8 @@
 		clocks = <&tegra_car TEGRA20_CLK_SBC1>;
 		resets = <&tegra_car 41>;
 		reset-names = "spi";
+		dmas = <&apbdma 15>, <&apbdma 15>;
+		dma-names = "rx", "tx";
 		status = "disabled";
 	};
 
@@ -452,6 +481,8 @@
 		clocks = <&tegra_car TEGRA20_CLK_SBC2>;
 		resets = <&tegra_car 44>;
 		reset-names = "spi";
+		dmas = <&apbdma 16>, <&apbdma 16>;
+		dma-names = "rx", "tx";
 		status = "disabled";
 	};
 
@@ -465,6 +496,8 @@
 		clocks = <&tegra_car TEGRA20_CLK_SBC3>;
 		resets = <&tegra_car 46>;
 		reset-names = "spi";
+		dmas = <&apbdma 17>, <&apbdma 17>;
+		dma-names = "rx", "tx";
 		status = "disabled";
 	};
 
@@ -478,6 +511,8 @@
 		clocks = <&tegra_car TEGRA20_CLK_SBC4>;
 		resets = <&tegra_car 68>;
 		reset-names = "spi";
+		dmas = <&apbdma 18>, <&apbdma 18>;
+		dma-names = "rx", "tx";
 		status = "disabled";
 	};
 
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 95635e54bd34..0e69dd9f33e6 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -302,6 +302,7 @@
 		clocks = <&tegra_car TEGRA30_CLK_APBDMA>;
 		resets = <&tegra_car 34>;
 		reset-names = "dma";
+		#dma-cells = <1>;
 	};
 
 	ahb: ahb {
@@ -349,6 +350,8 @@
 		clocks = <&tegra_car TEGRA30_CLK_UARTA>;
 		resets = <&tegra_car 6>;
 		reset-names = "serial";
+		dmas = <&apbdma 8>, <&apbdma 8>;
+		dma-names = "rx", "tx";
 		status = "disabled";
 	};
 
@@ -361,6 +364,8 @@
 		clocks = <&tegra_car TEGRA30_CLK_UARTB>;
 		resets = <&tegra_car 7>;
 		reset-names = "serial";
+		dmas = <&apbdma 9>, <&apbdma 9>;
+		dma-names = "rx", "tx";
 		status = "disabled";
 	};
 
@@ -373,6 +378,8 @@
 		clocks = <&tegra_car TEGRA30_CLK_UARTC>;
 		resets = <&tegra_car 55>;
 		reset-names = "serial";
+		dmas = <&apbdma 10>, <&apbdma 10>;
+		dma-names = "rx", "tx";
 		status = "disabled";
 	};
 
@@ -385,6 +392,8 @@
 		clocks = <&tegra_car TEGRA30_CLK_UARTD>;
 		resets = <&tegra_car 65>;
 		reset-names = "serial";
+		dmas = <&apbdma 19>, <&apbdma 19>;
+		dma-names = "rx", "tx";
 		status = "disabled";
 	};
 
@@ -397,6 +406,8 @@
 		clocks = <&tegra_car TEGRA30_CLK_UARTE>;
 		resets = <&tegra_car 66>;
 		reset-names = "serial";
+		dmas = <&apbdma 20>, <&apbdma 20>;
+		dma-names = "rx", "tx";
 		status = "disabled";
 	};
 
@@ -428,6 +439,8 @@
 		clock-names = "div-clk", "fast-clk";
 		resets = <&tegra_car 12>;
 		reset-names = "i2c";
+		dmas = <&apbdma 21>, <&apbdma 21>;
+		dma-names = "rx", "tx";
 		status = "disabled";
 	};
 
@@ -442,6 +455,8 @@
 		clock-names = "div-clk", "fast-clk";
 		resets = <&tegra_car 54>;
 		reset-names = "i2c";
+		dmas = <&apbdma 22>, <&apbdma 22>;
+		dma-names = "rx", "tx";
 		status = "disabled";
 	};
 
@@ -456,6 +471,8 @@
 		clock-names = "div-clk", "fast-clk";
 		resets = <&tegra_car 67>;
 		reset-names = "i2c";
+		dmas = <&apbdma 23>, <&apbdma 23>;
+		dma-names = "rx", "tx";
 		status = "disabled";
 	};
 
@@ -470,6 +487,8 @@
 		resets = <&tegra_car 103>;
 		reset-names = "i2c";
 		clock-names = "div-clk", "fast-clk";
+		dmas = <&apbdma 26>, <&apbdma 26>;
+		dma-names = "rx", "tx";
 		status = "disabled";
 	};
 
@@ -484,6 +503,8 @@
 		clock-names = "div-clk", "fast-clk";
 		resets = <&tegra_car 47>;
 		reset-names = "i2c";
+		dmas = <&apbdma 24>, <&apbdma 24>;
+		dma-names = "rx", "tx";
 		status = "disabled";
 	};
 
@@ -497,6 +518,8 @@
 		clocks = <&tegra_car TEGRA30_CLK_SBC1>;
 		resets = <&tegra_car 41>;
 		reset-names = "spi";
+		dmas = <&apbdma 15>, <&apbdma 15>;
+		dma-names = "rx", "tx";
 		status = "disabled";
 	};
 
@@ -510,6 +533,8 @@
 		clocks = <&tegra_car TEGRA30_CLK_SBC2>;
 		resets = <&tegra_car 44>;
 		reset-names = "spi";
+		dmas = <&apbdma 16>, <&apbdma 16>;
+		dma-names = "rx", "tx";
 		status = "disabled";
 	};
 
@@ -523,6 +548,8 @@
 		clocks = <&tegra_car TEGRA30_CLK_SBC3>;
 		resets = <&tegra_car 46>;
 		reset-names = "spi";
+		dmas = <&apbdma 17>, <&apbdma 17>;
+		dma-names = "rx", "tx";
 		status = "disabled";
 	};
 
@@ -536,6 +563,8 @@
 		clocks = <&tegra_car TEGRA30_CLK_SBC4>;
 		resets = <&tegra_car 68>;
 		reset-names = "spi";
+		dmas = <&apbdma 18>, <&apbdma 18>;
+		dma-names = "rx", "tx";
 		status = "disabled";
 	};
 
@@ -549,6 +578,8 @@
 		clocks = <&tegra_car TEGRA30_CLK_SBC5>;
 		resets = <&tegra_car 104>;
 		reset-names = "spi";
+		dmas = <&apbdma 27>, <&apbdma 27>;
+		dma-names = "rx", "tx";
 		status = "disabled";
 	};
 
@@ -562,6 +593,8 @@
 		clocks = <&tegra_car TEGRA30_CLK_SBC6>;
 		resets = <&tegra_car 106>;
 		reset-names = "spi";
+		dmas = <&apbdma 28>, <&apbdma 28>;
+		dma-names = "rx", "tx";
 		status = "disabled";
 	};
 
@@ -635,6 +668,12 @@
 		reset-names = "d_audio", "apbif", "i2s0", "i2s1", "i2s2",
 			      "i2s3", "i2s4", "dam0", "dam1", "dam2",
 			      "spdif";
+		dmas = <&apbdma 1>, <&apbdma 1>,
+		       <&apbdma 2>, <&apbdma 2>,
+		       <&apbdma 3>, <&apbdma 3>,
+		       <&apbdma 4>, <&apbdma 4>;
+		dma-names = "rx0", "tx0", "rx1", "tx1", "rx2", "tx2",
+			    "rx3", "tx3";
 		ranges;
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
1.8.1.5
