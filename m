From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 31 May 2014 16:10:13 +0400
Subject: [PATCH 5/5] ARM: clps711x: edb7211: Remove excess layer to calling
 clps711x_devices_init()
In-Reply-To: <1401538213-16106-1-git-send-email-shc_work@mail.ru>
References: <1401538213-16106-1-git-send-email-shc_work@mail.ru>
Message-ID: <1401538213-16106-5-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clps711x_devices_init() can be used directly in ".machine_init" without
any intermediate function.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-clps711x/board-edb7211.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm/mach-clps711x/board-edb7211.c b/arch/arm/mach-clps711x/board-edb7211.c
index fa4580f..122d89f 100644
--- a/arch/arm/mach-clps711x/board-edb7211.c
+++ b/arch/arm/mach-clps711x/board-edb7211.c
@@ -150,11 +150,6 @@ fixup_edb7211(struct tag *tags, char **cmdline, struct meminfo *mi)
 	mi->nr_banks = 2;
 }
 
-static void __init edb7211_init(void)
-{
-	clps711x_devices_init();
-}
-
 static void __init edb7211_init_late(void)
 {
 	gpio_request_array(edb7211_gpios, ARRAY_SIZE(edb7211_gpios));
@@ -182,7 +177,7 @@ MACHINE_START(EDB7211, "CL-EDB7211 (EP7211 eval board)")
 	.map_io		= clps711x_map_io,
 	.init_irq	= clps711x_init_irq,
 	.init_time	= clps711x_timer_init,
-	.init_machine	= edb7211_init,
+	.init_machine	= clps711x_devices_init,
 	.init_late	= edb7211_init_late,
 	.restart	= clps711x_restart,
 MACHINE_END
-- 
1.8.5.5
