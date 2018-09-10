From: lkundrak@v3.sk (Lubomir Rintel)
Date: Mon, 10 Sep 2018 13:59:32 +0200
Subject: [PATCH 2/5] PCI: provide pci_match_id() with CONFIG_PCI=n
In-Reply-To: <20180910115935.163121-1-lkundrak@v3.sk>
References: <20180910115935.163121-1-lkundrak@v3.sk>
Message-ID: <20180910115935.163121-3-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This spares drivers from #ifdef-ing on CONFIG_PCI if the driver can be
optionally built on machines without PCI bus.

Consistent with acpi_driver_match_device() and similar.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 include/linux/pci.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index e72ca8dd6241..d2f14eb23ea4 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1702,6 +1702,10 @@ static inline int pci_irqd_intx_xlate(struct irq_domain *d,
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
2.17.1
