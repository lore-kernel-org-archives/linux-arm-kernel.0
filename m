From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Thu, 28 Jul 2016 16:17:14 +0000
Subject: [PATCH -next] PCI: aardvark: Remove redundant dev_err call in
 advk_pcie_probe()
Message-ID: <1469722634-15049-1-git-send-email-weiyj.lk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a error message within devm_ioremap_resource
already, so remove the dev_err call to avoid redundant
error message.

Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
---
 drivers/pci/host/pci-aardvark.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/host/pci-aardvark.c b/drivers/pci/host/pci-aardvark.c
index ef9893f..05c33b5 100644
--- a/drivers/pci/host/pci-aardvark.c
+++ b/drivers/pci/host/pci-aardvark.c
@@ -925,10 +925,8 @@ static int advk_pcie_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pcie->base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(pcie->base)) {
-		dev_err(&pdev->dev, "Failed to map registers\n");
+	if (IS_ERR(pcie->base))
 		return PTR_ERR(pcie->base);
-	}
 
 	irq = platform_get_irq(pdev, 0);
 	ret = devm_request_irq(&pdev->dev, irq, advk_pcie_irq_handler,
