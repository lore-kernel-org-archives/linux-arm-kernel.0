From: davidb@codeaurora.org (David Brown)
Date: Thu, 18 Jul 2013 13:07:13 -0700
Subject: [PATCH 1/3] ARM: msm: dts: Fix the gpio register address for msm8960
In-Reply-To: <1374178035-19943-1-git-send-email-davidb@codeaurora.org>
References: <1374178035-19943-1-git-send-email-davidb@codeaurora.org>
Message-ID: <1374178035-19943-2-git-send-email-davidb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rohit Vaswani <rvaswani@codeaurora.org>

Fix the the gpio reg address for the device tree entry.

Signed-off-by: Rohit Vaswani <rvaswani@codeaurora.org>
Signed-off-by: David Brown <davidb@codeaurora.org>
---
 arch/arm/boot/dts/msm8960-cdp.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/msm8960-cdp.dts b/arch/arm/boot/dts/msm8960-cdp.dts
index db2060c..9c1167b0 100644
--- a/arch/arm/boot/dts/msm8960-cdp.dts
+++ b/arch/arm/boot/dts/msm8960-cdp.dts
@@ -26,7 +26,7 @@
 		cpu-offset = <0x80000>;
 	};
 
-	msmgpio: gpio at fd510000 {
+	msmgpio: gpio at 800000 {
 		compatible = "qcom,msm-gpio";
 		gpio-controller;
 		#gpio-cells = <2>;
@@ -34,7 +34,7 @@
 		interrupts = <0 32 0x4>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
-		reg = <0xfd510000 0x4000>;
+		reg = <0x800000 0x4000>;
 	};
 
 	serial at 16440000 {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
