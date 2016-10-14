From: xiaogang@codeaurora.org (Xiaogang Cui)
Date: Fri, 14 Oct 2016 10:09:32 +0800
Subject: [PATCH 2/2] arm64: dts: add msm8996 reboot mode support
Message-ID: <1476411017-21040-1-git-send-email-xiaogang@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add reboot mode entry for MSM8996 platform.

Signed-off-by: Xiaogang Cui <xiaogang@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/pm8994.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8994.dtsi b/arch/arm64/boot/dts/qcom/pm8994.dtsi
index 1222d2e..c9b14ab 100644
--- a/arch/arm64/boot/dts/qcom/pm8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8994.dtsi
@@ -51,6 +51,14 @@
 				     <0 0xa6 0 IRQ_TYPE_NONE>,
 				     <0 0xa7 0 IRQ_TYPE_NONE>;
 		};
+
+		qcom,reboot-mode at 88f {
+			compatible = "qcom,reboot-mode";
+			offset = <0x88f>;
+			mode-normal = <0x00>;
+			mode-recovery = <0x04>;
+			mode-bootloader = <0x08>;
+		};
 	};
 
 	pmic at 1 {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
