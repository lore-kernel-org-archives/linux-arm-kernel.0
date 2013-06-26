From: shc_work@mail.ru (Alexander Shiyan)
Date: Wed, 26 Jun 2013 08:33:47 +0400
Subject: [RFC] ARM: Allow use debug_ll_io_init as .map_io in machine
 description
Message-ID: <1372221227-20091-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/include/asm/mach/map.h | 4 +---
 arch/arm/mm/mmu.c               | 4 ++++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/mach/map.h b/arch/arm/include/asm/mach/map.h
index 2fe141f..c1fafc5 100644
--- a/arch/arm/include/asm/mach/map.h
+++ b/arch/arm/include/asm/mach/map.h
@@ -42,10 +42,8 @@ extern void vm_reserve_area_early(unsigned long addr, unsigned long size,
 
 #ifdef CONFIG_DEBUG_LL
 extern void debug_ll_addr(unsigned long *paddr, unsigned long *vaddr);
-extern void debug_ll_io_init(void);
-#else
-static inline void debug_ll_io_init(void) {}
 #endif
+extern void debug_ll_io_init(void);
 
 struct mem_type;
 extern const struct mem_type *get_mem_type(unsigned int type);
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index d7229d2..557831b 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -952,6 +952,10 @@ void __init debug_ll_io_init(void)
 	map.type = MT_DEVICE;
 	create_mapping(&map);
 }
+#else
+void __init debug_ll_io_init(void)
+{
+}
 #endif
 
 static void * __initdata vmalloc_min =
-- 
1.8.1.5
