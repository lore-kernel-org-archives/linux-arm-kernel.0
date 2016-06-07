From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon,  6 Jun 2016 17:57:24 -0700
Subject: [PATCH] ARM: dts: msm8916: Update reserved-memory
In-Reply-To: <1465261044-2762-1-git-send-email-bjorn.andersson@linaro.org>
References: <1465261044-2762-1-git-send-email-bjorn.andersson@linaro.org>
Message-ID: <1465261044-2762-2-git-send-email-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update reserved-memory in accordance with memory the detailed memory map
for 8916, so that we will be able to reference the firmware memory
regions.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 41 ++++++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 96812007850e..3ca609a11648 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -42,13 +42,48 @@
 		#size-cells = <2>;
 		ranges;
 
-		reserve_aligned at 86000000 {
-			reg = <0x0 0x86000000 0x0 0x0300000>;
+		tz-apps at 86000000 {
+			reg = <0x0 0x86000000 0x0 0x300000>;
 			no-map;
 		};
 
 		smem_mem: smem_region at 86300000 {
-			reg = <0x0 0x86300000 0x0 0x0100000>;
+			reg = <0x0 0x86300000 0x0 0x100000>;
+			no-map;
+		};
+
+		hypervisor at 86400000 {
+			reg = <0x0 0x86400000 0x0 0x100000>;
+			no-map;
+		};
+
+		tz at 86500000 {
+			reg = <0x0 0x86500000 0x0 0x180000>;
+			no-map;
+		};
+
+		reserved at 8668000 {
+			reg = <0x0 0x86680000 0x0 0x80000>;
+			no-map;
+		};
+
+		rmtfs at 86700000 {
+			reg = <0x0 0x86700000 0x0 0xe0000>;
+			no-map;
+		};
+
+		rfsa at 867e00000 {
+			reg = <0x0 0x867e0000 0x0 0x20000>;
+			no-map;
+		};
+
+		mpss at 86800000 {
+			reg = <0x0 0x86800000 0x0 0x2b00000>;
+			no-map;
+		};
+
+		wcnss at 89300000 {
+			reg = <0x0 0x89300000 0x0 0x600000>;
 			no-map;
 		};
 	};
-- 
2.5.0
