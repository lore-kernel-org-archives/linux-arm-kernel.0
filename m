From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 18 May 2017 10:07:40 +0200
Subject: [PATCH v3 4/4] Revert "irqchip/armada-370-xp: Fix regression by
 clearing IRQ_NOAUTOEN"
In-Reply-To: <1495094860-24709-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1495094860-24709-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1495094860-24709-5-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit 353d6d6c82e5d2533ba22e7f9fb081582bf50dc2, which is
no longer needed, now that the irq-armada-370-xp driver properly
re-enables per-CPU interrupt on both the boot CPU and secondary CPUs
after resume.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/irqchip/irq-armada-370-xp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index 1d4de6e..577b428 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -365,7 +365,6 @@ static int armada_370_xp_mpic_irq_map(struct irq_domain *h,
 					handle_level_irq);
 	}
 	irq_set_probe(virq);
-	irq_clear_status_flags(virq, IRQ_NOAUTOEN);
 
 	return 0;
 }
-- 
2.7.4
