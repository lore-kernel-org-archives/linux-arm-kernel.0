From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 28 Oct 2013 11:02:00 -0700
Subject: [PATCH 2/6] ARM: dts: msm: Add MSM8960 MMCC DT node
In-Reply-To: <1382983324-31155-1-git-send-email-sboyd@codeaurora.org>
References: <1382983324-31155-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1382983324-31155-3-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the necessary DT node to probe the multimedia clock controller
on MSM8960 devices.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/boot/dts/qcom-msm8960-cdp.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8960-cdp.dts b/arch/arm/boot/dts/qcom-msm8960-cdp.dts
index 7234253..cf8ecc5 100644
--- a/arch/arm/boot/dts/qcom-msm8960-cdp.dts
+++ b/arch/arm/boot/dts/qcom-msm8960-cdp.dts
@@ -60,6 +60,13 @@
 		reg = <0x900000 0x4000>;
 	};
 
+	clock-controller at 4000000 {
+		compatible = "qcom,mmcc-8960", "qcom,mmcc";
+		reg = <0x4000000 0x1000>;
+		#clock-cells = <1>;
+		#reset-cells = <1>;
+	};
+
 	kpss at 2088000 {
 		compatible = "qcom,kpss";
 		reg = <0x02088000 0x1000
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
