From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  7 Jun 2016 22:41:40 +0200
Subject: [PATCH v2 01/15] dt-bindings: sunxi: Add CCU binding documentation
In-Reply-To: <20160607204154.31967-1-maxime.ripard@free-electrons.com>
References: <20160607204154.31967-1-maxime.ripard@free-electrons.com>
Message-ID: <20160607204154.31967-2-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce a new binding with its documentation for the brand new clock
sub-framework.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 Documentation/devicetree/bindings/clock/sunxi-ccu.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sunxi-ccu.txt

diff --git a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
new file mode 100644
index 000000000000..2c66046a1342
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
@@ -0,0 +1,17 @@
+Allwinner Clock Control Unit Binding
+------------------------------------
+
+Required properties :
+- compatible: must contain one of the following compatible:
+		- "allwinner,sun8i-h3-ccu"
+
+- reg: Must contain the registers base address and length
+- clocks: phandle to the oscillators feeding the SPI controller. Two are
+          needed:
+  - "hosc": the high frequency oscillator (usually at 24MHz)
+  - "losc": the low frequency oscillator (usually at 32kHz)
+- clock-names: Must contain the clock names described just above
+- #clock-cells : must contain 1
+- #reset-cells : must contain 1
+
+Example:
-- 
2.8.3
