From: flora.fu@mediatek.com (Flora Fu)
Date: Mon, 17 Nov 2014 15:40:25 +0800
Subject: [PATCH 5/7] dt-bindings: Add document for MT6397 regulator
In-Reply-To: <1416210027-5562-1-git-send-email-flora.fu@mediatek.com>
References: <1416210027-5562-1-git-send-email-flora.fu@mediatek.com>
Message-ID: <1416210027-5562-6-git-send-email-flora.fu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Flora Fu <flora.fu@mediatek.com>
---
 .../bindings/regulator/mt6397-regulator.txt        | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mt6397-regulator.txt

diff --git a/Documentation/devicetree/bindings/regulator/mt6397-regulator.txt b/Documentation/devicetree/bindings/regulator/mt6397-regulator.txt
new file mode 100644
index 0000000..019d9bd
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mt6397-regulator.txt
@@ -0,0 +1,31 @@
+Mediatek mt6397 regulator
+
+Required properties:
+- compatible: "mediatek,mt6397"
+- regulators: This is the list of child nodes that specify the regulator
+  initialization data for defined regulators. The definition for each of these
+  nodes is defined using the standard binding for regulators found at
+  Documentation/devicetree/bindings/regulator/regulator.txt.
+
+Example:
+
+	pmic {
+		compatible = "mediatek,mt6397";
+
+		regulators {
+
+			mt6397_vpca15_reg: buck_vpca15 {
+				regulator-name = "vpca15";
+				regulator-min-microvolt = < 700000>;
+				regulator-max-microvolt = <1493750>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			mt6397_vgp4_reg: ldo_vgp4 {
+				regulator-name = "vgp4";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3300000>;
+			};
+		};
+	};
-- 
1.8.1.1.dirty
