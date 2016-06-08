From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed,  8 Jun 2016 18:55:33 +0100
Subject: [PATCH] irqchip/armada-370-xp: make syscore_ops static
Message-ID: <1465408533-13906-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The armada_370_xp_mpic_syscore_ops structure is not exported or
declared anywhere. Fix the following warning by making it static:

drivers/irqchip/irq-armada-370-xp.c:544:20: warning: symbol 'armada_370_xp_mpic_syscore_ops' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
---
 drivers/irqchip/irq-armada-370-xp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index e7dc6cb..7c42b1d 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -541,7 +541,7 @@ static void armada_370_xp_mpic_resume(void)
 		writel(1, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
 }
 
-struct syscore_ops armada_370_xp_mpic_syscore_ops = {
+static struct syscore_ops armada_370_xp_mpic_syscore_ops = {
 	.suspend	= armada_370_xp_mpic_suspend,
 	.resume		= armada_370_xp_mpic_resume,
 };
-- 
2.8.1
