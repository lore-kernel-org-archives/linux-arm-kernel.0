From: bhelgaas@google.com (Bjorn Helgaas)
Date: Fri, 08 Jan 2016 09:54:02 -0600
Subject: [PATCH 1/2] PCI: dra7xx: Mark driver as broken
In-Reply-To: <20160108153427.32755.63673.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160108153427.32755.63673.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Message-ID: <20160108155402.32755.99031.stgit@bhelgaas-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Richard Cochran <richardcochran@gmail.com>

Mark the dra7xx PCI host driver as broken.  This driver was first merged in
v3.17 and has never worked.  Although the driver compiles just fine, it is
missing an essential device reset.  If the driver is included, the kernel
locks up hard shortly after booting, before any console output appears.

Signed-off-by: Richard Cochran <richardcochran@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index f131ba9..c0ad9aa 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -5,6 +5,7 @@ config PCI_DRA7XX
 	bool "TI DRA7xx PCIe controller"
 	select PCIE_DW
 	depends on OF && HAS_IOMEM && TI_PIPE3
+	depends on BROKEN
 	help
 	 Enables support for the PCIe controller in the DRA7xx SoC.  There
 	 are two instances of PCIe controller in DRA7xx.  This controller can
