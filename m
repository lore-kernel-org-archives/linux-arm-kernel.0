From: megous@megous.com (megous at megous.com)
Date: Sat, 25 Jun 2016 05:45:00 +0200
Subject: [PATCH v2 03/14] dt-bindings: document sun8i_ths - H3 thermal sensor
 driver
In-Reply-To: <20160625034511.7966-1-megous@megous.com>
References: <20160625034511.7966-1-megous@megous.com>
Message-ID: <20160625034511.7966-4-megous@megous.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ondrej Jirman <megous@megous.com>

This patch adds the binding documentation for the
sun8i_ths driver. This is a driver for thermal sensor
found in Allwinner H3 SoC.

Signed-off-by: Ond?ej Jirman <megous@megous.com>
---
 .../devicetree/bindings/thermal/sun8i-ths.txt      | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/sun8i-ths.txt

diff --git a/Documentation/devicetree/bindings/thermal/sun8i-ths.txt b/Documentation/devicetree/bindings/thermal/sun8i-ths.txt
new file mode 100644
index 0000000..76859d4
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/sun8i-ths.txt
@@ -0,0 +1,26 @@
+* Thermal sensor driver for Allwinner H3 SoC
+
+Required properties:
+- compatible : "allwinner,sun8i-h3-ths"
+- reg : Address range of the thermal sensor registers and of the calibration
+  data
+- resets : Must contain phandles to reset controls matching the entries
+  of the names
+- reset-names : Must include the name "ahb"
+- clocks : Must contain phandles to clock controls matching the entries
+  of the names
+- clock-names : Must contain "ahb" for the bus gate and "ths" for the THS
+  clock
+
+Example:
+ths: ths at 01c25000 {
+	#thermal-sensor-cells = <0>;
+	compatible = "allwinner,sun8i-h3-ths";
+	reg = <0x01c25000 0x400>,
+	      <0x01c14234 0x4>;
+	interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
+	resets = <&bus_rst 136>;
+	reset-names = "ahb";
+	clocks = <&bus_gates 72>, <&ths_clk>;
+	clock-names = "ahb", "ths";
+};
-- 
2.9.0
