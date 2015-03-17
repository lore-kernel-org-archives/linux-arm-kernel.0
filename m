From: iivanov@mm-sol.com (Ivan T. Ivanov)
Date: Tue, 17 Mar 2015 12:48:35 +0200
Subject: [PATCH v2 3/3] ARM: dts: qcom: Add APQ8084 chipset SPMI PMIC's nodes
In-Reply-To: <1426589315-16847-1-git-send-email-iivanov@mm-sol.com>
References: <1426589315-16847-1-git-send-email-iivanov@mm-sol.com>
Message-ID: <1426589315-16847-4-git-send-email-iivanov@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PMA8084 have 2 SPMI devices per physical package. Add their
configuration nodes and include them in boards which are using
AQP8084 based chipset.

Reviewed-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Reviewed-by: Andy Gross <agross@codeaurora.org>
Signed-off-by: Ivan T. Ivanov <iivanov@mm-sol.com>
---
 arch/arm/boot/dts/qcom-apq8084-ifc6540.dts |  1 +
 arch/arm/boot/dts/qcom-apq8084-mtp.dts     |  1 +
 arch/arm/boot/dts/qcom-pma8084.dtsi        | 18 ++++++++++++++++++
 3 files changed, 20 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-pma8084.dtsi

diff --git a/arch/arm/boot/dts/qcom-apq8084-ifc6540.dts b/arch/arm/boot/dts/qcom-apq8084-ifc6540.dts
index c9ff108..f7725b9 100644
--- a/arch/arm/boot/dts/qcom-apq8084-ifc6540.dts
+++ b/arch/arm/boot/dts/qcom-apq8084-ifc6540.dts
@@ -1,4 +1,5 @@
 #include "qcom-apq8084.dtsi"
+#include "qcom-pma8084.dtsi"

 / {
 	model = "Qualcomm APQ8084/IFC6540";
diff --git a/arch/arm/boot/dts/qcom-apq8084-mtp.dts b/arch/arm/boot/dts/qcom-apq8084-mtp.dts
index 8ecec58..cb43acf 100644
--- a/arch/arm/boot/dts/qcom-apq8084-mtp.dts
+++ b/arch/arm/boot/dts/qcom-apq8084-mtp.dts
@@ -1,4 +1,5 @@
 #include "qcom-apq8084.dtsi"
+#include "qcom-pma8084.dtsi"

 / {
 	model = "Qualcomm APQ 8084-MTP";
diff --git a/arch/arm/boot/dts/qcom-pma8084.dtsi b/arch/arm/boot/dts/qcom-pma8084.dtsi
new file mode 100644
index 0000000..b1116a1
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-pma8084.dtsi
@@ -0,0 +1,18 @@
+#include <dt-bindings/spmi/spmi.h>
+
+&spmi_bus {
+
+	usid0: pma8084 at 0 {
+		compatible = "qcom,pma8084", "qcom,spmi-pmic";
+		reg = <0x0 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+	};
+
+	usid1: pma8084 at 1 {
+		compatible = "qcom,pma8084", "qcom,spmi-pmic";
+		reg = <0x1 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+	};
+};
--
1.9.1
