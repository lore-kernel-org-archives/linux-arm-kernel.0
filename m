From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Feb 2013 23:47:43 +0100
Subject: [PATCH 1/9] ARM: arch_timer: include linux/errno.h
In-Reply-To: <1360882071-4072668-1-git-send-email-arnd@arndb.de>
References: <1360882071-4072668-1-git-send-email-arnd@arndb.de>
Message-ID: <1360882071-4072668-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch 8a4da6e "arm: arch_timer: move core to drivers/clocksource"
moved a lot of code out of arch_timer.c, but ended up deleting
too much, which broke some configurations.

Obviously, include linux/errno.h is required to return error
values.

Without this patch, building allmodconfig results in:

arch/arm/kernel/arch_timer.c: In function 'arch_timer_sched_clock_init':
arch/arm/kernel/arch_timer.c:55:11: error: 'ENXIO' undeclared (first use in this function)
arch/arm/kernel/arch_timer.c:55:11: note: each undeclared identifier is reported only once for each function it appears in

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kernel/arch_timer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kernel/arch_timer.c b/arch/arm/kernel/arch_timer.c
index 36ebcf4..d957a51 100644
--- a/arch/arm/kernel/arch_timer.c
+++ b/arch/arm/kernel/arch_timer.c
@@ -10,6 +10,7 @@
  */
 #include <linux/init.h>
 #include <linux/types.h>
+#include <linux/errno.h>
 
 #include <asm/delay.h>
 #include <asm/sched_clock.h>
-- 
1.8.1.2
