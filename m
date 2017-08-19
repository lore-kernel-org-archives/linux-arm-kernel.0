From: bhumirks@gmail.com (Bhumika Goyal)
Date: Sat, 19 Aug 2017 17:52:01 +0530
Subject: [PATCH] qe/ic: make irq_chip const
Message-ID: <1503145321-13202-1-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make this const as it is only used in a copy operation.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/soc/fsl/qe/qe_ic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/soc/fsl/qe/qe_ic.c
index ec2ca86..00f48d5 100644
--- a/drivers/soc/fsl/qe/qe_ic.c
+++ b/drivers/soc/fsl/qe/qe_ic.c
@@ -238,7 +238,7 @@ static void qe_ic_mask_irq(struct irq_data *d)
 	raw_spin_unlock_irqrestore(&qe_ic_lock, flags);
 }
 
-static struct irq_chip qe_ic_irq_chip = {
+static const struct irq_chip qe_ic_irq_chip = {
 	.name = "QEIC",
 	.irq_unmask = qe_ic_unmask_irq,
 	.irq_mask = qe_ic_mask_irq,
-- 
1.9.1
