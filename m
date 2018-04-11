From: vincenzo.frascino@arm.com (Vincenzo Frascino)
Date: Wed, 11 Apr 2018 11:24:46 +0100
Subject: arm64: Remove duplicate include
Message-ID: <1523442286-11714-1-git-send-email-vincenzo.frascino@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In armv8_deprecated asm/cpufeature.h has been included twice.

This patch removes the double inclusion.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/kernel/armv8_deprecated.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
index c33b5e4..b3b6d7a 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -13,6 +13,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/sysctl.h>
+#include <linux/uaccess.h>
 
 #include <asm/cpufeature.h>
 #include <asm/insn.h>
@@ -20,8 +21,6 @@
 #include <asm/system_misc.h>
 #include <asm/traps.h>
 #include <asm/kprobes.h>
-#include <linux/uaccess.h>
-#include <asm/cpufeature.h>
 
 #define CREATE_TRACE_POINTS
 #include "trace-events-emulation.h"
-- 
2.7.4
