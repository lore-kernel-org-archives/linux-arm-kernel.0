From: Zhiqiang.Hou@nxp.com (Zhiqiang Hou)
Date: Fri, 4 Aug 2017 14:41:34 +0800
Subject: [PATCHv2 2/2] PCI: layerscape: Add support for ls1088a
In-Reply-To: <1501828894-25598-1-git-send-email-Zhiqiang.Hou@nxp.com>
References: <1501828894-25598-1-git-send-email-Zhiqiang.Hou@nxp.com>
Message-ID: <1501828894-25598-3-git-send-email-Zhiqiang.Hou@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V2:
 - New patch

 Documentation/devicetree/bindings/pci/layerscape-pci.txt | 1 +
 drivers/pci/dwc/pci-layerscape.c                         | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
index 2057b00..ebf3fef 100644
--- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
+++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
@@ -16,6 +16,7 @@ Required properties:
         "fsl,ls1021a-pcie", "snps,dw-pcie"
         "fsl,ls2080a-pcie", "fsl,ls2085a-pcie", "snps,dw-pcie"
         "fsl,ls2088a-pcie"
+        "fsl,ls1088a-pcie"
         "fsl,ls1046a-pcie"
 - reg: base addresses and lengths of the PCIe controller
 - interrupts: A list of interrupt outputs of the controller. Must contain an
diff --git a/drivers/pci/dwc/pci-layerscape.c b/drivers/pci/dwc/pci-layerscape.c
index 5989ae1..cdb9800 100644
--- a/drivers/pci/dwc/pci-layerscape.c
+++ b/drivers/pci/dwc/pci-layerscape.c
@@ -255,6 +255,7 @@ static const struct of_device_id ls_pcie_of_match[] = {
 	{ .compatible = "fsl,ls2080a-pcie", .data = &ls2080_drvdata },
 	{ .compatible = "fsl,ls2085a-pcie", .data = &ls2080_drvdata },
 	{ .compatible = "fsl,ls2088a-pcie", .data = &ls2088_drvdata },
+	{ .compatible = "fsl,ls1088a-pcie", .data = &ls2088_drvdata },
 	{ },
 };
 
-- 
2.1.0.27.g96db324
