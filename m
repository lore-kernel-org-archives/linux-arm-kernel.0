From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Tue, 14 Mar 2017 12:08:51 -0700
Subject: [PATCH] PCI: aardvark: Remove msi-controller dt node probing
Message-ID: <20170314190851.28203-1-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This code assigns variables that are never used. Remove them.

Reported-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 drivers/pci/host/pci-aardvark.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/pci/host/pci-aardvark.c b/drivers/pci/host/pci-aardvark.c
index 4fce494271cc..56e1aead65fc 100644
--- a/drivers/pci/host/pci-aardvark.c
+++ b/drivers/pci/host/pci-aardvark.c
@@ -917,8 +917,6 @@ static int advk_pcie_probe(struct platform_device *pdev)
 	struct advk_pcie *pcie;
 	struct resource *res;
 	struct pci_bus *bus, *child;
-	struct msi_controller *msi;
-	struct device_node *msi_node;
 	int ret, irq;
 
 	pcie = devm_kzalloc(dev, sizeof(struct advk_pcie), GFP_KERNEL);
@@ -962,12 +960,6 @@ static int advk_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	msi_node = of_parse_phandle(dev->of_node, "msi-parent", 0);
-	if (msi_node)
-		msi = of_pci_find_msi_chip_by_node(msi_node);
-	else
-		msi = NULL;
-
 	bus = pci_scan_root_bus_msi(dev, 0, &advk_pcie_ops,
 				    pcie, &pcie->resources, &pcie->msi);
 	if (!bus) {
-- 
2.10.0.297.gf6727b0
