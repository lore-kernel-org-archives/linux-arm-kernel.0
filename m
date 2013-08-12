From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 12 Aug 2013 20:46:51 +0200
Subject: [PATCH 5/9] PCI: mvebu: add support for Marvell Dove SoCs
In-Reply-To: <1376333215-12885-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1376333215-12885-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1376333215-12885-6-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a compatible for the PCIe controller found on Marvell
Dove SoCs. Binding documentation and Kconfig entry are also updated.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: devicetree at vger.kernel.org
Cc: linux-doc at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-pci at vger.kernel.org
---
 Documentation/devicetree/bindings/pci/mvebu-pci.txt |    1 +
 drivers/pci/host/Kconfig                            |    2 +-
 drivers/pci/host/pci-mvebu.c                        |    1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/mvebu-pci.txt b/Documentation/devicetree/bindings/pci/mvebu-pci.txt
index f2fa261..cf470a9 100644
--- a/Documentation/devicetree/bindings/pci/mvebu-pci.txt
+++ b/Documentation/devicetree/bindings/pci/mvebu-pci.txt
@@ -5,6 +5,7 @@ Mandatory properties:
 - compatible: one of the following values:
     marvell,armada-370-pcie
     marvell,armada-xp-pcie
+    marvell,dove-pcie
     marvell,kirkwood-pcie
 - #address-cells, set to <3>
 - #size-cells, set to <2>
diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 1184ff6..492eec9 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -3,7 +3,7 @@ menu "PCI host controller drivers"
 
 config PCI_MVEBU
 	bool "Marvell EBU PCIe controller"
-	depends on ARCH_MVEBU || ARCH_KIRKWOOD
+	depends on ARCH_MVEBU || ARCH_DOVE || ARCH_KIRKWOOD
 
 config PCIE_DW
 	bool
diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index bdad4d4..b204c1d 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -986,6 +986,7 @@ static int mvebu_pcie_remove(struct platform_device *pdev)
 static const struct of_device_id mvebu_pcie_of_match_table[] = {
 	{ .compatible = "marvell,armada-xp-pcie", },
 	{ .compatible = "marvell,armada-370-pcie", },
+	{ .compatible = "marvell,dove-pcie", },
 	{ .compatible = "marvell,kirkwood-pcie", },
 	{},
 };
-- 
1.7.10.4
