From: dustinb@codeaurora.org (Dustin Brown)
Date: Tue, 13 Jun 2017 10:33:08 -0700
Subject: [PATCH 2/2] arm64: Export save_stack_trace_tsk()
In-Reply-To: <20170613173308.6653-1-dustinb@codeaurora.org>
References: <20170613085029.GA5374@arm.com>
 <20170613173308.6653-1-dustinb@codeaurora.org>
Message-ID: <20170613173308.6653-2-dustinb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To aid in debugging driver modules, export save_stack_trace_tsk() for
the ARM64 architecture.
---
 arch/arm64/kernel/stacktrace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index feac80c22f61..09d37d66b630 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -210,6 +210,7 @@ void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
 
 	put_task_stack(tsk);
 }
+EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
 
 void save_stack_trace(struct stack_trace *trace)
 {
-- 
2.12.2
