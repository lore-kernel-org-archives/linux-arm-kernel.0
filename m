From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  6 Feb 2014 09:55:58 +0100
Subject: [PATCH v2 2/2] ARM: sunxi: dt: Convert to the new clock compatibles
In-Reply-To: <1391676958-13883-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1391676958-13883-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1391676958-13883-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch the device tree to the new compatibles introduced in the clock drivers
to have a common pattern accross all Allwinner SoCs.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi  | 60 +++++++++++++++++++--------------------
 arch/arm/boot/dts/sun5i-a10s.dtsi | 48 +++++++++++++++----------------
 arch/arm/boot/dts/sun5i-a13.dtsi  | 48 +++++++++++++++----------------
 arch/arm/boot/dts/sun6i-a31.dtsi  | 10 +++----
 arch/arm/boot/dts/sun7i-a20.dtsi  | 54 +++++++++++++++++------------------
 5 files changed, 110 insertions(+), 110 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 28273f9..c3fa0da 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -60,7 +60,7 @@
 
 		osc24M: osc24M at 01c20050 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-osc-clk";
+			compatible = "allwinner,sun4i-a10-osc-clk";
 			reg = <0x01c20050 0x4>;
 			clock-frequency = <24000000>;
 		};
@@ -73,21 +73,21 @@
 
 		pll1: pll1 at 01c20000 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-pll1-clk";
+			compatible = "allwinner,sun4i-a10-pll1-clk";
 			reg = <0x01c20000 0x4>;
 			clocks = <&osc24M>;
 		};
 
 		pll4: pll4 at 01c20018 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-pll1-clk";
+			compatible = "allwinner,sun4i-a10-pll1-clk";
 			reg = <0x01c20018 0x4>;
 			clocks = <&osc24M>;
 		};
 
 		pll5: pll5 at 01c20020 {
 			#clock-cells = <1>;
-			compatible = "allwinner,sun4i-pll5-clk";
+			compatible = "allwinner,sun4i-a10-pll5-clk";
 			reg = <0x01c20020 0x4>;
 			clocks = <&osc24M>;
 			clock-output-names = "pll5_ddr", "pll5_other";
@@ -95,7 +95,7 @@
 
 		pll6: pll6 at 01c20028 {
 			#clock-cells = <1>;
-			compatible = "allwinner,sun4i-pll6-clk";
+			compatible = "allwinner,sun4i-a10-pll6-clk";
 			reg = <0x01c20028 0x4>;
 			clocks = <&osc24M>;
 			clock-output-names = "pll6_sata", "pll6_other", "pll6";
@@ -104,21 +104,21 @@
 		/* dummy is 200M */
 		cpu: cpu at 01c20054 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-cpu-clk";
+			compatible = "allwinner,sun4i-a10-cpu-clk";
 			reg = <0x01c20054 0x4>;
 			clocks = <&osc32k>, <&osc24M>, <&pll1>, <&dummy>;
 		};
 
 		axi: axi at 01c20054 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-axi-clk";
+			compatible = "allwinner,sun4i-a10-axi-clk";
 			reg = <0x01c20054 0x4>;
 			clocks = <&cpu>;
 		};
 
 		axi_gates: axi_gates at 01c2005c {
 			#clock-cells = <1>;
-			compatible = "allwinner,sun4i-axi-gates-clk";
+			compatible = "allwinner,sun4i-a10-axi-gates-clk";
 			reg = <0x01c2005c 0x4>;
 			clocks = <&axi>;
 			clock-output-names = "axi_dram";
@@ -126,14 +126,14 @@
 
 		ahb: ahb at 01c20054 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-ahb-clk";
+			compatible = "allwinner,sun4i-a10-ahb-clk";
 			reg = <0x01c20054 0x4>;
 			clocks = <&axi>;
 		};
 
 		ahb_gates: ahb_gates at 01c20060 {
 			#clock-cells = <1>;
-			compatible = "allwinner,sun4i-ahb-gates-clk";
+			compatible = "allwinner,sun4i-a10-ahb-gates-clk";
 			reg = <0x01c20060 0x8>;
 			clocks = <&ahb>;
 			clock-output-names = "ahb_usb0", "ahb_ehci0",
@@ -151,14 +151,14 @@
 
 		apb0: apb0 at 01c20054 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-apb0-clk";
+			compatible = "allwinner,sun4i-a10-apb0-clk";
 			reg = <0x01c20054 0x4>;
 			clocks = <&ahb>;
 		};
 
 		apb0_gates: apb0_gates at 01c20068 {
 			#clock-cells = <1>;
-			compatible = "allwinner,sun4i-apb0-gates-clk";
+			compatible = "allwinner,sun4i-a10-apb0-gates-clk";
 			reg = <0x01c20068 0x4>;
 			clocks = <&apb0>;
 			clock-output-names = "apb0_codec", "apb0_spdif",
@@ -168,21 +168,21 @@
 
 		apb1_mux: apb1_mux at 01c20058 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-apb1-mux-clk";
+			compatible = "allwinner,sun4i-a10-apb1-mux-clk";
 			reg = <0x01c20058 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&osc32k>;
 		};
 
 		apb1: apb1 at 01c20058 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-apb1-clk";
