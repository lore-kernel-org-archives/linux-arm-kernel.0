From: joshc@codeaurora.org (Josh Cartwright)
Date: Fri, 9 Aug 2013 13:37:08 -0700
Subject: [PATCH RFC v2 5/5] spmi: document the PMIC arbiter SPMI bindings
In-Reply-To: <cover.1377202730.git.joshc@codeaurora.org>
References: <cover.1377202730.git.joshc@codeaurora.org>
Message-ID: <ea2d30d47cb54b4322231f5c319663ee9c996784.1377202730.git.joshc@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Josh Cartwright <joshc@codeaurora.org>
---
 .../bindings/spmi/qcom,spmi-pmic-arb.txt           | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt

diff --git a/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt b/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt
new file mode 100644
index 0000000..3965236
--- /dev/null
+++ b/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt
@@ -0,0 +1,36 @@
+Qualcomm SPMI Controller (PMIC Arbiter)
+
+The SPMI PMIC Arbiter is found on the Snapdragon 800 Series.  It is an SPMI
+controller with wrapping arbitration logic to allow for multiple on-chip
+devices to control a single SPMI master.
+
+See spmi.txt for the generic SPMI controller bindings.
+
+Required properties:
+- compatible : should be "qcom,spmi-pmic-arb".
+- reg-names  : should be "core", "intr", "cnfg"
+- reg : offset and length of the PMIC Arbiter Core register map.
+- reg : offset and length of the PMIC Arbiter Interrupt controller register map.
+- reg : offset and length of the PMIC Arbiter Configuration register map.
+- #address-cells : must be set to 1
+- #size-cells : must be set to 0
+
+Child nodes:
+
+Zero or more child nodes must be specified as per the spmi.txt document.
+
+Example:
+
+	qcom,spmi at fc4c0000 {
+		compatible = "qcom,spmi-pmic-arb";
+		reg-names = "core", "intr", "cnfg";
+		reg = <0xfc4cf000 0x1000>,
+		      <0Xfc4cb000 0x1000>,
+		      <0Xfc4ca000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		qcom,pm8841 at 4 {
+			reg = <0x4>;
+		};
+	};
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
