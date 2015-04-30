From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 30 Apr 2015 13:42:53 +0900
Subject: [PATCH 3/3] clocksource: exynos_mct: Remove old platform mct_init()
In-Reply-To: <1430368973-23786-1-git-send-email-k.kozlowski@samsung.com>
References: <1430368973-23786-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1430368973-23786-3-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 228e3023eb04 ("Merge tag 'mct-exynos-for-v3.10' of ...") the
mct_init() was superseded by mct_init_dt() and is not referenced
anywhere. Remove it.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clocksource/exynos_mct.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 8b2a9fc66dcc..935b05936dbd 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -560,18 +560,6 @@ out_irq:
 	free_percpu_irq(mct_irqs[MCT_L0_IRQ], &percpu_mct_tick);
 }
 
-void __init mct_init(void __iomem *base, int irq_g0, int irq_l0, int irq_l1)
-{
-	mct_irqs[MCT_G0_IRQ] = irq_g0;
-	mct_irqs[MCT_L0_IRQ] = irq_l0;
-	mct_irqs[MCT_L1_IRQ] = irq_l1;
-	mct_int_type = MCT_INT_SPI;
-
-	exynos4_timer_resources(NULL, base);
-	exynos4_clocksource_init();
-	exynos4_clockevent_init();
-}
-
 static void __init mct_init_dt(struct device_node *np, unsigned int int_type)
 {
 	u32 nr_irqs, i;
-- 
1.9.1
