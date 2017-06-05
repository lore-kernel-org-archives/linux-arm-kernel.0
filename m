From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon,  5 Jun 2017 14:15:18 -0600
Subject: [PATCH 17/17] arm64: dts: qcom: msm8916: Add debug unit
In-Reply-To: <1496693718-9191-1-git-send-email-mathieu.poirier@linaro.org>
References: <1496693718-9191-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1496693718-9191-18-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Leo Yan <leo.yan@linaro.org>

Add debug unit on Qualcomm msm8916 based platforms, including the
DragonBoard 410c board.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Acked-by: Andy Gross <andy.gross@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index ab3093995ded..17691abea608 100644
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
