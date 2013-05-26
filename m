From: gang.chen@asianux.com (Chen Gang)
Date: Sun, 26 May 2013 14:54:34 +0800
Subject: [PATCH] arch: arm: mach-msm: using strlcpy instead of strncpy
Message-ID: <51A1B1AA.9090605@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


For NULL terminated string, need always be sure of ended by zero.

Or the next 'ptr' in 'for' looping may cause issue.


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/arm/mach-msm/clock-debug.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-msm/clock-debug.c b/arch/arm/mach-msm/clock-debug.c
index 4886404..b0fbdf1 100644
--- a/arch/arm/mach-msm/clock-debug.c
+++ b/arch/arm/mach-msm/clock-debug.c
@@ -104,7 +104,7 @@ int __init clock_debug_add(struct clk *clock)
 	if (!debugfs_base)
 		return -ENOMEM;
 
-	strncpy(temp, clock->dbg_name, ARRAY_SIZE(temp)-1);
+	strlcpy(temp, clock->dbg_name, ARRAY_SIZE(temp));
 	for (ptr = temp; *ptr; ptr++)
 		*ptr = tolower(*ptr);
 
-- 
1.7.7.6
