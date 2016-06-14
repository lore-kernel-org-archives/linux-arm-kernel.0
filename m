From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Tue, 14 Jun 2016 09:45:18 -0500
Subject: [PATCH V6 4/5] irqchip/gicv3-its: Remove an unused argument
 'node_name'
In-Reply-To: <1465915519-10807-1-git-send-email-shankerd@codeaurora.org>
References: <1465915519-10807-1-git-send-email-shankerd@codeaurora.org>
Message-ID: <1465915519-10807-4-git-send-email-shankerd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No references to argument 'node_name' after modifying pr_xxx()
messages to include ITS base address instead of 'node_name'.

Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 146189b..7afac33 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -982,7 +982,7 @@ static void its_free_tables(struct its_node *its)
 	}
 }
 
-static int its_alloc_tables(const char *node_name, struct its_node *its)
+static int its_alloc_tables(struct its_node *its)
 {
 	u64 typer = readq_relaxed(its->base + GITS_TYPER);
 	u32 ids = GITS_TYPER_DEVBITS(typer);
@@ -1598,7 +1598,7 @@ static int __init its_probe(struct device_node *node,
 
 	its_enable_quirks(its);
 
-	err = its_alloc_tables(node->full_name, its);
+	err = its_alloc_tables(its);
 	if (err)
 		goto out_free_cmd;
 
-- 
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project
