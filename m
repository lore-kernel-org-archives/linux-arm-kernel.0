From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 20 May 2013 17:50:37 -0700
Subject: [PATCH] ARM: dts: msm: Fix bad register addresses
Message-ID: <1369097437-19217-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some bad copy/paste got in as well as too many zeroes. Fix
everything up so that the registers after the @ sign are
consistent with the first reg property.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/boot/dts/msm8660-surf.dts | 4 ++--
 arch/arm/boot/dts/msm8960-cdp.dts  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/msm8660-surf.dts b/arch/arm/boot/dts/msm8660-surf.dts
index 9bf49b3..d347082 100644
--- a/arch/arm/boot/dts/msm8660-surf.dts
+++ b/arch/arm/boot/dts/msm8660-surf.dts
@@ -15,7 +15,7 @@
 		      < 0x02081000 0x1000 >;
 	};
 
-	timer at 2000004 {
+	timer at 2000000 {
 		compatible = "qcom,scss-timer", "qcom,msm-timer";
 		interrupts = <1 0 0x301>,
 			     <1 1 0x301>,
@@ -26,7 +26,7 @@
 		cpu-offset = <0x40000>;
 	};
 
-	serial at 19c400000 {
+	serial at 19c40000 {
 		compatible = "qcom,msm-hsuart", "qcom,msm-uart";
 		reg = <0x19c40000 0x1000>,
 		      <0x19c00000 0x1000>;
diff --git a/arch/arm/boot/dts/msm8960-cdp.dts b/arch/arm/boot/dts/msm8960-cdp.dts
index 2e4d87a..7c9ef9b 100644
--- a/arch/arm/boot/dts/msm8960-cdp.dts
+++ b/arch/arm/boot/dts/msm8960-cdp.dts
@@ -26,7 +26,7 @@
 		cpu-offset = <0x80000>;
 	};
 
-	serial at 19c400000 {
+	serial at 16440000 {
 		compatible = "qcom,msm-hsuart", "qcom,msm-uart";
 		reg = <0x16440000 0x1000>,
 		      <0x16400000 0x1000>;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
