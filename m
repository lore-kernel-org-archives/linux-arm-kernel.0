From: ptesarik@suse.cz (Petr Tesarik)
Date: Fri, 17 Jun 2011 10:46:51 +0200
Subject: [PATCH 07/10] arm: change valid_phys_addr_range's @addr param to
	phys_addr_t
In-Reply-To: <201106171038.25988.ptesarik@suse.cz>
References: <201106171038.25988.ptesarik@suse.cz>
Message-ID: <201106171046.52057.ptesarik@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No other changes are needed, the function will work just fine with
a potentially larger data type.


Signed-off-by: Petr Tesarik <ptesarik@suse.cz>
---
 arch/arm/include/asm/io.h |    2 +-
 arch/arm/mm/mmap.c        |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index d66605d..91e4ff2 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -290,7 +290,7 @@ extern void pci_iounmap(struct pci_dev *dev, void __iomem *addr);
 
 #ifdef CONFIG_MMU
 #define ARCH_HAS_VALID_PHYS_ADDR_RANGE
-extern int valid_phys_addr_range(unsigned long addr, size_t size);
+extern int valid_phys_addr_range(phys_addr_t addr, size_t size);
 extern int valid_mmap_phys_addr_range(unsigned long pfn, size_t size);
 extern int devmem_is_allowed(unsigned long pfn);
 #endif
diff --git a/arch/arm/mm/mmap.c b/arch/arm/mm/mmap.c
index 74be05f..3bf1d88 100644
--- a/arch/arm/mm/mmap.c
+++ b/arch/arm/mm/mmap.c
@@ -127,7 +127,7 @@ full_search:
  * You really shouldn't be using read() or write() on /dev/mem.  This
  * might go away in the future.
  */
-int valid_phys_addr_range(unsigned long addr, size_t size)
+int valid_phys_addr_range(phys_addr_t addr, size_t size)
 {
 	if (addr < PHYS_OFFSET)
 		return 0;
-- 
1.7.3.4
