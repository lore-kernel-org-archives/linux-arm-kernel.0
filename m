From: clabbe@baylibre.com (Corentin Labbe)
Date: Wed, 15 Nov 2017 19:33:22 +0000
Subject: [PATCH] arm: Remove unused __readwrite_bug function
Message-ID: <1510774402-34611-1-git-send-email-clabbe@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The function __readwrite_bug() is not used at all, so this patch remove
it.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arm/include/asm/io.h | 5 -----
 arch/arm/kernel/traps.c   | 7 -------
 2 files changed, 12 deletions(-)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 2cfbc531f63b..6a9d9d2d4c0a 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -150,11 +150,6 @@ extern void __iomem * (*arch_ioremap_caller)(phys_addr_t, size_t,
 extern void (*arch_iounmap)(volatile void __iomem *);
 
 /*
- * Bad read/write accesses...
- */
-extern void __readwrite_bug(const char *fn);
-
-/*
  * A typesafe __io() helper
  */
 static inline void __iomem *__typesafe_io(unsigned long addr)
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 5cf04888c581..cce8b18d673f 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -757,13 +757,6 @@ baddataabort(int code, unsigned long instr, struct pt_regs *regs)
 	arm_notify_die("unknown data abort code", regs, &info, instr, 0);
 }
 
-void __readwrite_bug(const char *fn)
-{
-	pr_err("%s called, but not implemented\n", fn);
-	BUG();
-}
-EXPORT_SYMBOL(__readwrite_bug);
-
 void __pte_error(const char *file, int line, pte_t pte)
 {
 	pr_err("%s:%d: bad pte %08llx.\n", file, line, (long long)pte_val(pte));
-- 
2.13.6
