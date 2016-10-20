From: spjoshi@codeaurora.org (Sarangdhar Joshi)
Date: Thu, 20 Oct 2016 11:56:03 -0700
Subject: [PATCH 2/4] arm64: dts: msm8996: Add reserve-memory nodes
In-Reply-To: <1476989765-7524-1-git-send-email-spjoshi@codeaurora.org>
References: <1476989765-7524-1-git-send-email-spjoshi@codeaurora.org>
Message-ID: <1476989765-7524-2-git-send-email-spjoshi@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add reserve-memory nodes required for Qualcomm
Peripheral Image Loaders

Signed-off-by: Sarangdhar Joshi <spjoshi@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 36216ae..949b096 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -36,6 +36,31 @@
 		#size-cells = <2>;
 		ranges;
 
+		mba_region: mba at 91500000 {
+			reg = <0x0 0x91500000 0x0 0x200000>;
+			no-map;
+		};
+
+		slpi_region: slpi at 90b00000 {
+			reg = <0x0 0x90b00000 0xa00000>;
+			no-map;
+		};
+
+		venus_region: venus at 90400000 {
+			reg = <0x0 0x90400000 0x0 0x700000>;
+			no-map;
+		};
+
+		adsp_region: adsp at 8ea00000 {
+			reg = <0x0 0x8ea00000 0x0 0x1a00000>;
+			no-map;
+		};
+
+		mpss_region: mpss at 88800000 {
+			reg = <0x0 0x88800000 0x0 0x6200000>;
+			no-map;
+		};
+
 		smem_mem: smem-mem at 86000000 {
 			reg = <0x0 0x86000000 0x0 0x200000>;
 			no-map;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
