From: agross@codeaurora.org (Andy Gross)
Date: Fri, 30 Jan 2015 00:25:32 -0600
Subject: [Patch v2 3/6] ARM: DT: apq8064: Add TCSR support
In-Reply-To: <1422599135-5588-1-git-send-email-agross@codeaurora.org>
References: <1422599135-5588-1-git-send-email-agross@codeaurora.org>
Message-ID: <1422599135-5588-4-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds TCSR support for use by the GSBI to automatically configure ADM
CRCI values based on the GSBI port configuration.

Signed-off-by: Andy Gross <agross@codeaurora.org>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index b3154c0..720fa2e 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -11,6 +11,12 @@
 	compatible = "qcom,apq8064";
 	interrupt-parent = <&intc>;
 
+	aliases {
+		gsbi1 = &gsbi1;
+		gsbi2 = &gsbi2;
+		gsbi7 = &gsbi7;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -173,6 +179,8 @@
 			#size-cells = <1>;
 			ranges;
 
+			syscon-tcsr = <&tcsr>;
+
 			i2c1: i2c at 12460000 {
 				compatible = "qcom,i2c-qup-v1.1.1";
 				reg = <0x12460000 0x1000>;
@@ -194,6 +202,8 @@
 			#size-cells = <1>;
 			ranges;
 
+			syscon-tcsr = <&tcsr>;
+
 			i2c2: i2c at 124a0000 {
 				compatible = "qcom,i2c-qup-v1.1.1";
 				reg = <0x124a0000 0x1000>;
@@ -215,6 +225,8 @@
 			#size-cells = <1>;
 			ranges;
 
+			syscon-tcsr = <&tcsr>;
+
 			serial at 16640000 {
 				compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
 				reg = <0x16640000 0x1000>,
@@ -349,5 +361,10 @@
 				pinctrl-0 = <&sdc4_gpios>;
 			};
 		};
+
+		tcsr: syscon at 1a400000 {
+			compatible = "qcom,tcsr-apq8064", "syscon";
+			reg = <0x1a400000 0x100>;
+		};
 	};
 };
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
