From: shijie.huang@arm.com (Huang Shijie)
Date: Mon, 18 Apr 2016 09:49:56 +0800
Subject: [PATCH] arm64: mm: remove the redundant code
Message-ID: <1460944196-11780-1-git-send-email-shijie.huang@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We already re-enable interrupts where necessary in the entry code, so
there is no need to do it again in do_page fault. This patch removes
the redundant code.

Signed-off-by: Huang Shijie <shijie.huang@arm.com>
---
 arch/arm64/mm/fault.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 95df28b..bdc193c 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -212,10 +212,6 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 	tsk = current;
 	mm  = tsk->mm;
 
-	/* Enable interrupts if they were enabled in the parent context. */
-	if (interrupts_enabled(regs))
-		local_irq_enable();
-
 	/*
 	 * If we're in an interrupt or have no user context, we must not take
 	 * the fault.
-- 
2.5.5
