From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 22 Sep 2010 07:55:59 +0200
Subject: [PATCH] sam9m10g45ek: use the right machine id
Message-ID: <1285134959-6786-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

today the board use 2 machines id AT91SAM9G45EKES and AT91SAM9M10G45EK
now will use only AT91SAM9M10G45EK

the other boards revision will be specified via system_rev
as done for the 9g20ek

for 9g45ekes, m10g45ekes and m10g45ek boards and revisions

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
---
 arch/arm/mach-at91/Kconfig              |    4 ++--
 arch/arm/mach-at91/Makefile             |    2 +-
 arch/arm/mach-at91/board-sam9m10g45ek.c |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 879b515..200331c 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -384,8 +384,8 @@ if ARCH_AT91SAM9G45
 
 comment "AT91SAM9G45 Board Type"
 
-config MACH_AT91SAM9G45EKES
-	bool "Atmel AT91SAM9G45-EKES Evaluation Kit"
+config MACH_AT91SAM9M10G45EK
+	bool "Atmel AT91SAM9M10G45-EK Evaluation Kits"
 	select HAVE_NAND_ATMEL_BUSWIDTH_16
 	help
 	  Select this if you are using Atmel's AT91SAM9G45-EKES Evaluation Kit.
diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index e3711f6..ffd61ab 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -68,7 +68,7 @@ obj-$(CONFIG_MACH_PORTUXG20)	+= board-stamp9g20.o
 obj-$(CONFIG_MACH_SNAPPER_9260)	+= board-snapper9260.o
 
 # AT91SAM9G45 board-specific support
-obj-$(CONFIG_MACH_AT91SAM9G45EKES) += board-sam9m10g45ek.o
+obj-$(CONFIG_MACH_AT91SAM9M10G45EK) += board-sam9m10g45ek.o
 
 # AT91CAP9 board-specific support
 obj-$(CONFIG_MACH_AT91CAP9ADK)	+= board-cap9adk.o
diff --git a/arch/arm/mach-at91/board-sam9m10g45ek.c b/arch/arm/mach-at91/board-sam9m10g45ek.c
index ee80059..f9bf45e 100644
--- a/arch/arm/mach-at91/board-sam9m10g45ek.c
+++ b/arch/arm/mach-at91/board-sam9m10g45ek.c
@@ -399,7 +399,7 @@ static void __init ek_board_init(void)
 	at91_pwm_leds(ek_pwm_led, ARRAY_SIZE(ek_pwm_led));
 }
 
-MACHINE_START(AT91SAM9G45EKES, "Atmel AT91SAM9G45-EKES")
+MACHINE_START(AT91SAM9M10G45EK, "Atmel AT91SAM9M10G45-EK")
 	/* Maintainer: Atmel */
 	.phys_io	= AT91_BASE_SYS,
 	.io_pg_offst	= (AT91_VA_BASE_SYS >> 18) & 0xfffc,
-- 
1.7.1
