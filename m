From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Thu, 17 Oct 2013 16:34:41 +0530
Subject: [PATCH 1/1] irqchip: exynos: Remove hardcoded irqbase
Message-ID: <1382007881-1161-1-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that Exynos platforms are DT only, hard-coded irqbase is not
necessary.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/irqchip/exynos-combiner.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/irqchip/exynos-combiner.c b/drivers/irqchip/exynos-combiner.c
index 868ed40..08538df 100644
--- a/drivers/irqchip/exynos-combiner.c
+++ b/drivers/irqchip/exynos-combiner.c
@@ -207,7 +207,7 @@ static int __init combiner_of_init(struct device_node *np,
 {
 	void __iomem *combiner_base;
 	unsigned int max_nr = 20;
-	int irq_base = -1;
+	int irq_base = 0;
 
 	combiner_base = of_iomap(np, 0);
 	if (!combiner_base) {
@@ -221,13 +221,6 @@ static int __init combiner_of_init(struct device_node *np,
 			__func__, max_nr);
 	}
 
-	/* 
-	 * FIXME: This is a hardwired COMBINER_IRQ(0,0). Once all devices
-	 * get their IRQ from DT, remove this in order to get dynamic
-	 * allocation.
-	 */
-	irq_base = 160;
-
 	combiner_init(combiner_base, np, max_nr, irq_base);
 
 	return 0;
-- 
1.7.9.5
