From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 25 Nov 2015 14:27:36 -0800
Subject: [PATCH 1/2] ARM: dts: qcom: Remove size elements from pmic reg
 properties
In-Reply-To: <1448490457-9799-1-git-send-email-sboyd@codeaurora.org>
References: <1448490457-9799-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1448490457-9799-2-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The #size-cells for the pmics are 0, but we specify a size in the
reg property so that MPP and GPIO modules can figure out how many
pins there are. Now that we've done that by counting irqs, we can
remove the size elements in the reg properties and be DT
compliant.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/boot/dts/qcom-pm8841.dtsi |  4 ++--
 arch/arm/boot/dts/qcom-pm8941.dtsi | 22 +++++++++++-----------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-pm8841.dtsi b/arch/arm/boot/dts/qcom-pm8841.dtsi
index 9f357f68713c..0512f645922e 100644
--- a/arch/arm/boot/dts/qcom-pm8841.dtsi
+++ b/arch/arm/boot/dts/qcom-pm8841.dtsi
@@ -11,7 +11,7 @@
 
 		pm8841_mpps: mpps at a000 {
 			compatible = "qcom,pm8841-mpp", "qcom,spmi-mpp";
-			reg = <0xa000 0x400>;
+			reg = <0xa000>;
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupts = <4 0xa0 0 IRQ_TYPE_NONE>,
@@ -22,7 +22,7 @@
 
 		temp-alarm at 2400 {
 			compatible = "qcom,spmi-temp-alarm";
-			reg = <0x2400 0x100>;
+			reg = <0x2400>;
 			interrupts = <4 0x24 0 IRQ_TYPE_EDGE_RISING>;
 		};
 	};
diff --git a/arch/arm/boot/dts/qcom-pm8941.dtsi b/arch/arm/boot/dts/qcom-pm8941.dtsi
index 64622bd251d1..3960b96273ec 100644
--- a/arch/arm/boot/dts/qcom-pm8941.dtsi
+++ b/arch/arm/boot/dts/qcom-pm8941.dtsi
@@ -12,15 +12,15 @@
 
 		rtc at 6000 {
 			compatible = "qcom,pm8941-rtc";
-			reg = <0x6000 0x100>,
-			      <0x6100 0x100>;
+			reg = <0x6000>,
+			      <0x6100>;
 			reg-names = "rtc", "alarm";
 			interrupts = <0x0 0x61 0x1 IRQ_TYPE_EDGE_RISING>;
 		};
 
 		pwrkey at 800 {
 			compatible = "qcom,pm8941-pwrkey";
-			reg = <0x800 0x100>;
+			reg = <0x800>;
 			interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
 			debounce = <15625>;
 			bias-pull-up;
@@ -28,7 +28,7 @@
 
 		charger at 1000 {
 			compatible = "qcom,pm8941-charger";
-			reg = <0x1000 0x700>;
+			reg = <0x1000>;
 			interrupts = <0x0 0x10 7 IRQ_TYPE_EDGE_BOTH>,
 				     <0x0 0x10 5 IRQ_TYPE_EDGE_BOTH>,
 				     <0x0 0x10 4 IRQ_TYPE_EDGE_BOTH>,
@@ -49,7 +49,7 @@
 
 		pm8941_gpios: gpios at c000 {
 			compatible = "qcom,pm8941-gpio", "qcom,spmi-gpio";
-			reg = <0xc000 0x2400>;
+			reg = <0xc000>;
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupts = <0 0xc0 0 IRQ_TYPE_NONE>,
@@ -92,7 +92,7 @@
 
 		pm8941_mpps: mpps at a000 {
 			compatible = "qcom,pm8941-mpp", "qcom,spmi-mpp";
-			reg = <0xa000 0x800>;
+			reg = <0xa000>;
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupts = <0 0xa0 0 IRQ_TYPE_NONE>,
@@ -107,7 +107,7 @@
 
 		pm8941_temp: temp-alarm at 2400 {
 			compatible = "qcom,spmi-temp-alarm";
-			reg = <0x2400 0x100>;
+			reg = <0x2400>;
 			interrupts = <0 0x24 0 IRQ_TYPE_EDGE_RISING>;
 			io-channels = <&pm8941_vadc VADC_DIE_TEMP>;
 			io-channel-names = "thermal";
@@ -116,7 +116,7 @@
 
 		pm8941_vadc: vadc at 3100 {
 			compatible = "qcom,spmi-vadc";
-			reg = <0x3100 0x100>;
+			reg = <0x3100>;
 			interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -141,14 +141,14 @@
 
 		pm8941_iadc: iadc at 3600 {
 			compatible = "qcom,pm8941-iadc", "qcom,spmi-iadc";
-			reg = <0x3600 0x100>;
+			reg = <0x3600>;
 			interrupts = <0x0 0x36 0x0 IRQ_TYPE_EDGE_RISING>;
 			qcom,external-resistor-micro-ohms = <10000>;
 		};
 
 		coincell at 2800 {
 			compatible = "qcom,pm8941-coincell";
-			reg = <0x2800 0x100>;
+			reg = <0x2800>;
 			status = "disabled";
 		};
 	};
@@ -161,7 +161,7 @@
 
 		wled at d800 {
 			compatible = "qcom,pm8941-wled";
-			reg = <0xd800 0x100>;
+			reg = <0xd800>;
 			label = "backlight";
 
 			qcom,cs-out;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
