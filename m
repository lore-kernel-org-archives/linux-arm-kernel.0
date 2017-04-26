From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 26 Apr 2017 12:18:06 +0100
Subject: [RFC/RFT PATCH 15/18] OF/PCI: Update of_irq_parse_and_map_pci()
 comment
In-Reply-To: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
References: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
Message-ID: <20170426111809.19922-16-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Matthew Minter <matt@masarand.com>

With the introduction of struct pci_host_bridge.(*map_irq) function
pointer add another direct usage of of_irq_parse_and_map_pci().

Update the function comment to reflect this behaviour.

Signed-off-by: Matthew Minter <matt@masarand.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/of/of_pci_irq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/of/of_pci_irq.c b/drivers/of/of_pci_irq.c
index c175d9c..3a05568 100644
--- a/drivers/of/of_pci_irq.c
+++ b/drivers/of/of_pci_irq.c
@@ -113,7 +113,8 @@ EXPORT_SYMBOL_GPL(of_irq_parse_pci);
  * @pin: PCI irq pin number; passed when used as map_irq callback. Unused
  *
  * @slot and @pin are unused, but included in the function so that this
- * function can be used directly as the map_irq callback to pci_fixup_irqs().
+ * function can be used directly as the map_irq callback to
+ * pci_assign_irq() and struct pci_host_bridge.map_irq pointer
  */
 int of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin)
 {
-- 
2.10.0
