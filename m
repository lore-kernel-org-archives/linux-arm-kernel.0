From: yang.shi@linaro.org (Yang Shi)
Date: Fri, 12 Feb 2016 09:56:43 -0800
Subject: [PATCH] arm64: remove redundant preempt.h
Message-ID: <1455299803-317-1-git-send-email-yang.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

preempt.h has been included by sched.h, so it is not necessary to include
both, just keep sched.h.

Signed-off-by: Yang Shi <yang.shi@linaro.org>
---
Happened to find this when checking preempt.h include for another patch review.
Build test is passed with and without CONFIG_PREEMPT enabled.

 arch/arm64/kernel/cpuinfo.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 212ae63..e2b37ff 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -25,7 +25,6 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/personality.h>
-#include <linux/preempt.h>
 #include <linux/printk.h>
 #include <linux/seq_file.h>
 #include <linux/sched.h>
-- 
2.0.2