+			compatible = "allwinner,sun4i-a10-apb1-clk";
 			reg = <0x01c20058 0x4>;
 			clocks = <&apb1_mux>;
 		};
 
 		apb1_gates: apb1_gates at 01c2006c {
 			#clock-cells = <1>;
-			compatible = "allwinner,sun4i-apb1-gates-clk";
+			compatible = "allwinner,sun4i-a10-apb1-gates-clk";
 			reg = <0x01c2006c 0x4>;
 			clocks = <&apb1>;
 			clock-output-names = "apb1_i2c0", "apb1_i2c1",
@@ -195,7 +195,7 @@
 
 		nand_clk: clk at 01c20080 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c20080 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "nand";
@@ -203,7 +203,7 @@
 
 		ms_clk: clk at 01c20084 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c20084 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "ms";
@@ -211,7 +211,7 @@
 
 		mmc0_clk: clk at 01c20088 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c20088 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "mmc0";
@@ -219,7 +219,7 @@
 
 		mmc1_clk: clk at 01c2008c {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c2008c 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "mmc1";
@@ -227,7 +227,7 @@
 
 		mmc2_clk: clk at 01c20090 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c20090 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "mmc2";
@@ -235,7 +235,7 @@
 
 		mmc3_clk: clk at 01c20094 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c20094 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "mmc3";
@@ -243,7 +243,7 @@
 
 		ts_clk: clk at 01c20098 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c20098 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "ts";
@@ -251,7 +251,7 @@
 
 		ss_clk: clk at 01c2009c {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c2009c 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "ss";
@@ -259,7 +259,7 @@
 
 		spi0_clk: clk at 01c200a0 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200a0 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "spi0";
@@ -267,7 +267,7 @@
 
 		spi1_clk: clk at 01c200a4 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200a4 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "spi1";
@@ -275,7 +275,7 @@
 
 		spi2_clk: clk at 01c200a8 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200a8 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "spi2";
@@ -283,7 +283,7 @@
 
 		pata_clk: clk at 01c200ac {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200ac 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "pata";
@@ -291,7 +291,7 @@
 
 		ir0_clk: clk at 01c200b0 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200b0 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "ir0";
@@ -299,7 +299,7 @@
 
 		ir1_clk: clk at 01c200b4 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200b4 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "ir1";
@@ -307,7 +307,7 @@
 
 		spi3_clk: clk at 01c200d4 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200d4 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "spi3";
diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 2318082..fa3c62b 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -53,7 +53,7 @@
 
 		osc24M: osc24M at 01c20050 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-osc-clk";
+			compatible = "allwinner,sun4i-a10-osc-clk";
 			reg = <0x01c20050 0x4>;
 			clock-frequency = <24000000>;
 		};
@@ -66,21 +66,21 @@
 
 		pll1: pll1 at 01c20000 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-pll1-clk";
+			compatible = "allwinner,sun4i-a10-pll1-clk";
 			reg = <0x01c20000 0x4>;
 			clocks = <&osc24M>;
 		};
 
 		pll4: pll4 at 01c20018 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-pll1-clk";
+			compatible = "allwinner,sun4i-a10-pll1-clk";
 			reg = <0x01c20018 0x4>;
 			clocks = <&osc24M>;
 		};
 
 		pll5: pll5 at 01c20020 {
 			#clock-cells = <1>;
-			compatible = "allwinner,sun4i-pll5-clk";
+			compatible = "allwinner,sun4i-a10-pll5-clk";
 			reg = <0x01c20020 0x4>;
 			clocks = <&osc24M>;
 			clock-output-names = "pll5_ddr", "pll5_other";
@@ -88,7 +88,7 @@
 
 		pll6: pll6 at 01c20028 {
 			#clock-cells = <1>;
-			compatible = "allwinner,sun4i-pll6-clk";
+			compatible = "allwinner,sun4i-a10-pll6-clk";
 			reg = <0x01c20028 0x4>;
 			clocks = <&osc24M>;
 			clock-output-names = "pll6_sata", "pll6_other", "pll6";
@@ -97,21 +97,21 @@
 		/* dummy is 200M */
 		cpu: cpu at 01c20054 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-cpu-clk";
+			compatible = "allwinner,sun4i-a10-cpu-clk";
 			reg = <0x01c20054 0x4>;
 			clocks = <&osc32k>, <&osc24M>, <&pll1>, <&dummy>;
 		};
 
 		axi: axi at 01c20054 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-axi-clk";
+			compatible = "allwinner,sun4i-a10-axi-clk";
 			reg = <0x01c20054 0x4>;
 			clocks = <&cpu>;
 		};
 
 		axi_gates: axi_gates at 01c2005c {
 			#clock-cells = <1>;
-			compatible = "allwinner,sun4i-axi-gates-clk";
+			compatible = "allwinner,sun4i-a10-axi-gates-clk";
 			reg = <0x01c2005c 0x4>;
 			clocks = <&axi>;
 			clock-output-names = "axi_dram";
@@ -119,7 +119,7 @@
 
 		ahb: ahb at 01c20054 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-ahb-clk";
+			compatible = "allwinner,sun4i-a10-ahb-clk";
 			reg = <0x01c20054 0x4>;
 			clocks = <&axi>;
 		};
@@ -140,7 +140,7 @@
 
 		apb0: apb0 at 01c20054 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-apb0-clk";
+			compatible = "allwinner,sun4i-a10-apb0-clk";
 			reg = <0x01c20054 0x4>;
 			clocks = <&ahb>;
 		};
