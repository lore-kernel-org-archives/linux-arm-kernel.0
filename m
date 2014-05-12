From: jays.lee@samsung.com (Jungseok Lee)
Date: Mon, 12 May 2014 18:40:30 +0900
Subject: [PATCH v6 1/7] arm64: Use pr_* instead of printk
Message-ID: <000001cf6dc6$36c5d240$a45176c0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixed the following checkpatch complaint as using pr_*
instead of printk.

WARNING: printk() should include KERN_ facility level

Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Jungseok Lee <jays.lee@samsung.com>
Reviewed-by: Sungjinn Chung <sungjinn.chung@samsung.com>
Acked-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm64/kernel/traps.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index c43cfa9..506f781 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -156,7 +156,7 @@ static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 		frame.pc = thread_saved_pc(tsk);
 	}
 
-	printk("Call trace:\n");
+	pr_emerg("Call trace:\n");
 	while (1) {
 		unsigned long where = frame.pc;
 		int ret;
@@ -331,17 +331,17 @@ asmlinkage void bad_mode(struct pt_regs *regs, int reason, unsigned int esr)
 
 void __pte_error(const char *file, int line, unsigned long val)
 {
-	printk("%s:%d: bad pte %016lx.\n", file, line, val);
+	pr_crit("%s:%d: bad pte %016lx.\n", file, line, val);
 }
 
 void __pmd_error(const char *file, int line, unsigned long val)
 {
-	printk("%s:%d: bad pmd %016lx.\n", file, line, val);
+	pr_crit("%s:%d: bad pmd %016lx.\n", file, line, val);
 }
 
 void __pgd_error(const char *file, int line, unsigned long val)
 {
-	printk("%s:%d: bad pgd %016lx.\n", file, line, val);
+	pr_crit("%s:%d: bad pgd %016lx.\n", file, line, val);
 }
 
 void __init trap_init(void)
-- 
1.7.10.4
