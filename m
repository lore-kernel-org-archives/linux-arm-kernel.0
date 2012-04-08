From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun,  8 Apr 2012 17:40:05 +0200
Subject: [PATCH 09/10] ARM: at91/dt: do not specify the board any more
In-Reply-To: <20120408151236.GH16641@game.jcrosoft.org>
References: <20120408151236.GH16641@game.jcrosoft.org>
Message-ID: <1333899606-30518-9-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will allow to add any board to a compiled kernel by just passing the DTB.

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/board-dt.c |   14 +++++---------
 1 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-at91/board-dt.c b/arch/arm/mach-at91/board-dt.c
index c18d4d3..78a4a61 100644
--- a/arch/arm/mach-at91/board-dt.c
+++ b/arch/arm/mach-at91/board-dt.c
@@ -1,12 +1,10 @@
 /*
- *  Setup code for AT91SAM Evaluation Kits with Device Tree support
+ * Setup code for AT91SAM Evaluation Kits with Device Tree support
  *
- *  Covers: * AT91SAM9G45-EKES  board
- *          * AT91SAM9M10-EKES  board
- *          * AT91SAM9M10G45-EK board
+ * Copyright (C) 2011-2012 Atmel,
+ *		 2011-2012 Nicolas Ferre <nicolas.ferre@atmel.com>
  *
- *  Copyright (C) 2011 Atmel,
- *                2011 Nicolas Ferre <nicolas.ferre@atmel.com>
+ * Copyright (C) 2011-2012 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
  *
  * Licensed under GPLv2 or later.
  */
@@ -49,9 +47,7 @@ static void __init at91_dt_device_init(void)
 }
 
 static const char *at91_dt_board_compat[] __initdata = {
-	"atmel,at91sam9m10g45ek",
-	"atmel,at91sam9x5ek",
-	"calao,usb-a9g20",
+	"atmel,at91sam9",
 	NULL
 };
 
-- 
1.7.9.1
