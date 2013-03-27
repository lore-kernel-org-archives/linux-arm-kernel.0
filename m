From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 27 Mar 2013 19:05:00 +0100
Subject: [RFC PATCHv1 1/5] pci: mvebu: enable driver usage on Kirkwood
In-Reply-To: <1364407504-13524-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1364407504-13524-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1364407504-13524-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We allow the pci-mvebu driver to be compiled on the Kirkwood platform,
and add the 'marvell,kirkwood-pcie' as a compatible string supported
by the driver.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../devicetree/bindings/pci/mvebu-pci.txt          |    1 +
 drivers/pci/host/Kconfig                           |    2 +-
 drivers/pci/host/pci-mvebu.c                       |    1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/mvebu-pci.txt b/Documentation/devicetree/bindings/pci/mvebu-pci.txt
index eb69d92..f8d4058 100644
--- a/Documentation/devicetree/bindings/pci/mvebu-pci.txt
+++ b/Documentation/devicetree/bindings/pci/mvebu-pci.txt
@@ -4,6 +4,7 @@ Mandatory properties:
 - compatible: one of the following values:
     marvell,armada-370-pcie
     marvell,armada-xp-pcie
+    marvell,kirkwood-pcie
 - #address-cells, set to <3>
 - #size-cells, set to <2>
 - #interrupt-cells, set to <1>
diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 6918fbc..1f1d67f 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -3,6 +3,6 @@ menu "PCI host controller drivers"
 
 config PCI_MVEBU
 	bool "Marvell EBU PCIe controller"
-	depends on ARCH_MVEBU
+	depends on ARCH_MVEBU || ARCH_KIRKWOOD
 
 endmenu
diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 289babd..8d6b5ea 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -901,6 +901,7 @@ static int __init mvebu_pcie_probe(struct platform_device *pdev)
 static const struct of_device_id mvebu_pcie_of_match_table[] = {
 	{ .compatible = "marvell,armada-xp-pcie", },
 	{ .compatible = "marvell,armada-370-pcie", },
+	{ .compatible = "marvell,kirkwood-pcie", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, mvebu_pcie_of_match_table);
-- 
1.7.9.5
