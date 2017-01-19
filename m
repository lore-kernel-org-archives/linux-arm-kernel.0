From: spjoshi@codeaurora.org (Sarangdhar Joshi)
Date: Wed, 18 Jan 2017 19:31:53 -0800
Subject: [PATCH] arm64: dts: msm8996: Add ADSP PIL node
Message-ID: <1484796713-30796-1-git-send-email-spjoshi@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ADSP node required for Qualcomm ADSP Peripheral Image Loader.

Signed-off-by: Sarangdhar Joshi <spjoshi@codeaurora.org>
---

This patch uses "xo_board" clock for now. We would have to move to
rpmcc once it is available.

 arch/arm64/boot/dts/qcom/msm8996.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index c9c7fd7..7cebf63 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -181,6 +181,26 @@
 		method = "smc";
 	};
 
+	adsp-pil {
+		compatible = "qcom,msm8996-adsp-pil";
+
+		interrupts-extended = <&intc 0 162 IRQ_TYPE_EDGE_RISING>,
+				      <&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+				      <&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+				      <&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+				      <&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
+		interrupt-names = "wdog", "fatal", "ready",
+				  "handover", "stop-ack";
+
+		clocks = <&xo_board>;
+		clock-names = "xo";
+
+		memory-region = <&adsp_region>;
+
+		qcom,smem-states = <&adsp_smp2p_out 0>;
+		qcom,smem-state-names = "stop";
+	};
+
 	adsp-smp2p {
 		compatible = "qcom,smp2p";
 		qcom,smem = <443>, <429>;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
