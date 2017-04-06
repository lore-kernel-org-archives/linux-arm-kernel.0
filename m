From: leo.yan@linaro.org (Leo Yan)
Date: Thu,  6 Apr 2017 21:31:01 +0800
Subject: [PATCH v6 8/8] arm64: dts: qcom: msm8916: Add debug unit
In-Reply-To: <1491485461-22800-1-git-send-email-leo.yan@linaro.org>
References: <1491485461-22800-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1491485461-22800-9-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add debug unit on Qualcomm msm8916 based platforms, including the
DragonBoard 410c board.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 68a8e67..3af814b 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1104,6 +1104,38 @@
 			};
 		};
 
+		debug at 850000 {
+			compatible = "arm,coresight-cpu-debug","arm,primecell";
+			reg = <0x850000 0x1000>;
+			clocks = <&rpmcc RPM_QDSS_CLK>;
+			clock-names = "apb_pclk";
+			cpu = <&CPU0>;
+		};
+
+		debug at 852000 {
+			compatible = "arm,coresight-cpu-debug","arm,primecell";
+			reg = <0x852000 0x1000>;
+			clocks = <&rpmcc RPM_QDSS_CLK>;
+			clock-names = "apb_pclk";
+			cpu = <&CPU1>;
+		};
+
+		debug at 854000 {
+			compatible = "arm,coresight-cpu-debug","arm,primecell";
+			reg = <0x854000 0x1000>;
+			clocks = <&rpmcc RPM_QDSS_CLK>;
+			clock-names = "apb_pclk";
+			cpu = <&CPU2>;
+		};
+
+		debug at 856000 {
+			compatible = "arm,coresight-cpu-debug","arm,primecell";
+			reg = <0x856000 0x1000>;
+			clocks = <&rpmcc RPM_QDSS_CLK>;
+			clock-names = "apb_pclk";
+			cpu = <&CPU3>;
+		};
+
 		etm at 85c000 {
 			compatible = "arm,coresight-etm4x", "arm,primecell";
 			reg = <0x85c000 0x1000>;
-- 
2.7.4
