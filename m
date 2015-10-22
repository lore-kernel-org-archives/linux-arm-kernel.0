From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Thu, 22 Oct 2015 11:13:49 -0700
Subject: [PATCH 2/4] ARM: dts: qcom: apq8064: Declare all pm8921 regulators
In-Reply-To: <1445537631-29055-1-git-send-email-bjorn.andersson@sonymobile.com>
References: <1445537631-29055-1-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <1445537631-29055-3-git-send-email-bjorn.andersson@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Consolidate all labeling of regulators into the core 8064 dtsi file to
make them available from all other dts files.

Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
---
 arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts | 16 +++++-----
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts  | 20 ++++++-------
 arch/arm/boot/dts/qcom-apq8064.dtsi         | 46 +++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts b/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
index 03784f1366e5..21095dad7741 100644
--- a/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
@@ -54,7 +54,7 @@
 
 
 				/* Buck SMPS */
-				pm8921_s1: s1 {
+				s1 {
 					regulator-always-on;
 					regulator-min-microvolt = <1225000>;
 					regulator-max-microvolt = <1225000>;
@@ -62,43 +62,43 @@
 					bias-pull-down;
 				};
 
-				pm8921_s3: s3 {
+				s3 {
 					regulator-min-microvolt = <1000000>;
 					regulator-max-microvolt = <1400000>;
 					qcom,switch-mode-frequency = <4800000>;
 				};
 
-				pm8921_s4: s4 {
+				s4 {
 					regulator-min-microvolt	= <1800000>;
 					regulator-max-microvolt	= <1800000>;
 					qcom,switch-mode-frequency = <3200000>;
 				};
 
-				pm8921_s7: s7 {
+				s7 {
 					regulator-min-microvolt = <1300000>;
 					regulator-max-microvolt = <1300000>;
 					qcom,switch-mode-frequency = <3200000>;
 				};
 
-				pm8921_l3: l3 {
+				l3 {
 					regulator-min-microvolt = <3050000>;
 					regulator-max-microvolt = <3300000>;
 					bias-pull-down;
 				};
 
-				pm8921_l4: l4 {
+				l4 {
 					regulator-min-microvolt = <1000000>;
 					regulator-max-microvolt = <1800000>;
 					bias-pull-down;
 				};
 
-				pm8921_l5: l5 {
+				l5 {
 					regulator-min-microvolt = <2750000>;
 					regulator-max-microvolt = <3000000>;
 					bias-pull-down;
 				};
 
-				pm8921_l23: l23 {
+				l23 {
 					regulator-min-microvolt = <1700000>;
 					regulator-max-microvolt = <1900000>;
 					bias-pull-down;
diff --git a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
index 11ac608b6d50..f40e93f09673 100644
--- a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
@@ -64,7 +64,7 @@
 
 
 				/* Buck SMPS */
-				pm8921_s1: s1 {
+				s1 {
 					regulator-always-on;
 					regulator-min-microvolt = <1225000>;
 					regulator-max-microvolt = <1225000>;
@@ -72,55 +72,55 @@
 					bias-pull-down;
 				};
 
-				pm8921_s3: s3 {
+				s3 {
 					regulator-min-microvolt = <1000000>;
 					regulator-max-microvolt = <1400000>;
 					qcom,switch-mode-frequency = <4800000>;
 				};
 
-				pm8921_s4: s4 {
+				s4 {
 					regulator-min-microvolt	= <1800000>;
 					regulator-max-microvolt	= <1800000>;
 					qcom,switch-mode-frequency = <3200000>;
 				};
 
-				pm8921_s7: s7 {
+				s7 {
 					regulator-min-microvolt = <1300000>;
 					regulator-max-microvolt = <1300000>;
 					qcom,switch-mode-frequency = <3200000>;
 				};
 
-				pm8921_l3: l3 {
+				l3 {
 					regulator-min-microvolt = <3050000>;
 					regulator-max-microvolt = <3300000>;
 					bias-pull-down;
 				};
 
-				pm8921_l4: l4 {
+				l4 {
 					regulator-min-microvolt = <1000000>;
 					regulator-max-microvolt = <1800000>;
 					bias-pull-down;
 				};
 
-				pm8921_l5: l5 {
+				l5 {
 					regulator-min-microvolt = <2750000>;
 					regulator-max-microvolt = <3000000>;
 					bias-pull-down;
 				};
 
-				pm8921_l6: l6 {
+				l6 {
 					regulator-min-microvolt = <2950000>;
 					regulator-max-microvolt = <2950000>;
 					bias-pull-down;
 				};
 
-				pm8921_l23: l23 {
+				l23 {
 					regulator-min-microvolt = <1700000>;
 					regulator-max-microvolt = <1900000>;
 					bias-pull-down;
 				};
 
-				pm8921_lvs1: lvs1 {
+				lvs1 {
 					bias-pull-down;
 				};
 			};
diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 1b64723bd8a0..1bc6c4039dea 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -473,9 +473,55 @@
 			regulators {
 				compatible = "qcom,rpm-pm8921-regulators";
 
+				pm8921_s1: s1 {};
+				pm8921_s2: s2 {};
+				pm8921_s3: s3 {};
+				pm8921_s4: s4 {};
+				pm8921_s7: s7 {};
+				pm8921_s8: s8 {};
+
+				pm8921_l1: l1 {};
+				pm8921_l2: l2 {};
+				pm8921_l3: l3 {};
+				pm8921_l4: l4 {};
+				pm8921_l5: l5 {};
+				pm8921_l6: l6 {};
+				pm8921_l7: l7 {};
+				pm8921_l8: l8 {};
+				pm8921_l9: l9 {};
+				pm8921_l10: l10 {};
+				pm8921_l11: l11 {};
+				pm8921_l12: l12 {};
+				pm8921_l14: l14 {};
+				pm8921_l15: l15 {};
+				pm8921_l16: l16 {};
+				pm8921_l17: l17 {};
+				pm8921_l18: l18 {};
+				pm8921_l21: l21 {};
+				pm8921_l22: l22 {};
+				pm8921_l23: l23 {};
+				pm8921_l24: l24 {};
+				pm8921_l25: l25 {};
+				pm8921_l26: l26 {};
+				pm8921_l27: l27 {};
+				pm8921_l28: l28 {};
+				pm8921_l29: l29 {};
+
+				pm8921_lvs1: lvs1 {};
+				pm8921_lvs2: lvs2 {};
+				pm8921_lvs3: lvs3 {};
+				pm8921_lvs4: lvs4 {};
+				pm8921_lvs5: lvs5 {};
+				pm8921_lvs6: lvs6 {};
+				pm8921_lvs7: lvs7 {};
+
+				pm8921_usb_switch: usb-switch {};
+
 				pm8921_hdmi_switch: hdmi-switch {
 					bias-pull-down;
 				};
+
+				pm8921_ncp: ncp {};
 			};
 		};
 
-- 
2.4.2
