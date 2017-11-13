From: helgaas@kernel.org (Bjorn Helgaas)
Date: Mon, 13 Nov 2017 16:40:43 -0600
Subject: [PATCH v1 1/3] PCI: xgene: Rename xgene_pcie_probe_bridge() to
 xgene_pcie_probe()
In-Reply-To: <20171113224001.29024.87126.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20171113224001.29024.87126.stgit@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <20171113224043.29024.73152.stgit@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bjorn Helgaas <bhelgaas@google.com>

Rename xgene_pcie_probe_bridge() to xgene_pcie_probe() to follow the
convention of other drivers.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-xgene.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
index 087645116ecb..9f53612f6594 100644
--- a/drivers/pci/host/pci-xgene.c
+++ b/drivers/pci/host/pci-xgene.c
@@ -628,7 +628,7 @@ static struct pci_ops xgene_pcie_ops = {
 	.write = pci_generic_config_write32,
 };
 
-static int xgene_pcie_probe_bridge(struct platform_device *pdev)
+static int xgene_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *dn = dev->of_node;
@@ -709,7 +709,7 @@ static struct platform_driver xgene_pcie_driver = {
 		.of_match_table = of_match_ptr(xgene_pcie_match_table),
 		.suppress_bind_attrs = true,
 	},
-	.probe = xgene_pcie_probe_bridge,
+	.probe = xgene_pcie_probe,
 };
 builtin_platform_driver(xgene_pcie_driver);
 #endif
