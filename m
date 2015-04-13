From: richard@nod.at (Richard Weinberger)
Date: Mon, 13 Apr 2015 20:52:18 +0200
Subject: [PATCH] arm64: Removed unused variable
Message-ID: <1428951138-26046-1-git-send-email-richard@nod.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm64/kernel/signal.c: In function ?handle_signal?:
arch/arm64/kernel/signal.c:290:22: warning: unused variable ?thread? [-Wunused-variable]

Fixes: arm64: Remove signal translation and exec_domain
Reported-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
Will be applied on top of my execdomain removal series.

Thanks,
//richard
---
 arch/arm64/kernel/signal.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 9f28eaa..e18c48c 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -287,7 +287,6 @@ static void setup_restart_syscall(struct pt_regs *regs)
  */
 static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 {
-	struct thread_info *thread = current_thread_info();
 	struct task_struct *tsk = current;
 	sigset_t *oldset = sigmask_to_save();
 	int usig = ksig->sig;
-- 
1.8.4.5
