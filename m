From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sun, 06 Apr 2014 23:30:31 +0100
Subject: [PATCH] ARM: add missing system_misc.h include to process.c
Message-ID: <E1WWvaB-0004Bc-QL@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm_pm_restart(), arm_pm_idle() and soft_restart() are all declared in
system_misc.h, but this file is not included in process.c.  Add this
missing include.  Found via sparse:

arch/arm/kernel/process.c:98:6: warning: symbol 'soft_restart' was not declared. Should it be static?
arch/arm/kernel/process.c:127:6: warning: symbol 'arm_pm_restart' was not declared. Should it be static?
arch/arm/kernel/process.c:134:6: warning: symbol 'arm_pm_idle' was not declared. Should it be static?

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/process.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 204f7d273319..b5444731dbb4 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -39,6 +39,7 @@
 #include <asm/processor.h>
 #include <asm/thread_notify.h>
 #include <asm/stacktrace.h>
+#include <asm/system_misc.h>
 #include <asm/mach/time.h>
 #include <asm/tls.h>
 
-- 
1.8.3.1
