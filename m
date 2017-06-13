From: dustinb@codeaurora.org (Dustin Brown)
Date: Tue, 13 Jun 2017 10:33:07 -0700
Subject: [PATCH 1/2] arm: Export save_stack_trace_tsk()
In-Reply-To: <20170613085029.GA5374@arm.com>
References: <20170613085029.GA5374@arm.com>
Message-ID: <20170613173308.6653-1-dustinb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To aid in debugging driver modules, export save_stack_trace_tsk() for
the ARM architecture.
---
 arch/arm/kernel/stacktrace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
index 3a2fa203637a..564bb468b7ba 100644
--- a/arch/arm/kernel/stacktrace.c
+++ b/arch/arm/kernel/stacktrace.c
@@ -171,6 +171,7 @@ void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
 {
 	__save_stack_trace(tsk, trace, 1);
 }
+EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
 
 void save_stack_trace(struct stack_trace *trace)
 {
-- 
2.12.2
