From: agross@codeaurora.org (Andy Gross)
Date: Tue,  8 Sep 2015 16:35:31 -0500
Subject: [PATCH 11/11] arm: dts: Add RPM SMD regulator support on MSM8974
In-Reply-To: <1441748131-26490-1-git-send-email-agross@codeaurora.org>
References: <1441748131-26490-1-git-send-email-agross@codeaurora.org>
Message-ID: <1441748131-26490-13-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds all the nodes required to support the PM8841 and PM8941
PMIC regulators present on MSM8974 platforms.

Signed-off-by: Andy Gross <agross@codeaurora.org>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi |   75 +++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index d7c99b8..f0a41b5 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -114,6 +114,11 @@
 			      <0xf9002000 0x1000>;
 		};
 
+		apcs: syscon at f9011000 {
+			compatible = "syscon";
+			reg = <0xf9011000 0x1000>;
+		};
+
 		timer at f9020000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -334,4 +339,74 @@
 			#interrupt-cells = <4>;
 		};
 	};
+
+	smd {
+		compatible = "qcom,smd";
+
+		rpm {
+			interrupts = <0 168 1>;
+			qcom,ipc = <&apcs 8 0>;
+			qcom,smd-edge = <15>;
+
+			rpm_requests {
+				compatible = "qcom,rpm-msm8974";
+				qcom,smd-channels = "rpm_requests";
+
+				pm8841-regulators {
+					compatible = "qcom,rpm-pm8841-regulators";
+
+					pm8841_s1: s1 {};
+					pm8841_s2: s2 {};
+					pm8841_s3: s3 {};
+					pm8841_s4: s4 {};
+					pm8841_s5: s5 {};
+					pm8841_s6: s6 {};
+					pm8841_s7: s7 {};
+					pm8841_s8: s8 {};
+				};
+
+				pm8941-regulators {
+					compatible = "qcom,rpm-pm8941-regulators";
+
+					pm8941_s1: s1 {};
+					pm8941_s2: s2 {};
+					pm8941_s3: s3 {};
+					pm8941_5v: s4 {};
+
+					pm8941_l1: l1 {};
+					pm8941_l2: l2 {};
+					pm8941_l3: l3 {};
+					pm8941_l4: l4 {};
+					pm8941_l5: l5 {};
+					pm8941_l6: l6 {};
+					pm8941_l7: l7 {};
+					pm8941_l8: l8 {};
+					pm8941_l9: l9 {};
+					pm8941_l10: l10 {};
+					pm8941_l11: l11 {};
+					pm8941_l12: l12 {};
+					pm8941_l13: l13 {};
+					pm8941_l14: l14 {};
+					pm8941_l15: l15 {};
+					pm8941_l16: l16 {};
+					pm8941_l17: l17 {};
+					pm8941_l18: l18 {};
+					pm8941_l19: l19 {};
+					pm8941_l20: l20 {};
+					pm8941_l21: l21 {};
+					pm8941_l22: l22 {};
+					pm8941_l23: l23 {};
+					pm8941_l24: l24 {};
+
+					pm8941_lvs1: lvs1 {};
+					pm8941_lvs2: lvs2 {};
+					pm8941_lvs3: lvs3 {};
+					pm8941_lvs4: lvs4 {};
+
+					pm8941_5vs1: 5vs1 {};
+					pm8941_5vs2: 5vs2 {};
+				};
+			};
+		};
+	};
 };
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
