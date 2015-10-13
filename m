From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Wed, 14 Oct 2015 00:24:24 +0900
Subject: [PATCH v3 3/7] arm64: ftrace: fix a stack tracer's output under
 function graph tracer
In-Reply-To: <1444298504-10392-4-git-send-email-takahiro.akashi@linaro.org>
References: <1444298504-10392-1-git-send-email-takahiro.akashi@linaro.org>
 <1444298504-10392-4-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <DBC9AC69-1187-4BF5-887D-23ACA29C2865@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Oct 8, 2015, at 7:01 PM, AKASHI Takahiro wrote:

Hi Akashi,

> Function graph tracer modifies a return address (LR) in a stack frame
> to hook a function return. This will result in many useless entries
> (return_to_handler) showing up in a stack tracer's output.
> 
> This patch replaces such entries with originals values preserved in
> current->ret_stack[].
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>

The following diff should be folded into this patch, not [7/7] one, to
address build breakage.

----8<----
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 407991b..7126d4d 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -17,6 +17,7 @@
  */
 #include <linux/kernel.h>
 #include <linux/export.h>
+#include <linux/ftrace.h>
 #include <linux/sched.h>
 #include <linux/stacktrace.h>
----8<----

Best Regards
Jungseok Lee
