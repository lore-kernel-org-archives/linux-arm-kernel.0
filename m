From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Mon, 29 Sep 2014 15:29:22 +0100
Subject: [PATCH v13 03/12] ARM: Define PCI_IOBASE as the base of virtual PCI
 IO space
In-Reply-To: <1412000971-9242-1-git-send-email-Liviu.Dudau@arm.com>
References: <1412000971-9242-1-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <1412000971-9242-4-git-send-email-Liviu.Dudau@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is needed for calls into OF code that parses PCI ranges.  It signals
support for memory mapped PCI I/O accesses that are described by device
trees.

Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
CC: Russell King <linux@arm.linux.org.uk>
CC: Rob Herring <robh+dt@kernel.org>
---
 arch/arm/include/asm/io.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 3d23418..1805674 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -178,6 +178,7 @@ static inline void __iomem *__typesafe_io(unsigned long addr)
 
 /* PCI fixed i/o mapping */
 #define PCI_IO_VIRT_BASE	0xfee00000
+#define PCI_IOBASE		((void __iomem *)PCI_IO_VIRT_BASE)
 
 #if defined(CONFIG_PCI)
 void pci_ioremap_set_mem_type(int mem_type);
-- 
2.1.1
