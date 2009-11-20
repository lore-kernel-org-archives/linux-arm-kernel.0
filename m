From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 20 Nov 2009 18:01:00 +0000
Subject: [PATCH 1/7] ARM: provide phys_to_page() to complement page_to_phys()
In-Reply-To: <20091120182539.GG16920@n2100.arm.linux.org.uk>
References: <20091120182539.GG16920@n2100.arm.linux.org.uk>
Message-ID: <E1NBYDx-0005ks-EU@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/memory.h |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index cefedf0..e0f8f4a 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -134,6 +134,12 @@
 #define	__phys_to_pfn(paddr)	((paddr) >> PAGE_SHIFT)
 #define	__pfn_to_phys(pfn)	((pfn) << PAGE_SHIFT)
 
+/*
+ * Convert a page to/from a physical address
+ */
+#define page_to_phys(page)	(__pfn_to_phys(page_to_pfn(page)))
+#define phys_to_page(phys)	(pfn_to_page(__phys_to_pfn(phys)))
+
 #ifndef __ASSEMBLY__
 
 /*
@@ -293,11 +299,6 @@ static inline __deprecated void *bus_to_virt(unsigned long x)
 #endif /* !CONFIG_DISCONTIGMEM */
 
 /*
- * For BIO.  "will die".  Kill me when bio_to_phys() and bvec_to_phys() die.
- */
-#define page_to_phys(page)	(page_to_pfn(page) << PAGE_SHIFT)
-
-/*
  * Optional coherency support.  Currently used only by selected
  * Intel XSC3-based systems.
  */
-- 
1.6.2.5
