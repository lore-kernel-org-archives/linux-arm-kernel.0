From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri,  8 Jan 2016 15:57:09 -0800
Subject: [PATCH] arm64: dts: Add L2 cache node to msm8916
Message-ID: <1452297429-6382-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The msm8916 SoC has an L2 cache for all 4 CPUs. Add it to the
dtsi file so that the cache hierarchy can be probed.

Cc: <devicetree@vger.kernel.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index ba8184d0f948..42573a7d4a94 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -61,24 +61,33 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0x0>;
+			next-level-cache = <&L2_0>;
 		};
 
 		CPU1: cpu at 1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0x1>;
+			next-level-cache = <&L2_0>;
 		};
 
 		CPU2: cpu at 2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0x2>;
+			next-level-cache = <&L2_0>;
 		};
 
 		CPU3: cpu at 3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0x3>;
+			next-level-cache = <&L2_0>;
+		};
+
+		L2_0: l2-cache {
+		      compatible = "cache";
+		      cache-level = <2>;
 		};
 	};
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
