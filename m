From: tpiepho@impinj.com (Trent Piepho)
Date: Mon, 16 Oct 2017 17:11:58 -0700
Subject: [PATCH 1/2] PCI: dwc: Adjust Kconfig to allow IMX6 PCIe host on IMX7
Message-ID: <20171017001159.109152-1-tpiepho@impinj.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IMX6 PCI-e host driver also supports the IMX7d.  However, the
Kconfig dependencies of the driver prevented it from being enabled
unless the kernel was built with both IMX6 and IMX7 support.  It works
fine to build with only IMX7 support enabled.

Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
CC: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Trent Piepho <tpiepho@impinj.com>
---
 drivers/pci/dwc/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig
index 22ec82fcdea2..85cf392921a9 100644
--- a/drivers/pci/dwc/Kconfig
+++ b/drivers/pci/dwc/Kconfig
@@ -71,9 +71,9 @@ config PCI_EXYNOS
 	select PCIE_DW_HOST
 
 config PCI_IMX6
-	bool "Freescale i.MX6 PCIe controller"
+	bool "Freescale i.MX6/7 PCIe controller"
 	depends on PCI
-	depends on SOC_IMX6Q
+	depends on SOC_IMX6Q || SOC_IMX7D
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIEPORTBUS
 	select PCIE_DW_HOST
-- 
2.13.6
