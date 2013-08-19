From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 19 Aug 2013 14:39:57 -0700
Subject: [PATCH 4/4] ARM: dts: msm: Update uartdm compatible strings
In-Reply-To: <1376948397-6882-1-git-send-email-sboyd@codeaurora.org>
References: <1376948397-6882-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1376948397-6882-5-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let's follow the ratified DT binding and use uartdm instead of
hsuart. This does break backwards compatibility but this
shouldn't be a problem because the uart driver isn't probing on
these devices without adding clock support (which isn't merged so
far).

Cc: David Brown <davidb@codeaurora.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/boot/dts/msm8660-surf.dts | 2 +-
 arch/arm/boot/dts/msm8960-cdp.dts  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/msm8660-surf.dts b/arch/arm/boot/dts/msm8660-surf.dts
index cdc010e..386d428 100644
--- a/arch/arm/boot/dts/msm8660-surf.dts
+++ b/arch/arm/boot/dts/msm8660-surf.dts
@@ -38,7 +38,7 @@
 	};
 
 	serial at 19c40000 {
-		compatible = "qcom,msm-hsuart", "qcom,msm-uart";
+		compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
 		reg = <0x19c40000 0x1000>,
 		      <0x19c00000 0x1000>;
 		interrupts = <0 195 0x0>;
diff --git a/arch/arm/boot/dts/msm8960-cdp.dts b/arch/arm/boot/dts/msm8960-cdp.dts
index db2060c..532050b 100644
--- a/arch/arm/boot/dts/msm8960-cdp.dts
+++ b/arch/arm/boot/dts/msm8960-cdp.dts
@@ -38,7 +38,7 @@
 	};
 
 	serial at 16440000 {
-		compatible = "qcom,msm-hsuart", "qcom,msm-uart";
+		compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
 		reg = <0x16440000 0x1000>,
 		      <0x16400000 0x1000>;
 		interrupts = <0 154 0x0>;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
