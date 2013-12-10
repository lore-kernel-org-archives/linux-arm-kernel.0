From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 10 Dec 2013 15:14:43 -0800
Subject: [PATCH] ARM: dts: msm: Fix gpio interrupt and reg length
Message-ID: <1386717283-30227-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The summary interrupt is #16 in the SPI space. Unfortunately,
when this device was translated from board files to DT we forgot
to subtract 16 from the interrupt number to translate it into a
SPI interrupt. Also, the register space is larger than 4k, increase
it appropriately so that the gpio driver doesn't try to access
registers outside of its mapping.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/boot/dts/qcom-msm8660-surf.dts | 4 ++--
 arch/arm/boot/dts/qcom-msm8960-cdp.dts  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8660-surf.dts b/arch/arm/boot/dts/qcom-msm8660-surf.dts
index 8632991..12439f5 100644
--- a/arch/arm/boot/dts/qcom-msm8660-surf.dts
+++ b/arch/arm/boot/dts/qcom-msm8660-surf.dts
@@ -30,11 +30,11 @@
 
 	msmgpio: gpio at 800000 {
 		compatible = "qcom,msm-gpio";
-		reg = <0x00800000 0x1000>;
+		reg = <0x00800000 0x4000>;
 		gpio-controller;
 		#gpio-cells = <2>;
 		ngpio = <173>;
-		interrupts = <0 32 0x4>;
+		interrupts = <0 16 0x4>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 	};
diff --git a/arch/arm/boot/dts/qcom-msm8960-cdp.dts b/arch/arm/boot/dts/qcom-msm8960-cdp.dts
index cf0956c..3a84c9a 100644
--- a/arch/arm/boot/dts/qcom-msm8960-cdp.dts
+++ b/arch/arm/boot/dts/qcom-msm8960-cdp.dts
@@ -33,7 +33,7 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 		ngpio = <150>;
-		interrupts = <0 32 0x4>;
+		interrupts = <0 16 0x4>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 		reg = <0x800000 0x4000>;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
