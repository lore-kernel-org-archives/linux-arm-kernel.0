From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Mon, 4 Feb 2013 13:08:19 +0200
Subject: [PATCH 2/2] regmap: Fix build error next-20130204
In-Reply-To: <1359976100-28871-1-git-send-email-hdoyu@nvidia.com>
References: <1359976100-28871-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <1359976100-28871-2-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In function 'regmap_async_complete_cb':
1656:3: error: 'TASK_NORMAL' undeclared (first use in this function)
In function 'regmap_async_complete':
1688:2: error: 'TASK_UNINTERRUPTIBLE' undeclared (first use in this function)

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
 drivers/base/regmap/regmap.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index bee8560..49ec460 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -16,6 +16,8 @@
 #include <linux/mutex.h>
 #include <linux/err.h>
 #include <linux/rbtree.h>
+#include <linux/sched.h>
+#include <linux/wait.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/regmap.h>
-- 
1.7.9.5
