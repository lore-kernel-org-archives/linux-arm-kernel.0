From: rjui@broadcom.com (Ray Jui)
Date: Tue, 15 Sep 2015 17:39:17 -0700
Subject: [PATCH 3/8] PCI: iproc: Remove ARCH specific flag
In-Reply-To: <1442363962-29805-1-git-send-email-rjui@broadcom.com>
References: <1442363962-29805-1-git-send-email-rjui@broadcom.com>
Message-ID: <1442363962-29805-4-git-send-email-rjui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now setup-irq.o is built for arm64, in 'commit 459a07721c11
("PCI: Build setup-irq.o for arm64")' by Jayachandran, pci_fixup_irqs
can be referenced. We no longer need the CONFIG_ARM flag to wrap
around call to pci_fixup_irqs

Signed-off-by: Ray Jui <rjui@broadcom.com>
---
 drivers/pci/host/pcie-iproc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index fe2efb1..52e7ff2 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -238,9 +238,7 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
 
 	pci_scan_child_bus(bus);
 	pci_assign_unassigned_bus_resources(bus);
-#ifdef CONFIG_ARM
 	pci_fixup_irqs(pci_common_swizzle, pcie->map_irq);
-#endif
 	pci_bus_add_devices(bus);
 
 	return 0;
-- 
1.9.1
