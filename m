From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Fri, 31 Mar 2017 09:31:31 +0200
Subject: [PATCH V3 1/2] dt-bindings: thermal: add support for Broadcom's
 Northstar thermal
In-Reply-To: <20170323223045.15786-1-zajec5@gmail.com>
References: <20170323223045.15786-1-zajec5@gmail.com>
Message-ID: <20170331073132.21457-1-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rafa? Mi?ecki <rafal@milecki.pl>

This commit documents binding for thermal used in Northstar family SoCs.

Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
---
V3: Add thermal-zones to the example
    Rob: Because of this update, I didn't include Acked-by I got for V2
---
 .../devicetree/bindings/thermal/brcm,ns-thermal    | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/brcm,ns-thermal

diff --git a/Documentation/devicetree/bindings/thermal/brcm,ns-thermal b/Documentation/devicetree/bindings/thermal/brcm,ns-thermal
new file mode 100644
index 000000000000..c561c7349f17
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/brcm,ns-thermal
@@ -0,0 +1,26 @@
+* Broadcom Northstar Thermal
+
+This binding describes thermal sensor that is part of Northstar's DMU (Device
+Management Unit).
+
+Required properties:
+- compatible : Must be "brcm,ns-thermal"
+- reg : iomem address range of PVTMON registers
+- #thermal-sensor-cells : Should be <0>
+
+Example:
+
+thermal: thermal at 1800c2c0 {
+	compatible = "brcm,ns-thermal";
+	reg = <0x1800c2c0 0x10>;
+	#thermal-sensor-cells = <0>;
+};
+
+thermal-zones {
+	cpu_thermal: cpu-thermal {
+		polling-delay-passive = <0>;
+		polling-delay = <1000>;
+		coefficients = <(-556) 418000>;
+		thermal-sensors = <&thermal>;
+	};
+};
-- 
2.11.0
