From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 20 Nov 2015 15:31:19 -0800
Subject: [PATCH v2 4/5] arm64: dts: qcom: Alias pm8916 on msm8916 devices
In-Reply-To: <1448062280-15406-1-git-send-email-sboyd@codeaurora.org>
References: <1448062280-15406-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1448062280-15406-5-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an alias for pm8916 on msm8916 based SoCs so that the newly
updated dtbTool can find the pmic compatible string and add the
pmic-id element to the QCDT header.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi | 1 +
 arch/arm64/boot/dts/qcom/msm8916-mtp.dtsi | 1 +
 arch/arm64/boot/dts/qcom/pm8916.dtsi      | 6 +++---
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
index 6b8abbe68746..46bfcb9b2e84 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
@@ -20,6 +20,7 @@
 	aliases {
 		serial0 = &blsp1_uart2;
 		serial1 = &blsp1_uart1;
+		usid0 = &pm8916_0;
 	};
 
 	chosen {
diff --git a/arch/arm64/boot/dts/qcom/msm8916-mtp.dtsi b/arch/arm64/boot/dts/qcom/msm8916-mtp.dtsi
index a1aa0b201e92..ceeb8a6feed6 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-mtp.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-mtp.dtsi
@@ -17,6 +17,7 @@
 / {
 	aliases {
 		serial0 = &blsp1_uart2;
+		usid0 = &pm8916_0;
 	};
 
 	chosen {
diff --git a/arch/arm64/boot/dts/qcom/pm8916.dtsi b/arch/arm64/boot/dts/qcom/pm8916.dtsi
index b222ece7e3d2..37432451ee4c 100644
--- a/arch/arm64/boot/dts/qcom/pm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8916.dtsi
@@ -4,8 +4,8 @@
 
 &spmi_bus {
 
-	usid0: pm8916 at 0 {
-		compatible = "qcom,spmi-pmic";
+	pm8916_0: pm8916 at 0 {
+		compatible = "qcom,pm8916", "qcom,spmi-pmic";
 		reg = <0x0 SPMI_USID>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -90,7 +90,7 @@
 		};
 	};
 
-	usid1: pm8916 at 1 {
+	pm8916_1: pm8916 at 1 {
 		compatible = "qcom,spmi-pmic";
 		reg = <0x1 SPMI_USID>;
 		#address-cells = <1>;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
