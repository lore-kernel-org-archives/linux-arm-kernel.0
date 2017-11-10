From: xiaowei.bao@nxp.com (Bao Xiaowei)
Date: Fri, 10 Nov 2017 11:48:47 +0800
Subject: [PATCHv4 3/3] ARMv8: pcie: make the DWC EP driver support for
 layerscape
In-Reply-To: <20171110034847.17891-1-xiaowei.bao@nxp.com>
References: <20171110034847.17891-1-xiaowei.bao@nxp.com>
Message-ID: <20171110034847.17891-4-xiaowei.bao@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Layerscape pcie controllers support RC or EP mode, Add the EP mode
support in Kconfig, the driver will support both RC and EP mode, and
the driver is able to judge the pcie controllers work on RC or EP mode.

Signed-off-by: Bao Xiaowei <xiaowei.bao@nxp.com>
Acked-by: Minghuan Lian <minghuan.Lian@nxp.com>
---
 v2:
 no change
 v3:
 no change
 v4:
 no change

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
