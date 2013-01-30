From: gang.chen@asianux.com (Chen Gang)
Date: Wed, 30 Jan 2013 13:01:07 +0800
Subject: [PATCH] ARM:mach-msm: seting tail NUL after strncpy
Message-ID: <5108A913.6080304@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


  temp need NUL terminated, or next ptr may cause issue.

Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/arm/mach-msm/clock-debug.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-msm/clock-debug.c
b/arch/arm/mach-msm/clock-debug.c
index 4886404..bdca900 100644
--- a/arch/arm/mach-msm/clock-debug.c
+++ b/arch/arm/mach-msm/clock-debug.c
@@ -105,6 +105,8 @@ int __init clock_debug_add(struct clk *clock)
 		return -ENOMEM;

 	strncpy(temp, clock->dbg_name, ARRAY_SIZE(temp)-1);
+	temp[ARRAY_SIZE(temp)-1] = '\0';
+
 	for (ptr = temp; *ptr; ptr++)
 		*ptr = tolower(*ptr);

-- 
1.7.10.4
