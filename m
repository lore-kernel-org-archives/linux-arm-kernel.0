From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Mon,  6 Jun 2016 18:17:31 -0500
Subject: [PATCH V5 4/5] irqchip/gicv3-its: Remove an unused argument
 'node_name'
In-Reply-To: <1465255052-28045-1-git-send-email-shankerd@codeaurora.org>
References: <1465255052-28045-1-git-send-email-shankerd@codeaurora.org>
Message-ID: <1465255052-28045-4-git-send-email-shankerd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No references to argument 'node_name' after modifying pr_xxx()
messages to include ITS base address instead of 'node_name'.

Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 0a1944f..7e1b9e0 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -988,7 +988,7 @@ static void its_free_tables(struct its_node *its)
 	}
 }
 
-static int its_alloc_tables(const char *node_name, struct its_node *its)
+static int its_alloc_tables(struct its_node *its)
 {
 	u64 typer = readq_relaxed(its->base + GITS_TYPER);
 	u32 ids = GITS_TYPER_DEVBITS(typer);
@@ -1604,7 +1604,7 @@ static int __init its_probe(struct device_node *node,
 
 	its_enable_quirks(its);
 
-	err = its_alloc_tables(node->full_name, its);
+	err = its_alloc_tables(its);
 	if (err)
 		goto out_free_cmd;
 
-- 
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project
