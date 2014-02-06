From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  6 Feb 2014 15:20:42 +0900
Subject: [PATCH 07/17] ARM: shmobile: r8a7790: Add serial ports to the device
 tree
In-Reply-To: <cover.1391665761.git.horms+renesas@verge.net.au>
References: <cover.1391665761.git.horms+renesas@verge.net.au>
Message-ID: <597af20fa8f810a26c84179a8ac58cb3fce6c102.1391665761.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The platform code serial port instantiation mechanism is kept for the
non-DT platforms only.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 100 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 96fc731..15e2a97 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -300,6 +300,106 @@
 		status = "disabled";
 	};
 
+	scifa0: serial at e6c40000 {
+		compatible = "renesas,scifa-r8a7790", "renesas,scifa-generic";
+		reg = <0 0xe6c40000 0 64>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 144 4>;
+		clocks = <&mstp2_clks R8A7790_CLK_SCIFA0>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scifa1: serial at e6c50000 {
+		compatible = "renesas,scifa-r8a7790", "renesas,scifa-generic";
+		interrupt-parent = <&gic>;
+		reg = <0 0xe6c50000 0 64>;
+		interrupts = <0 145 4>;
+		clocks = <&mstp2_clks R8A7790_CLK_SCIFA1>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scifa2: serial at e6c60000 {
+		compatible = "renesas,scifa-r8a7790", "renesas,scifa-generic";
+		interrupt-parent = <&gic>;
+		reg = <0 0xe6c60000 0 64>;
+		interrupts = <0 151 4>;
+		clocks = <&mstp2_clks R8A7790_CLK_SCIFA2>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scifb0: serial at e6c20000 {
+		compatible = "renesas,scifb-r8a7790", "renesas,scifb-generic";
+		interrupt-parent = <&gic>;
+		reg = <0 0xe6c20000 0 64>;
+		interrupts = <0 148 4>;
+		clocks = <&mstp2_clks R8A7790_CLK_SCIFB0>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scifb1: serial at e6c30000 {
+		compatible = "renesas,scifb-r8a7790", "renesas,scifb-generic";
+		interrupt-parent = <&gic>;
+		reg = <0 0xe6c30000 0 64>;
+		interrupts = <0 149 4>;
+		clocks = <&mstp2_clks R8A7790_CLK_SCIFB1>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scifb2: serial at e6ce0000 {
+		compatible = "renesas,scifb-r8a7790", "renesas,scifb-generic";
+		interrupt-parent = <&gic>;
+		reg = <0 0xe6ce0000 0 64>;
+		interrupts = <0 150 4>;
+		clocks = <&mstp2_clks R8A7790_CLK_SCIFB2>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scif0: serial at e6e60000 {
+		compatible = "renesas,scif-r8a7790", "renesas,scif-generic";
+		interrupt-parent = <&gic>;
+		reg = <0 0xe6e60000 0 64>;
+		interrupts = <0 152 4>;
+		clocks = <&mstp7_clks R8A7790_CLK_SCIF0>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scif1: serial at e6e68000 {
+		compatible = "renesas,scif-r8a7790", "renesas,scif-generic";
+		interrupt-parent = <&gic>;
+		reg = <0 0xe6e68000 0 64>;
+		interrupts = <0 153 4>;
+		clocks = <&mstp7_clks R8A7790_CLK_SCIF1>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	hscif0: serial at e62c0000 {
+		compatible = "renesas,hscif-r8a7790", "renesas,hscif-generic";
+		interrupt-parent = <&gic>;
+		reg = <0 0xe62c0000 0 96>;
+		interrupts = <0 154 4>;
+		clocks = <&mstp7_clks R8A7790_CLK_HSCIF0>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	hscif1: serial at e62c8000 {
+		compatible = "renesas,hscif-r8a7790", "renesas,hscif-generic";
+		interrupt-parent = <&gic>;
+		reg = <0 0xe62c8000 0 96>;
+		interrupts = <0 155 4>;
+		clocks = <&mstp7_clks R8A7790_CLK_HSCIF1>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
 	clocks {
 		#address-cells = <2>;
 		#size-cells = <2>;
-- 
1.8.5.2
