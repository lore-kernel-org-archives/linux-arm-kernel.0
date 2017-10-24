From: xiaowei.bao@nxp.com (Bao Xiaowei)
Date: Tue, 24 Oct 2017 16:30:45 +0800
Subject: [PATCH 3/3] ARMv8: pcie: make the DWC EP driver support for layerscape
In-Reply-To: <20171024083045.31135-1-xiaowei.bao@nxp.com>
References: <20171024083045.31135-1-xiaowei.bao@nxp.com>
Message-ID: <20171024083045.31135-4-xiaowei.bao@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Layerscape pcie controllers support RC or EP mode, Add the EP mode
support in Kconfig, the driver will support both RC and EP mode, and
the driver is able to judge the pcie controllers work on RC or EP mode.

Signed-off-by: Bao Xiaowei <xiaowei.bao@nxp.com>
---
 drivers/pci/dwc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig
index 22ec82fcdea2..b5f507795779 100644
--- a/drivers/pci/dwc/Kconfig
+++ b/drivers/pci/dwc/Kconfig
@@ -108,6 +108,7 @@ config PCI_LAYERSCAPE
 	depends on PCI_MSI_IRQ_DOMAIN
 	select MFD_SYSCON
 	select PCIE_DW_HOST
+	select PCIE_DW_EP
 	help
 	  Say Y here if you want PCIe controller support on Layerscape SoCs.
 
-- 
2.14.1
