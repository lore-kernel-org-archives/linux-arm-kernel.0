From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 28 Oct 2013 17:31:30 -0700
Subject: [PATCH 6/6] ARM: dts: msm: Add Krait edac node
In-Reply-To: <1383006690-6754-1-git-send-email-sboyd@codeaurora.org>
References: <1383006690-6754-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1383006690-6754-7-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: David Brown <davidb@codeaurora.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

This is based on the dts updates I sent two weeks ago to add mmio
architected timesr to qcom-msm8974.dtsi.

 arch/arm/boot/dts/qcom-msm8974.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 152879d..7b15eb7 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -32,6 +32,11 @@
 			clock-frequency = <19200000>;
 		};
 
+		edac {
+			compatible = "qcom,krait-cache-erp";
+			interrupts = <1 9 0xf04>, <0 2 0>;
+		};
+
 		timer at f9020000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
