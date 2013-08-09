From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri,  9 Aug 2013 12:35:50 +0200
Subject: [PATCH] PCI: mvebu: make Marvell PCIe driver depend on OF
Message-ID: <1376044550-30572-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Marvell PCIe host controller driver is heavily tied to Device Tree
APIs, and can only be used on platforms where the Device Tree is
used. Therefore, it should "depends on OF" to avoid build failures on
!OF configurations.

Reported-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
Bjorn, you can take this one through your tree. Either for 3.11 or
3.12, at your preference.
---
 drivers/pci/host/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 1184ff6..e5ba4eb 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -4,6 +4,7 @@ menu "PCI host controller drivers"
 config PCI_MVEBU
 	bool "Marvell EBU PCIe controller"
 	depends on ARCH_MVEBU || ARCH_KIRKWOOD
+	depends on OF
 
 config PCIE_DW
 	bool
-- 
1.8.1.2
