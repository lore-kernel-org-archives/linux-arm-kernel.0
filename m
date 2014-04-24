From: shaik.ameer@samsung.com (Shaik Ameer Basha)
Date: Thu, 24 Apr 2014 18:33:50 +0530
Subject: [PATCH v3 14/16] clk: exynos5420: correct g3d parent clock
In-Reply-To: <1398344632-18623-1-git-send-email-shaik.ameer@samsung.com>
References: <1398344632-18623-1-git-send-email-shaik.ameer@samsung.com>
Message-ID: <1398344632-18623-15-git-send-email-shaik.ameer@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the g3d parent clock.

Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
Signed-off-by: Shaik Ameer Basha <shaik.ameer@samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c   |    7 +++----
 include/dt-bindings/clock/exynos5420.h |    2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 0323b34..944ff20 100755
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -427,8 +427,8 @@ static struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
 			8, 1),
 	MUX(0, "mout_user_aclk266_g2d", mout_user_aclk266_g2d_p, SRC_TOP5,
 			12, 1),
-	MUX_A(0, "mout_user_aclk_g3d", mout_user_aclk_g3d_p,
-			SRC_TOP5, 16, 1, "aclkg3d"),
+	MUX(CLK_MOUT_G3D, "mout_user_aclk_g3d", mout_user_aclk_g3d_p,
+			SRC_TOP5, 16, 1),
 	MUX(0, "mout_user_aclk300_jpeg", mout_user_aclk300_jpeg_p,
 			SRC_TOP5, 20, 1),
 	MUX(0, "mout_user_aclk300_disp1", mout_user_aclk300_disp1_p,
@@ -889,8 +889,7 @@ static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
 	GATE(CLK_MFC, "mfc", "aclk333", GATE_IP_MFC, 0, 0, 0),
 	GATE(CLK_SMMU_MFCL, "smmu_mfcl", "dout_mfc_blk", GATE_IP_MFC, 1, 0, 0),
 	GATE(CLK_SMMU_MFCR, "smmu_mfcr", "dout_mfc_blk", GATE_IP_MFC, 2, 0, 0),
-
-	GATE(CLK_G3D, "g3d", "aclkg3d", GATE_IP_G3D, 9, 0, 0),
+	GATE(CLK_G3D, "g3d", "mout_user_aclk_g3d", GATE_IP_G3D, 9, 0, 0),
 
 	GATE(CLK_ROTATOR, "rotator", "mout_user_aclk266", GATE_IP_GEN, 1, 0, 0),
 	GATE(CLK_JPEG, "jpeg", "aclk300_jpeg", GATE_IP_GEN, 2, 0, 0),
diff --git a/include/dt-bindings/clock/exynos5420.h b/include/dt-bindings/clock/exynos5420.h
index c36c7c6..b2410bc 100755
--- a/include/dt-bindings/clock/exynos5420.h
+++ b/include/dt-bindings/clock/exynos5420.h
@@ -176,7 +176,6 @@
 #define CLK_SMMU_FIMCL1		493
 #define CLK_SMMU_FIMCL3		494
 #define CLK_FIMC_LITE3		495
-#define CLK_ACLK_G3D		500
 #define CLK_G3D			501
 #define CLK_SMMU_MIXER		502
 #define CLK_SMMU_G2D		503
@@ -190,6 +189,7 @@
 /* mux clocks */
 #define CLK_MOUT_HDMI		640
 #define CLK_MOUT_MAUDIO0	642
+#define CLK_MOUT_G3D		643
 
 /* divider clocks */
 #define CLK_DOUT_PIXEL		768
-- 
1.7.9.5
