From: agross@codeaurora.org (Andy Gross)
Date: Fri, 30 Jan 2015 00:25:33 -0600
Subject: [Patch v2 4/6] ARM: DT: ipq8064: Add TCSR support
In-Reply-To: <1422599135-5588-1-git-send-email-agross@codeaurora.org>
References: <1422599135-5588-1-git-send-email-agross@codeaurora.org>
Message-ID: <1422599135-5588-5-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds TCSR support for use by the GSBI to automatically configure ADM
CRCI values based on the GSBI port configuration.

Signed-off-by: Andy Gross <agross@codeaurora.org>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 63b2146..8939d31 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -9,6 +9,12 @@
 	compatible = "qcom,ipq8064";
 	interrupt-parent = <&intc>;
 
+	aliases {
+		gsbi2 = &gsbi2;
+		gsbi4 = &gsbi4;
+		gsbi5 = &gsbi5;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -128,6 +134,8 @@
 			ranges;
 			status = "disabled";
 
+			syscon-tcsr = <&tcsr>;
+
 			serial at 12490000 {
 				compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
 				reg = <0x12490000 0x1000>,
@@ -163,6 +171,8 @@
 			ranges;
 			status = "disabled";
 
+			syscon-tcsr = <&tcsr>;
+
 			serial at 16340000 {
 				compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
 				reg = <0x16340000 0x1000>,
@@ -197,6 +207,8 @@
 			ranges;
 			status = "disabled";
 
+			syscon-tcsr = <&tcsr>;
+
 			serial at 1a240000 {
 				compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
 				reg = <0x1a240000 0x1000>,
@@ -279,5 +291,10 @@
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
