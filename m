From: chanho61.park@samsung.com (Chanho Park)
Date: Mon, 22 Jul 2013 17:12:30 +0900
Subject: [PATCH] clk: exynos4: fix g2d/mdma clocks of exynos4x12
Message-ID: <1374480750-30962-1-git-send-email-chanho61.park@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The exynos4x12 has different address of GATE_IP_IMAGE reg. We should use
EXYNOS4X12_GATE_IP_IMAGE for g2d gating clocks instead of 4210's reg.
In case of mdma node, We don't use it for any exynos4 chipsets. I think we'll
need to change it to 'none' or leave it on.

Signed-off-by: Chanho Park <chanho61.park@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/clk/samsung/clk-exynos4.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index 1bdb882..6300c9d 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -820,8 +820,10 @@ struct samsung_gate_clock exynos4210_gate_clks[] __initdata = {
 struct samsung_gate_clock exynos4x12_gate_clks[] __initdata = {
 	GATE(audss, "audss", "sclk_epll", E4X12_GATE_IP_MAUDIO, 0, 0, 0),
 	GATE(mdnie0, "mdnie0", "aclk160", GATE_IP_LCD0, 2, 0, 0),
+	GATE(g2d, "g2d", "aclk200", E4X12_GATE_IP_IMAGE, 0, 0, 0),
 	GATE(rotator, "rotator", "aclk200", E4X12_GATE_IP_IMAGE, 1, 0, 0),
-	GATE(mdma2, "mdma2", "aclk200", E4X12_GATE_IP_IMAGE, 2, 0, 0),
+	GATE(mdma, "mdma", "aclk200", E4X12_GATE_IP_IMAGE, 2, 0, 0),
+	GATE(smmu_g2d, "smmu_g2d", "aclk200", E4X12_GATE_IP_IMAGE, 3, 0, 0),
 	GATE(smmu_mdma, "smmu_mdma", "aclk200", E4X12_GATE_IP_IMAGE, 5, 0, 0),
 	GATE(mipi_hsi, "mipi_hsi", "aclk133", GATE_IP_FSYS, 10, 0, 0),
 	GATE(chipid, "chipid", "aclk100", E4X12_GATE_IP_PERIR, 0, 0, 0),
-- 
1.7.9.5
