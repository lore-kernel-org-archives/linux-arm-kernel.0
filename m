From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 1 Oct 2012 09:40:19 +0200
Subject: [PATCH] ARM: ux500: support the HREFP520 board variant
Message-ID: <1349077219-25974-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This adds support for another board registered for the old machine
type system. Mainly doing this because it is all that is required
to get that board working, everything else stays the same.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
This is basically just another U8500 MOP500 variant, so while I
know the fine DT work is going on, this is still some legacy
business.
---
 arch/arm/mach-ux500/board-mop500.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index dd629b7..4f77208 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -1,6 +1,5 @@
-
 /*
- * Copyright (C) 2008-2009 ST-Ericsson
+ * Copyright (C) 2008-2012 ST-Ericsson
  *
  * Author: Srinidhi KASAGAR <srinidhi.kasagar@stericsson.com>
  *
@@ -722,6 +721,16 @@ MACHINE_START(U8500, "ST-Ericsson MOP500 platform")
 	.init_late	= ux500_init_late,
 MACHINE_END
 
+MACHINE_START(U8520, "ST-Ericsson U8520 Platform HREFP520")
+	.atag_offset	= 0x100,
+	.map_io		= u8500_map_io,
+	.init_irq	= ux500_init_irq,
+	.timer		= &ux500_timer,
+	.handle_irq	= gic_handle_irq,
+	.init_machine	= mop500_init_machine,
+	.init_late	= ux500_init_late,
+MACHINE_END
+
 MACHINE_START(HREFV60, "ST-Ericsson U8500 Platform HREFv60+")
 	.atag_offset	= 0x100,
 	.map_io		= u8500_map_io,
-- 
1.7.11.3
