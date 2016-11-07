From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon,  7 Nov 2016 09:44:42 +0100
Subject: [PATCH 1/3 v4] ARM: dts: rename MSM8660/APQ8060 pmicintc to pm8058
Message-ID: <1478508284-10847-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The name "pmicintc" is ambiguous: there is a second power
management IC named PM8901 on these systems, and it is also
an interrupt controller. To make things clear, just name the
node alias "pm8058", this in unambigous and has all information
we need.

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v4:
- Add Bjorn's ACK.
- Follow version numbering of the primary patch.
---
 arch/arm/boot/dts/qcom-apq8060-dragonboard.dts |  2 +-
 arch/arm/boot/dts/qcom-msm8660-surf.dts        |  2 +-
 arch/arm/boot/dts/qcom-msm8660.dtsi            | 12 ++++++------
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts b/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
index 4b8872cc8bf9..4a532ddab53a 100644
--- a/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
+++ b/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
@@ -412,7 +412,7 @@
 				 * The second interrupt is the PME interrupt
 				 * for network wakeup, connected to the TLMM.
 				 */
-				interrupts-extended = <&pmicintc 198 IRQ_TYPE_EDGE_FALLING>,
+				interrupts-extended = <&pm8058 198 IRQ_TYPE_EDGE_FALLING>,
 						    <&tlmm 29 IRQ_TYPE_EDGE_RISING>;
 				reset-gpios = <&tlmm 30 GPIO_ACTIVE_LOW>;
 				vdd33a-supply = <&dragon_veth>;
diff --git a/arch/arm/boot/dts/qcom-msm8660-surf.dts b/arch/arm/boot/dts/qcom-msm8660-surf.dts
index 23de764558ab..1adc04978a47 100644
--- a/arch/arm/boot/dts/qcom-msm8660-surf.dts
+++ b/arch/arm/boot/dts/qcom-msm8660-surf.dts
@@ -48,7 +48,7 @@
 	};
 };
 
-&pmicintc {
+&pm8058 {
 	keypad at 148 {
 		linux,keymap = <
 			MATRIX_KEY(0, 0, KEY_FN_F1)
diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom-msm8660.dtsi
index 4d828f810746..91c9a62ae725 100644
--- a/arch/arm/boot/dts/qcom-msm8660.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8660.dtsi
@@ -163,7 +163,7 @@
 			reg = <0x500000 0x1000>;
 			qcom,controller-type = "pmic-arbiter";
 
-			pmicintc: pmic at 0 {
+			pm8058: pmic at 0 {
 				compatible = "qcom,pm8058";
 				interrupt-parent = <&tlmm>;
 				interrupts = <88 8>;
@@ -176,7 +176,7 @@
 					compatible = "qcom,pm8058-gpio",
 						     "qcom,ssbi-gpio";
 					reg = <0x150>;
-					interrupt-parent = <&pmicintc>;
+					interrupt-parent = <&pm8058>;
 					interrupts = <192 IRQ_TYPE_NONE>,
 						     <193 IRQ_TYPE_NONE>,
 						     <194 IRQ_TYPE_NONE>,
@@ -232,7 +232,7 @@
 					reg = <0x50>;
 					gpio-controller;
 					#gpio-cells = <2>;
-					interrupt-parent = <&pmicintc>;
+					interrupt-parent = <&pm8058>;
 					interrupts =
 					<128 IRQ_TYPE_NONE>,
 					<129 IRQ_TYPE_NONE>,
@@ -251,7 +251,7 @@
 				pwrkey at 1c {
 					compatible = "qcom,pm8058-pwrkey";
 					reg = <0x1c>;
-					interrupt-parent = <&pmicintc>;
+					interrupt-parent = <&pm8058>;
 					interrupts = <50 1>, <51 1>;
 					debounce = <15625>;
 					pull-up;
@@ -260,7 +260,7 @@
 				keypad at 148 {
 					compatible = "qcom,pm8058-keypad";
 					reg = <0x148>;
-					interrupt-parent = <&pmicintc>;
+					interrupt-parent = <&pm8058>;
 					interrupts = <74 1>, <75 1>;
 					debounce = <15>;
 					scan-delay = <32>;
@@ -270,7 +270,7 @@
 				rtc at 1e8 {
 					compatible = "qcom,pm8058-rtc";
 					reg = <0x1e8>;
-					interrupt-parent = <&pmicintc>;
+					interrupt-parent = <&pm8058>;
 					interrupts = <39 1>;
 					allow-set-time;
 				};
-- 
2.7.4
