From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Wed,  2 Aug 2017 21:35:15 -0700
Subject: [PATCH v2 1/4] arm64: dts: qcom: Add RPM glink nodes to msm8996
In-Reply-To: <20170803043518.21408-1-bjorn.andersson@linaro.org>
References: <20170803043518.21408-1-bjorn.andersson@linaro.org>
Message-ID: <20170803043518.21408-2-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- None

 arch/arm64/boot/dts/qcom/msm8996.dtsi | 78 +++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 8f085716e258..8ebef05e1750 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -276,12 +276,83 @@
 		hwlocks = <&tcsr_mutex 3>;
 	};
 
+	rpm-glink {
+		compatible = "qcom,glink-rpm";
+
+		interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
+
+		qcom,rpm-msg-ram = <&rpm_msg_ram>;
+
+		mboxes = <&apcs_glb 0>;
+
+		rpm_requests {
+			compatible = "qcom,rpm-msm8996";
+			qcom,glink-channels = "rpm_requests";
+
+			pm8994-regulators {
+				compatible = "qcom,rpm-pm8994-regulators";
+
+				pm8994_s1: s1 {};
+				pm8994_s2: s2 {};
+				pm8994_s3: s3 {};
+				pm8994_s4: s4 {};
+				pm8994_s5: s5 {};
+				pm8994_s6: s6 {};
+				pm8994_s7: s7 {};
+				pm8994_s8: s8 {};
+				pm8994_s9: s9 {};
+				pm8994_s10: s10 {};
+				pm8994_s11: s11 {};
+				pm8994_s12: s12 {};
+
+				pm8994_l1: l1 {};
+				pm8994_l2: l2 {};
+				pm8994_l3: l3 {};
+				pm8994_l4: l4 {};
+				pm8994_l5: l5 {};
+				pm8994_l6: l6 {};
+				pm8994_l7: l7 {};
+				pm8994_l8: l8 {};
+				pm8994_l9: l9 {};
+				pm8994_l10: l10 {};
+				pm8994_l11: l11 {};
+				pm8994_l12: l12 {};
+				pm8994_l13: l13 {};
+				pm8994_l14: l14 {};
+				pm8994_l15: l15 {};
+				pm8994_l16: l16 {};
+				pm8994_l17: l17 {};
+				pm8994_l18: l18 {};
+				pm8994_l19: l19 {};
+				pm8994_l20: l20 {};
+				pm8994_l21: l21 {};
+				pm8994_l22: l22 {};
+				pm8994_l23: l23 {};
+				pm8994_l24: l24 {};
+				pm8994_l25: l25 {};
+				pm8994_l26: l26 {};
+				pm8994_l27: l27 {};
+				pm8994_l28: l28 {};
+				pm8994_l29: l29 {};
+				pm8994_l30: l30 {};
+				pm8994_l31: l31 {};
+				pm8994_l32: l32 {};
+			};
+
+		};
+	};
+
 	soc: soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0 0 0 0xffffffff>;
 		compatible = "simple-bus";
 
+		rpm_msg_ram: memory at 68000 {
+			compatible = "qcom,rpm-msg-ram";
+			reg = <0x68000 0x6000>;
+		};
+
 		tcsr_mutex_regs: syscon at 740000 {
 			compatible = "syscon";
 			reg = <0x740000 0x20000>;
@@ -303,6 +374,13 @@
 			reg = <0x9820000 0x1000>;
 		};
 
+		apcs_glb: mailbox at 9820000 {
+			compatible = "qcom,msm8996-apcs-hmss-global";
+			reg = <0x9820000 0x1000>;
+
+			#mbox-cells = <1>;
+		};
+
 		gcc: clock-controller at 300000 {
 			compatible = "qcom,gcc-msm8996";
 			#clock-cells = <1>;
-- 
2.12.0
