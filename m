From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Tue, 14 Apr 2015 18:42:14 +0530
Subject: [PATCH v5 08/11] arm: dts: qcom: Add #power-domain-cells property
In-Reply-To: <1429017137-20218-1-git-send-email-rnayak@codeaurora.org>
References: <1429017137-20218-1-git-send-email-rnayak@codeaurora.org>
Message-ID: <1429017137-20218-9-git-send-email-rnayak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

msm8974 has gcc and mmcc nodes, and apq8084 has a gcc node which
implement gdsc powerdomains. Add the #power-domain-cells property
to them.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 arch/arm/boot/dts/qcom-apq8084.dtsi | 1 +
 arch/arm/boot/dts/qcom-msm8974.dtsi | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
index 1f130bc..55c281c 100644
--- a/arch/arm/boot/dts/qcom-apq8084.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
@@ -183,6 +183,7 @@
 			compatible = "qcom,gcc-apq8084";
 			#clock-cells = <1>;
 			#reset-cells = <1>;
+			#power-domain-cells = <1>;
 			reg = <0xfc400000 0x4000>;
 		};
 
diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index e265ec1..6184d32 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -179,6 +179,7 @@
 			compatible = "qcom,gcc-msm8974";
 			#clock-cells = <1>;
 			#reset-cells = <1>;
+			#power-domain-cells = <1>;
 			reg = <0xfc400000 0x4000>;
 		};
 
@@ -186,6 +187,7 @@
 			compatible = "qcom,mmcc-msm8974";
 			#clock-cells = <1>;
 			#reset-cells = <1>;
+			#power-domain-cells = <1>;
 			reg = <0xfd8c0000 0x6000>;
 		};
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
