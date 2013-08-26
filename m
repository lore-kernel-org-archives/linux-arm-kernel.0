From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 26 Aug 2013 19:09:02 +0200
Subject: [PATCH v2 07/16] clk: samsung: exynos4: Remove checks for DT node
In-Reply-To: <1377536951-9307-1-git-send-email-t.figa@samsung.com>
References: <1377536951-9307-1-git-send-email-t.figa@samsung.com>
Message-ID: <1377536951-9307-8-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos 4 supports only DT based bootup, so non-DT cases does not need to
be handled anymore.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/clk/samsung/clk-exynos4.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index 457b15a..f1b61fe 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -1006,11 +1006,9 @@ static void __init exynos4_clk_init(struct device_node *np,
 {
 	struct clk *apll, *mpll, *epll, *vpll;
 
-	if (np) {
-		reg_base = of_iomap(np, 0);
-		if (!reg_base)
-			panic("%s: failed to map registers\n", __func__);
-	}
+	reg_base = of_iomap(np, 0);
+	if (!reg_base)
+		panic("%s: failed to map registers\n", __func__);
 
 	if (exynos4_soc == EXYNOS4210)
 		samsung_clk_init(np, reg_base, nr_clks,
@@ -1021,8 +1019,7 @@ static void __init exynos4_clk_init(struct device_node *np,
 			exynos4_clk_regs, ARRAY_SIZE(exynos4_clk_regs),
 			exynos4x12_clk_save, ARRAY_SIZE(exynos4x12_clk_save));
 
-	if (np)
-		samsung_clk_of_register_fixed_ext(exynos4_fixed_rate_ext_clks,
+	samsung_clk_of_register_fixed_ext(exynos4_fixed_rate_ext_clks,
 			ARRAY_SIZE(exynos4_fixed_rate_ext_clks),
 			ext_clk_match);
 
-- 
1.8.3.2
