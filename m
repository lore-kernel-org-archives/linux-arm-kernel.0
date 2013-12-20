From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Fri, 20 Dec 2013 10:52:57 +0800
Subject: [PATCH 2/3] ARM: hisi: remove init_time
In-Reply-To: <1387507978-4485-1-git-send-email-haojian.zhuang@gmail.com>
References: <1387507978-4485-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1387507978-4485-2-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since init_time in machine descriptor is already covered by
arch/arm/kernel/time.c by default. We needn't to append it any more.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 arch/arm/mach-hisi/hisilicon.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm/mach-hisi/hisilicon.c b/arch/arm/mach-hisi/hisilicon.c
index 685d9eb..741faf3 100644
--- a/arch/arm/mach-hisi/hisilicon.c
+++ b/arch/arm/mach-hisi/hisilicon.c
@@ -51,12 +51,6 @@ static void __init hi3620_map_io(void)
 	iotable_init(hi3620_io_desc, ARRAY_SIZE(hi3620_io_desc));
 }
 
-static void __init hi3xxx_timer_init(void)
-{
-	of_clk_init(NULL);
-	clocksource_of_init();
-}
-
 static void hi3xxx_restart(enum reboot_mode mode, const char *cmd)
 {
 	struct device_node *np;
@@ -90,7 +84,6 @@ static const char *hi3xxx_compat[] __initconst = {
 
 DT_MACHINE_START(HI3620, "Hisilicon Hi3620 (Flattened Device Tree)")
 	.map_io		= hi3620_map_io,
-	.init_time	= hi3xxx_timer_init,
 	.dt_compat	= hi3xxx_compat,
 	.smp		= smp_ops(hi3xxx_smp_ops),
 	.restart	= hi3xxx_restart,
-- 
1.8.3.2
