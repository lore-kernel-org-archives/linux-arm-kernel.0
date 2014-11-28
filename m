From: flora.fu@mediatek.com (Flora Fu)
Date: Fri, 28 Nov 2014 11:54:32 +0800
Subject: [PATCH v2 6/8] dt-bindings: Add document for MT6397 regulator
In-Reply-To: <1417146874-5232-1-git-send-email-flora.fu@mediatek.com>
References: <1417146874-5232-1-git-send-email-flora.fu@mediatek.com>
Message-ID: <1417146874-5232-7-git-send-email-flora.fu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Flora Fu <flora.fu@mediatek.com>
---
 .../bindings/regulator/mt6397-regulator.txt        | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mt6397-regulator.txt

diff --git a/Documentation/devicetree/bindings/regulator/mt6397-regulator.txt b/Documentation/devicetree/bindings/regulator/mt6397-regulator.txt
new file mode 100644
index 0000000..3a3cc59
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mt6397-regulator.txt
@@ -0,0 +1,32 @@
+Mediatek MT6397 Regulator Driver
+
+Required properties:
+- compatible: "mediatek,mt6397"
+- regulators: This is the list of child nodes that specify the regulator
+  initialization data for defined regulators. The definition for each of these
+  nodes is defined using the standard binding for regulators found at
+  Documentation/devicetree/bindings/regulator/regulator.txt.
+
+Example:
+	pmic {
+		compatible = "mediatek,mt6397";
+
+		regulators {
+			mt6397_vpca15_reg: buck_vpca15 {
+				regulator-name = "vpca15";
+				regulator-min-microvolt = < 700000>;
+				regulator-max-microvolt = <1493750>;
+				regulator-ramp-delay = <12500>;
+				regulator-enable-ramp-delay = <200>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			mt6397_vgp4_reg: ldo_vgp4 {
+				regulator-name = "vgp4";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-enable-ramp-delay = <218>;
+			};
+		};
+	};
-- 
1.8.1.1.dirty
