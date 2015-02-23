From: tranmanphong@gmail.com (Phong Tran)
Date: Mon, 23 Feb 2015 17:21:39 +0700
Subject: [PATCH] PCI: xgene: Fix the map_bus callback prototype
Message-ID: <1424686899-7869-1-git-send-email-tranmanphong@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The return value should be void __iomem *.
Tested by compile only.

Signed-off-by: Phong Tran <tranmanphong@gmail.com>
---
 drivers/pci/host/pci-xgene.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
index aab5547..9c3bfd8 100644
--- a/drivers/pci/host/pci-xgene.c
+++ b/drivers/pci/host/pci-xgene.c
@@ -127,7 +127,7 @@ static bool xgene_pcie_hide_rc_bars(struct pci_bus *bus, int offset)
 	return false;
 }
 
-static int xgene_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
+static void __iomem *xgene_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
 			      int offset)
 {
 	struct xgene_pcie_port *port = bus->sysdata;
-- 
2.1.0
