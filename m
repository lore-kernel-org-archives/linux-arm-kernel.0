From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 09 Jul 2013 19:39:52 +0900
Subject: [PATCH 01/04] ARM: shmobile: No need to use INTC header on r8a7779
In-Reply-To: <20130709103944.1891.67462.sendpatchset@w520>
References: <20130709103944.1891.67462.sendpatchset@w520>
Message-ID: <20130709103952.1891.92697.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Now when the intc-irqpin driver is used for external
IRQ pins on r8a7779 it possible to get rid of unused
INTC headers mach/intc.h and linux/sh_intc.h.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/intc-r8a7779.c  |    1 -
 arch/arm/mach-shmobile/setup-r8a7779.c |    1 -
 2 files changed, 2 deletions(-)

--- 0001/arch/arm/mach-shmobile/intc-r8a7779.c
+++ work/arch/arm/mach-shmobile/intc-r8a7779.c	2013-07-09 18:42:08.000000000 +0900
@@ -27,7 +27,6 @@
 #include <linux/platform_data/irq-renesas-intc-irqpin.h>
 #include <linux/irqchip.h>
 #include <mach/common.h>
-#include <mach/intc.h>
 #include <mach/irqs.h>
 #include <mach/r8a7779.h>
 #include <asm/mach-types.h>
--- 0001/arch/arm/mach-shmobile/setup-r8a7779.c
+++ work/arch/arm/mach-shmobile/setup-r8a7779.c	2013-07-09 18:42:25.000000000 +0900
@@ -29,7 +29,6 @@
 #include <linux/input.h>
 #include <linux/io.h>
 #include <linux/serial_sci.h>
-#include <linux/sh_intc.h>
 #include <linux/sh_timer.h>
 #include <linux/dma-mapping.h>
 #include <linux/usb/otg.h>
