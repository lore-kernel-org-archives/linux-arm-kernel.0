From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 13 Jul 2016 00:10:18 +0300
Subject: [PATCH 1/2] ARM: dts: r8a7792: add SD clocks
In-Reply-To: <2441635.ESeLhIjWEX@wasted.cogentembedded.com>
References: <2441635.ESeLhIjWEX@wasted.cogentembedded.com>
Message-ID: <5720002.roQESv2v7G@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Describe the SDHI0 clock and its parent, SD clock in the R8A7792 device tree.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/boot/dts/r8a7792.dtsi |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7792.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7792.dtsi
+++ renesas/arch/arm/boot/dts/r8a7792.dtsi
@@ -511,6 +511,13 @@
 			clock-div = <8>;
 			clock-mult = <1>;
 		};
+		sd_clk: sd {
+			compatible = "fixed-factor-clock";
+			clocks = <&pll1_div2_clk>;
+			#clock-cells = <0>;
+			clock-div = <8>;
+			clock-mult = <1>;
+		};
 
 		/* Gate clocks */
 		mstp1_clks: mstp1_clks at e6150134 {
@@ -533,6 +540,15 @@
 			>;
 			clock-output-names = "sys-dmac1", "sys-dmac0";
 		};
+		mstp3_clks: mstp3_clks at e615013c {
+			compatible = "renesas,r8a7792-mstp-clocks",
+				     "renesas,cpg-mstp-clocks";
+			reg = <0 0xe615013c 0 4>, <0 0xe6150048 0 4>;
+			clocks = <&sd_clk>;
+			#clock-cells = <1>;
+			renesas,clock-indices = <R8A7792_CLK_SDHI0>;
+			clock-output-names = "sdhi0";
+		};
 		mstp4_clks: mstp4_clks at e6150140 {
 			compatible = "renesas,r8a7792-mstp-clocks",
 				     "renesas,cpg-mstp-clocks";
