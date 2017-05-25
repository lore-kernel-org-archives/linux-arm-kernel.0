From: leo.yan@linaro.org (Leo Yan)
Date: Fri, 26 May 2017 00:04:13 +0800
Subject: [PATCH v13 9/9] arm64: dts: qcom: msm8916: Add debug unit
Message-ID: <1495728253-30970-1-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add debug unit on Qualcomm msm8916 based platforms, including the
DragonBoard 410c board.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index ab30939..17691ab 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1116,6 +1116,38 @@
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
