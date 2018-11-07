From: rrichter@cavium.com (Robert Richter)
Date: Wed, 7 Nov 2018 22:03:28 +0000
Subject: [PATCH 06/10] irqchip/gic-v3-its: Initialize its nodes in probe order
In-Reply-To: <20181107220254.6116-1-rrichter@cavium.com>
References: <20181107220254.6116-1-rrichter@cavium.com>
Message-ID: <20181107220254.6116-7-rrichter@cavium.com>
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
index db20e992a40f..4033f71f5181 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3602,7 +3602,7 @@ static int __init its_probe_one(struct resource *res,
 		goto out_free_tables;
 
 	raw_spin_lock(&its_lock);
-	list_add(&its->entry, &its_nodes);
+	list_add_tail(&its->entry, &its_nodes);
 	raw_spin_unlock(&its_lock);
 
 	return 0;
-- 
2.11.0
