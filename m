From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 17 Nov 2015 17:12:28 -0800
Subject: [PATCH 3/4] arm64: dts: qcom: Add pm8994, pmi8994,
 pm8004 PMIC skeletons
In-Reply-To: <1447809149-29724-1-git-send-email-sboyd@codeaurora.org>
References: <1447809149-29724-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1447809149-29724-4-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the skeleton nodes for the PMICs found on msm8996-mtp
devices.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/pm8004.dtsi  | 19 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/pm8994.dtsi  | 19 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/pmi8994.dtsi | 19 +++++++++++++++++++
 3 files changed, 57 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/pm8004.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/pm8994.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/pmi8994.dtsi

diff --git a/arch/arm64/boot/dts/qcom/pm8004.dtsi b/arch/arm64/boot/dts/qcom/pm8004.dtsi
new file mode 100644
index 000000000000..ef2207afa86b
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pm8004.dtsi
@@ -0,0 +1,19 @@
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/spmi/spmi.h>
+
+&spmi_bus {
+
+	pmic at 4 {
+		compatible = "qcom,pm8004", "qcom,spmi-pmic";
+		reg = <0x4 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	pmic at 5 {
+		compatible = "qcom,pm8004", "qcom,spmi-pmic";
+		reg = <0x5 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/pm8994.dtsi b/arch/arm64/boot/dts/qcom/pm8994.dtsi
new file mode 100644
index 000000000000..e61b376f0b7c
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pm8994.dtsi
@@ -0,0 +1,19 @@
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/spmi/spmi.h>
+
+&spmi_bus {
+
+	pmic at 0 {
+		compatible = "qcom,pm8994", "qcom,spmi-pmic";
+		reg = <0x0 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	pmic at 1 {
+		compatible = "qcom,pm8994", "qcom,spmi-pmic";
+		reg = <0x1 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/pmi8994.dtsi b/arch/arm64/boot/dts/qcom/pmi8994.dtsi
new file mode 100644
index 000000000000..d3879a4e8076
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pmi8994.dtsi
@@ -0,0 +1,19 @@
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/spmi/spmi.h>
+
+&spmi_bus {
+
+	pmic at 2 {
+		compatible = "qcom,pmi8994", "qcom,spmi-pmic";
+		reg = <0x2 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	pmic at 3 {
+		compatible = "qcom,pmi8994", "qcom,spmi-pmic";
+		reg = <0x3 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
