From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Tue, 15 May 2018 07:58:16 +0200
Subject: [PATCH v3 8/8] PCI: Enable PCI_DOMAINS along with generic PCI host
 controller
In-Reply-To: <cover.1526363896.git.jan.kiszka@siemens.com>
References: <cover.1526363896.git.jan.kiszka@siemens.com>
Message-ID: <f46a0a3d87de60fec7bca1348464fbe3eb418f70.1526363896.git.jan.kiszka@siemens.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jan Kiszka <jan.kiszka@siemens.com>

This controller is often instantiated by hypervisors, and they may add
multiple of them or add them in addition to a physical host controller
like the Jailhouse hypervisor is doing. Therefore allow for multiple
domains so that we can handle them all.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/pci/host/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 0d0177ce436c..3d25b35bb5ab 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -68,6 +68,7 @@ config PCI_HOST_GENERIC
 	depends on (ARM || ARM64) && OF
 	select PCI_HOST_COMMON
 	select IRQ_DOMAIN
+	select PCI_DOMAINS
 	help
 	  Say Y here if you want to support a simple generic PCI host
 	  controller, such as the one emulated by kvmtool.
-- 
2.13.6
