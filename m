From: thomas.petazzoni@bootlin.com (Thomas Petazzoni)
Date: Fri,  3 Aug 2018 16:38:48 +0200
Subject: [PATCH v2 6/6] PCI: mvebu: Drop bogus comment above
 mvebu_pcie_map_registers()
In-Reply-To: <20180803143848.21551-1-thomas.petazzoni@bootlin.com>
References: <20180803143848.21551-1-thomas.petazzoni@bootlin.com>
Message-ID: <20180803143848.21551-7-thomas.petazzoni@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This comment has been there since the driver was introduced, but seems
to be a leftover from previous iterations of the driver. Indeed, we do
not lookup in a list to find the register ranges that matches the
given port/lane, as the "reg" property is in each sub-node
representing a PCI port. There is no lookup involved at all.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 drivers/pci/controller/pci-mvebu.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 9055f03596ef..50eb0729385b 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -888,11 +888,6 @@ static resource_size_t mvebu_pcie_align_resource(struct pci_dev *dev,
 		return start;
 }
 
-/*
- * Looks up the list of register addresses encoded into the reg =
- * <...> property for one that matches the given port/lane. Once
- * found, maps it.
- */
 static void __iomem *mvebu_pcie_map_registers(struct platform_device *pdev,
 					      struct device_node *np,
 					      struct mvebu_pcie_port *port)
-- 
2.14.4
