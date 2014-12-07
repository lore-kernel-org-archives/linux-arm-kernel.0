From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sun,  7 Dec 2014 20:20:44 +0100
Subject: [PATCH 2/20] PCI: keystone: fix misspelling of current function in
 string
In-Reply-To: <1417980062-25151-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1417980062-25151-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1417980062-25151-3-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace a misspelled function name by %s and then __func__.

The function name contains pcie, not pci as in the string.

This was done using Coccinelle, including the use of Levenshtein distance,
as proposed by Rasmus Villemoes.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
The semantic patch is difficult to summarize, but is available in the cover
letter of this patch series.

 drivers/pci/host/pci-keystone.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-keystone.c b/drivers/pci/host/pci-keystone.c
index 78f79e3..e2f600e 100644
--- a/drivers/pci/host/pci-keystone.c
+++ b/drivers/pci/host/pci-keystone.c
@@ -119,7 +119,7 @@ static void ks_pcie_msi_irq_handler(unsigned int irq, struct irq_desc *desc)
 	struct pcie_port *pp = &ks_pcie->pp;
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 
-	dev_dbg(pp->dev, "ks_pci_msi_irq_handler, irq %d\n", irq);
+	dev_dbg(pp->dev, "%s, irq %d\n", __func__, irq);
 
 	/*
 	 * The chained irq handler installation would have replaced normal
