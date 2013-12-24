From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 15:06:00 +0900
Subject: [PATCH 1/3] irqchip: renesas-irqc: Use lazy disable
In-Reply-To: <cover.1387855444.git.horms+renesas@verge.net.au>
References: <cover.1387855444.git.horms+renesas@verge.net.au>
Message-ID: <272012d0f748de2e4d2428f5cb7003280032ce08.1387855444.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Set the ->irq_enable() and ->irq_disable() methods to NULL
to enable lazy disable of interrupts. This by itself provides
some level of optimization, but is mainly enabled as ground
work for future Suspend-to-RAM wake up support.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/irqchip/irq-renesas-irqc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-irqc.c b/drivers/irqchip/irq-renesas-irqc.c
index 2f404ba..8fdd7d6 100644
--- a/drivers/irqchip/irq-renesas-irqc.c
+++ b/drivers/irqchip/irq-renesas-irqc.c
@@ -212,8 +212,6 @@ static int irqc_probe(struct platform_device *pdev)
 	irq_chip->name = name;
 	irq_chip->irq_mask = irqc_irq_disable;
 	irq_chip->irq_unmask = irqc_irq_enable;
-	irq_chip->irq_enable = irqc_irq_enable;
-	irq_chip->irq_disable = irqc_irq_disable;
 	irq_chip->irq_set_type = irqc_irq_set_type;
 	irq_chip->flags	= IRQCHIP_SKIP_SET_WAKE;
 
-- 
1.8.4
