From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 24 Jul 2017 22:47:03 -0700
Subject: [PATCH 3/5] arm64: dts: msm8996: Add modem smp2p nodes
In-Reply-To: <20170725054705.20674-1-bjorn.andersson@linaro.org>
References: <20170725054705.20674-1-bjorn.andersson@linaro.org>
Message-ID: <20170725054705.20674-4-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 8ebef05e1750..7d909546ca24 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -662,6 +662,30 @@
 		};
 	};
 
+	modem-smp2p {
+		compatible = "qcom,smp2p";
+		qcom,smem = <435>, <428>;
+
+		interrupts = <0 451 IRQ_TYPE_EDGE_RISING>;
+
+		qcom,ipc = <&apcs 16 14>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <1>;
+
+		modem_smp2p_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		modem_smp2p_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
 	smp2p-slpi {
 		compatible = "qcom,smp2p";
 		qcom,smem = <481>, <430>;
-- 
2.12.0
