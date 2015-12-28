From: bjorn@kryo.se (bjorn at kryo.se)
Date: Sun, 27 Dec 2015 17:51:13 -0800
Subject: [PATCH] ARM: dts: qcom: msm8974: Add WCNSS SMP2P node
Message-ID: <1451267473-15948-1-git-send-email-bjorn@kryo.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bjorn Andersson <bjorn.andersson@sonymobile.com>

Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 18c419ee9d48..3a88228e4358 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -160,6 +160,32 @@
 		hwlocks = <&tcsr_mutex 3>;
 	};
 
+	smp2p-wcnss {
+		compatible = "qcom,smp2p";
+		qcom,smem = <451>, <431>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <0 143 IRQ_TYPE_EDGE_RISING>;
+
+		qcom,ipc = <&apcs 8 18>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <4>;
+
+		wcnss_smp2p_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+
+			#qcom,state-cells = <1>;
+		};
+
+		wcnss_smp2p_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
 	smsm {
 		compatible = "qcom,smsm";
 
-- 
2.5.0
