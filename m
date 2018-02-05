From: georgi.djakov@linaro.org (Georgi Djakov)
Date: Mon,  5 Feb 2018 16:46:48 +0200
Subject: [PATCH 1/4] arm64: dts: qcom: msm8916: Add msm8916 A53 PLL DT node
Message-ID: <20180205144651.5934-1-georgi.djakov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a device tree node for the A53 PLL, which exists on msm8916
platforms.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index e51b04900726..d3592b19cfc9 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -326,6 +326,12 @@
 			status = "disabled";
 		};
 
+		a53pll: clock at b016000 {
+			compatible = "qcom,msm8916-a53pll";
+			reg = <0xb016000 0x40>;
+			#clock-cells = <0>;
+		};
+
 		apcs: syscon at b011000 {
 			compatible = "syscon";
 			reg = <0x0b011000 0x1000>;
