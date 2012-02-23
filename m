From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 23 Feb 2012 15:26:03 +0100
Subject: [PATCH v3 19/21] ARM: at91/board-dt: drop default console
In-Reply-To: <cover.1330006537.git.nicolas.ferre@atmel.com>
References: <cover.1330006537.git.nicolas.ferre@atmel.com>
Message-ID: <e8729dda3fb0f99c1353d32b7cc88384e3d9124b.1330006537.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

This default console mechanism is not used if the console is selected
by command line (console= parameter).
Dropping this will simplify the compilation of multiple SoC in the same
kernel image.

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/at91sam9x5.c |    3 ---
 arch/arm/mach-at91/board-dt.c   |    6 ------
 2 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9x5.c b/arch/arm/mach-at91/at91sam9x5.c
index 90bb7ec..d17d426 100644
--- a/arch/arm/mach-at91/at91sam9x5.c
+++ b/arch/arm/mach-at91/at91sam9x5.c
@@ -318,9 +318,6 @@ void __init at91sam9x5_initialize(void)
 /* --------------------------------------------------------------------
  *  AT91SAM9x5 devices (temporary before modification of code)
  * -------------------------------------------------------------------- */
-void __init at91_register_uart(unsigned id, unsigned portnr, unsigned pins) {}
-void __init at91_set_serial_console(unsigned portnr) {}
-
 void __init at91_add_device_nand(struct atmel_nand_data *data) {}
 
 /* --------------------------------------------------------------------
diff --git a/arch/arm/mach-at91/board-dt.c b/arch/arm/mach-at91/board-dt.c
index 0579315..08c8ad8 100644
--- a/arch/arm/mach-at91/board-dt.c
+++ b/arch/arm/mach-at91/board-dt.c
@@ -38,12 +38,6 @@ static void __init ek_init_early(void)
 {
 	/* Initialize processor: 12.000 MHz crystal */
 	at91_initialize(12000000);
-
-	/* DGBU on ttyS0. (Rx & Tx only) */
-	at91_register_uart(0, 0, 0);
-
-	/* set serial console to ttyS0 (ie, DBGU) */
-	at91_set_serial_console(0);
 }
 
 /* det_pin is not connected */
-- 
1.7.9
