From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 27 Nov 2015 10:52:45 +0900
Subject: [PATCH 1/2] ARM: shmobile: r8a7793: Add missing serial devices to DT
In-Reply-To: <1448589166-11612-1-git-send-email-horms+renesas@verge.net.au>
References: <1448589166-11612-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1448589166-11612-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instantiate all serial devices in r8a7793 device tree
and set them as disabled by default.

Based on similar work for the r8a7791 by Laurent Pinchart.

Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7793.dtsi | 179 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 177 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index cbcda80f4658..3ac2ec0414a0 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -298,6 +298,96 @@
 		dma-channels = <15>;
 	};
 
+	scifa0: serial at e6c40000 {
+		compatible = "renesas,scifa-r8a7793", "renesas,scifa";
+		reg = <0 0xe6c40000 0 64>;
+		interrupts = <0 144 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks R8A7793_CLK_SCIFA0>;
+		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+	};
+
+	scifa1: serial at e6c50000 {
+		compatible = "renesas,scifa-r8a7793", "renesas,scifa";
+		reg = <0 0xe6c50000 0 64>;
+		interrupts = <0 145 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks R8A7793_CLK_SCIFA1>;
+		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+	};
+
+	scifa2: serial at e6c60000 {
+		compatible = "renesas,scifa-r8a7793", "renesas,scifa";
+		reg = <0 0xe6c60000 0 64>;
+		interrupts = <0 151 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks R8A7793_CLK_SCIFA2>;
+		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+	};
+
+	scifa3: serial at e6c70000 {
+		compatible = "renesas,scifa-r8a7793", "renesas,scifa";
+		reg = <0 0xe6c70000 0 64>;
+		interrupts = <0 29 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp11_clks R8A7793_CLK_SCIFA3>;
+		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+	};
+
+	scifa4: serial at e6c78000 {
+		compatible = "renesas,scifa-r8a7793", "renesas,scifa";
+		reg = <0 0xe6c78000 0 64>;
+		interrupts = <0 30 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp11_clks R8A7793_CLK_SCIFA4>;
+		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+	};
+
+	scifa5: serial at e6c80000 {
+		compatible = "renesas,scifa-r8a7793", "renesas,scifa";
+		reg = <0 0xe6c80000 0 64>;
+		interrupts = <0 31 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp11_clks R8A7793_CLK_SCIFA5>;
+		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+	};
+
+	scifb0: serial at e6c20000 {
+		compatible = "renesas,scifb-r8a7793", "renesas,scifb";
+		reg = <0 0xe6c20000 0 64>;
+		interrupts = <0 148 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks R8A7793_CLK_SCIFB0>;
+		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+	};
+
+	scifb1: serial at e6c30000 {
+		compatible = "renesas,scifb-r8a7793", "renesas,scifb";
+		reg = <0 0xe6c30000 0 64>;
+		interrupts = <0 149 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks R8A7793_CLK_SCIFB1>;
+		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+	};
+
+	scifb2: serial at e6ce0000 {
+		compatible = "renesas,scifb-r8a7793", "renesas,scifb";
+		reg = <0 0xe6ce0000 0 64>;
+		interrupts = <0 150 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks R8A7793_CLK_SCIFB2>;
+		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+	};
+
 	scif0: serial at e6e60000 {
 		compatible = "renesas,scif-r8a7793", "renesas,scif";
 		reg = <0 0xe6e60000 0 64>;
@@ -318,6 +408,76 @@
 		status = "disabled";
 	};
 
+	scif2: serial at e6e58000 {
+		compatible = "renesas,scif-r8a7793", "renesas,scif";
+		reg = <0 0xe6e58000 0 64>;
+		interrupts = <0 22 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R8A7793_CLK_SCIF2>;
+		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+	};
+
+	scif3: serial at e6ea8000 {
+		compatible = "renesas,scif-r8a7793", "renesas,scif";
+		reg = <0 0xe6ea8000 0 64>;
+		interrupts = <0 23 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R8A7793_CLK_SCIF3>;
+		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+	};
+
+	scif4: serial at e6ee0000 {
+		compatible = "renesas,scif-r8a7793", "renesas,scif";
+		reg = <0 0xe6ee0000 0 64>;
+		interrupts = <0 24 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R8A7793_CLK_SCIF4>;
+		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+	};
+
+	scif5: serial at e6ee8000 {
+		compatible = "renesas,scif-r8a7793", "renesas,scif";
+		reg = <0 0xe6ee8000 0 64>;
+		interrupts = <0 25 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R8A7793_CLK_SCIF5>;
+		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+	};
+
+	hscif0: serial at e62c0000 {
+		compatible = "renesas,hscif-r8a7793", "renesas,hscif";
+		reg = <0 0xe62c0000 0 96>;
+		interrupts = <0 154 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R8A7793_CLK_HSCIF0>;
+		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+	};
+
+	hscif1: serial at e62c8000 {
+		compatible = "renesas,hscif-r8a7793", "renesas,hscif";
+		reg = <0 0xe62c8000 0 96>;
+		interrupts = <0 155 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R8A7793_CLK_HSCIF1>;
+		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+	};
+
+	hscif2: serial at e62d0000 {
+		compatible = "renesas,hscif-r8a7793", "renesas,hscif";
+		reg = <0 0xe62d0000 0 96>;
+		interrupts = <0 21 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R8A7793_CLK_HSCIF2>;
+		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+	};
+
 	ether: ethernet at ee700000 {
 		compatible = "renesas,ether-r8a7793";
 		reg = <0 0xee700000 0 0x400>;
@@ -530,12 +690,17 @@
 		mstp2_clks: mstp2_clks at e6150138 {
 			compatible = "renesas,r8a7793-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150138 0 4>, <0 0xe6150040 0 4>;
-			clocks = <&zs_clk>, <&zs_clk>;
+			clocks = <&mp_clk>, <&mp_clk>, <&mp_clk>, <&mp_clk>,
+				 <&mp_clk>, <&mp_clk>, <&zs_clk>, <&zs_clk>;
 			#clock-cells = <1>;
 			clock-indices = <
+				R8A7793_CLK_SCIFA2 R8A7793_CLK_SCIFA1 R8A7793_CLK_SCIFA0
+				R8A7793_CLK_SCIFB0 R8A7793_CLK_SCIFB1 R8A7793_CLK_SCIFB2
 				R8A7793_CLK_SYS_DMAC1 R8A7793_CLK_SYS_DMAC0
 			>;
-			clock-output-names = "sys-dmac1", "sys-dmac0";
+			clock-output-names =
+				"scifa2", "scifa1", "scifa0", "scifb0",
+				"scifb1", "scifb2", "sys-dmac1", "sys-dmac0";
 		};
 		mstp3_clks: mstp3_clks at e615013c {
 			compatible = "renesas,r8a7793-mstp-clocks",
@@ -634,6 +799,16 @@
 				"gpio3", "gpio2", "gpio1", "gpio0",
 				"qspi_mod";
 		};
+		mstp11_clks: mstp11_clks at e615099c {
+			compatible = "renesas,r8a7793-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0 0xe615099c 0 4>, <0 0xe61509ac 0 4>;
+			clocks = <&mp_clk>, <&mp_clk>, <&mp_clk>;
+			#clock-cells = <1>;
+			clock-indices = <
+				R8A7793_CLK_SCIFA3 R8A7793_CLK_SCIFA4 R8A7793_CLK_SCIFA5
+			>;
+			clock-output-names = "scifa3", "scifa4", "scifa5";
+		};
 	};
 
 	ipmmu_sy0: mmu at e6280000 {
-- 
2.1.4
