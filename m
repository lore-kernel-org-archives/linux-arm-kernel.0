From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 20 Jun 2014 12:44:11 +0200
Subject: [PATCH 1/2] clocksource: arm_arch_timer: remove static from
 arch_timer_init
In-Reply-To: <70167479.zcs3JF0luJ@diego>
References: <70167479.zcs3JF0luJ@diego>
Message-ID: <3602534.r5eJA8RqrN@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There exist SoCs that need some special setup procedure for their architected-timer
to work. Therefore allow arch_timer_init to be called from such specialized
clocksources.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clocksource/arm_arch_timer.c | 2 +-
 drivers/clocksource/arm_arch_timer.h | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clocksource/arm_arch_timer.h

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 5163ec1..55116d6 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -635,7 +635,7 @@ static void __init arch_timer_common_init(void)
 	arch_timer_arch_init();
 }
 
-static void __init arch_timer_init(struct device_node *np)
+void __init arch_timer_init(struct device_node *np)
 {
 	int i;
 
diff --git a/drivers/clocksource/arm_arch_timer.h b/drivers/clocksource/arm_arch_timer.h
new file mode 100644
index 0000000..af3974d
--- /dev/null
+++ b/drivers/clocksource/arm_arch_timer.h
@@ -0,0 +1,7 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+void __init arch_timer_init(struct device_node *np);
-- 
1.9.0
