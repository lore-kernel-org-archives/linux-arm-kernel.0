From: bhelgaas@google.com (Bjorn Helgaas)
Date: Mon, 06 Jun 2016 18:06:14 -0500
Subject: [PATCH v1 12/25] PCI: xilinx-nwl: Use dev_printk() when possible
In-Reply-To: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Message-ID: <20160606230614.20936.98599.stgit@bhelgaas-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use dev_printk() when possible to make messages more useful.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-xilinx-nwl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
index 3c16bbf..0b597d9 100644
--- a/drivers/pci/host/pcie-xilinx-nwl.c
+++ b/drivers/pci/host/pcie-xilinx-nwl.c
@@ -825,7 +825,7 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 
 	err = of_pci_get_host_bridge_resources(node, 0, 0xff, &res, &iobase);
 	if (err) {
-		pr_err("Getting bridge resources failed\n");
+		dev_err(pcie->dev, "Getting bridge resources failed\n");
 		return err;
 	}
 
