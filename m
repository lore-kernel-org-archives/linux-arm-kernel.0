From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Tue, 28 Jun 2016 18:13:22 +0800
Subject: [RFC PATCH 2/5] dt: bindings: add bindings for allwinner a23/33 ths
In-Reply-To: <20160628101325.2522-1-icenowy@aosc.xyz>
References: <20160628101325.2522-1-icenowy@aosc.xyz>
Message-ID: <20160628101325.2522-2-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the THS on A23/33 SoCs.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 .../devicetree/bindings/thermal/sun8iw3-thermal.txt  | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/sun8iw3-thermal.txt

diff --git a/Documentation/devicetree/bindings/thermal/sun8iw3-thermal.txt b/Documentation/devicetree/bindings/thermal/sun8iw3-thermal.txt
new file mode 100644
index 0000000..0cdcb9a
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/sun8iw3-thermal.txt
@@ -0,0 +1,20 @@
+* Thermal Sensor (THS) on Allwinner sun8i A23/33 SoCs
+
+Required properties:
+- compatible : should be "allwinner,sun8i-<name>-ths"
+   "allwinner,sun8i-a23-ths": found on A23 SoCs
+   "allwinner,sun8i-a33-ths": found on A33 SoCs
+- reg : physical base address of the controller and length of memory mapped
+	region.
+- clocks : Must contain an entry for each entry in clock-names.
+- clock-names : Shall be "pll2", since the THS on A23/33 is using audio PLL (PLL2).
+- #thermal-sensor-cells : Should be 0. See ./thermal.txt for a description.
+
+Example:
+ths: ths at 01c25000 {
+	#thermal-sensor-cells = <0>;
+	compatible = "allwinner,sun8i-a23-ths";
+	reg = <0x01c25000 0x44>;
+	clocks = <&pll2 0>;
+	clock-names = "pll2";
+};
-- 
2.9.0
