From: lauraa@codeaurora.org (Laura Abbott)
Date: Wed, 24 Aug 2011 10:21:47 -0700
Subject: [PATCH 2/2] process: change from __backtrace to dump_stack_regs in
	show_regs
In-Reply-To: <1314206507-6487-1-git-send-email-lauraa@codeaurora.org>
References: <1314206507-6487-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <1314206507-6487-3-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, show_regs calls __backtrace which does
nothing if CONIFG_FRAME_POINTER is not set. Switch to
dump_stack_regs to show the backtrace from a given
set of registers.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm/kernel/process.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 1a347f4..6f11213 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -319,7 +319,7 @@ void show_regs(struct pt_regs * regs)
 	printk("\n");
 	printk("Pid: %d, comm: %20s\n", task_pid_nr(current), current->comm);
 	__show_regs(regs);
-	__backtrace();
+	dump_stack_regs(regs);
 }
 
 ATOMIC_NOTIFIER_HEAD(thread_notify_head);
-- 
1.7.3.3
