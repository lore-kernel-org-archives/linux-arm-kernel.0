From: agross@codeaurora.org (Andy Gross)
Date: Fri, 30 Jan 2015 00:25:35 -0600
Subject: [Patch v2 6/6] ARM: DT: msm8960: Add TCSR support
In-Reply-To: <1422599135-5588-1-git-send-email-agross@codeaurora.org>
References: <1422599135-5588-1-git-send-email-agross@codeaurora.org>
Message-ID: <1422599135-5588-7-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds TCSR support for use by the GSBI to automatically configure ADM
CRCI values based on the GSBI port configuration.

Signed-off-by: Andy Gross <agross@codeaurora.org>
---
 arch/arm/boot/dts/qcom-msm8960.dtsi |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
index e1b0d5c..078b4fb 100644
--- a/arch/arm/boot/dts/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
@@ -11,6 +11,10 @@
 	compatible = "qcom,msm8960";
 	interrupt-parent = <&intc>;
 
+	aliases {
+		gsbi5 = &gsbi5;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -129,6 +133,8 @@
 			#size-cells = <1>;
 			ranges;
 
+			syscon-tcsr = <&tcsr>;
+
 			serial at 16440000 {
 				compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
 				reg = <0x16440000 0x1000>,
@@ -238,5 +244,10 @@
 				vmmc-supply = <&vsdcc_fixed>;
 			};
 		};
+
+		tcsr: syscon at 1a400000 {
+			compatible = "qcom,tcsr-msm8960", "syscon";
+			reg = <0x1a400000 0x100>;
+		};
 	};
 };
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
