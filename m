From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Mon, 17 Oct 2016 14:55:40 +0000
Subject: [PATCH -next] PCI: layerscape: Remove redundant dev_err call in
 ls_pcie_probe()
Message-ID: <1476716140-30608-1-git-send-email-weiyj.lk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <weiyongjun1@huawei.com>

There is a error message within devm_ioremap_resource
already, so remove the dev_err call to avoid redundant
error message.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/pci/host/pci-layerscape.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
index 2cb7315..bbd3d23 100644
--- a/drivers/pci/host/pci-layerscape.c
+++ b/drivers/pci/host/pci-layerscape.c
@@ -251,10 +251,8 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
 
 	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
 	pcie->pp.dbi_base = devm_ioremap_resource(dev, dbi_base);
-	if (IS_ERR(pcie->pp.dbi_base)) {
-		dev_err(dev, "missing *regs* space\n");
+	if (IS_ERR(pcie->pp.dbi_base))
 		return PTR_ERR(pcie->pp.dbi_base);
-	}
 
 	pcie->drvdata = match->data;
 	pcie->lut = pcie->pp.dbi_base + pcie->drvdata->lut_offset;
