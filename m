From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 10 Feb 2016 15:46:59 +0100
Subject: [PATCH v3 4/6] irqchip: irq-armada-370-xp: use shorter names for
 irq_chip
In-Reply-To: <1455115621-22846-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1455115621-22846-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1455115621-22846-5-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to make the output of /proc/interrupts, use shorter names for
the irq_chip registered by the irq-armada-370-xp driver. Using capital
letters also matches better what is done for the GIC driver, which
uses just "GIC" as the irq_chip->name.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/irqchip/irq-armada-370-xp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index f53eb71..c99ae5f 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -117,7 +117,7 @@ static void armada_370_xp_irq_unmask(struct irq_data *d)
 #ifdef CONFIG_PCI_MSI
 
 static struct irq_chip armada_370_xp_msi_irq_chip = {
-	.name = "armada_370_xp_msi_irq",
+	.name = "MPIC MSI",
 	.irq_mask = pci_msi_mask_irq,
 	.irq_unmask = pci_msi_unmask_irq,
 };
@@ -141,7 +141,7 @@ static int armada_370_xp_msi_set_affinity(struct irq_data *irq_data,
 }
 
 static struct irq_chip armada_370_xp_msi_bottom_irq_chip = {
-	.name			= "armada_370_xp_msi_irq",
+	.name			= "MPIC MSI",
 	.irq_compose_msi_msg	= armada_370_xp_compose_msi_msg,
 	.irq_set_affinity	= armada_370_xp_msi_set_affinity,
 };
@@ -253,7 +253,7 @@ static int armada_xp_set_affinity(struct irq_data *d,
 #endif
 
 static struct irq_chip armada_370_xp_irq_chip = {
-	.name		= "armada_370_xp_irq",
+	.name		= "MPIC",
 	.irq_mask       = armada_370_xp_irq_mask,
 	.irq_mask_ack   = armada_370_xp_irq_mask,
 	.irq_unmask     = armada_370_xp_irq_unmask,
-- 
2.6.4
