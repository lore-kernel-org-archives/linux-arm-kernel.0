From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 12 Jan 2015 19:42:15 +0100
Subject: [PATCH 6/7] ARM: at91: remove useless at91rm9200_dt_initialize()
In-Reply-To: <1421088136-10172-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1421088136-10172-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1421088136-10172-7-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

at91rm9200_dt_initialize() is doing the same as at91_dit_initialize(), use that
one instead.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/board-dt-rm9200.c | 2 +-
 arch/arm/mach-at91/generic.h         | 1 -
 arch/arm/mach-at91/setup.c           | 7 -------
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/arm/mach-at91/board-dt-rm9200.c b/arch/arm/mach-at91/board-dt-rm9200.c
index 76dfe8f9af50..a15ab6f8de00 100644
--- a/arch/arm/mach-at91/board-dt-rm9200.c
+++ b/arch/arm/mach-at91/board-dt-rm9200.c
@@ -38,6 +38,6 @@ static const char *at91rm9200_dt_board_compat[] __initdata = {
 DT_MACHINE_START(at91rm9200_dt, "Atmel AT91RM9200 (Device Tree)")
 	.init_time      = at91rm9200_dt_timer_init,
 	.map_io		= at91_map_io,
-	.init_early	= at91rm9200_dt_initialize,
+	.init_early	= at91_dt_initialize,
 	.dt_compat	= at91rm9200_dt_board_compat,
 MACHINE_END
diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index e0368aa06390..c10c2ddaae6d 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -22,7 +22,6 @@ extern void __init at91_init_sram(int bank, unsigned long base,
 
  /* Processors */
 extern void __init at91rm9200_set_type(int type);
-extern void __init at91rm9200_dt_initialize(void);
 extern void __init at91_dt_initialize(void);
 
  /* Timer */
diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
index ce25e85720fb..acb8d7724609 100644
--- a/arch/arm/mach-at91/setup.c
+++ b/arch/arm/mach-at91/setup.c
@@ -429,13 +429,6 @@ static void at91_dt_ramc(void)
 	at91_pm_set_standby(standby);
 }
 
-void __init at91rm9200_dt_initialize(void)
-{
-	at91_dt_ramc();
-
-	at91_boot_soc.init();
-}
-
 void __init at91_dt_initialize(void)
 {
 	at91_dt_ramc();
-- 
2.1.0
