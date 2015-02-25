From: lauraa@codeaurora.org (Laura Abbott)
Date: Tue, 24 Feb 2015 17:25:06 -0800
Subject: [PATCH] drivers: cpuidle: Explictly include proc-fns.h for
 cpuidle-arm64
Message-ID: <1424827506-12245-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cpuidle-arm64.c fails to compile with CONFIG_ARM64_64K_PAGES=y

/kernel/drivers/cpuidle/cpuidle-arm64.c: In function "arm64_enter_idle_state"
/kernel/drivers/cpuidle/cpuidle-arm64.c:42:3: error: implicit declaration of function "cpu_do_idle" [-Werror=implicit-function-declaration]
   cpu_do_idle();
   ^

Explicitly add the header file with the declaration of cpu_do_idle.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
Not sure how long this has been broken, bisect between v3.19 and master showed
6b00f7efb5303418c231994c91fb8239f5ada260 as the first bad commit which
isn't particularly helpful. Probably some header shuffling.
---
 drivers/cpuidle/cpuidle-arm64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpuidle/cpuidle-arm64.c b/drivers/cpuidle/cpuidle-arm64.c
index 80704b9..f1d5422 100644
--- a/drivers/cpuidle/cpuidle-arm64.c
+++ b/drivers/cpuidle/cpuidle-arm64.c
@@ -19,6 +19,7 @@
 #include <linux/of.h>
 
 #include <asm/cpuidle.h>
+#include <asm/proc-fns.h>
 #include <asm/suspend.h>
 
 #include "dt_idle_states.h"
-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
