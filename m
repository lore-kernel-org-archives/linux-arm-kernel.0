From: henryc.chen@mediatek.com (Henry Chen)
Date: Fri, 24 Jul 2015 13:24:40 +0800
Subject: [PATCH v4 1/2] dt-bindings: regulator: mt6311: Add document for
 mt6311 regulator
In-Reply-To: <1437715481-31528-1-git-send-email-henryc.chen@mediatek.com>
References: <1437715481-31528-1-git-send-email-henryc.chen@mediatek.com>
Message-ID: <1437715481-31528-2-git-send-email-henryc.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a list of supported regulator names to the devicetree
binding documentation for Mediatek MT6311 PMIC.

Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
---
 .../bindings/regulator/mt6311-regulator.txt        | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mt6311-regulator.txt

diff --git a/Documentation/devicetree/bindings/regulator/mt6311-regulator.txt b/Documentation/devicetree/bindings/regulator/mt6311-regulator.txt
new file mode 100644
index 0000000..02649d8
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mt6311-regulator.txt
@@ -0,0 +1,35 @@
+Mediatek MT6311 Regulator Driver
+
+Required properties:
+- compatible: "mediatek,mt6311-regulator"
+- reg: I2C slave address, usually 0x6b.
+- regulators: List of regulators provided by this controller. It is named
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
+	mt6311: pmic at 6b {
+		compatible = "mediatek,mt6311-regulator";
+		reg = <0x6b>;
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