@@ -156,14 +156,14 @@
 
 		apb1_mux: apb1_mux at 01c20058 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-apb1-mux-clk";
+			compatible = "allwinner,sun4i-a10-apb1-mux-clk";
 			reg = <0x01c20058 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&osc32k>;
 		};
 
 		apb1: apb1 at 01c20058 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-apb1-clk";
+			compatible = "allwinner,sun4i-a10-apb1-clk";
 			reg = <0x01c20058 0x4>;
 			clocks = <&apb1_mux>;
 		};
@@ -180,7 +180,7 @@
 
 		nand_clk: clk at 01c20080 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c20080 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "nand";
@@ -188,7 +188,7 @@
 
 		ms_clk: clk at 01c20084 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c20084 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "ms";
@@ -196,7 +196,7 @@
 
 		mmc0_clk: clk at 01c20088 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c20088 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "mmc0";
@@ -204,7 +204,7 @@
 
 		mmc1_clk: clk at 01c2008c {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c2008c 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "mmc1";
@@ -212,7 +212,7 @@
 
 		mmc2_clk: clk at 01c20090 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c20090 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "mmc2";
@@ -220,7 +220,7 @@
 
 		ts_clk: clk at 01c20098 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c20098 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "ts";
@@ -228,7 +228,7 @@
 
 		ss_clk: clk at 01c2009c {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c2009c 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "ss";
@@ -236,7 +236,7 @@
 
 		spi0_clk: clk at 01c200a0 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200a0 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "spi0";
@@ -244,7 +244,7 @@
 
 		spi1_clk: clk at 01c200a4 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200a4 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "spi1";
@@ -252,7 +252,7 @@
 
 		spi2_clk: clk at 01c200a8 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200a8 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "spi2";
@@ -260,7 +260,7 @@
 
 		ir0_clk: clk at 01c200b0 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200b0 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "ir0";
@@ -268,7 +268,7 @@
 
 		mbus_clk: clk at 01c2015c {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c2015c 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "mbus";
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index 6de40b6..7660bf1 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -54,7 +54,7 @@
 
 		osc24M: osc24M at 01c20050 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-osc-clk";
+			compatible = "allwinner,sun4i-a10-osc-clk";
 			reg = <0x01c20050 0x4>;
 			clock-frequency = <24000000>;
 		};
@@ -67,21 +67,21 @@
 
 		pll1: pll1 at 01c20000 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-pll1-clk";
+			compatible = "allwinner,sun4i-a10-pll1-clk";
 			reg = <0x01c20000 0x4>;
 			clocks = <&osc24M>;
 		};
 
 		pll4: pll4 at 01c20018 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-pll1-clk";
+			compatible = "allwinner,sun4i-a10-pll1-clk";
 			reg = <0x01c20018 0x4>;
 			clocks = <&osc24M>;
 		};
 
 		pll5: pll5 at 01c20020 {
 			#clock-cells = <1>;
-			compatible = "allwinner,sun4i-pll5-clk";
+			compatible = "allwinner,sun4i-a10-pll5-clk";
 			reg = <0x01c20020 0x4>;
 			clocks = <&osc24M>;
 			clock-output-names = "pll5_ddr", "pll5_other";
@@ -89,7 +89,7 @@
 
 		pll6: pll6 at 01c20028 {
 			#clock-cells = <1>;
-			compatible = "allwinner,sun4i-pll6-clk";
+			compatible = "allwinner,sun4i-a10-pll6-clk";
 			reg = <0x01c20028 0x4>;
 			clocks = <&osc24M>;
 			clock-output-names = "pll6_sata", "pll6_other", "pll6";
@@ -98,21 +98,21 @@
 		/* dummy is 200M */
 		cpu: cpu at 01c20054 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-cpu-clk";
+			compatible = "allwinner,sun4i-a10-cpu-clk";
 			reg = <0x01c20054 0x4>;
 			clocks = <&osc32k>, <&osc24M>, <&pll1>, <&dummy>;
 		};
 
 		axi: axi at 01c20054 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-axi-clk";
+			compatible = "allwinner,sun4i-a10-axi-clk";
 			reg = <0x01c20054 0x4>;
 			clocks = <&cpu>;
 		};
 
 		axi_gates: axi_gates at 01c2005c {
 			#clock-cells = <1>;
-			compatible = "allwinner,sun4i-axi-gates-clk";
+			compatible = "allwinner,sun4i-a10-axi-gates-clk";
 			reg = <0x01c2005c 0x4>;
 			clocks = <&axi>;
 			clock-output-names = "axi_dram";
@@ -120,7 +120,7 @@
 
 		ahb: ahb at 01c20054 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-ahb-clk";
+			compatible = "allwinner,sun4i-a10-ahb-clk";
 			reg = <0x01c20054 0x4>;
 			clocks = <&axi>;
 		};
