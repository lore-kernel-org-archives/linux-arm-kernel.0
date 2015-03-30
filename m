From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 30 Mar 2015 16:04:37 +0200
Subject: [PATCH 4/5] irqchip: armada-370-xp: Allow using wakeup source
In-Reply-To: <1427724278-12379-1-git-send-email-gregory.clement@free-electrons.com>
References: <1427724278-12379-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1427724278-12379-5-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the Armada 370/XP SoCs, in standby mode the SoC stay powered and it
is possible to wake-up from any interrupt sources. This patch adds
flag to the MPIC irqchip driver to let linux know this.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/irqchip/irq-armada-370-xp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index 564ec69af5f0..ab186b344e14 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -290,6 +290,7 @@ static struct irq_chip armada_370_xp_irq_chip = {
 #ifdef CONFIG_SMP
 	.irq_set_affinity = armada_xp_set_affinity,
 #endif
+	.flags		= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MASK_ON_SUSPEND,
 };
 
 static int armada_370_xp_mpic_irq_map(struct irq_domain *h,
-- 
2.1.0
