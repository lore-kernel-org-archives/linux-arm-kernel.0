From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Thu, 23 Mar 2017 23:30:44 +0100
Subject: [PATCH V2 1/2] dt-bindings: thermal: add support for Broadcom's
 Northstar thermal
In-Reply-To: <20170318155632.18099-1-zajec5@gmail.com>
References: <20170318155632.18099-1-zajec5@gmail.com>
Message-ID: <20170323223045.15786-1-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rafa? Mi?ecki <rafal@milecki.pl>

This commit documents binding for thermal used in Northstar family SoCs.

Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
---
 .../devicetree/bindings/thermal/brcm,ns-thermal         | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/brcm,ns-thermal

diff --git a/Documentation/devicetree/bindings/thermal/brcm,ns-thermal b/Documentation/devicetree/bindings/thermal/brcm,ns-thermal
new file mode 100644
index 000000000000..9a22dd76ec01
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/brcm,ns-thermal
@@ -0,0 +1,17 @@
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
+thermal {
+	compatible = "brcm,ns-thermal";
+	reg = <0x1800c2c0 0x10>;
+	#thermal-sensor-cells = <0>;
+};
-- 
2.11.0