@@ -140,7 +140,7 @@
 
 		apb0: apb0 at 01c20054 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-apb0-clk";
+			compatible = "allwinner,sun4i-a10-apb0-clk";
 			reg = <0x01c20054 0x4>;
 			clocks = <&ahb>;
 		};
@@ -155,14 +155,14 @@
 
 		apb1_mux: apb1_mux at 01c20058 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-apb1-mux-clk";
+			compatible = "allwinner,sun4i-a10-apb1-mux-clk";
 			reg = <0x01c20058 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&osc32k>;
 		};
 
 		apb1: apb1 at 01c20058 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-apb1-clk";
+			compatible = "allwinner,sun4i-a10-apb1-clk";
 			reg = <0x01c20058 0x4>;
 			clocks = <&apb1_mux>;
 		};
@@ -178,7 +178,7 @@
 
 		nand_clk: clk at 01c20080 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c20080 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "nand";
@@ -186,7 +186,7 @@
 
 		ms_clk: clk at 01c20084 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c20084 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "ms";
@@ -194,7 +194,7 @@
 
 		mmc0_clk: clk at 01c20088 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c20088 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "mmc0";
@@ -202,7 +202,7 @@
 
 		mmc1_clk: clk at 01c2008c {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c2008c 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "mmc1";
@@ -210,7 +210,7 @@
 
 		mmc2_clk: clk at 01c20090 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c20090 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "mmc2";
@@ -218,7 +218,7 @@
 
 		ts_clk: clk at 01c20098 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c20098 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "ts";
@@ -226,7 +226,7 @@
 
 		ss_clk: clk at 01c2009c {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c2009c 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "ss";
@@ -234,7 +234,7 @@
 
 		spi0_clk: clk at 01c200a0 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200a0 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "spi0";
@@ -242,7 +242,7 @@
 
 		spi1_clk: clk at 01c200a4 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200a4 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "spi1";
@@ -250,7 +250,7 @@
 
 		spi2_clk: clk at 01c200a8 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200a8 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "spi2";
@@ -258,7 +258,7 @@
 
 		ir0_clk: clk at 01c200b0 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200b0 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "ir0";
@@ -266,7 +266,7 @@
 
 		mbus_clk: clk at 01c2015c {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c2015c 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "mbus";
diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 092bf97..eb97ce4 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -97,7 +97,7 @@
 
 		cpu: cpu at 01c20050 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-cpu-clk";
+			compatible = "allwinner,sun4i-a10-cpu-clk";
 			reg = <0x01c20050 0x4>;
 
 			/*
@@ -111,7 +111,7 @@
 
 		axi: axi at 01c20050 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-axi-clk";
+			compatible = "allwinner,sun4i-a10-axi-clk";
 			reg = <0x01c20050 0x4>;
 			clocks = <&cpu>;
 		};
@@ -125,7 +125,7 @@
 
 		ahb1: ahb1 at 01c20054 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-ahb-clk";
+			compatible = "allwinner,sun4i-a10-ahb-clk";
 			reg = <0x01c20054 0x4>;
 			clocks = <&ahb1_mux>;
 		};
@@ -153,7 +153,7 @@
 
 		apb1: apb1 at 01c20054 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-apb0-clk";
+			compatible = "allwinner,sun4i-a10-apb0-clk";
 			reg = <0x01c20054 0x4>;
 			clocks = <&ahb1>;
 		};
@@ -170,7 +170,7 @@
 
 		apb2_mux: apb2_mux at 01c20058 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-apb1-mux-clk";
+			compatible = "allwinner,sun4i-a10-apb1-mux-clk";
 			reg = <0x01c20058 0x4>;
 			clocks = <&osc32k>, <&osc24M>, <&pll6>, <&pll6>;
 		};
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index bfb2cf2..29db11e 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -56,7 +56,7 @@
 
 		osc24M: osc24M at 01c20050 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-osc-clk";
+			compatible = "allwinner,sun4i-a10-osc-clk";
 			reg = <0x01c20050 0x4>;
 			clock-frequency = <24000000>;
 		};
@@ -70,21 +70,21 @@
 
 		pll1: pll1 at 01c20000 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-pll1-clk";
+			compatible = "allwinner,sun4i-a10-pll1-clk";
 			reg = <0x01c20000 0x4>;
 			clocks = <&osc24M>;
 		};
 
 		pll4: pll4 at 01c20018 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-pll1-clk";
+			compatible = "allwinner,sun4i-a10-pll1-clk";
 			reg = <0x01c20018 0x4>;
 			clocks = <&osc24M>;
 		};
 
 		pll5: pll5 at 01c20020 {
 			#clock-cells = <1>;
-			compatible = "allwinner,sun4i-pll5-clk";
+			compatible = "allwinner,sun4i-a10-pll5-clk";
 			reg = <0x01c20020 0x4>;
 			clocks = <&osc24M>;
 			clock-output-names = "pll5_ddr", "pll5_other";
@@ -92,7 +92,7 @@
 
 		pll6: pll6 at 01c20028 {
 			#clock-cells = <1>;
-			compatible = "allwinner,sun4i-pll6-clk";
+			compatible = "allwinner,sun4i-a10-pll6-clk";
 			reg = <0x01c20028 0x4>;
 			clocks = <&osc24M>;
 			clock-output-names = "pll6_sata", "pll6_other", "pll6";
@@ -100,21 +100,21 @@
 
 		cpu: cpu at 01c20054 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-cpu-clk";
+			compatible = "allwinner,sun4i-a10-cpu-clk";
 			reg = <0x01c20054 0x4>;
 			clocks = <&osc32k>, <&osc24M>, <&pll1>, <&pll6 1>;
 		};
 
 		axi: axi at 01c20054 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-axi-clk";
+			compatible = "allwinner,sun4i-a10-axi-clk";
 			reg = <0x01c20054 0x4>;
 			clocks = <&cpu>;
 		};
 
 		ahb: ahb at 01c20054 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-ahb-clk";
+			compatible = "allwinner,sun4i-a10-ahb-clk";
 			reg = <0x01c20054 0x4>;
 			clocks = <&axi>;
 		};
@@ -141,7 +141,7 @@
 
 		apb0: apb0 at 01c20054 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-apb0-clk";
+			compatible = "allwinner,sun4i-a10-apb0-clk";
 			reg = <0x01c20054 0x4>;
 			clocks = <&ahb>;
 		};
@@ -159,14 +159,14 @@
 
 		apb1_mux: apb1_mux at 01c20058 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-apb1-mux-clk";
+			compatible = "allwinner,sun4i-a10-apb1-mux-clk";
 			reg = <0x01c20058 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&osc32k>;
 		};
 
 		apb1: apb1 at 01c20058 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-apb1-clk";
+			compatible = "allwinner,sun4i-a10-apb1-clk";
 			reg = <0x01c20058 0x4>;
 			clocks = <&apb1_mux>;
 		};
@@ -186,7 +186,7 @@
 
 		nand_clk: clk at 01c20080 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c20080 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "nand";
@@ -194,7 +194,7 @@
 
 		ms_clk: clk at 01c20084 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c20084 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "ms";
@@ -202,7 +202,7 @@
 
 		mmc0_clk: clk at 01c20088 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c20088 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "mmc0";
@@ -210,7 +210,7 @@
 
 		mmc1_clk: clk at 01c2008c {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c2008c 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "mmc1";
@@ -218,7 +218,7 @@
 
 		mmc2_clk: clk at 01c20090 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c20090 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "mmc2";
@@ -226,7 +226,7 @@
 
 		mmc3_clk: clk at 01c20094 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c20094 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "mmc3";
@@ -234,7 +234,7 @@
 
 		ts_clk: clk at 01c20098 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c20098 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "ts";
@@ -242,7 +242,7 @@
 
 		ss_clk: clk at 01c2009c {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c2009c 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "ss";
@@ -250,7 +250,7 @@
 
 		spi0_clk: clk at 01c200a0 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200a0 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "spi0";
@@ -258,7 +258,7 @@
 
 		spi1_clk: clk at 01c200a4 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200a4 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "spi1";
@@ -266,7 +266,7 @@
 
 		spi2_clk: clk at 01c200a8 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200a8 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "spi2";
@@ -274,7 +274,7 @@
 
 		pata_clk: clk at 01c200ac {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200ac 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "pata";
@@ -282,7 +282,7 @@
 
 		ir0_clk: clk at 01c200b0 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200b0 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "ir0";
@@ -290,7 +290,7 @@
 
 		ir1_clk: clk at 01c200b4 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200b4 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "ir1";
@@ -298,7 +298,7 @@
 
 		spi3_clk: clk at 01c200d4 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200d4 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "spi3";
@@ -306,7 +306,7 @@
 
 		mbus_clk: clk at 01c2015c {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c2015c 0x4>;
 			clocks = <&osc24M>, <&pll6 2>, <&pll5 1>;
 			clock-output-names = "mbus";
-- 
1.8.4.2
