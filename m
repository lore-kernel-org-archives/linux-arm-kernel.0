From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Sun, 20 Jan 2013 17:22:06 -0800
Subject: [PATCH] ARM: architected timers: allow dt based discovery using
 clocksource_of_init
Message-ID: <1358731326-2979-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an entry in __clksrc_of_table so that ARMv7 architected timer is
discoverable using call to clocksource_of_init.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/kernel/arch_timer.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/arch_timer.c b/arch/arm/kernel/arch_timer.c
index c8ef207..d21aada 100644
--- a/arch/arm/kernel/arch_timer.c
+++ b/arch/arm/kernel/arch_timer.c
@@ -504,6 +504,9 @@ int __init arch_timer_of_register(void)
 
 	return arch_timer_register();
 }
+#ifdef CONFIG_CLKSRC_OF
+CLOCKSOURCE_OF_DECLARE(armv7_timer, "arm,armv7-timer", arch_timer_of_register)
+#endif
 
 int __init arch_timer_sched_clock_init(void)
 {
-- 
1.7.5.4
