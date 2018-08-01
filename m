From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Wed,  1 Aug 2018 10:19:50 +0200
Subject: [PATCH 2/2] dt-bindings: clock: Add bindings for the Clocking Wizard
 IP
In-Reply-To: <20180801081950.10497-1-boris.brezillon@bootlin.com>
References: <20180801081950.10497-1-boris.brezillon@bootlin.com>
Message-ID: <20180801081950.10497-2-boris.brezillon@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document Xilinx Clocking Wizard bindings.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 .../devicetree/bindings/clock/xlnx,clk-wizard.txt  | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/xlnx,clk-wizard.txt

diff --git a/Documentation/devicetree/bindings/clock/xlnx,clk-wizard.txt b/Documentation/devicetree/bindings/clock/xlnx,clk-wizard.txt
new file mode 100644
index 000000000000..1bf7a764f4a9
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/xlnx,clk-wizard.txt
@@ -0,0 +1,28 @@
+Device Tree Clock bindings for the "Clocking Wizard" IP provided by Xilinx
+
+This block can be used to generate up to 4 clock signals out of a single input
+clock. It embeds a PLL to generate an intermediate clock which then feeds 4
+clock dividers whose divider value can be adjusted based on the user needs.
+
+Required properties:
+ - #clock-cells: must be 1. The cell is encoding the id of the output clk
+		 (from 0 to xlnx,clk-wizard-num-outputs - 1)
+ - compatible: must be "xlnx,clk-wizard-5.1"
+ - clocks: 2 clocks are required
+ - clock-names: should contain 2 clock names: "aclk" and "clkin".
+		"aclk" is driving the register interface and "clk_in" is the
+		input clock signal that is used by the PLL block
+ - xlnx,clk-wizard-num-outputs: this describe the number of output clocks
+				(chosen at synthesization time)
+ - reg: registers used to configure the Clocking wizard block
+
+Example:
+
+	clkwizard: clkwizard at 43c20000 {
+		compatible = "xlnx,clk-wizard-5.1";
+		reg = <0x43c20000 0x10000>;
+		clocks = <&clkc 18>, <&clkc 18>;
+		clock-names = "aclk", "clk_in1";
+		#clock-cells = <1>;
+		xlnx,clk-wizard-num-outputs = <2>;
+	};
-- 
2.14.1
