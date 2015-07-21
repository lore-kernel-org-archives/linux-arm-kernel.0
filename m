From: long.wanglong@huawei.com (Wang Long)
Date: Tue, 21 Jul 2015 08:11:01 +0000
Subject: [PATCH] drivers/irqchip: replace pr_warning by pr_warn
Message-ID: <1437466261-147373-1-git-send-email-long.wanglong@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the last pr_warning callsite in drivers/irqchip.

Signed-off-by: Wang Long <long.wanglong@huawei.com>
---
 drivers/irqchip/exynos-combiner.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/exynos-combiner.c b/drivers/irqchip/exynos-combiner.c
index 5c82e3b..80104f9 100644
--- a/drivers/irqchip/exynos-combiner.c
+++ b/drivers/irqchip/exynos-combiner.c
@@ -185,14 +185,14 @@ static void __init combiner_init(void __iomem *combiner_base,
 
 	combiner_data = kcalloc(max_nr, sizeof (*combiner_data), GFP_KERNEL);
 	if (!combiner_data) {
-		pr_warning("%s: could not allocate combiner data\n", __func__);
+		pr_warn("%s: could not allocate combiner data\n", __func__);
 		return;
 	}
 
 	combiner_irq_domain = irq_domain_add_linear(np, nr_irq,
 				&combiner_irq_domain_ops, combiner_data);
 	if (WARN_ON(!combiner_irq_domain)) {
-		pr_warning("%s: irq domain init failed\n", __func__);
+		pr_warn("%s: irq domain init failed\n", __func__);
 		return;
 	}
 
-- 
1.8.3.4
