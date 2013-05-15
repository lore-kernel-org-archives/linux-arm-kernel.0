From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 15 May 2013 15:36:54 +0200
Subject: [PATCHv4 1/9] pci: mvebu: enable driver usage on Kirkwood
In-Reply-To: <1368625022-25243-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1368625022-25243-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1368625022-25243-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We allow the pci-mvebu driver to be compiled on the Kirkwood platform,
and add the 'marvell,kirkwood-pcie' as a compatible string supported
by the driver.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Tested-by: Andrew Lunn <andrew@lunn.ch>
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
index b0ee63b..6fe8b90 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -853,6 +853,7 @@ static int __init mvebu_pcie_probe(struct platform_device *pdev)
 static const struct of_device_id mvebu_pcie_of_match_table[] = {
 	{ .compatible = "marvell,armada-xp-pcie", },
 	{ .compatible = "marvell,armada-370-pcie", },
+	{ .compatible = "marvell,kirkwood-pcie", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, mvebu_pcie_of_match_table);
-- 
1.7.9.5
