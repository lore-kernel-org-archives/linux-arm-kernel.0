From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Thu, 29 Aug 2013 11:07:06 +0530
Subject: [PATCH v4 2/5] clk/exynos5420: add gate clock for mixer sysmmu
In-Reply-To: <1377754629-31465-1-git-send-email-rahul.sharma@samsung.com>
References: <1377754629-31465-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1377754629-31465-3-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding sysmmu clock for mixer for exynos5420.

Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
---
 Documentation/devicetree/bindings/clock/exynos5420-clock.txt |    1 +
 drivers/clk/samsung/clk-exynos5420.c                         |    3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/exynos5420-clock.txt b/Documentation/devicetree/bindings/clock/exynos5420-clock.txt
index 596a368..5758a69 100644
--- a/Documentation/devicetree/bindings/clock/exynos5420-clock.txt
+++ b/Documentation/devicetree/bindings/clock/exynos5420-clock.txt
@@ -180,6 +180,7 @@ clock which they consume.
   fimc_lite3		495
   aclk_g3d		500
   g3d			501
+  smmu_mixer		502
 
 Example 1: An example of a clock controller node is listed below.
 
diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index a86cadc..4e0c13e 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -138,7 +138,7 @@ enum exynos5420_clks {
 	aclk300_gscl = 460, smmu_gscl0, smmu_gscl1, gscl_wa, gscl_wb, gscl0,
 	gscl1, clk_3aa, aclk266_g2d = 470, sss, slim_sss, mdma0,
 	aclk333_g2d = 480, g2d, aclk333_432_gscl = 490, smmu_3aa, smmu_fimcl0,
-	smmu_fimcl1, smmu_fimcl3, fimc_lite3, aclk_g3d = 500, g3d,
+	smmu_fimcl1, smmu_fimcl3, fimc_lite3, aclk_g3d = 500, g3d, smmu_mixer,
 
 	nr_clks,
 };
@@ -725,6 +725,7 @@ static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
 	GATE(smmu_mscl0, "smmu_mscl0", "aclk400_mscl", GATE_IP_MSCL, 8, 0, 0),
 	GATE(smmu_mscl1, "smmu_mscl1", "aclk400_mscl", GATE_IP_MSCL, 9, 0, 0),
 	GATE(smmu_mscl2, "smmu_mscl2", "aclk400_mscl", GATE_IP_MSCL, 10, 0, 0),
+	GATE(smmu_mixer, "smmu_mixer", "aclk200_disp1", GATE_IP_DISP1, 9, 0, 0),
 };
 
 static struct samsung_pll_clock exynos5420_plls[nr_plls] __initdata = {
-- 
1.7.10.4
