From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Wed,  2 Aug 2017 21:35:18 -0700
Subject: [PATCH v2 4/4] arm64: dts: qcom: msm8996: Specify smd-edge for ADSP
In-Reply-To: <20170803043518.21408-1-bjorn.andersson@linaro.org>
References: <20170803043518.21408-1-bjorn.andersson@linaro.org>
Message-ID: <20170803043518.21408-5-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the smd-edge node for the adsp, to allow SMD communication with the
ADSP.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Spelled out GIC_SPI

 arch/arm64/boot/dts/qcom/msm8996.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 20336ed597eb..4764d87c1b99 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -636,6 +636,15 @@
 
 		qcom,smem-states = <&adsp_smp2p_out 0>;
 		qcom,smem-state-names = "stop";
+
+		smd-edge {
+			interrupts = <GIC_SPI 156 IRQ_TYPE_EDGE_RISING>;
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
