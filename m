From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  5 Sep 2017 09:19:44 +0200
Subject: [PATCH 1/2] PCI: iproc: export iproc_pcie_shutdown symbol
Message-ID: <20170905072004.3959082-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The shutdown bugfix introduce a build regression for allmodconfig
kernels as the new function is not exported:

ERROR: "iproc_pcie_shutdown" [drivers/pci/host/pcie-iproc-platform.ko] undefined!

This adds the missing export.

Fixes: 2a9912565c05 ("PCI: iproc: Add 500ms delay during device shutdown")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/host/pcie-iproc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index 8bd5e544b1c1..d7f4c29aed96 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -704,6 +704,7 @@ int iproc_pcie_shutdown(struct iproc_pcie *pcie)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(iproc_pcie_shutdown);
 
 static int iproc_pcie_check_link(struct iproc_pcie *pcie)
 {
-- 
2.9.0
