From: bhumirks@gmail.com (Bhumika Goyal)
Date: Mon, 18 Sep 2017 19:56:55 +0530
Subject: [PATCH] qe/ic: make qe_ic_irq_chip const and __initconst
Message-ID: <1505744815-28851-1-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make this const as it is used only as a copy operation. This usage is
inside an __init function, so make it __initconst too.

Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
Cross-compiled for powerpc.

 drivers/soc/fsl/qe/qe_ic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/soc/fsl/qe/qe_ic.c
index ec2ca86..781e0ce 100644
--- a/drivers/soc/fsl/qe/qe_ic.c
+++ b/drivers/soc/fsl/qe/qe_ic.c
@@ -238,7 +238,7 @@ static void qe_ic_mask_irq(struct irq_data *d)
 	raw_spin_unlock_irqrestore(&qe_ic_lock, flags);
 }
 
-static struct irq_chip qe_ic_irq_chip = {
+static const struct irq_chip qe_ic_irq_chip __initconst = {
 	.name = "QEIC",
 	.irq_unmask = qe_ic_unmask_irq,
 	.irq_mask = qe_ic_mask_irq,
-- 
1.9.1
