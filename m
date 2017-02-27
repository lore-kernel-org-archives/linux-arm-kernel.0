From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Tue, 28 Feb 2017 03:40:52 +0800
Subject: [PATCH 1/3] dt-bindings: document the thermal sensor of Allwinner H3
 SoC
Message-ID: <20170227194054.51951-1-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ondrej Jirman <megous@megous.com>

This patch adds the binding documentation for the thermal sensor
found in Allwinner H3 SoC.

Signed-off-by: Ond?ej Jirman <megous@megous.com>
[Icenowy: some adjustments to documentation and the commit message]
Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 .../devicetree/bindings/thermal/sun8i-ths.txt      | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/sun8i-ths.txt

diff --git a/Documentation/devicetree/bindings/thermal/sun8i-ths.txt b/Documentation/devicetree/bindings/thermal/sun8i-ths.txt
new file mode 100644
index 000000000000..eec094c459b8
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/sun8i-ths.txt
@@ -0,0 +1,35 @@
+* Thermal sensor for new Allwinner SoCs
+
+Required properties:
+- compatible : Should be one of the following:
+ - "allwinner,sun8i-h3-ths"
+- reg : Address range of the thermal sensor registers
+- resets : Must contain phandles to reset controls matching the entries
+  of the names
+- reset-names : Must include the name "ahb"
+- clocks : Must contain phandles to clock controls matching the entries
+  of the names
+- clock-names : Must contain "ahb" for the bus gate and "ths" for the THS
+  clock
+- #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description.
+
+Optional properties:
+- nvmem-cells: A phandle to the calibration data provided by a nvmem device. If
+               unspecified default values shall be used. Refer to
+               Documentation/devicetree/bindings/nvmem/nvmem.txt to know how to
+               specify nvmem cells.
+- nvmem-cell-names: Should be "cal"
+
+Example:
+ths: ths at 01c25000 {
+	compatible = "allwinner,sun8i-h3-ths";
+	reg = <0x01c25000 0x400>;
+	interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
+	resets = <&ccu RST_BUS_THS>;
+	reset-names = "ahb";
+	clocks = <&ccu CLK_BUS_THS>, <&ccu CLK_THS>;
+	clock-names = "ahb", "ths";
+	nvmem-cells = <&ths_cal>;
+	nvmem-cell-names = "cal";
+	#thermal-sensor-cells = <1>;
+};
-- 
2.11.1
