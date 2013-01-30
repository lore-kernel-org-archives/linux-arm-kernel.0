From: gang.chen@asianux.com (Chen Gang)
Date: Wed, 30 Jan 2013 19:12:51 +0800
Subject: [PATCH v2] ARM:mach-msm: using strlcpy instead lof strncpy
In-Reply-To: <87pq0nni3v.fsf@nemi.mork.no>
References: <5108A913.6080304@asianux.com> <87pq0nni3v.fsf@nemi.mork.no>
Message-ID: <51090033.80004@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


  The fields must be null-terminated, or next ptr, will cause issue

Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/arm/mach-msm/clock-debug.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-msm/clock-debug.c b/arch/arm/mach-msm/clock-debug.c
index 4886404..c40dcaf 100644
--- a/arch/arm/mach-msm/clock-debug.c
+++ b/arch/arm/mach-msm/clock-debug.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/ctype.h>
 #include <linux/debugfs.h>
+#include <linux/string.h>
 #include <linux/clk.h>
 #include "clock.h"
 
@@ -104,7 +105,7 @@ int __init clock_debug_add(struct clk *clock)
 	if (!debugfs_base)
 		return -ENOMEM;
 
-	strncpy(temp, clock->dbg_name, ARRAY_SIZE(temp)-1);
+	strlcpy(temp, clock->dbg_name, ARRAY_SIZE(temp));
 	for (ptr = temp; *ptr; ptr++)
 		*ptr = tolower(*ptr);
 
-- 
1.7.10.4
