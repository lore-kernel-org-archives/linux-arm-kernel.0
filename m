From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 26 Aug 2015 12:35:04 -0700
Subject: [PATCH] ARM: dts: qcom: Remove extra reg element from iadc device
Message-ID: <1440617704-30346-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This doesn't match the binding, and the driver doesn't look to
be using it. Remove the extra element.

CC: Ivan T. Ivanov <ivan.ivanov@linaro.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/boot/dts/qcom-pm8941.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-pm8941.dtsi b/arch/arm/boot/dts/qcom-pm8941.dtsi
index 968f1043d4f5..0fe1080aeb20 100644
--- a/arch/arm/boot/dts/qcom-pm8941.dtsi
+++ b/arch/arm/boot/dts/qcom-pm8941.dtsi
@@ -120,8 +120,7 @@
 
 		pm8941_iadc: iadc at 3600 {
 			compatible = "qcom,pm8941-iadc", "qcom,spmi-iadc";
-			reg = <0x3600 0x100>,
-				  <0x12f1 0x1>;
+			reg = <0x3600 0x100>;
 			interrupts = <0x0 0x36 0x0 IRQ_TYPE_EDGE_RISING>;
 			qcom,external-resistor-micro-ohms = <10000>;
 		};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
