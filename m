From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 22 Aug 2016 22:57:46 -0700
Subject: [PATCH v2 4/4] ARM: dts: msm8974: Add ADSP PIL node
In-Reply-To: <1471931866-3107-1-git-send-email-bjorn.andersson@linaro.org>
References: <1471931866-3107-1-git-send-email-bjorn.andersson@linaro.org>
Message-ID: <1471931866-3107-4-git-send-email-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Added this patch

 arch/arm/boot/dts/qcom-msm8974.dtsi | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index eac24cbe3c87..4fa630cc7e4a 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -29,7 +29,7 @@
 			no-map;
 		};
 
-		adsp at 0dc00000 {
+		adsp_region: adsp at 0dc00000 {
 			reg = <0x0dc00000 0x1900000>;
 			no-map;
 		};
@@ -159,6 +159,24 @@
 		clock-frequency = <19200000>;
 	};
 
+	adsp-pil {
+		compatible = "qcom,msm8974-adsp-pil";
+
+		interrupts-extended = <&intc 0 162 IRQ_TYPE_EDGE_RISING>,
+				      <&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+				      <&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+				      <&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+				      <&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
+		interrupt-names = "wdog", "fatal", "ready", "handover", "stop-ack";
+
+		cx-supply = <&pm8841_s2>;
+
+		memory-region = <&adsp_region>;
+
+		qcom,smem-states = <&adsp_smp2p_out 0>;
+		qcom,smem-state-names = "stop";
+	};
+
 	smem {
 		compatible = "qcom,smem";
 
-- 
2.5.0
