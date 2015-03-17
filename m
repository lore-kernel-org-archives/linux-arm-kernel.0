From: iivanov@mm-sol.com (Ivan T. Ivanov)
Date: Tue, 17 Mar 2015 12:48:34 +0200
Subject: [PATCH v2 2/3] ARM: dts: qcom: Add 8x74 chipset SPMI PMIC's nodes
In-Reply-To: <1426589315-16847-1-git-send-email-iivanov@mm-sol.com>
References: <1426589315-16847-1-git-send-email-iivanov@mm-sol.com>
Message-ID: <1426589315-16847-3-git-send-email-iivanov@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PM8841 and PM8941 have 2 SPMI devices per physical package.
Add their configuration nodes and include them in boards
which are using 8x74 based chipset.

Reviewed-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Reviewed-by: Andy Gross <agross@codeaurora.org>
Signed-off-by: Ivan T. Ivanov <iivanov@mm-sol.com>
---
 arch/arm/boot/dts/qcom-apq8074-dragonboard.dts        |  2 ++
 arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts |  2 ++
 arch/arm/boot/dts/qcom-pm8841.dtsi                    | 18 ++++++++++++++++++
 arch/arm/boot/dts/qcom-pm8941.dtsi                    | 18 ++++++++++++++++++
 4 files changed, 40 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-pm8841.dtsi
 create mode 100644 arch/arm/boot/dts/qcom-pm8941.dtsi

diff --git a/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts b/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
index 4737049..d484d08 100644
--- a/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
+++ b/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
@@ -1,4 +1,6 @@
 #include "qcom-msm8974.dtsi"
+#include "qcom-pm8841.dtsi"
+#include "qcom-pm8941.dtsi"

 / {
 	model = "Qualcomm APQ8074 Dragonboard";
diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
index cccc21b..bd35b06 100644
--- a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
@@ -1,4 +1,6 @@
 #include "qcom-msm8974.dtsi"
+#include "qcom-pm8841.dtsi"
+#include "qcom-pm8941.dtsi"

 / {
 	model = "Sony Xperia Z1";
diff --git a/arch/arm/boot/dts/qcom-pm8841.dtsi b/arch/arm/boot/dts/qcom-pm8841.dtsi
new file mode 100644
index 0000000..45b5eaf
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-pm8841.dtsi
@@ -0,0 +1,18 @@
+#include <dt-bindings/spmi/spmi.h>
+
+&spmi_bus {
+
+	usid4: pm8841 at 4 {
+		compatible = "qcom,pm8841", "qcom,spmi-pmic";
+		reg = <0x4 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+	};
+
+	usid5: pm8841 at 5 {
+		compatible = "qcom,pm8841", "qcom,spmi-pmic";
+		reg = <0x5 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+	};
+};
diff --git a/arch/arm/boot/dts/qcom-pm8941.dtsi b/arch/arm/boot/dts/qcom-pm8941.dtsi
new file mode 100644
index 0000000..78069f5
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-pm8941.dtsi
@@ -0,0 +1,18 @@
+#include <dt-bindings/spmi/spmi.h>
+
+&spmi_bus {
+
+	usid0: pm8941 at 0 {
+		compatible = "qcom,pm8941", "qcom,spmi-pmic";
+		reg = <0x0 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+	};
+
+	usid1: pm8941 at 1 {
+		compatible = "qcom,pm8941", "qcom,spmi-pmic";
+		reg = <0x1 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+	};
+};
--
1.9.1
