From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 28 Oct 2013 11:02:01 -0700
Subject: [PATCH 3/6] ARM: dts: msm: Add clock entries for MSM8960 uart device
In-Reply-To: <1382983324-31155-1-git-send-email-sboyd@codeaurora.org>
References: <1382983324-31155-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1382983324-31155-4-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hook up the clock controller to the msm8960 uart device so the
uart device can be probed.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/boot/dts/qcom-msm8960-cdp.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8960-cdp.dts b/arch/arm/boot/dts/qcom-msm8960-cdp.dts
index cf8ecc5..faef5b9 100644
--- a/arch/arm/boot/dts/qcom-msm8960-cdp.dts
+++ b/arch/arm/boot/dts/qcom-msm8960-cdp.dts
@@ -2,6 +2,8 @@
 
 /include/ "skeleton.dtsi"
 
+#include <dt-bindings/clk/msm-gcc-8960.h>
+
 / {
 	model = "Qualcomm MSM8960 CDP";
 	compatible = "qcom,msm8960-cdp", "qcom,msm8960";
@@ -78,6 +80,8 @@
 		reg = <0x16440000 0x1000>,
 		      <0x16400000 0x1000>;
 		interrupts = <0 154 0x0>;
+		clocks = <&gcc GSBI5_UART_CLK>, <&gcc GSBI5_H_CLK>;
+		clock-names = "core", "iface";
 	};
 
 	qcom,ssbi at 500000 {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
