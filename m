From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 29 Jun 2016 21:05:22 +0200
Subject: [PATCH v3 01/14] dt-bindings: sunxi: Add CCU binding documentation
In-Reply-To: <20160629190535.11855-1-maxime.ripard@free-electrons.com>
References: <20160629190535.11855-1-maxime.ripard@free-electrons.com>
Message-ID: <20160629190535.11855-2-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce a new binding with its documentation for the brand new clock
sub-framework.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 .../devicetree/bindings/clock/sunxi-ccu.txt        | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sunxi-ccu.txt

diff --git a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
new file mode 100644
index 000000000000..cb91507ffb1e
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
@@ -0,0 +1,24 @@
+Allwinner Clock Control Unit Binding
+------------------------------------
+
+Required properties :
+- compatible: must contain one of the following compatible:
+		- "allwinner,sun8i-h3-ccu"
+
+- reg: Must contain the registers base address and length
+- clocks: phandle to the oscillators feeding the CCU. Two are needed:
+  - "hosc": the high frequency oscillator (usually at 24MHz)
+  - "losc": the low frequency oscillator (usually at 32kHz)
+- clock-names: Must contain the clock names described just above
+- #clock-cells : must contain 1
+- #reset-cells : must contain 1
+
+Example:
+ccu: clock at 01c20000 {
+	compatible = "allwinner,sun8i-h3-ccu";
+	reg = <0x01c20000 0x400>;
+	clocks = <&osc24M>, <&osc32k>;
+	clock-names = "hosc", "losc";
+	#clock-cells = <1>;
+	#reset-cells = <1>;
+};
-- 
2.9.0
