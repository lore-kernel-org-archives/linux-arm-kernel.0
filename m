From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue,  2 Jun 2015 14:31:49 +0200
Subject: [PATCH 04/11] clocksource/drivers/exynos_mct: Remove old platform
 mct_init()
In-Reply-To: <1433248316-26320-1-git-send-email-daniel.lezcano@linaro.org>
References: <556DA1E5.1030601@linaro.org>
 <1433248316-26320-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1433248316-26320-4-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Since commit 228e3023eb04 ("Merge tag 'mct-exynos-for-v3.10' of ...") the
mct_init() was superseded by mct_init_dt() and is not referenced
anywhere. Remove it.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/exynos_mct.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 8b2a9fc..935b059 100644
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
