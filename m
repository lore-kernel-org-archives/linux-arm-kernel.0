From: agross@codeaurora.org (Andy Gross)
Date: Tue, 27 Jan 2015 16:10:42 -0600
Subject: [PATCH 4/6] ARM: DT: ipq8064: Add TCSR support
In-Reply-To: <1422396644-21714-1-git-send-email-agross@codeaurora.org>
References: <1422396644-21714-1-git-send-email-agross@codeaurora.org>
Message-ID: <1422396644-21714-5-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds TCSR support for use by the GSBI to automatically configure ADM
CRCI values based on the GSBI port configuration.

Signed-off-by: Andy Gross <agross@codeaurora.org>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi |   20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 63b2146..e47358d 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -119,7 +119,7 @@
 		};
 
 		gsbi2: gsbi at 12480000 {
-			compatible = "qcom,gsbi-v1.0.0";
+			compatible = "qcom,gsbi-ipq8064";
 			reg = <0x12480000 0x100>;
 			clocks = <&gcc GSBI2_H_CLK>;
 			clock-names = "iface";
@@ -128,6 +128,9 @@
 			ranges;
 			status = "disabled";
 
+			qcom,gsbi-num = <2>;
+			syscon-tcsr = <&tcsr>;
+
 			serial at 12490000 {
 				compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
 				reg = <0x12490000 0x1000>,
@@ -154,7 +157,7 @@
 		};
 
 		gsbi4: gsbi at 16300000 {
-			compatible = "qcom,gsbi-v1.0.0";
+			compatible = "qcom,gsbi-ipq8064";
 			reg = <0x16300000 0x100>;
 			clocks = <&gcc GSBI4_H_CLK>;
 			clock-names = "iface";
@@ -163,6 +166,9 @@
 			ranges;
 			status = "disabled";
 
+			qcom,gsbi-num = <4>;
+			syscon-tcsr = <&tcsr>;
+
 			serial at 16340000 {
 				compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
 				reg = <0x16340000 0x1000>,
@@ -188,7 +194,7 @@
 		};
 
 		gsbi5: gsbi at 1a200000 {
-			compatible = "qcom,gsbi-v1.0.0";
+			compatible = "qcom,gsbi-ipq8064";
 			reg = <0x1a200000 0x100>;
 			clocks = <&gcc GSBI5_H_CLK>;
 			clock-names = "iface";
@@ -197,6 +203,9 @@
 			ranges;
 			status = "disabled";
 
+			qcom,gsbi-num = <5>;
+			syscon-tcsr = <&tcsr>;
+
 			serial at 1a240000 {
 				compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
 				reg = <0x1a240000 0x1000>,
@@ -279,5 +288,10 @@
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 		};
+
+		tcsr: syscon at 1a400000 {
+			compatible = "qcom,tcsr-ipq8064", "syscon";
+			reg = <0x1a400000 0x100>;
+		};
 	};
 };
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
