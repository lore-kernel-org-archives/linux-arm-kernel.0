From: megous@megous.com (megous at megous.com)
Date: Thu, 23 Jun 2016 21:20:54 +0200
Subject: [PATCH 04/14] dt-bindings: document sun8i_ths
In-Reply-To: <20160623192104.18720-1-megous@megous.com>
References: <20160623192104.18720-1-megous@megous.com>
Message-ID: <20160623192104.18720-5-megous@megous.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ondrej Jirman <megous@megous.com>

This patch adds the binding documentation for the sun8i_ths driver

Signed-off-by: Ond?ej Jirman <megous@megous.com>
---
 .../devicetree/bindings/thermal/sun8i-ths.txt      | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/sun8i-ths.txt

diff --git a/Documentation/devicetree/bindings/thermal/sun8i-ths.txt b/Documentation/devicetree/bindings/thermal/sun8i-ths.txt
new file mode 100644
index 0000000..826cd57
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/sun8i-ths.txt
@@ -0,0 +1,31 @@
+* sun8i THS
+
+Required properties:
+- compatible : "allwinner,sun8i-h3-ths"
+- reg : Address range of the thermal registers and location of the calibration
+        value
+- resets : Must contain an entry for each entry in reset-names.
+           see ../reset/reset.txt for details
+- reset-names : Must include the name "ahb"
+- clocks : Must contain an entry for each entry in clock-names.
+- clock-names : Must contain "ahb" for the bus gate and "ths" for the THS
+  clock
+
+Optional properties:
+- nvmem-cells : Must contain an entry for each entry in nvmem-cell-names
+- nvmem-cell-names : Must contain "calibration" for the cell containing the
+  temperature calibration cell, if available
+
+Example:
+ths: ths at 01c25000 {
+	#thermal-sensor-cells = <0>;
+	compatible = "allwinner,sun8i-h3-ths";
+	reg = <0x01c25000 0x400>;
+	interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
+	resets = <&bus_rst 136>;
+	reset-names = "ahb";
+	clocks = <&bus_gates 72>, <&ths_clk>;
+	clock-names = "ahb", "ths";
+	nvmem-cells = <&ths_calibration>;
+	nvmem-cell-names = "calibration";
+};
-- 
2.9.0
