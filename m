From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 20 Nov 2015 15:31:20 -0800
Subject: [PATCH v2 5/5] arm: dts: qcom: Add aliases for PMICs
In-Reply-To: <1448062280-15406-1-git-send-email-sboyd@codeaurora.org>
References: <1448062280-15406-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1448062280-15406-6-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an alias for the PMICs found on qcom based SoCs so that the
newly updated dtbTool can find the PMIC compatible string and add
the pmic-id element to the QCDT header.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/boot/dts/qcom-apq8074-dragonboard.dts | 2 ++
 arch/arm/boot/dts/qcom-apq8084-ifc6540.dts     | 1 +
 arch/arm/boot/dts/qcom-apq8084-mtp.dts         | 1 +
 arch/arm/boot/dts/qcom-pm8841.dtsi             | 8 ++++----
 arch/arm/boot/dts/qcom-pm8941.dtsi             | 8 ++++----
 arch/arm/boot/dts/qcom-pma8084.dtsi            | 8 ++++----
 6 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts b/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
index 835bdc71c5ba..c0e205315042 100644
--- a/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
+++ b/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
@@ -8,6 +8,8 @@
 
 	aliases {
 		serial0 = &blsp1_uart2;
+		usid0 = &pm8941_0;
+		usid4 = &pm8841_0;
 	};
 
 	chosen {
diff --git a/arch/arm/boot/dts/qcom-apq8084-ifc6540.dts b/arch/arm/boot/dts/qcom-apq8084-ifc6540.dts
index 32aaa9d45228..2052b84a77c6 100644
--- a/arch/arm/boot/dts/qcom-apq8084-ifc6540.dts
+++ b/arch/arm/boot/dts/qcom-apq8084-ifc6540.dts
@@ -7,6 +7,7 @@
 
 	aliases {
 		serial0 = &blsp2_uart2;
+		usid0 = &pma8084_0;
 	};
 
 	chosen {
diff --git a/arch/arm/boot/dts/qcom-apq8084-mtp.dts b/arch/arm/boot/dts/qcom-apq8084-mtp.dts
index 3016c7048d44..d174d15bcf70 100644
--- a/arch/arm/boot/dts/qcom-apq8084-mtp.dts
+++ b/arch/arm/boot/dts/qcom-apq8084-mtp.dts
@@ -7,6 +7,7 @@
 
 	aliases {
 		serial0 = &blsp2_uart2;
+		usid0 = &pma8084_0;
 	};
 
 	chosen {
diff --git a/arch/arm/boot/dts/qcom-pm8841.dtsi b/arch/arm/boot/dts/qcom-pm8841.dtsi
index 8f1a0b162017..523bee959f98 100644
--- a/arch/arm/boot/dts/qcom-pm8841.dtsi
+++ b/arch/arm/boot/dts/qcom-pm8841.dtsi
@@ -3,8 +3,8 @@
 
 &spmi_bus {
 
-	usid4: pm8841 at 4 {
-		compatible = "qcom,spmi-pmic";
+	pm8841_0: pm8841 at 4 {
+		compatible = "qcom,pm8841", "qcom,spmi-pmic";
 		reg = <0x4 SPMI_USID>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -27,8 +27,8 @@
 		};
 	};
 
-	usid5: pm8841 at 5 {
-		compatible = "qcom,spmi-pmic";
+	pm8841_1: pm8841 at 5 {
+		compatible = "qcom,pm8841", "qcom,spmi-pmic";
 		reg = <0x5 SPMI_USID>;
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/qcom-pm8941.dtsi b/arch/arm/boot/dts/qcom-pm8941.dtsi
index c19a48732b2d..12c1202ba2ca 100644
--- a/arch/arm/boot/dts/qcom-pm8941.dtsi
+++ b/arch/arm/boot/dts/qcom-pm8941.dtsi
@@ -4,8 +4,8 @@
 
 &spmi_bus {
 
-	usid0: pm8941 at 0 {
-		compatible ="qcom,spmi-pmic";
+	pm8941_0: pm8941 at 0 {
+		compatible = "qcom,pm8941", "qcom,spmi-pmic";
 		reg = <0x0 SPMI_USID>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -153,8 +153,8 @@
 		};
 	};
 
-	usid1: pm8941 at 1 {
-		compatible = "qcom,spmi-pmic";
+	pm8941_1: pm8941 at 1 {
+		compatible = "qcom,pm8941", "qcom,spmi-pmic";
 		reg = <0x1 SPMI_USID>;
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/qcom-pma8084.dtsi b/arch/arm/boot/dts/qcom-pma8084.dtsi
index 5e240ccc08b7..10b8f9e6d60b 100644
--- a/arch/arm/boot/dts/qcom-pma8084.dtsi
+++ b/arch/arm/boot/dts/qcom-pma8084.dtsi
@@ -4,8 +4,8 @@
 
 &spmi_bus {
 
-	usid0: pma8084 at 0 {
-		compatible = "qcom,spmi-pmic";
+	pma8084_0: pma8084 at 0 {
+		compatible = "qcom,pma8084", "qcom,spmi-pmic";
 		reg = <0x0 SPMI_USID>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -101,8 +101,8 @@
 		};
 	};
 
-	usid1: pma8084 at 1 {
-		compatible = "qcom,spmi-pmic";
+	pma8084_1: pma8084 at 1 {
+		compatible = "qcom,pma8084", "qcom,spmi-pmic";
 		reg = <0x1 SPMI_USID>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
