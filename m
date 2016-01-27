From: yang.shi@linaro.org (Yang Shi)
Date: Wed, 27 Jan 2016 09:32:05 -0800
Subject: [PATCH] PCI: layerscape: add ls2085a compatible
Message-ID: <1453915925-19198-1-git-send-email-yang.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The layerscape PCI host driver needs recognize ls2085a compatible when using
firmware with ls2085a compatible property, otherwise the PCI bus won't be
detected even though ls2085a compatible is included by the dts.

Signed-off-by: Yang Shi <yang.shi@linaro.org>
---
 drivers/pci/host/pci-layerscape.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
index 3923bed..c40d8b2 100644
--- a/drivers/pci/host/pci-layerscape.c
+++ b/drivers/pci/host/pci-layerscape.c
@@ -203,6 +203,7 @@ static const struct of_device_id ls_pcie_of_match[] = {
 	{ .compatible = "fsl,ls1021a-pcie", .data = &ls1021_drvdata },
 	{ .compatible = "fsl,ls1043a-pcie", .data = &ls1043_drvdata },
 	{ .compatible = "fsl,ls2080a-pcie", .data = &ls2080_drvdata },
+	{ .compatible = "fsl,ls2085a-pcie", .data = &ls2080_drvdata },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, ls_pcie_of_match);
-- 
2.0.2
