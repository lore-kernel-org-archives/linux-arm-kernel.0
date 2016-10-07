From: bhelgaas@google.com (Bjorn Helgaas)
Date: Fri, 07 Oct 2016 11:21:31 -0500
Subject: [PATCH 5/5] PCI: aardvark: Remove unused platform data
In-Reply-To: <20161007162053.22668.91420.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007162053.22668.91420.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Message-ID: <20161007162131.22668.30227.stgit@bhelgaas-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The aardvark driver never uses the platform drvdata pointer, so don't
bother setting it.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-aardvark.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/host/pci-aardvark.c b/drivers/pci/host/pci-aardvark.c
index b255a08..5b12199 100644
--- a/drivers/pci/host/pci-aardvark.c
+++ b/drivers/pci/host/pci-aardvark.c
@@ -922,7 +922,6 @@ static int advk_pcie_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	advk->pdev = pdev;
-	platform_set_drvdata(pdev, advk);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	advk->base = devm_ioremap_resource(dev, res);
