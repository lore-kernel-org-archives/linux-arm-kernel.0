From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 10 Feb 2015 17:06:03 -0800
Subject: [PATCH] ARM: dts: qcom: Add msm8660 PMU node
Message-ID: <1423616763-21121-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable perf events on msm8660 devices by adding the pmu node.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/boot/dts/qcom-msm8660.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom-msm8660.dtsi
index 0affd6193f56..48330e3c8307 100644
--- a/arch/arm/boot/dts/qcom-msm8660.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8660.dtsi
@@ -37,6 +37,11 @@
 		};
 	};
 
+	cpu-pmu {
+		compatible = "qcom,scorpion-mp-pmu";
+		interrupts = <1 9 0x304>;
+	};
+
 	soc: soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
