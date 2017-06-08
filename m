From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu,  8 Jun 2017 15:13:24 +0100
Subject: [RFT PATCH v2 24/42] PCI: Build setup-irq.o on all arches
In-Reply-To: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
References: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
Message-ID: <20170608141342.2018-25-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Matthew Minter <matt@masarand.com>

The functions included in setup-irq.o currently apply only to a selection
of architectures which share common IRQ assignment code. However this
code needs to be generalised for all arches to allow deferred IRQ
assignment. So the first step is to build it on all architectures.

Signed-off-by: Matthew Minter <matt@masarand.com>
---
 drivers/pci/Makefile | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 462c1f5..66a21ac 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -4,7 +4,8 @@
 
 obj-y		+= access.o bus.o probe.o host-bridge.o remove.o pci.o \
 			pci-driver.o search.o pci-sysfs.o rom.o setup-res.o \
-			irq.o vpd.o setup-bus.o vc.o mmap.o
+			irq.o vpd.o setup-bus.o vc.o mmap.o setup-irq.o
+
 obj-$(CONFIG_PROC_FS) += proc.o
 obj-$(CONFIG_SYSFS) += slot.o
 
@@ -29,20 +30,6 @@ obj-$(CONFIG_PCI_ATS) += ats.o
 obj-$(CONFIG_PCI_IOV) += iov.o
 
 #
-# Some architectures use the generic PCI setup functions
-#
-obj-$(CONFIG_ALPHA) += setup-irq.o
-obj-$(CONFIG_ARC) += setup-irq.o
-obj-$(CONFIG_ARM) += setup-irq.o
-obj-$(CONFIG_ARM64) += setup-irq.o
-obj-$(CONFIG_UNICORE32) += setup-irq.o
-obj-$(CONFIG_SUPERH) += setup-irq.o
-obj-$(CONFIG_MIPS) += setup-irq.o
-obj-$(CONFIG_TILE) += setup-irq.o
-obj-$(CONFIG_SPARC_LEON) += setup-irq.o
-obj-$(CONFIG_M68K) += setup-irq.o
-
-#
 # ACPI Related PCI FW Functions
 # ACPI _DSM provided firmware instance and string name
 #
-- 
2.10.0
