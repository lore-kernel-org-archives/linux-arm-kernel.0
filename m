From: martinknoll@me.com (Martin Knoll)
Date: Wed, 06 Mar 2013 21:18:58 +0100
Subject: [PATCH] ARM: LPC32xx: changed lpc23xx_restart to lpc32xx_restart
Message-ID: <1362601138-16550-1-git-send-email-martinknoll@me.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This function has an odd name. This is probably a typo.
---
 arch/arm/mach-lpc32xx/common.c  | 2 +-
 arch/arm/mach-lpc32xx/common.h  | 2 +-
 arch/arm/mach-lpc32xx/phy3250.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/common.c b/arch/arm/mach-lpc32xx/common.c
index 0d4db8c..20c0ed7 100644
--- a/arch/arm/mach-lpc32xx/common.c
+++ b/arch/arm/mach-lpc32xx/common.c
@@ -207,7 +207,7 @@ void __init lpc32xx_map_io(void)
 	iotable_init(lpc32xx_io_desc, ARRAY_SIZE(lpc32xx_io_desc));
 }
 
-void lpc23xx_restart(char mode, const char *cmd)
+void lpc32xx_restart(char mode, const char *cmd)
 {
 	switch (mode) {
 	case 's':
diff --git a/arch/arm/mach-lpc32xx/common.h b/arch/arm/mach-lpc32xx/common.h
index e0b2606..5d90469 100644
--- a/arch/arm/mach-lpc32xx/common.h
+++ b/arch/arm/mach-lpc32xx/common.h
@@ -29,7 +29,7 @@ extern void lpc32xx_timer_init(void);
 extern void __init lpc32xx_init_irq(void);
 extern void __init lpc32xx_map_io(void);
 extern void __init lpc32xx_serial_init(void);
-extern void lpc23xx_restart(char, const char *);
+extern void lpc32xx_restart(char, const char *);
 
 
 /*
diff --git a/arch/arm/mach-lpc32xx/phy3250.c b/arch/arm/mach-lpc32xx/phy3250.c
index c1cd5a9..16e5b58 100644
--- a/arch/arm/mach-lpc32xx/phy3250.c
+++ b/arch/arm/mach-lpc32xx/phy3250.c
@@ -266,5 +266,5 @@ DT_MACHINE_START(LPC32XX_DT, "LPC32XX SoC (Flattened Device Tree)")
 	.init_time	= lpc32xx_timer_init,
 	.init_machine	= lpc3250_machine_init,
 	.dt_compat	= lpc32xx_dt_compat,
-	.restart	= lpc23xx_restart,
+	.restart	= lpc32xx_restart,
 MACHINE_END
-- 
1.7.12.4 (Apple Git-37)
