From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Fri, 11 Jan 2013 13:31:22 +0530
Subject: [PATCH v2 03/10] ARM: dt: tegra30: Add clock information
In-Reply-To: <1357891289-23500-1-git-send-email-pgaikwad@nvidia.com>
References: <1357891289-23500-1-git-send-email-pgaikwad@nvidia.com>
Message-ID: <1357891289-23500-3-git-send-email-pgaikwad@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clock information to device nodes.

Signed-off-by: Prashant Gaikwad <pgaikwad@nvidia.com>
---
 arch/arm/boot/dts/tegra30.dtsi |   55 +++++++++++++++++++++++++++++++++++++++-
 1 files changed, 54 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 6765646..c3e129a 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -9,6 +9,7 @@
 		reg = <0x50000000 0x00024000>;
 		interrupts = <0 65 0x04   /* mpcore syncpt */
 			      0 67 0x04>; /* mpcore general */
+		clocks = <&tegra_car 28>;
 
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -19,41 +20,49 @@
 			compatible = "nvidia,tegra30-mpe";
 			reg = <0x54040000 0x00040000>;
 			interrupts = <0 68 0x04>;
+			clocks = <&tegra_car 60>;
 		};
 
 		vi {
 			compatible = "nvidia,tegra30-vi";
 			reg = <0x54080000 0x00040000>;
 			interrupts = <0 69 0x04>;
+			clocks = <&tegra_car 164>;
 		};
 
 		epp {
 			compatible = "nvidia,tegra30-epp";
 			reg = <0x540c0000 0x00040000>;
 			interrupts = <0 70 0x04>;
+			clocks = <&tegra_car 19>;
 		};
 
 		isp {
 			compatible = "nvidia,tegra30-isp";
 			reg = <0x54100000 0x00040000>;
 			interrupts = <0 71 0x04>;
+			clocks = <&tegra_car 23>;
 		};
 
 		gr2d {
 			compatible = "nvidia,tegra30-gr2d";
 			reg = <0x54140000 0x00040000>;
 			interrupts = <0 72 0x04>;
+			clocks = <&tegra_car 21>;
 		};
 
 		gr3d {
 			compatible = "nvidia,tegra30-gr3d";
 			reg = <0x54180000 0x00040000>;
+			clocks = <&tegra_car 24>;
 		};
 
 		dc at 54200000 {
 			compatible = "nvidia,tegra30-dc";
 			reg = <0x54200000 0x00040000>;
 			interrupts = <0 73 0x04>;
+			clocks = <&tegra_car 27>, <&tegra_car 179>;
+			clock-names = "disp1", "parent";
 
 			rgb {
 				status = "disabled";
@@ -64,6 +73,8 @@
 			compatible = "nvidia,tegra30-dc";
 			reg = <0x54240000 0x00040000>;
 			interrupts = <0 74 0x04>;
+			clocks = <&tegra_car 26>, <&tegra_car 179>;
+			clock-names = "disp2", "parent";
 
 			rgb {
 				status = "disabled";
@@ -75,6 +86,8 @@
 			reg = <0x54280000 0x00040000>;
 			interrupts = <0 75 0x04>;
 			status = "disabled";
+			clocks = <&tegra_car 51>, <&tegra_car 189>;
+			clock-names = "hdmi", "parent";
 		};
 
 		tvo {
@@ -82,12 +95,14 @@
 			reg = <0x542c0000 0x00040000>;
 			interrupts = <0 76 0x04>;
 			status = "disabled";
+			clocks = <&tegra_car 169>;
 		};
 
 		dsi {
 			compatible = "nvidia,tegra30-dsi";
 			reg = <0x54300000 0x00040000>;
 			status = "disabled";
+			clocks = <&tegra_car 48>;
 		};
 	};
 
@@ -166,6 +181,7 @@
 			      0 141 0x04
 			      0 142 0x04
 			      0 143 0x04>;
+		clocks = <&tegra_car 34>;
 	};
 
 	ahb: ahb {
@@ -202,6 +218,7 @@
 		reg-shift = <2>;
 		interrupts = <0 36 0x04>;
 		status = "disabled";
+		clocks = <&tegra_car 6>;
 	};
 
 	serial at 70006040 {
@@ -210,6 +227,7 @@
 		reg-shift = <2>;
 		interrupts = <0 37 0x04>;
 		status = "disabled";
+		clocks = <&tegra_car 160>;
 	};
 
 	serial at 70006200 {
@@ -218,6 +236,7 @@
 		reg-shift = <2>;
 		interrupts = <0 46 0x04>;
 		status = "disabled";
+		clocks = <&tegra_car 55>;
 	};
 
 	serial at 70006300 {
@@ -226,6 +245,7 @@
 		reg-shift = <2>;
 		interrupts = <0 90 0x04>;
 		status = "disabled";
+		clocks = <&tegra_car 65>;
 	};
 
 	serial at 70006400 {
@@ -234,12 +254,14 @@
 		reg-shift = <2>;
 		interrupts = <0 91 0x04>;
 		status = "disabled";
+		clocks = <&tegra_car 66>;
 	};
 
 	pwm: pwm {
 		compatible = "nvidia,tegra30-pwm", "nvidia,tegra20-pwm";
 		reg = <0x7000a000 0x100>;
 		#pwm-cells = <2>;
+		clocks = <&tegra_car 17>;
 	};
 
 	rtc {
@@ -255,6 +277,8 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
+		clocks = <&tegra_car 12>, <&tegra_car 182>;
+		clock-names = "div-clk", "fast-clk";
 	};
 
 	i2c at 7000c400 {
@@ -264,6 +288,8 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
+		clocks = <&tegra_car 54>, <&tegra_car 182>;
+		clock-names = "div-clk", "fast-clk";
 	};
 
 	i2c at 7000c500 {
@@ -273,6 +299,8 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
+		clocks = <&tegra_car 67>, <&tegra_car 182>;
+		clock-names = "div-clk", "fast-clk";
 	};
 
 	i2c at 7000c700 {
@@ -282,6 +310,8 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
+		clocks = <&tegra_car 103>, <&tegra_car 182>;
+		clock-names = "div-clk", "fast-clk";
 	};
 
 	i2c at 7000d000 {
@@ -291,6 +321,8 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
+		clocks = <&tegra_car 47>, <&tegra_car 182>;
+		clock-names = "div-clk", "fast-clk";
 	};
 
 	spi at 7000d400 {
@@ -301,6 +333,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
+		clocks = <&tegra_car 41>;
 	};
 
 	spi at 7000d600 {
@@ -311,6 +344,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
+		clocks = <&tegra_car 44>;
 	};
 
 	spi at 7000d800 {
@@ -321,6 +355,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
+		clocks = <&tegra_car 46>;
 	};
 
 	spi at 7000da00 {
@@ -331,6 +366,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
+		clocks = <&tegra_car 68>;
 	};
 
 	spi at 7000dc00 {
@@ -341,6 +377,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
+		clocks = <&tegra_car 104>;
 	};
 
 	spi at 7000de00 {
@@ -351,6 +388,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
+		clocks = <&tegra_car 105>;
 	};
 
 	pmc {
@@ -383,7 +421,13 @@
 		       0x70080200 0x100>;
 		interrupts = <0 103 0x04>;
 		nvidia,dma-request-selector = <&apbdma 1>;
-
+		clocks = <&tegra_car 106>, <&tegra_car 107>, <&tegra_car 30>,
+			 <&tegra_car 11>, <&tegra_car 18>, <&tegra_car 101>,
+			 <&tegra_car 102>, <&tegra_car 108>, <&tegra_car 109>,
+			 <&tegra_car 110>, <&tegra_car 162>;
+		clock-names = "d_audio", "apbif", "i2s0", "i2s1", "i2s2",
+			      "i2s3", "i2s4", "dam0", "dam1", "dam2",
+			      "spdif_in";
 		ranges;
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -393,6 +437,7 @@
 			reg = <0x70080300 0x100>;
 			nvidia,ahub-cif-ids = <4 4>;
 			status = "disabled";
+			clocks = <&tegra_car 30>;
 		};
 
 		tegra_i2s1: i2s at 70080400 {
@@ -400,6 +445,7 @@
 			reg = <0x70080400 0x100>;
 			nvidia,ahub-cif-ids = <5 5>;
 			status = "disabled";
+			clocks = <&tegra_car 11>;
 		};
 
 		tegra_i2s2: i2s at 70080500 {
@@ -407,6 +453,7 @@
 			reg = <0x70080500 0x100>;
 			nvidia,ahub-cif-ids = <6 6>;
 			status = "disabled";
+			clocks = <&tegra_car 18>;
 		};
 
 		tegra_i2s3: i2s at 70080600 {
@@ -414,6 +461,7 @@
 			reg = <0x70080600 0x100>;
 			nvidia,ahub-cif-ids = <7 7>;
 			status = "disabled";
+			clocks = <&tegra_car 101>;
 		};
 
 		tegra_i2s4: i2s at 70080700 {
@@ -421,6 +469,7 @@
 			reg = <0x70080700 0x100>;
 			nvidia,ahub-cif-ids = <8 8>;
 			status = "disabled";
+			clocks = <&tegra_car 102>;
 		};
 	};
 
@@ -429,6 +478,7 @@
 		reg = <0x78000000 0x200>;
 		interrupts = <0 14 0x04>;
 		status = "disabled";
+		clocks = <&tegra_car 14>;
 	};
 
 	sdhci at 78000200 {
@@ -436,6 +486,7 @@
 		reg = <0x78000200 0x200>;
 		interrupts = <0 15 0x04>;
 		status = "disabled";
+		clocks = <&tegra_car 9>;
 	};
 
 	sdhci at 78000400 {
@@ -443,6 +494,7 @@
 		reg = <0x78000400 0x200>;
 		interrupts = <0 19 0x04>;
 		status = "disabled";
+		clocks = <&tegra_car 69>;
 	};
 
 	sdhci at 78000600 {
@@ -450,6 +502,7 @@
 		reg = <0x78000600 0x200>;
 		interrupts = <0 31 0x04>;
 		status = "disabled";
+		clocks = <&tegra_car 15>;
 	};
 
 	pmu {
-- 
1.7.4.1
