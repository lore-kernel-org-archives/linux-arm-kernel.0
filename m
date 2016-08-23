From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 22 Aug 2016 22:57:45 -0700
Subject: [PATCH v2 3/4] ARM: dts: msm8974: Add ADSP smp2p and smd nodes
In-Reply-To: <1471931866-3107-1-git-send-email-bjorn.andersson@linaro.org>
References: <1471931866-3107-1-git-send-email-bjorn.andersson@linaro.org>
Message-ID: <1471931866-3107-3-git-send-email-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Added this patch

 arch/arm/boot/dts/qcom-msm8974.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 561d4d136762..eac24cbe3c87 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -168,6 +168,31 @@
 		hwlocks = <&tcsr_mutex 3>;
 	};
 
+	smp2p-adsp {
+		compatible = "qcom,smp2p";
+		qcom,smem = <443>, <429>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <0 158 IRQ_TYPE_EDGE_RISING>;
+
+		qcom,ipc = <&apcs 8 10>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <2>;
+
+		adsp_smp2p_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		adsp_smp2p_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
 	smp2p-modem {
 		compatible = "qcom,smp2p";
 		qcom,smem = <435>, <428>;
@@ -543,6 +568,13 @@
 	smd {
 		compatible = "qcom,smd";
 
+		adsp {
+			interrupts = <0 156 IRQ_TYPE_EDGE_RISING>;
+
+			qcom,ipc = <&apcs 8 8>;
+			qcom,smd-edge = <1>;
+		};
+
 		modem {
 			interrupts = <0 25 IRQ_TYPE_EDGE_RISING>;
 
-- 
2.5.0
