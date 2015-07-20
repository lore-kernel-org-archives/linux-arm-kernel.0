From: broonie@kernel.org (Mark Brown)
Date: Mon, 20 Jul 2015 11:14:49 +0100
Subject: [PATCH] coresight: Fix implicit inclusion of linux/sched.h
Message-ID: <1437387289-14847-1-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch "Coresight: Add an interface for supporting ETM3/4 Context ID
tracing" adds uses of find_task_by_vpid() and task_pid_nr() from
linux/sched.h but does not include that header causing build errors in
at least an ARM allmodconfig where it is not implicitly included. Add an
explicit include to fix that.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/linux/coresight.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 626da6948ca2..c69e1b932809 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -14,6 +14,7 @@
 #define _LINUX_CORESIGHT_H
 
 #include <linux/device.h>
+#include <linux/sched.h>
 
 /* Peripheral id registers (0xFD0-0xFEC) */
 #define CORESIGHT_PERIPHIDR4	0xfd0
-- 
2.1.4
