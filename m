From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 24 Jun 2013 20:10:19 +0200
Subject: next-20130624 build fix for imx_v6_v7_defconfig
Message-ID: <1421252.HsQN8mblgM@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

The issue is probably caused by:

commit 38ff87f77af0b5a93fc8581cff1d6e5692ab8970
Author: Stephen Boyd <sboyd@codeaurora.org>
Date:   Sat Jun 1 23:39:40 2013 -0700

    sched_clock: Make ARM's sched_clock generic for all architectures
...

not taking into account following change:

commit c19672492d233e0012b60fbfa460ffac1381ee26
Author: Jingchang Lu <b35083@freescale.com>
Date:   Wed May 29 10:12:17 2013 +0200

    clocksource: Add Freescale Vybrid pit timer support
...

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

---

Index: b/drivers/clocksource/vf_pit_timer.c
===================================================================
--- a/drivers/clocksource/vf_pit_timer.c	2013-06-24 19:41:07.022518558 +0200
+++ b/drivers/clocksource/vf_pit_timer.c	2013-06-24 19:41:13.274518546 +0200
@@ -12,7 +12,7 @@
 #include <linux/clk.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
-#include <asm/sched_clock.h>
+#include <linux/sched_clock.h>
 
 /*
  * Each pit takes 0x10 Bytes register space
