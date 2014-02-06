From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  6 Feb 2014 15:20:41 +0900
Subject: [PATCH 06/17] ARM: shmobile: r8a7791: Add serial ports to the device
 tree
In-Reply-To: <cover.1391665761.git.horms+renesas@verge.net.au>
References: <cover.1391665761.git.horms+renesas@verge.net.au>
Message-ID: <9640cf259c9496d56bf44df8ae86f00f7b417ecc.1391665761.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Add all serial ports marked as disabled.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 180 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 180 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 34f5d39..00ed0e0 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -186,6 +186,186 @@
 		#gpio-range-cells = <3>;
 	};
 
+	scifa0: serial at e6c40000 {
+		compatible = "renesas,scifa-r8a7791", "renesas,scifa";
+		reg = <0 0xe6c40000 0 64>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 144 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks R8A7791_CLK_SCIFA0>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scifa1: serial at e6c50000 {
+		compatible = "renesas,scifa-r8a7791", "renesas,scifa";
+		interrupt-parent = <&gic>;
+		reg = <0 0xe6c50000 0 64>;
+		interrupts = <0 145 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks R8A7791_CLK_SCIFA1>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scifa2: serial at e6c60000 {
+		compatible = "renesas,scifa-r8a7791", "renesas,scifa";
+		interrupt-parent = <&gic>;
+		reg = <0 0xe6c60000 0 64>;
+		interrupts = <0 151 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks R8A7791_CLK_SCIFA2>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scifa3: serial at e6c70000 {
+		compatible = "renesas,scifa-r8a7791", "renesas,scifa";
+		interrupt-parent = <&gic>;
+		reg = <0 0xe6c70000 0 64>;
+		interrupts = <0 29 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp11_clks R8A7791_CLK_SCIFA3>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scifa4: serial at e6c78000 {
+		compatible = "renesas,scifa-r8a7791", "renesas,scifa";
+		interrupt-parent = <&gic>;
+		reg = <0 0xe6c78000 0 64>;
+		interrupts = <0 30 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp11_clks R8A7791_CLK_SCIFA4>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scifa5: serial at e6c80000 {
+		compatible = "renesas,scifa-r8a7791", "renesas,scifa";
+		interrupt-parent = <&gic>;
+		reg = <0 0xe6c80000 0 64>;
+		interrupts = <0 31 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp11_clks R8A7791_CLK_SCIFA5>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scifb0: serial at e6c20000 {
+		compatible = "renesas,scifb-r8a7791", "renesas,scifb";
+		interrupt-parent = <&gic>;
+		reg = <0 0xe6c20000 0 64>;
+		interrupts = <0 148 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks R8A7791_CLK_SCIFB0>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scifb1: serial at e6c30000 {
+		compatible = "renesas,scifb-r8a7791", "renesas,scifb";
+		interrupt-parent = <&gic>;
+		reg = <0 0xe6c30000 0 64>;
+		interrupts = <0 149 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks R8A7791_CLK_SCIFB1>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scifb2: serial at e6ce0000 {
+		compatible = "renesas,scifb-r8a7791", "renesas,scifb";
+		interrupt-parent = <&gic>;
+		reg = <0 0xe6ce0000 0 64>;
+		interrupts = <0 150 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks R8A7791_CLK_SCIFB2>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scif0: serial at e6e60000 {
+		compatible = "renesas,scif-r8a7791", "renesas,scif";
+		interrupt-parent = <&gic>;
+		reg = <0 0xe6e60000 0 64>;
+		interrupts = <0 152 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R8A7791_CLK_SCIF0>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scif1: serial at e6e68000 {
+		compatible = "renesas,scif-r8a7791", "renesas,scif";
+		interrupt-parent = <&gic>;
+		reg = <0 0xe6e68000 0 64>;
+		interrupts = <0 153 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R8A7791_CLK_SCIF1>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scif2: serial at e6e58000 {
+		compatible = "renesas,scif-r8a7791", "renesas,scif";
+		interrupt-parent = <&gic>;
+		reg = <0 0xe6e58000 0 64>;
+		interrupts = <0 22 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R8A7791_CLK_SCIF2>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scif3: serial at e6ea8000 {
+		compatible = "renesas,scif-r8a7791", "renesas,scif";
+		interrupt-parent = <&gic>;
+		reg = <0 0xe6ea8000 0 64>;
+		interrupts = <0 23 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R8A7791_CLK_SCIF3>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scif4: serial at e6ee0000 {
+		compatible = "renesas,scif-r8a7791", "renesas,scif";
+		interrupt-parent = <&gic>;
+		reg = <0 0xe6ee0000 0 64>;
+		interrupts = <0 24 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R8A7791_CLK_SCIF4>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scif5: serial at e6ee8000 {
+		compatible = "renesas,scif-r8a7791", "renesas,scif";
+		interrupt-parent = <&gic>;
+		reg = <0 0xe6ee8000 0 64>;
+		interrupts = <0 25 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R8A7791_CLK_SCIF5>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	hscif0: serial at e62c0000 {
+		compatible = "renesas,hscif-r8a7791", "renesas,hscif";
+		interrupt-parent = <&gic>;
+		reg = <0 0xe62c0000 0 96>;
+		interrupts = <0 154 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R8A7791_CLK_HSCIF0>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	hscif1: serial at e62c8000 {
+		compatible = "renesas,hscif-r8a7791", "renesas,hscif";
+		interrupt-parent = <&gic>;
+		reg = <0 0xe62c8000 0 96>;
+		interrupts = <0 155 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R8A7791_CLK_HSCIF1>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	hscif2: serial at e62d0000 {
+		compatible = "renesas,hscif-r8a7791", "renesas,hscif";
+		interrupt-parent = <&gic>;
+		reg = <0 0xe62d0000 0 96>;
+		interrupts = <0 21 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R8A7791_CLK_HSCIF2>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
 	clocks {
 		#address-cells = <2>;
 		#size-cells = <2>;
-- 
1.8.5.2
