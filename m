From: mmcclint@codeaurora.org (Matthew McClintock)
Date: Wed, 23 Mar 2016 17:05:10 -0500
Subject: [PATCH 15/17] qcom: ipq4019: add cpu operating points for cpufreq
 support
In-Reply-To: <1458770712-10880-1-git-send-email-mmcclint@codeaurora.org>
References: <1458770712-10880-1-git-send-email-mmcclint@codeaurora.org>
Message-ID: <1458770712-10880-16-git-send-email-mmcclint@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds some operating points for cpu frequeny scaling

Signed-off-by: Matthew McClintock <mmcclint@codeaurora.org>
---
 arch/arm/boot/dts/qcom-ipq4019.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
index 1937edf..db48fd3 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -40,6 +40,14 @@
 			reg = <0x0>;
 			clocks = <&gcc GCC_APPS_CLK_SRC>;
 			clock-frequency = <0>;
+			operating-points = <
+				/* kHz	uV (fixed) */
+				48000	1100000
+				200000	1100000
+				500000	1100000
+				666000	1100000
+			>;
+			clock-latency = <256000>;
 		};
 
 		cpu at 1 {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
