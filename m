From: lkundrak@v3.sk (Lubomir Rintel)
Date: Wed, 10 Oct 2018 19:09:27 +0200
Subject: [PATCH v2 02/11] PCI: Provide pci_match_id() with CONFIG_PCI=n
In-Reply-To: <20181010170936.316862-1-lkundrak@v3.sk>
References: <20181010170936.316862-1-lkundrak@v3.sk>
Message-ID: <20181010170936.316862-3-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This spares drivers from #ifdef-ing on CONFIG_PCI if the driver can be
optionally built on machines without PCI bus.

Consistent with acpi_driver_match_device() and similar.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v1:
- Capitalization in the commit message

 include/linux/pci.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 6925828f9f25..2c4755032475 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1705,6 +1705,10 @@ static inline int pci_irqd_intx_xlate(struct irq_domain *d,
 				      unsigned long *out_hwirq,
 				      unsigned int *out_type)
 { return -EINVAL; }
+
+static inline const struct pci_device_id *pci_match_id(const struct pci_device_id *ids,
+							 struct pci_dev *dev)
+{ return NULL; }
 #endif /* CONFIG_PCI */
 
 /* Include architecture-dependent settings and functions */
-- 
2.19.0
