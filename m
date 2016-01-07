From: richardcochran@gmail.com (Richard Cochran)
Date: Thu, 7 Jan 2016 09:11:02 +0100
Subject: [PATCH] arm: pci: mark the dra7xx driver as broken
In-Reply-To: <568DF4FE.5010704@ti.com>
References: <20160106214518.GA6106@localhost.localdomain>
 <568DF4FE.5010704@ti.com>
Message-ID: <20160107081102.GA6243@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch marks the dra7xx pci host driver as broken.  This driver
was first merged in v3.17 and has never worked.  Although the driver
compiles just fine, it is missing an essential device reset.  If the
driver is included, the kernel locks up hard shortly after booting,
before any console output appears.

Signed-off-by: Richard Cochran <richardcochran@gmail.com>

---
 drivers/pci/host/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index d5e58ba..d83e8f0 100644
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
