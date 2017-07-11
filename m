From: chunyan.zhang@spreadtrum.com (Chunyan Zhang)
Date: Tue, 11 Jul 2017 18:56:19 +0800
Subject: [PATCH V2 02/10] dt-bindings: Add Spreadtrum clock binding
 documentation
In-Reply-To: <20170711105627.20526-1-chunyan.zhang@spreadtrum.com>
References: <20170711105627.20526-1-chunyan.zhang@spreadtrum.com>
Message-ID: <20170711105627.20526-3-chunyan.zhang@spreadtrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce a new binding with its documentation for Spreadtrum clock
sub-framework.

Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
---
 Documentation/devicetree/bindings/clock/sprd.txt | 36 ++++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sprd.txt

diff --git a/Documentation/devicetree/bindings/clock/sprd.txt b/Documentation/devicetree/bindings/clock/sprd.txt
new file mode 100644
index 0000000..c6f3abf
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sprd.txt
@@ -0,0 +1,36 @@
+Spreadtrum Clock Binding
+------------------------
+
+Required properties:
+- compatible: must contain the following compatible:
+	- "sprd,sc9860-clk" (only support SC9860 for the time being)
+
+- reg:	Must contain the registers base address and length.
+	Clocks on most of Spreadtrum's SoCs were designed to locate in a few
+	different address areas, so there would be more than one items under
+	this property.
+
+- #clock-cells: must be 1
+
+Example:
+
+clk: clk {
+	compatible = "sprd,sc9860-clk";
+	#clock-cells = <1>;
+	reg = <0 0x20000000 0 0x400>,
+	      <0 0x20210000 0 0x3000>,
+	      <0 0x402b0000 0 0x4000>,
+	      <0 0x402d0000 0 0x400>,
+	      <0 0x402e0000 0 0x4000>,
+	      <0 0x40400000 0 0x400>,
+	      <0 0x40880000 0 0x400>,
+	      <0 0x415e0000 0 0x400>,
+	      <0 0x60200000 0 0x400>,
+	      <0 0x61000000 0 0x400>,
+	      <0 0x61100000 0 0x3000>,
+	      <0 0x62000000 0 0x4000>,
+	      <0 0x62100000 0 0x4000>,
+	      <0 0x63000000 0 0x400>,
+	      <0 0x63100000 0 0x3000>,
+	      <0 0x70b00000 0 0x3000>;
+};
-- 
2.7.4
