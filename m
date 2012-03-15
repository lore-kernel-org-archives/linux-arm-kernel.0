From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 15 Mar 2012 11:47:26 +0000
Subject: [PATCH -next] ARM: ux500: fix compilation after local timer rework
Message-ID: <1331812046-21062-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mach-ux500/timer.c lacked the inclusion of mach/irqs.h, and thus
failed to compile. Fix it and also remove an unused variable.

Test compiled only.

Reported-by: Lee Jones <lee.jones@linaro.org>
Cc: Arnd Bergman <arnd@arndb.de>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
Arnd,

I've pushed this patch to my local_timers-for-arm-soc. If you can pull
it one more time, that would be great.

Thanks,

	M.

 arch/arm/mach-ux500/timer.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ux500/timer.c b/arch/arm/mach-ux500/timer.c
index fbeed7e..e9d5807 100644
--- a/arch/arm/mach-ux500/timer.c
+++ b/arch/arm/mach-ux500/timer.c
@@ -14,6 +14,7 @@
 
 #include <mach/setup.h>
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 
 #ifdef CONFIG_HAVE_ARM_TWD
 static DEFINE_TWD_LOCAL_TIMER(u5500_twd_local_timer,
@@ -41,7 +42,6 @@ static void __init ux500_timer_init(void)
 {
 	void __iomem *mtu_timer_base;
 	void __iomem *prcmu_timer_base;
-	int err;
 
 	if (cpu_is_u5500()) {
 		mtu_timer_base = __io_address(U5500_MTU0_BASE);
-- 
1.7.7.1
