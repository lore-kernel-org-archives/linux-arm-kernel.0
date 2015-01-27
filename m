From: agross@codeaurora.org (Andy Gross)
Date: Tue, 27 Jan 2015 16:10:43 -0600
Subject: [PATCH 5/6] ARM: DT: msm8660: Add TCSR support
In-Reply-To: <1422396644-21714-1-git-send-email-agross@codeaurora.org>
References: <1422396644-21714-1-git-send-email-agross@codeaurora.org>
Message-ID: <1422396644-21714-6-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds TCSR support for use by the GSBI to automatically configure ADM
CRCI values based on the GSBI port configuration.

Signed-off-by: Andy Gross <agross@codeaurora.org>
---
 arch/arm/boot/dts/qcom-msm8660.dtsi |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom-msm8660.dtsi
index 0affd61..c162736 100644
--- a/arch/arm/boot/dts/qcom-msm8660.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8660.dtsi
@@ -81,7 +81,7 @@
 		};
 
 		gsbi12: gsbi at 19c00000 {
-			compatible = "qcom,gsbi-v1.0.0";
+			compatible = "qcom,gsbi-msm8660";
 			reg = <0x19c00000 0x100>;
 			clocks = <&gcc GSBI12_H_CLK>;
 			clock-names = "iface";
@@ -89,6 +89,9 @@
 			#size-cells = <1>;
 			ranges;
 
+			qcom,gsbi-num = <12>;
+			syscon-tcsr = <&tcsr>;
+
 			serial at 19c40000 {
 				compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
 				reg = <0x19c40000 0x1000>,
@@ -196,6 +199,11 @@
 				vmmc-supply = <&vsdcc_fixed>;
 			};
 		};
+
+		tcsr: syscon at 1a400000 {
+			compatible = "qcom,tcsr-msm8660", "syscon";
+			reg = <0x1a400000 0x100>;
+		};
 	};
 
 };
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
