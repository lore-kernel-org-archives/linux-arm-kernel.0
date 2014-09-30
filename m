From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 29 Sep 2014 18:35:29 -0700
Subject: [PATCH 4/5] ARM: vexpress: drop unnecessary include
In-Reply-To: <1412040930-16864-1-git-send-email-computersforpeace@gmail.com>
References: <1412040930-16864-1-git-send-email-computersforpeace@gmail.com>
Message-ID: <1412040930-16864-5-git-send-email-computersforpeace@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

<asm/cp15.h> is only being included because of the implicit requirements
of v7_exit_coherency_flush(). Now that the implicit include is provided
for us, we can drop it from our explicit list.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-vexpress/dcscb.c  | 1 -
 arch/arm/mach-vexpress/tc2_pm.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/mach-vexpress/dcscb.c b/arch/arm/mach-vexpress/dcscb.c
index 30b993399ed7..28b0a33c91e1 100644
--- a/arch/arm/mach-vexpress/dcscb.c
+++ b/arch/arm/mach-vexpress/dcscb.c
@@ -22,7 +22,6 @@
 #include <asm/proc-fns.h>
 #include <asm/cacheflush.h>
 #include <asm/cputype.h>
-#include <asm/cp15.h>
 
 
 #define RST_HOLD0	0x0
diff --git a/arch/arm/mach-vexpress/tc2_pm.c b/arch/arm/mach-vexpress/tc2_pm.c
index 2fb78b4648cb..bc596f7d0d85 100644
--- a/arch/arm/mach-vexpress/tc2_pm.c
+++ b/arch/arm/mach-vexpress/tc2_pm.c
@@ -26,7 +26,6 @@
 #include <asm/proc-fns.h>
 #include <asm/cacheflush.h>
 #include <asm/cputype.h>
-#include <asm/cp15.h>
 
 #include <linux/arm-cci.h>
 
-- 
1.9.1
