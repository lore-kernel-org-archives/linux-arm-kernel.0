From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Fri, 11 Jan 2013 13:31:21 +0530
Subject: [PATCH v2 02/10] ARM: dt: tegra20: Add clock information
In-Reply-To: <1357891289-23500-1-git-send-email-pgaikwad@nvidia.com>
References: <1357891289-23500-1-git-send-email-pgaikwad@nvidia.com>
Message-ID: <1357891289-23500-2-git-send-email-pgaikwad@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clock information to device nodes.

Signed-off-by: Prashant Gaikwad <pgaikwad@nvidia.com>
---
 arch/arm/boot/dts/tegra20.dtsi |   44 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 5b104f1..8ac1544 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -9,6 +9,7 @@
 		reg = <0x50000000 0x00024000>;
 		interrupts = <0 65 0x04   /* mpcore syncpt */
 			      0 67 0x04>; /* mpcore general */
+		clocks = <&tegra_car 28>;
 
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -19,41 +20,49 @@
 			compatible = "nvidia,tegra20-mpe";
 			reg = <0x54040000 0x00040000>;
 			interrupts = <0 68 0x04>;
+			clocks = <&tegra_car 60>;
 		};
 
 		vi {
 			compatible = "nvidia,tegra20-vi";
 			reg = <0x54080000 0x00040000>;
 			interrupts = <0 69 0x04>;
+			clocks = <&tegra_car 100>;
 		};
 
 		epp {
 			compatible = "nvidia,tegra20-epp";
 			reg = <0x540c0000 0x00040000>;
 			interrupts = <0 70 0x04>;
+			clocks = <&tegra_car 19>;
 		};
 
 		isp {
 			compatible = "nvidia,tegra20-isp";
 			reg = <0x54100000 0x00040000>;
 			interrupts = <0 71 0x04>;
+			clocks = <&tegra_car 23>;
 		};
 
 		gr2d {
 			compatible = "nvidia,tegra20-gr2d";
 			reg = <0x54140000 0x00040000>;
 			interrupts = <0 72 0x04>;
+			clocks = <&tegra_car 21>;
 		};
 
 		gr3d {
 			compatible = "nvidia,tegra20-gr3d";
 			reg = <0x54180000 0x00040000>;
+			clocks = <&tegra_car 24>;
 		};
 
 		dc at 54200000 {
 			compatible = "nvidia,tegra20-dc";
 			reg = <0x54200000 0x00040000>;
 			interrupts = <0 73 0x04>;
+			clocks = <&tegra_car 27>, <&tegra_car 121>;
+			clock-names = "disp1", "parent";
 
 			rgb {
 				status = "disabled";
@@ -64,6 +73,8 @@
 			compatible = "nvidia,tegra20-dc";
 			reg = <0x54240000 0x00040000>;
 			interrupts = <0 74 0x04>;
+			clocks = <&tegra_car 26>, <&tegra_car 121>;
+			clock-names = "disp2", "parent";
 
 			rgb {
 				status = "disabled";
@@ -75,6 +86,8 @@
 			reg = <0x54280000 0x00040000>;
 			interrupts = <0 75 0x04>;
 			status = "disabled";
+			clocks = <&tegra_car 51>, <&tegra_car 117>;
+			clock-names = "hdmi", "parent";
 		};
 
 		tvo {
@@ -82,12 +95,14 @@
 			reg = <0x542c0000 0x00040000>;
 			interrupts = <0 76 0x04>;
 			status = "disabled";
+			clocks = <&tegra_car 102>;
 		};
 
 		dsi {
 			compatible = "nvidia,tegra20-dsi";
 			reg = <0x54300000 0x00040000>;
 			status = "disabled";
+			clocks = <&tegra_car 48>;
 		};
 	};
 
@@ -148,6 +163,7 @@
 			      0 117 0x04
 			      0 118 0x04
 			      0 119 0x04>;
+		clocks = <&tegra_car 34>;
 	};
 
 	ahb {
@@ -190,6 +206,7 @@
 		interrupts = <0 13 0x04>;
 		nvidia,dma-request-selector = <&apbdma 2>;
 		status = "disabled";
+		clocks = <&tegra_car 11>;
 	};
 
 	tegra_i2s2: i2s at 70002a00 {
@@ -198,6 +215,7 @@
 		interrupts = <0 3 0x04>;
 		nvidia,dma-request-selector = <&apbdma 1>;
 		status = "disabled";
+		clocks = <&tegra_car 18>;
 	};
 
 	serial at 70006000 {
@@ -206,6 +224,7 @@
 		reg-shift = <2>;
 		interrupts = <0 36 0x04>;
 		status = "disabled";
+		clocks = <&tegra_car 6>;
 	};
 
 	serial at 70006040 {
@@ -214,6 +233,7 @@
 		reg-shift = <2>;
 		interrupts = <0 37 0x04>;
 		status = "disabled";
+		clocks = <&tegra_car 96>;
 	};
 
 	serial at 70006200 {
@@ -222,6 +242,7 @@
 		reg-shift = <2>;
 		interrupts = <0 46 0x04>;
 		status = "disabled";
+		clocks = <&tegra_car 55>;
 	};
 
 	serial at 70006300 {
@@ -230,6 +251,7 @@
 		reg-shift = <2>;
 		interrupts = <0 90 0x04>;
 		status = "disabled";
+		clocks = <&tegra_car 65>;
 	};
 
 	serial at 70006400 {
@@ -238,12 +260,14 @@
 		reg-shift = <2>;
 		interrupts = <0 91 0x04>;
 		status = "disabled";
+		clocks = <&tegra_car 66>;
 	};
 
 	pwm: pwm {
 		compatible = "nvidia,tegra20-pwm";
 		reg = <0x7000a000 0x100>;
 		#pwm-cells = <2>;
+		clocks = <&tegra_car 17>;
 	};
 
 	rtc {
@@ -259,6 +283,8 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
+		clocks = <&tegra_car 12>, <&tegra_car 124>;
+		clock-names = "div-clk", "fast-clk";
 	};
 
 	spi at 7000c380 {
@@ -269,6 +295,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
+		clocks = <&tegra_car 43>;
 	};
 
 	i2c at 7000c400 {
@@ -278,6 +305,8 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
+		clocks = <&tegra_car 54>, <&tegra_car 124>;
+		clock-names = "div-clk", "fast-clk";
 	};
 
 	i2c at 7000c500 {
@@ -287,6 +316,8 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
+		clocks = <&tegra_car 67>, <&tegra_car 124>;
+		clock-names = "div-clk", "fast-clk";
 	};
 
 	i2c at 7000d000 {
@@ -296,6 +327,8 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
+		clocks = <&tegra_car 47>, <&tegra_car 124>;
+		clock-names = "div-clk", "fast-clk";
 	};
 
 	spi at 7000d400 {
@@ -306,6 +339,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
+		clocks = <&tegra_car 41>;
 	};
 
 	spi at 7000d600 {
@@ -316,6 +350,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
+		clocks = <&tegra_car 44>;
 	};
 
 	spi at 7000d800 {
@@ -326,6 +361,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
+		clocks = <&tegra_car 46>;
 	};
 
 	spi at 7000da00 {
@@ -336,6 +372,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
+		clocks = <&tegra_car 68>;
 	};
 
 	pmc {
@@ -370,6 +407,7 @@
 		phy_type = "utmi";
 		nvidia,has-legacy-mode;
 		status = "disabled";
+		clocks = <&tegra_car 22>;
 	};
 
 	usb at c5004000 {
@@ -378,6 +416,7 @@
 		interrupts = <0 21 0x04>;
 		phy_type = "ulpi";
 		status = "disabled";
+		clocks = <&tegra_car 58>;
 	};
 
 	usb at c5008000 {
@@ -386,6 +425,7 @@
 		interrupts = <0 97 0x04>;
 		phy_type = "utmi";
 		status = "disabled";
+		clocks = <&tegra_car 59>;
 	};
 
 	sdhci at c8000000 {
@@ -393,6 +433,7 @@
 		reg = <0xc8000000 0x200>;
 		interrupts = <0 14 0x04>;
 		status = "disabled";
+		clocks = <&tegra_car 14>;
 	};
 
 	sdhci at c8000200 {
@@ -400,6 +441,7 @@
 		reg = <0xc8000200 0x200>;
 		interrupts = <0 15 0x04>;
 		status = "disabled";
+		clocks = <&tegra_car 9>;
 	};
 
 	sdhci at c8000400 {
@@ -407,6 +449,7 @@
 		reg = <0xc8000400 0x200>;
 		interrupts = <0 19 0x04>;
 		status = "disabled";
+		clocks = <&tegra_car 69>;
 	};
 
 	sdhci at c8000600 {
@@ -414,6 +457,7 @@
 		reg = <0xc8000600 0x200>;
 		interrupts = <0 31 0x04>;
 		status = "disabled";
+		clocks = <&tegra_car 15>;
 	};
 
 	pmu {
-- 
1.7.4.1
