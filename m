From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 13 Jan 2014 17:58:24 -0800
Subject: [PATCH] ARM: pm: remove outdated comment
Message-ID: <1389664704-22350-1-git-send-email-computersforpeace@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As of commit abda1bd5f4e04054ce083c298fcd68a743e9df03 __cpu_suspend()
takes only 2 arguments, and those arguments are passed by the platform
code. This comment thus makes no sense, as cpu_suspend() is not actually
hiding any arguments.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 arch/arm/kernel/suspend.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/kernel/suspend.c b/arch/arm/kernel/suspend.c
index 2835d35234ca..9a2f882a0a2d 100644
--- a/arch/arm/kernel/suspend.c
+++ b/arch/arm/kernel/suspend.c
@@ -14,10 +14,6 @@ extern int __cpu_suspend(unsigned long, int (*)(unsigned long), u32 cpuid);
 extern void cpu_resume_mmu(void);
 
 #ifdef CONFIG_MMU
-/*
- * Hide the first two arguments to __cpu_suspend - these are an implementation
- * detail which platform code shouldn't have to know about.
- */
 int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
 {
 	struct mm_struct *mm = current->active_mm;
-- 
1.8.3.2
