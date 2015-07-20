From: henryc.chen@mediatek.com (Henry Chen)
Date: Mon, 20 Jul 2015 15:36:32 +0800
Subject: [PATCH 1/2] dt-bindings: Add document for MT6311 regulator
In-Reply-To: <1437377793-31558-1-git-send-email-henryc.chen@mediatek.com>
References: <1437377793-31558-1-git-send-email-henryc.chen@mediatek.com>
Message-ID: <1437377793-31558-2-git-send-email-henryc.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a list of supported regulator names to the devicetree
binding documentation for Mediatek MT6311 PMIC.

Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
---
 .../bindings/regulator/mt6311-regulator.txt        | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mt6311-regulator.txt

diff --git a/Documentation/devicetree/bindings/regulator/mt6311-regulator.txt b/Documentation/devicetree/bindings/regulator/mt6311-regulator.txt
new file mode 100644
index 0000000..c607029
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mt6311-regulator.txt
@@ -0,0 +1,34 @@
+Mediatek MT6311 Regulator Driver
+
+Required properties:
+- compatible: "mediatek,mt6311-regulator"
+- mt6311regulator: List of regulators provided by this controller. It is named
+  to VDVFS and VBIASN.
+  The definition for each of these nodes is defined using the standard binding
+  for regulators at Documentation/devicetree/bindings/regulator/regulator.txt.
+
+The valid names for regulators are:
+BUCK:
+  VDVFS
+LDO:
+  VBIASN
+
+Example:
+	pmic: mt6311 at 6B {
+		compatible = "mediatek,mt6311-regulator";
+		reg = <0x6B>;
+
+		regulators {
+			mt6311_vcpu_reg: VDVFS {
+				regulator-name = "VDVFS";
+				regulator-min-microvolt = < 600000>;
+				regulator-max-microvolt = <1400000>;
+				regulator-ramp-delay = <10000>;
+			};
+			mt6311_ldo_reg: VBIASN {
+				regulator-name = "VBIASN";
+				regulator-min-microvolt = <200000>;
+				regulator-max-microvolt = <800000>;
+			};
+		};
+	};
-- 
1.8.1.1.dirty
