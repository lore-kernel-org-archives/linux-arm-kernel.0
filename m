From: rjui@broadcom.com (Ray Jui)
Date: Wed, 15 Jul 2015 21:39:21 -0700
Subject: [PATCH v3 2/4] PCI: iproc: Fix ARM64 dependency in Kconfig
In-Reply-To: <1437021563-29139-1-git-send-email-rjui@broadcom.com>
References: <1437021563-29139-1-git-send-email-rjui@broadcom.com>
Message-ID: <1437021563-29139-3-git-send-email-rjui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow Broadcom iProc PCIe core driver to be compiled for ARM64

Signed-off-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Vikram Prakash <vikramp@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 drivers/pci/host/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index c132bdd..d2c6144 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -117,7 +117,7 @@ config PCI_VERSATILE
 
 config PCIE_IPROC
 	tristate "Broadcom iProc PCIe controller"
-	depends on OF && ARM
+	depends on OF && (ARM || ARM64)
 	default n
 	help
 	  This enables the iProc PCIe core controller support for Broadcom's
-- 
1.7.9.5
