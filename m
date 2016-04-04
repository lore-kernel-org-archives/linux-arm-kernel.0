From: ssambang@codeaurora.org (Sreedhar Sambangi)
Date: Mon,  4 Apr 2016 14:08:10 -0700
Subject: [PATCH 1/2] qcom: ipq4019: Add regulator support to DK04 device tree
Message-ID: <1459804090-31739-1-git-send-email-ssambang@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

    This adds the regulator nodes to DK04 device tree to support

Change-Id: I9c1df0e720a330bf6db1889fd2247f6a70ea6faa
Signed-off-by: Sreedhar Sambangi <ssambang@codeaurora.org>
---
 .../bindings/regulator/ipq4019-regulator.txt          | 19 +++++++++++++++++++
 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi         | 11 +++++++++++
 2 files changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/ipq4019-regulator.txt

diff --git a/Documentation/devicetree/bindings/regulator/ipq4019-regulator.txt b/Documentation/devicetree/bindings/regulator/ipq4019-regulator.txt
new file mode 100644
index 0000000..9d934a4
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/ipq4019-regulator.txt
@@ -0,0 +1,19 @@
+* Qualcomm Technologies, Inc. IPQ4019 regulators
+
+Required properties:
+- compatible		: Must be "regulator-ipq4019".
+- states		: Selection of available voltages and corresponding values
+- reg			: Register address for controlling LDO
+- mask			: Mask value for switching voltages
+Example:
+
+	vccq_sd0: regulator at 0 {
+		compatible = "qcom,regulator-ipq4019";
+		regulator-name = "SD0 VccQ";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3000000>;
+		states = <3000000 0x3
+			1800000 0x1>;
+		reg = <0x01948000 0x4>;
+		mask = <0x3>;
+	};
diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi b/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi
index 9f3c864..566e239 100644
--- a/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi
@@ -155,5 +155,16 @@
 		watchdog at b017000 {
 			status = "ok";
 		};
+
+		vccq_sd0: regulator at 0 {
+			compatible = "qcom,regulator-ipq4019";
+			regulator-name = "SD0 VccQ";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3000000>;
+			states = <3000000 0x3
+				1800000 0x1>;
+			reg = <0x01948000 0x4>;
+			mask = <0x3>;
+		};
 	};
 };
--
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
