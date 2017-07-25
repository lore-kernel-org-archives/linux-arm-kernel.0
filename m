From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 24 Jul 2017 22:47:04 -0700
Subject: [PATCH 4/5] arm64: dts: qcom: msm8996: Specify smd-edge for ADSP
In-Reply-To: <20170725054705.20674-1-bjorn.andersson@linaro.org>
References: <20170725054705.20674-1-bjorn.andersson@linaro.org>
Message-ID: <20170725054705.20674-5-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the smd-edge node for the adsp, to allow SMD communication with the
ADSP.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 7d909546ca24..395666dcce1b 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -636,6 +636,15 @@
 
 		qcom,smem-states = <&adsp_smp2p_out 0>;
 		qcom,smem-state-names = "stop";
+
+		smd-edge {
+			interrupts = <0 156 IRQ_TYPE_EDGE_RISING>;
+
+			label = "lpass";
+			qcom,ipc = <&apcs 16 8>;
+			qcom,smd-edge = <1>;
+			qcom,remote-pid = <2>;
+		};
 	};
 
 	adsp-smp2p {
-- 
2.12.0
