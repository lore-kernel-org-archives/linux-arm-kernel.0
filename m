From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 28 Oct 2013 11:02:03 -0700
Subject: [PATCH 5/6] ARM: dts: msm: Add MSM8974 serial device node
In-Reply-To: <1382983324-31155-1-git-send-email-sboyd@codeaurora.org>
References: <1382983324-31155-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1382983324-31155-6-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Describe the uart device used for the serial console on MSM8974
based platforms.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index c013037..152879d 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -2,6 +2,8 @@
 
 #include "skeleton.dtsi"
 
+#include <dt-bindings/clk/msm-gcc-8974.h>
+
 / {
 	model = "Qualcomm MSM8974";
 	compatible = "qcom,msm8974";
@@ -101,5 +103,12 @@
 			reg = <0xfc400000 0x4000>;
 		};
 
+		serial at f991e000 {
+			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+			reg = <0xf991e000 0x1000>;
+			interrupts = <0 108 0x0>;
+			clocks = <&gcc GCC_BLSP1_UART2_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+		};
 	};
 };
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
