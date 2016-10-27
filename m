From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 27 Oct 2016 16:23:06 -0700
Subject: [PATCH] ARM: dts: msm8974: Remove "unused" reserved region
Message-ID: <20161027232306.13653-1-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From what I can tell by looking at the android 3.10 kernel
sources for msm8974, this isn't actually a reserved region.
Instead it's marked as "unused" for reserved regions. Let's
remove it so we get back a good chunk of memory.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 561d4d136762..5f4752696171 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -58,11 +58,6 @@
 			reg = <0x0fd80000 0x180000>;
 			no-map;
 		};
-
-		unused at 0ff00000 {
-			reg = <0x0ff00000 0x10100000>;
-			no-map;
-		};
 	};
 
 	cpus {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
