From: achandran@mvista.com (Arun Chandran)
Date: Wed, 20 Aug 2014 12:17:48 +0530
Subject: [PATCH v2] Arm64: Remove unnecessary keyword 'extern' from proc-fns.h
Message-ID: <1408517268-14566-1-git-send-email-achandran@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since function prototypes are not definitions,
extern doesn't have any effect on them; removing it.

Reported-by: Geoff Levand <geoff@infradead.org>
Signed-off-by: Arun Chandran <achandran@mvista.com>
---
v2
* cleaned the patch description according to comment from Geoff Levand <geoff@infradead.org>
---
 arch/arm64/include/asm/proc-fns.h |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/proc-fns.h b/arch/arm64/include/asm/proc-fns.h
index 0c657bb..919ac3a 100644
--- a/arch/arm64/include/asm/proc-fns.h
+++ b/arch/arm64/include/asm/proc-fns.h
@@ -28,12 +28,12 @@
 struct mm_struct;
 struct cpu_suspend_ctx;
 
-extern void cpu_cache_off(void);
-extern void cpu_do_idle(void);
-extern void cpu_do_switch_mm(unsigned long pgd_phys, struct mm_struct *mm);
-extern void cpu_reset(unsigned long addr) __attribute__((noreturn));
-extern void cpu_do_suspend(struct cpu_suspend_ctx *ptr);
-extern u64 cpu_do_resume(phys_addr_t ptr, u64 idmap_ttbr);
+void cpu_cache_off(void);
+void cpu_do_idle(void);
+void cpu_do_switch_mm(unsigned long pgd_phys, struct mm_struct *mm);
+void cpu_reset(unsigned long addr) __attribute__((noreturn));
+void cpu_do_suspend(struct cpu_suspend_ctx *ptr);
+u64 cpu_do_resume(phys_addr_t ptr, u64 idmap_ttbr);
 
 #include <asm/memory.h>
 
-- 
1.7.9.5
