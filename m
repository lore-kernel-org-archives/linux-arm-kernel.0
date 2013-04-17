From: cedric@precidata.com (Cedric Berger)
Date: Wed, 17 Apr 2013 22:42:57 +0200 (CEST)
Subject: [PATCH 9/10] LPC32XX: 009-plat.1: lpc23xx => lpc32xx in LPC32xx
 platform code
Message-ID: <mailman.18.1366231457.1198.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Cedric Berger <cedric@precidata.com>
---
This is the lpc32xx, not the lpc23xx.

Index: arch/arm/mach-lpc32xx/phy3250.c
===================================================================
--- arch/arm/mach-lpc32xx/phy3250.c	(revision 1711)
+++ arch/arm/mach-lpc32xx/phy3250.c	(revision 1712)
@@ -266,5 +266,5 @@
 	.init_time	= lpc32xx_timer_init,
 	.init_machine	= lpc3250_machine_init,
 	.dt_compat	= lpc32xx_dt_compat,
-	.restart	= lpc23xx_restart,
+	.restart	= lpc32xx_restart,
 MACHINE_END
Index: arch/arm/mach-lpc32xx/common.c
===================================================================
--- arch/arm/mach-lpc32xx/common.c	(revision 1711)
+++ arch/arm/mach-lpc32xx/common.c	(revision 1712)
@@ -230,7 +230,7 @@
 	iotable_init(lpc32xx_io_desc, ARRAY_SIZE(lpc32xx_io_desc));
 }
 
-void lpc23xx_restart(char mode, const char *cmd)
+void lpc32xx_restart(char mode, const char *cmd)
 {
 	switch (mode) {
 	case 's':
Index: arch/arm/mach-lpc32xx/common.h
===================================================================
--- arch/arm/mach-lpc32xx/common.h	(revision 1711)
+++ arch/arm/mach-lpc32xx/common.h	(revision 1712)
@@ -29,7 +29,7 @@
 extern void __init lpc32xx_init_irq(void);
 extern void __init lpc32xx_map_io(void);
 extern void __init lpc32xx_serial_init(void);
-extern void lpc23xx_restart(char, const char *);
+extern void lpc32xx_restart(char, const char *);
 
 
 /*
