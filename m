From: bhelgaas@google.com (Bjorn Helgaas)
Date: Wed, 12 Oct 2016 07:36:43 -0500
Subject: [PATCH v2 2/2] PCI: aardvark: Remove unused platform data
In-Reply-To: <20161012123001.22186.4053.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012123001.22186.4053.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Message-ID: <20161012123643.22186.96942.stgit@bhelgaas-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The aardvark driver never uses the platform drvdata pointer, so don't
bother setting it.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/pci/host/pci-aardvark.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/host/pci-aardvark.c b/drivers/pci/host/pci-aardvark.c
index 16421d1..4fce494 100644
--- a/drivers/pci/host/pci-aardvark.c
+++ b/drivers/pci/host/pci-aardvark.c
@@ -926,7 +926,6 @@ static int advk_pcie_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	pcie->pdev = pdev;
-	platform_set_drvdata(pdev, pcie);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pcie->base = devm_ioremap_resource(dev, res);
