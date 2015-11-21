From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 20 Nov 2015 17:49:46 -0800
Subject: [PATCH] arm: dts: qcom: Add generic PMIC gpio/MPP compat strings
Message-ID: <1448070586-2653-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the generic compatible strings for the PMIC gpio and MPP
modules found on qcom based PMICs.

Cc: <devicetree@vger.kernel.org>
Cc: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 6 ++++--
 arch/arm/boot/dts/qcom-pm8841.dtsi  | 2 +-
 arch/arm/boot/dts/qcom-pm8941.dtsi  | 4 ++--
 arch/arm/boot/dts/qcom-pma8084.dtsi | 4 ++--
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 11aca7fb1793..d0670d0ee08c 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -430,7 +430,8 @@
 
 				pm8921_gpio: gpio at 150 {
 
-					compatible = "qcom,pm8921-gpio";
+					compatible = "qcom,pm8921-gpio",
+						     "qcom,ssbi-gpio";
 					reg = <0x150>;
 					interrupts = <192 1>, <193 1>, <194 1>,
 						     <195 1>, <196 1>, <197 1>,
@@ -454,7 +455,8 @@
 				};
 
 				pm8921_mpps: mpps at 50 {
-					compatible = "qcom,pm8921-mpp";
+					compatible = "qcom,pm8921-mpp",
+						     "qcom,ssbi-mpp";
 					reg = <0x50>;
 					gpio-controller;
 					#gpio-cells = <2>;
diff --git a/arch/arm/boot/dts/qcom-pm8841.dtsi b/arch/arm/boot/dts/qcom-pm8841.dtsi
index 523bee959f98..9f357f68713c 100644
--- a/arch/arm/boot/dts/qcom-pm8841.dtsi
+++ b/arch/arm/boot/dts/qcom-pm8841.dtsi
@@ -10,7 +10,7 @@
 		#size-cells = <0>;
 
 		pm8841_mpps: mpps at a000 {
-			compatible = "qcom,pm8841-mpp";
+			compatible = "qcom,pm8841-mpp", "qcom,spmi-mpp";
 			reg = <0xa000 0x400>;
 			gpio-controller;
 			#gpio-cells = <2>;
diff --git a/arch/arm/boot/dts/qcom-pm8941.dtsi b/arch/arm/boot/dts/qcom-pm8941.dtsi
index 12c1202ba2ca..64622bd251d1 100644
--- a/arch/arm/boot/dts/qcom-pm8941.dtsi
+++ b/arch/arm/boot/dts/qcom-pm8941.dtsi
@@ -48,7 +48,7 @@
 		};
 
 		pm8941_gpios: gpios at c000 {
-			compatible = "qcom,pm8941-gpio";
+			compatible = "qcom,pm8941-gpio", "qcom,spmi-gpio";
 			reg = <0xc000 0x2400>;
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -91,7 +91,7 @@
 		};
 
 		pm8941_mpps: mpps at a000 {
-			compatible = "qcom,pm8941-mpp";
+			compatible = "qcom,pm8941-mpp", "qcom,spmi-mpp";
 			reg = <0xa000 0x800>;
 			gpio-controller;
 			#gpio-cells = <2>;
diff --git a/arch/arm/boot/dts/qcom-pma8084.dtsi b/arch/arm/boot/dts/qcom-pma8084.dtsi
index 10b8f9e6d60b..4e9bd3f88473 100644
--- a/arch/arm/boot/dts/qcom-pma8084.dtsi
+++ b/arch/arm/boot/dts/qcom-pma8084.dtsi
@@ -19,7 +19,7 @@
 		};
 
 		pma8084_gpios: gpios at c000 {
-			compatible = "qcom,pma8084-gpio";
+			compatible = "qcom,pma8084-gpio", "qcom,spmi-gpio";
 			reg = <0xc000 0x1600>;
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -48,7 +48,7 @@
 		};
 
 		pma8084_mpps: mpps at a000 {
-			compatible = "qcom,pma8084-mpp";
+			compatible = "qcom,pma8084-mpp", "qcom,spmi-mpp";
 			reg = <0xa000 0x800>;
 			gpio-controller;
 			#gpio-cells = <2>;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
