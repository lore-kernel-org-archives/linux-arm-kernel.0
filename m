From: agross@codeaurora.org (Andy Gross)
Date: Tue, 27 Jan 2015 16:10:44 -0600
Subject: [PATCH 6/6] ARM: DT: msm8960: Add TCSR support
In-Reply-To: <1422396644-21714-1-git-send-email-agross@codeaurora.org>
References: <1422396644-21714-1-git-send-email-agross@codeaurora.org>
Message-ID: <1422396644-21714-7-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds TCSR support for use by the GSBI to automatically configure ADM
CRCI values based on the GSBI port configuration.

Signed-off-by: Andy Gross <agross@codeaurora.org>
---
 arch/arm/boot/dts/qcom-msm8960.dtsi |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
index e1b0d5c..913a9f1 100644
--- a/arch/arm/boot/dts/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
@@ -121,7 +121,7 @@
 		};
 
 		gsbi5: gsbi at 16400000 {
-			compatible = "qcom,gsbi-v1.0.0";
+			compatible = "qcom,gsbi-msm8960";
 			reg = <0x16400000 0x100>;
 			clocks = <&gcc GSBI5_H_CLK>;
 			clock-names = "iface";
@@ -129,6 +129,9 @@
 			#size-cells = <1>;
 			ranges;
 
+			qcom,gsbi-num = <5>;
+			syscon-tcsr = <&tcsr>;
+
 			serial at 16440000 {
 				compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
 				reg = <0x16440000 0x1000>,
@@ -238,5 +241,10 @@
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
