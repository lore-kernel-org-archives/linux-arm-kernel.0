From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed,  9 Nov 2016 17:13:57 -0800
Subject: [PATCH] arm: dts: qcom: Fix ipq board clock rates
Message-ID: <20161110011357.25853-1-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ipq board has these rates as 25MHz, and not 19.2 and 27. I
copy/pasted from other boards that have those rates but forgot
to fix the rates here.

Fixes: 30fc4212d541 ("arm: dts: qcom: Add more board clocks")
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 2e375576ffd0..76f4e8921d58 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -65,13 +65,13 @@
 		cxo_board {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
-			clock-frequency = <19200000>;
+			clock-frequency = <25000000>;
 		};
 
 		pxo_board {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
-			clock-frequency = <27000000>;
+			clock-frequency = <25000000>;
 		};
 
 		sleep_clk: sleep_clk {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
