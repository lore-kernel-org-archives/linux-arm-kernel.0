From: achandran@mvista.com (Arun Chandran)
Date: Tue, 19 Aug 2014 14:28:46 +0530
Subject: [PATCH v1] Arm64: Remove unnecessary keyword 'extern' from proc-fns.h
Message-ID: <1408438726-2413-1-git-send-email-achandran@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the functions have external linkage by default, the extern
keyword is irrelevant here.

Reported-by: Geoff Levand <geoff@infradead.org>
Signed-off-by: Arun Chandran <achandran@mvista.com>
---
 arch/arm64/include/asm/proc-fns.h |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/proc-fns.h b/arch/arm64/include/asm/proc-fns.h
index 9a8fd84..edfd79d 100644
--- a/arch/arm64/include/asm/proc-fns.h
+++ b/arch/arm64/include/asm/proc-fns.h
@@ -28,14 +28,14 @@
 struct mm_struct;
 struct cpu_suspend_ctx;
 
-extern void cpu_cache_off(void);
-extern void cpu_do_idle(void);
-extern void cpu_do_switch_mm(unsigned long pgd_phys, struct mm_struct *mm);
-extern void cpu_reset(unsigned long addr) __attribute__((noreturn));
+void cpu_cache_off(void);
+void cpu_do_idle(void);
+void cpu_do_switch_mm(unsigned long pgd_phys, struct mm_struct *mm);
+void cpu_reset(unsigned long addr) __attribute__((noreturn));
 void cpu_soft_restart(phys_addr_t cpu_reset,
 		unsigned long addr) __attribute__((noreturn));
-extern void cpu_do_suspend(struct cpu_suspend_ctx *ptr);
-extern u64 cpu_do_resume(phys_addr_t ptr, u64 idmap_ttbr);
+void cpu_do_suspend(struct cpu_suspend_ctx *ptr);
+u64 cpu_do_resume(phys_addr_t ptr, u64 idmap_ttbr);
 
 #include <asm/memory.h>
 
-- 
1.7.9.5
