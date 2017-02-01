From: rrichter@cavium.com (Robert Richter)
Date: Wed, 1 Feb 2017 18:38:26 +0100
Subject: [PATCH 2/9] irqchip/gic-v3-its: Initialize its nodes in probe order
In-Reply-To: <20170201173833.12630-1-rrichter@cavium.com>
References: <20170201173833.12630-1-rrichter@cavium.com>
Message-ID: <20170201173833.12630-3-rrichter@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ATM the last discovered node is initialized first. Though this order
should work too, change the initialization of nodes to probe order as
one would expect it.

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index dce70f21a15d..5dfd489a11d1 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1744,7 +1744,7 @@ static int __init its_probe_one(struct resource *res,
 		goto out_free_tables;
 
 	spin_lock(&its_lock);
-	list_add(&its->entry, &its_nodes);
+	list_add_tail(&its->entry, &its_nodes);
 	spin_unlock(&its_lock);
 
 	return 0;
-- 
2.11.0
