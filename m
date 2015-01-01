From: rickard_strandqvist@spectrumdigital.se (Rickard Strandqvist)
Date: Thu,  1 Jan 2015 20:10:51 +0100
Subject: [PATCH] arch: arm: mm: ioremap:  Remove unused function
Message-ID: <1420139451-2671-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the function pci_ioremap_set_mem_type() that is not used anywhere.

This was partially found by using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 arch/arm/include/asm/io.h |    6 ------
 arch/arm/mm/ioremap.c     |    5 -----
 2 files changed, 11 deletions(-)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 1805674..8d8087f 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -180,12 +180,6 @@ static inline void __iomem *__typesafe_io(unsigned long addr)
 #define PCI_IO_VIRT_BASE	0xfee00000
 #define PCI_IOBASE		((void __iomem *)PCI_IO_VIRT_BASE)
 
-#if defined(CONFIG_PCI)
-void pci_ioremap_set_mem_type(int mem_type);
-#else
-static inline void pci_ioremap_set_mem_type(int mem_type) {}
-#endif
-
 extern int pci_ioremap_io(unsigned int offset, phys_addr_t phys_addr);
 
 /*
diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index d1e5ad7..0f25610 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -440,11 +440,6 @@ EXPORT_SYMBOL(__arm_iounmap);
 #ifdef CONFIG_PCI
 static int pci_ioremap_mem_type = MT_DEVICE;
 
-void pci_ioremap_set_mem_type(int mem_type)
-{
-	pci_ioremap_mem_type = mem_type;
-}
-
 int pci_ioremap_io(unsigned int offset, phys_addr_t phys_addr)
 {
 	BUG_ON(offset + SZ_64K > IO_SPACE_LIMIT);
-- 
1.7.10.4
