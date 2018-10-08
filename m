From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 08 Oct 2018 14:50:03 +0200
Subject: [PATCH 1/7] clocksource: exynos_mct: Remove dead code
In-Reply-To: <20181008125009.3721-1-m.szyprowski@samsung.com>
References: <20181008125009.3721-1-m.szyprowski@samsung.com>
 <CGME20181008125046eucas1p1e0304c8c22a4ac128a8e507c86442a37@eucas1p1.samsung.com>
Message-ID: <20181008125009.3721-2-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos Multi-Core Timer driver is used only on device-tree based
systems, so remove non-dt related code.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/clocksource/exynos_mct.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 7a244b681876..43b335ff4a96 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -581,11 +581,7 @@ static int __init mct_init_dt(struct device_node *np, unsigned int int_type)
 	 * timer irqs are specified after the four global timer
 	 * irqs are specified.
 	 */
-#ifdef CONFIG_OF
 	nr_irqs = of_irq_count(np);
-#else
-	nr_irqs = 0;
-#endif
 	for (i = MCT_L0_IRQ; i < nr_irqs; i++)
 		mct_irqs[i] = irq_of_parse_and_map(np, i);
 
-- 
2.17.1
