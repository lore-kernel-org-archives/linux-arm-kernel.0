From: olof@lixom.net (Olof Johansson)
Date: Mon, 11 Feb 2013 15:18:43 -0800
Subject: [PATCH] arm: arch_timer: add missing inline in stub function
Message-ID: <1360624723-10749-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes:

In file included from arch/arm/include/asm/arch_timer.h:10:0,
                 from arch/arm/mach-shmobile/timer.c:23:
include/clocksource/arm_arch_timer.h:56:28: warning: 'arch_timer_get_timecounter' defined but not used [-Wunused-function]

Signed-off-by: Olof Johansson <olof@lixom.net>
---

Will, Mark, Marc,

I've applied this on next/virt already since it started spewing pretty heavily
on a lot of defconfig builds. Just posting FYI.

 include/clocksource/arm_arch_timer.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
index b61f996..2603267 100644
--- a/include/clocksource/arm_arch_timer.h
+++ b/include/clocksource/arm_arch_timer.h
@@ -53,7 +53,7 @@ static inline u64 arch_timer_read_counter(void)
 	return 0;
 }
 
-static struct timecounter *arch_timer_get_timecounter(void)
+static inline struct timecounter *arch_timer_get_timecounter(void)
 {
 	return NULL;
 }
-- 
1.8.1.192.gc4361b8
