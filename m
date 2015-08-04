From: jchandra@broadcom.com (Jayachandran C)
Date: Wed, 5 Aug 2015 02:23:39 +0530
Subject: [PATCH v4 2/3] PCI: Add setup-irq.o when compiling for arm64
In-Reply-To: <1438721620-15493-1-git-send-email-jchandra@broadcom.com>
References: <1438721620-15493-1-git-send-email-jchandra@broadcom.com>
Message-ID: <1438721620-15493-2-git-send-email-jchandra@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM64 requires setup-irq.o to provide pci_fixup_irqs() implementation.
We are adding this now to support the pci-host-generic host controller,
but we enable it for ARM64 PCI so that other host controllers can use
this as well.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 drivers/pci/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 73e4af4..be3f631 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_PCI_IOV) += iov.o
 #
 obj-$(CONFIG_ALPHA) += setup-irq.o
 obj-$(CONFIG_ARM) += setup-irq.o
+obj-$(CONFIG_ARM64) += setup-irq.o
 obj-$(CONFIG_UNICORE32) += setup-irq.o
 obj-$(CONFIG_SUPERH) += setup-irq.o
 obj-$(CONFIG_MIPS) += setup-irq.o
-- 
1.9.1
