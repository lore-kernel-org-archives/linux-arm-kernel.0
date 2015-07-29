From: rjui@broadcom.com (Ray Jui)
Date: Wed, 29 Jul 2015 10:12:53 -0700
Subject: [PATCH v2] PCI: iproc: Fix BCMA dependency in Kconfig
Message-ID: <1438189973-5712-1-git-send-email-rjui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current iProc BCMA front-end driver can only work on ARM32 based
platforms; therefore its config option in Kconfig should be changed to
reflect that. This fixes arm64 allmodconfig build failure when compiling
the the iProc BCMA driver that contains struct pci_sys_data that is
arm32 specific

Signed-off-by: Ray Jui <rjui@broadcom.com>
---
 drivers/pci/host/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index d2c6144..48b5b30 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -136,7 +136,7 @@ config PCIE_IPROC_PLATFORM
 
 config PCIE_IPROC_BCMA
 	bool "Broadcom iProc PCIe BCMA bus driver"
-	depends on ARCH_BCM_IPROC || (ARM && COMPILE_TEST)
+	depends on ARM && (ARCH_BCM_IPROC || COMPILE_TEST)
 	select PCIE_IPROC
 	select BCMA
 	select PCI_DOMAINS
-- 
1.7.9.5
