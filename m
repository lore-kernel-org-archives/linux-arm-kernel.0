From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu,  3 Oct 2013 14:47:46 +0900
Subject: [PATCH v2 3/3] asm-generic: syscall_get/set_arguments accept zero for
 number of arguments
In-Reply-To: <1380779266-11753-1-git-send-email-takahiro.akashi@linaro.org>
References: <1380779266-11753-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1380779266-11753-4-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a possibility of calling syscall_get_arguments() with zero as
'number of arguments(n)' in ftrace_syscall_enter().
The comments in syscall_get_argumets() as well as syscall_set_arugments()
are corrected to clarify that.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 include/asm-generic/syscall.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/syscall.h b/include/asm-generic/syscall.h
index 5b09392..49b35ab 100644
--- a/include/asm-generic/syscall.h
+++ b/include/asm-generic/syscall.h
@@ -106,7 +106,7 @@ void syscall_set_return_value(struct task_struct *task, struct pt_regs *regs,
  * @task:	task of interest, must be blocked
  * @regs:	task_pt_regs() of @task
  * @i:		argument index [0,5]
- * @n:		number of arguments; n+i must be [1,6].
+ * @n:		number of arguments; n+i must be [0,6].
  * @args:	array filled with argument values
  *
  * Fetches @n arguments to the system call starting with the @i'th argument
@@ -126,7 +126,7 @@ void syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
  * @task:	task of interest, must be in system call entry tracing
  * @regs:	task_pt_regs() of @task
  * @i:		argument index [0,5]
- * @n:		number of arguments; n+i must be [1,6].
+ * @n:		number of arguments; n+i must be [0,6].
  * @args:	array of argument values to store
  *
  * Changes @n arguments to the system call starting with the @i'th argument.
-- 
1.7.9.5
