From: chunyan.zhang@spreadtrum.com (Chunyan Zhang)
Date: Sun, 18 Jun 2017 09:58:47 +0800
Subject: [PATCH V1 1/9] dt-bindings: Add Spreadtrum CCU binding documentation
In-Reply-To: <20170618015855.27738-1-chunyan.zhang@spreadtrum.com>
References: <20170618015855.27738-1-chunyan.zhang@spreadtrum.com>
Message-ID: <20170618015855.27738-2-chunyan.zhang@spreadtrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce a new binding with its documentation for Spreadtrum clock
sub-framework.

Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
---
 .../devicetree/bindings/clock/sprd-ccu.txt         | 46 ++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sprd-ccu.txt

diff --git a/Documentation/devicetree/bindings/clock/sprd-ccu.txt b/Documentation/devicetree/bindings/clock/sprd-ccu.txt
new file mode 100644
index 0000000..7a1aa4c
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sprd-ccu.txt
@@ -0,0 +1,46 @@
+Spreadtrum Clock Control Unit Binding
+------------------------------------
+
+This binding uses the common clock binding[1].
+
+Required properties:
+- compatible: must contain the following compatible:
+                - "sprd,sc9860-ccu" (only support SC9860 for the time being)
+
+- reg:	Must contain the registers base address and length.
+	Clocks on most of Spreadtrum's SoCs were designed to locate in a few
+	different address areas, so there would be more than one items under
+	this property.
+
+- clock-names:	Must contain the following clock names:
+		- "ext-26m", "ext-rco-100m", "ext-32k"
+- #clock-cells: must be 1
+
+Example:
+
+ccu: clk {
+	compatible = "sprd,sc9860-ccu";
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
+	clocks = <&ext_26m>, <&ext_rco_100m>, <&ext_32k>;
+	clock-names = "ext-26m", "ext-rco-100m", "ext-32k";
+};
+
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+
-- 
2.7.4
