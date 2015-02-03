From: 21cnbao@gmail.com (Barry Song)
Date: Tue,  3 Feb 2015 23:38:09 +0800
Subject: [PATCH] ARM: sirf: drop redundant function and marco declaration
Message-ID: <1422977889-10000-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

with the patchset to add CSR atlas7 support, the below stuff
has no user now:
SIRFSOC_VA
sirfsoc_map_lluart
sirfsoc_map_scu

the related patches missed to drop them.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/mach-prima2/common.h | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/arm/mach-prima2/common.h b/arch/arm/mach-prima2/common.h
index 07d3e5e..3916a66 100644
--- a/arch/arm/mach-prima2/common.h
+++ b/arch/arm/mach-prima2/common.h
@@ -15,9 +15,6 @@
 #include <asm/mach/time.h>
 #include <asm/exception.h>
 
-#define SIRFSOC_VA_BASE		_AC(0xFEC00000, UL)
-#define SIRFSOC_VA(x)		(SIRFSOC_VA_BASE + ((x) & 0x00FFF000))
-
 extern struct smp_operations   sirfsoc_smp_ops;
 extern void sirfsoc_secondary_startup(void);
 extern void sirfsoc_cpu_die(unsigned int cpu);
@@ -25,18 +22,6 @@ extern void sirfsoc_cpu_die(unsigned int cpu);
 extern void __init sirfsoc_of_irq_init(void);
 extern asmlinkage void __exception_irq_entry sirfsoc_handle_irq(struct pt_regs *regs);
 
-#ifndef CONFIG_DEBUG_LL
-static inline void sirfsoc_map_lluart(void)  {}
-#else
-extern void __init sirfsoc_map_lluart(void);
-#endif
-
-#ifndef CONFIG_SMP
-static inline void sirfsoc_map_scu(void) {}
-#else
-extern void sirfsoc_map_scu(void);
-#endif
-
 #ifdef CONFIG_SUSPEND
 extern int sirfsoc_pm_init(void);
 #else
-- 
2.2.1
