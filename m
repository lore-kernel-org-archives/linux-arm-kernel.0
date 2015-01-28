From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 28 Jan 2015 13:36:12 -0800
Subject: [PATCH] arm: dts: qcom: Add LCC nodes
Message-ID: <1422480972-4105-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kumar Gala <galak@codeaurora.org>

Add the node for the LPASS clock controller found on a few qcom
SoCs so that the clock driver can probe.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Kumar Gala <galak@codeaurora.org>
[sboyd at codeaurora.org: Added apq8064 and msm8960 nodes]
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 7 +++++++
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 8 ++++++++
 arch/arm/boot/dts/qcom-msm8960.dtsi | 7 +++++++
 3 files changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index b3154c071652..7705752c212c 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -239,6 +239,13 @@
 			#reset-cells = <1>;
 		};
 
+		lcc: clock-controller at 28000000 {
+			compatible = "qcom,lcc-apq8064";
+			reg = <0x28000000 0x1000>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
 		mmcc: clock-controller at 4000000 {
 			compatible = "qcom,mmcc-apq8064";
 			reg = <0x4000000 0x1000>;
diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index cb225dafe97c..568260c387bb 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -279,5 +279,13 @@
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 		};
+
+		lcc: clock-controller at 28000000 {
+			compatible = "qcom,lcc-ipq8064";
+			reg = <0x28000000 0x1000>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
 	};
 };
diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
index e1b0d5cd9e3c..41ac308d4d68 100644
--- a/arch/arm/boot/dts/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
@@ -91,6 +91,13 @@
 			reg = <0x900000 0x4000>;
 		};
 
+		lcc: clock-controller at 28000000 {
+			compatible = "qcom,lcc-msm8960";
+			reg = <0x28000000 0x1000>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
 		clock-controller at 4000000 {
 			compatible = "qcom,mmcc-msm8960";
 			reg = <0x4000000 0x1000>;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
