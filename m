From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  2 Feb 2014 14:36:31 +0100
Subject: [PATCH 2/2] ARM: sunxi: dt: Convert to the new clock compatibles
In-Reply-To: <1391348191-9375-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1391348191-9375-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1391348191-9375-2-git-send-email-maxime.ripard@free-electrons.com>
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
index 040bb0e..336de35 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
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
@@ -120,14 +120,14 @@
 
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
@@ -145,14 +145,14 @@
 
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
@@ -162,21 +162,21 @@
 
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
@@ -189,7 +189,7 @@
 
 		nand_clk: clk at 01c20080 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c20080 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "nand";
@@ -197,7 +197,7 @@
 
 		ms_clk: clk at 01c20084 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c20084 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "ms";
@@ -205,7 +205,7 @@
 
 		mmc0_clk: clk at 01c20088 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c20088 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "mmc0";
@@ -213,7 +213,7 @@
 
 		mmc1_clk: clk at 01c2008c {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c2008c 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "mmc1";
@@ -221,7 +221,7 @@
 
 		mmc2_clk: clk at 01c20090 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c20090 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "mmc2";
@@ -229,7 +229,7 @@
 
 		mmc3_clk: clk at 01c20094 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c20094 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "mmc3";
@@ -237,7 +237,7 @@
 
 		ts_clk: clk at 01c20098 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c20098 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "ts";
@@ -245,7 +245,7 @@
 
 		ss_clk: clk at 01c2009c {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c2009c 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "ss";
@@ -253,7 +253,7 @@
 
 		spi0_clk: clk at 01c200a0 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200a0 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "spi0";
@@ -261,7 +261,7 @@
 
 		spi1_clk: clk at 01c200a4 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200a4 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "spi1";
@@ -269,7 +269,7 @@
 
 		spi2_clk: clk at 01c200a8 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200a8 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "spi2";
@@ -277,7 +277,7 @@
 
 		pata_clk: clk at 01c200ac {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200ac 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "pata";
@@ -285,7 +285,7 @@
 
 		ir0_clk: clk at 01c200b0 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200b0 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "ir0";
@@ -293,7 +293,7 @@
 
 		ir1_clk: clk at 01c200b4 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200b4 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "ir1";
@@ -301,7 +301,7 @@
 
 		spi3_clk: clk at 01c200d4 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200d4 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "spi3";
diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index ea16054..8e48a94 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -49,7 +49,7 @@
 
 		osc24M: osc24M at 01c20050 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-osc-clk";
+			compatible = "allwinner,sun4i-a10-osc-clk";
 			reg = <0x01c20050 0x4>;
 			clock-frequency = <24000000>;
 		};
@@ -62,21 +62,21 @@
 
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
@@ -84,7 +84,7 @@
 
 		pll6: pll6 at 01c20028 {
 			#clock-cells = <1>;
-			compatible = "allwinner,sun4i-pll6-clk";
+			compatible = "allwinner,sun4i-a10-pll6-clk";
 			reg = <0x01c20028 0x4>;
 			clocks = <&osc24M>;
 			clock-output-names = "pll6_sata", "pll6_other", "pll6";
@@ -93,21 +93,21 @@
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
@@ -115,7 +115,7 @@
 
 		ahb: ahb at 01c20054 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-ahb-clk";
+			compatible = "allwinner,sun4i-a10-ahb-clk";
 			reg = <0x01c20054 0x4>;
 			clocks = <&axi>;
 		};
@@ -136,7 +136,7 @@
 
 		apb0: apb0 at 01c20054 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-apb0-clk";
+			compatible = "allwinner,sun4i-a10-apb0-clk";
 			reg = <0x01c20054 0x4>;
 			clocks = <&ahb>;
 		};
@@ -152,14 +152,14 @@
 
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
@@ -176,7 +176,7 @@
 
 		nand_clk: clk at 01c20080 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c20080 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "nand";
@@ -184,7 +184,7 @@
 
 		ms_clk: clk at 01c20084 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c20084 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "ms";
@@ -192,7 +192,7 @@
 
 		mmc0_clk: clk at 01c20088 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c20088 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "mmc0";
@@ -200,7 +200,7 @@
 
 		mmc1_clk: clk at 01c2008c {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c2008c 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "mmc1";
@@ -208,7 +208,7 @@
 
 		mmc2_clk: clk at 01c20090 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c20090 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "mmc2";
@@ -216,7 +216,7 @@
 
 		ts_clk: clk at 01c20098 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c20098 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "ts";
@@ -224,7 +224,7 @@
 
 		ss_clk: clk at 01c2009c {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c2009c 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "ss";
@@ -232,7 +232,7 @@
 
 		spi0_clk: clk at 01c200a0 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200a0 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "spi0";
@@ -240,7 +240,7 @@
 
 		spi1_clk: clk at 01c200a4 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200a4 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "spi1";
@@ -248,7 +248,7 @@
 
 		spi2_clk: clk at 01c200a8 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200a8 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "spi2";
@@ -256,7 +256,7 @@
 
 		ir0_clk: clk at 01c200b0 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200b0 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "ir0";
@@ -264,7 +264,7 @@
 
 		mbus_clk: clk at 01c2015c {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c2015c 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "mbus";
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index 320335a..2e665fd 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -49,7 +49,7 @@
 
 		osc24M: osc24M at 01c20050 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-osc-clk";
+			compatible = "allwinner,sun4i-a10-osc-clk";
 			reg = <0x01c20050 0x4>;
 			clock-frequency = <24000000>;
 		};
@@ -62,21 +62,21 @@
 
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
@@ -84,7 +84,7 @@
 
 		pll6: pll6 at 01c20028 {
 			#clock-cells = <1>;
-			compatible = "allwinner,sun4i-pll6-clk";
+			compatible = "allwinner,sun4i-a10-pll6-clk";
 			reg = <0x01c20028 0x4>;
 			clocks = <&osc24M>;
 			clock-output-names = "pll6_sata", "pll6_other", "pll6";
@@ -93,21 +93,21 @@
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
@@ -115,7 +115,7 @@
 
 		ahb: ahb at 01c20054 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-ahb-clk";
+			compatible = "allwinner,sun4i-a10-ahb-clk";
 			reg = <0x01c20054 0x4>;
 			clocks = <&axi>;
 		};
@@ -135,7 +135,7 @@
 
 		apb0: apb0 at 01c20054 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-apb0-clk";
+			compatible = "allwinner,sun4i-a10-apb0-clk";
 			reg = <0x01c20054 0x4>;
 			clocks = <&ahb>;
 		};
@@ -150,14 +150,14 @@
 
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
@@ -173,7 +173,7 @@
 
 		nand_clk: clk at 01c20080 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c20080 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "nand";
@@ -181,7 +181,7 @@
 
 		ms_clk: clk at 01c20084 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c20084 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "ms";
@@ -189,7 +189,7 @@
 
 		mmc0_clk: clk at 01c20088 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c20088 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "mmc0";
@@ -197,7 +197,7 @@
 
 		mmc1_clk: clk at 01c2008c {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c2008c 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "mmc1";
@@ -205,7 +205,7 @@
 
 		mmc2_clk: clk at 01c20090 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c20090 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "mmc2";
@@ -213,7 +213,7 @@
 
 		ts_clk: clk at 01c20098 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c20098 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "ts";
@@ -221,7 +221,7 @@
 
 		ss_clk: clk at 01c2009c {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c2009c 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "ss";
@@ -229,7 +229,7 @@
 
 		spi0_clk: clk at 01c200a0 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200a0 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "spi0";
@@ -237,7 +237,7 @@
 
 		spi1_clk: clk at 01c200a4 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200a4 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "spi1";
@@ -245,7 +245,7 @@
 
 		spi2_clk: clk at 01c200a8 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200a8 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "spi2";
@@ -253,7 +253,7 @@
 
 		ir0_clk: clk at 01c200b0 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200b0 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "ir0";
@@ -261,7 +261,7 @@
 
 		mbus_clk: clk at 01c2015c {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c2015c 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "mbus";
diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 5256ad9..4990daf 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -87,7 +87,7 @@
 
 		cpu: cpu at 01c20050 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-cpu-clk";
+			compatible = "allwinner,sun4i-a10-cpu-clk";
 			reg = <0x01c20050 0x4>;
 
 			/*
@@ -101,7 +101,7 @@
 
 		axi: axi at 01c20050 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-axi-clk";
+			compatible = "allwinner,sun4i-a10-axi-clk";
 			reg = <0x01c20050 0x4>;
 			clocks = <&cpu>;
 		};
@@ -115,7 +115,7 @@
 
 		ahb1: ahb1 at 01c20054 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-ahb-clk";
+			compatible = "allwinner,sun4i-a10-ahb-clk";
 			reg = <0x01c20054 0x4>;
 			clocks = <&ahb1_mux>;
 		};
@@ -143,7 +143,7 @@
 
 		apb1: apb1 at 01c20054 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-apb0-clk";
+			compatible = "allwinner,sun4i-a10-apb0-clk";
 			reg = <0x01c20054 0x4>;
 			clocks = <&ahb1>;
 		};
@@ -160,7 +160,7 @@
 
 		apb2_mux: apb2_mux at 01c20058 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-apb1-mux-clk";
+			compatible = "allwinner,sun4i-a10-apb1-mux-clk";
 			reg = <0x01c20058 0x4>;
 			clocks = <&osc32k>, <&osc24M>, <&pll6>, <&pll6>;
 		};
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 119f066..c15739f 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -48,7 +48,7 @@
 
 		osc24M: osc24M at 01c20050 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-osc-clk";
+			compatible = "allwinner,sun4i-a10-osc-clk";
 			reg = <0x01c20050 0x4>;
 			clock-frequency = <24000000>;
 		};
@@ -62,21 +62,21 @@
 
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
@@ -84,7 +84,7 @@
 
 		pll6: pll6 at 01c20028 {
 			#clock-cells = <1>;
-			compatible = "allwinner,sun4i-pll6-clk";
+			compatible = "allwinner,sun4i-a10-pll6-clk";
 			reg = <0x01c20028 0x4>;
 			clocks = <&osc24M>;
 			clock-output-names = "pll6_sata", "pll6_other", "pll6";
@@ -92,21 +92,21 @@
 
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
@@ -133,7 +133,7 @@
 
 		apb0: apb0 at 01c20054 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-apb0-clk";
+			compatible = "allwinner,sun4i-a10-apb0-clk";
 			reg = <0x01c20054 0x4>;
 			clocks = <&ahb>;
 		};
@@ -151,14 +151,14 @@
 
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
 
 		mmc3_clk: clk at 01c20094 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c20094 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "mmc3";
@@ -226,7 +226,7 @@
 
 		ts_clk: clk at 01c20098 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c20098 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "ts";
@@ -234,7 +234,7 @@
 
 		ss_clk: clk at 01c2009c {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c2009c 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "ss";
@@ -242,7 +242,7 @@
 
 		spi0_clk: clk at 01c200a0 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200a0 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "spi0";
@@ -250,7 +250,7 @@
 
 		spi1_clk: clk at 01c200a4 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200a4 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "spi1";
@@ -258,7 +258,7 @@
 
 		spi2_clk: clk at 01c200a8 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200a8 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "spi2";
@@ -266,7 +266,7 @@
 
 		pata_clk: clk at 01c200ac {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200ac 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "pata";
@@ -274,7 +274,7 @@
 
 		ir0_clk: clk at 01c200b0 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200b0 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "ir0";
@@ -282,7 +282,7 @@
 
 		ir1_clk: clk at 01c200b4 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200b4 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "ir1";
@@ -290,7 +290,7 @@
 
 		spi3_clk: clk at 01c200d4 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c200d4 0x4>;
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "spi3";
@@ -298,7 +298,7 @@
 
 		mbus_clk: clk at 01c2015c {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-mod0-clk";
+			compatible = "allwinner,sun4i-a10-mod0-clk";
 			reg = <0x01c2015c 0x4>;
 			clocks = <&osc24M>, <&pll6 2>, <&pll5 1>;
 			clock-output-names = "mbus";
-- 
1.8.4.2
