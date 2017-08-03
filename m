From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Wed,  2 Aug 2017 21:35:17 -0700
Subject: [PATCH v2 3/4] arm64: dts: msm8996: Add modem smp2p nodes
In-Reply-To: <20170803043518.21408-1-bjorn.andersson@linaro.org>
References: <20170803043518.21408-1-bjorn.andersson@linaro.org>
Message-ID: <20170803043518.21408-4-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Spelled out GIC_SPI

 arch/arm64/boot/dts/qcom/msm8996.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 8ebef05e1750..20336ed597eb 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -662,6 +662,30 @@
 		};
 	};
 
+	modem-smp2p {
+		compatible = "qcom,smp2p";
+		qcom,smem = <435>, <428>;
+
+		interrupts = <GIC_SPI 451 IRQ_TYPE_EDGE_RISING>;
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
