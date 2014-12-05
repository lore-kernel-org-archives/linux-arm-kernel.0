From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri,  5 Dec 2014 12:53:33 -0800
Subject: [PATCH] ARM: dts: qcom: Correct IPQ tlmm interrupt
Message-ID: <1417812813-12804-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The interrupt is 16, not 32 (which it would be if we include PPIs
in the count of interrupts).

Cc: Andy Gross <agross@codeaurora.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 63b2146f563b..cb225dafe97c 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -74,7 +74,7 @@
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
-			interrupts = <0 32 0x4>;
+			interrupts = <0 16 0x4>;
 		};
 
 		intc: interrupt-controller at 2000000 {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
