From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon,  6 Feb 2012 10:19:37 +0100
Subject: [PATCH 1/1] ARM: at91: board/dt drop default console
Message-ID: <1328519977-6388-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this will simplify multiple soc enable in the same kernel

the console can still be selected by cmdline

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/board-dt.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

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
1.7.7
