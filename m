From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 19 Mar 2013 11:19:27 +0900
Subject: [PATCH 05/14] irqchip: intc-irqpin: Whitespace fixes
In-Reply-To: <1363659576-6333-1-git-send-email-horms+renesas@verge.net.au>
References: <1363659576-6333-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363659576-6333-6-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Remove whitespace damage and add newline
between variables and code.

Signed-off-by: Magnus Damm <damm@opensource.se>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/irqchip/irq-renesas-intc-irqpin.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-intc-irqpin.c b/drivers/irqchip/irq-renesas-intc-irqpin.c
index 1e5058a..4b5933f 100644
--- a/drivers/irqchip/irq-renesas-intc-irqpin.c
+++ b/drivers/irqchip/irq-renesas-intc-irqpin.c
@@ -57,13 +57,13 @@ struct intc_irqpin_iomem {
 	unsigned long (*read)(void __iomem *iomem);
 	void (*write)(void __iomem *iomem, unsigned long data);
 	int width;
-};  
+};
 
 struct intc_irqpin_irq {
 	int hw_irq;
 	int irq;
 	struct intc_irqpin_priv *p;
-};  
+};
 
 struct intc_irqpin_priv {
 	struct intc_irqpin_iomem iomem[INTC_IRQPIN_REG_NR];
@@ -99,6 +99,7 @@ static inline unsigned long intc_irqpin_read(struct intc_irqpin_priv *p,
 					     int reg)
 {
 	struct intc_irqpin_iomem *i = &p->iomem[reg];
+
 	return i->read(i->iomem);
 }
 
@@ -106,6 +107,7 @@ static inline void intc_irqpin_write(struct intc_irqpin_priv *p,
 				     int reg, unsigned long data)
 {
 	struct intc_irqpin_iomem *i = &p->iomem[reg];
+
 	i->write(i->iomem, data);
 }
 
@@ -405,7 +407,7 @@ static int intc_irqpin_probe(struct platform_device *pdev)
 			dev_warn(&pdev->dev, "irq base mismatch (%d/%d)\n",
 				 p->config.irq_base, k);
 	}
-	
+
 	return 0;
 
 err3:
-- 
1.7.10.4
