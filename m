From: dustinb@codeaurora.org (Dustin Brown)
Date: Mon, 12 Jun 2017 15:24:31 -0700
Subject: [PATCH] Export save_stack_trace_tsk for ARM and ARM64
Message-ID: <20170612222431.1854-1-dustinb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To help in debugging driver modules on ARM platforms, export
save_stack_trace_tsk() for ARM and ARM64 architectures.
---
 arch/arm/kernel/stacktrace.c   | 1 +
 arch/arm64/kernel/stacktrace.c | 1 +
 2 files changed, 2 insertions(+)

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
