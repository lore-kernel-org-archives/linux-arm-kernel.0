From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 04 Aug 2015 16:54:50 -0500
Subject: [PATCH v5 8/9] PCI: xgene: Look for OF "msi-parent" in host
 controller, not root bus
In-Reply-To: <20150804214234.9189.42548.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150804214234.9189.42548.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Message-ID: <20150804215450.9189.61176.stgit@bhelgaas-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Look for the "msi-parent" in the PCI host controller OF node, not the root
bus OF node.  This makes it the same as MVEBU.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-xgene.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
index 5e0d6de..3cb58a3 100644
--- a/drivers/pci/host/pci-xgene.c
+++ b/drivers/pci/host/pci-xgene.c
@@ -506,8 +506,7 @@ static int xgene_pcie_msi_enable(struct xgene_pcie_port *port,
 {
 	struct device_node *msi_node;
 
-	msi_node = of_parse_phandle(bus->dev.of_node,
-					"msi-parent", 0);
+	msi_node = of_parse_phandle(port->dev.of_node, "msi-parent", 0);
 	if (!msi_node)
 		return -ENODEV;
 
