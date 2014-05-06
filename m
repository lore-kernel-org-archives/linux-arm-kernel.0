From: shaik.ameer@samsung.com (Shaik Ameer Basha)
Date: Tue, 06 May 2014 21:56:39 +0530
Subject: [PATCH v4 04/15] clk: exynos5420: fix parent clocks for mscl sysmmu
In-Reply-To: <1399393610-23394-1-git-send-email-shaik.ameer@samsung.com>
References: <1399393610-23394-1-git-send-email-shaik.ameer@samsung.com>
Message-ID: <1399393610-23394-5-git-send-email-shaik.ameer@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the parent clocks for mscl sysmmu.

Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
Signed-off-by: Shaik Ameer Basha <shaik.ameer@samsung.com>
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 328be6a..320f72d 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -582,6 +582,9 @@ static struct samsung_div_clock exynos5420_div_clks[] __initdata = {
 			DIV2_RATIO0, 4, 2),
 	DIV(0, "dout_gscl_blk_333", "aclk333_432_gscl", DIV2_RATIO0, 6, 2),
 
+	/* MSCL Block */
+	DIV(0, "dout_mscl_blk", "aclk400_mscl", DIV2_RATIO0, 28, 2),
+
 	/* ISP Block */
 	DIV(0, "dout_isp_sensor0", "mout_isp_sensor", SCLK_DIV_ISP0, 8, 8),
 	DIV(0, "dout_isp_sensor1", "mout_isp_sensor", SCLK_DIV_ISP0, 16, 8),
@@ -812,12 +815,12 @@ static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
 	GATE(CLK_MSCL0, "mscl0", "aclk400_mscl", GATE_IP_MSCL, 0, 0, 0),
 	GATE(CLK_MSCL1, "mscl1", "aclk400_mscl", GATE_IP_MSCL, 1, 0, 0),
 	GATE(CLK_MSCL2, "mscl2", "aclk400_mscl", GATE_IP_MSCL, 2, 0, 0),
-	GATE(CLK_SMMU_MSCL0, "smmu_mscl0", "aclk400_mscl",
-			GATE_IP_MSCL, 8, 0, 0),
-	GATE(CLK_SMMU_MSCL1, "smmu_mscl1", "aclk400_mscl",
-			GATE_IP_MSCL, 9, 0, 0),
-	GATE(CLK_SMMU_MSCL2, "smmu_mscl2", "aclk400_mscl",
-			GATE_IP_MSCL, 10, 0, 0),
+	GATE(CLK_SMMU_MSCL0, "smmu_mscl0", "dout_mscl_blk",
+			GATE_IP_MSCL, 8, CLK_SET_RATE_PARENT, 0),
+	GATE(CLK_SMMU_MSCL1, "smmu_mscl1", "dout_mscl_blk",
+			GATE_IP_MSCL, 9, CLK_SET_RATE_PARENT, 0),
+	GATE(CLK_SMMU_MSCL2, "smmu_mscl2", "dout_mscl_blk",
+			GATE_IP_MSCL, 10, CLK_SET_RATE_PARENT, 0),
 
 	GATE(CLK_FIMD1, "fimd1", "aclk300_disp1", GATE_IP_DISP1, 0, 0, 0),
 	GATE(CLK_DSIM1, "dsim1", "aclk200_disp1", GATE_IP_DISP1, 3, 0, 0),
-- 
1.7.9.5
