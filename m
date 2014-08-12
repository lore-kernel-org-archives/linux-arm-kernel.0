From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Tue, 12 Aug 2014 17:25:18 +0100
Subject: [PATCH v9 05/12] ARM: Define PCI_IOBASE as the base of virtual PCI IO
 space.
In-Reply-To: <1407860725-25202-1-git-send-email-Liviu.Dudau@arm.com>
References: <1407860725-25202-1-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <1407860725-25202-6-git-send-email-Liviu.Dudau@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is needed for calls into OF code that parses PCI ranges.
It signals support for memory mapped PCI I/O accesses that
are described be device trees.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
---
 arch/arm/include/asm/io.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 3d23418..22b7529 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -178,6 +178,7 @@ static inline void __iomem *__typesafe_io(unsigned long addr)
 
 /* PCI fixed i/o mapping */
 #define PCI_IO_VIRT_BASE	0xfee00000
+#define PCI_IOBASE		PCI_IO_VIRT_BASE
 
 #if defined(CONFIG_PCI)
 void pci_ioremap_set_mem_type(int mem_type);
-- 
2.0.4
