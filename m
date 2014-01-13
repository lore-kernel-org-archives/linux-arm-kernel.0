From: zhangwm@marvell.com (Neil Zhang)
Date: Mon, 13 Jan 2014 16:57:56 +0800
Subject: [PATCH] arm64: fix typo in entry.S
Message-ID: <1389603476-10494-1-git-send-email-zhangwm@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 64681787 (arm64: let the core code deal with preempt_count)
changed the code, but left the comments unchanged, fix it.

Signed-off-by: Neil Zhang <zhangwm@marvell.com>
---
 arch/arm64/kernel/entry.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 4d2c6f3..ffce55e 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -314,7 +314,7 @@ el1_irq:
 
 #ifdef CONFIG_PREEMPT
 	get_thread_info tsk
-	ldr	w24, [tsk, #TI_PREEMPT]		// restore preempt count
+	ldr	w24, [tsk, #TI_PREEMPT]		// get preempt count
 	cbnz	w24, 1f				// preempt count != 0
 	ldr	x0, [tsk, #TI_FLAGS]		// get flags
 	tbz	x0, #TIF_NEED_RESCHED, 1f	// needs rescheduling?
-- 
1.7.9.5
