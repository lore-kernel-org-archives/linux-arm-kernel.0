From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Mon, 18 May 2015 17:44:06 +0300
Subject: [RESEND][PATCH 4/5] ARM: sa1100: move irq driver to drivers/irqchip/
In-Reply-To: <1431960247-32646-1-git-send-email-dbaryshkov@gmail.com>
References: <1431960247-32646-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1431960247-32646-4-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move current sa11x0 IRQ driver to the irqchip subsystem. The driver is
not yet modified to be a proper part of irqchip subsystem, it will be a
next step.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-sa1100/Makefile                              | 2 +-
 drivers/irqchip/Makefile                                   | 1 +
 arch/arm/mach-sa1100/irq.c => drivers/irqchip/irq-sa11x0.c | 6 +++---
 3 files changed, 5 insertions(+), 4 deletions(-)
 rename arch/arm/mach-sa1100/irq.c => drivers/irqchip/irq-sa11x0.c (96%)

diff --git a/arch/arm/mach-sa1100/Makefile b/arch/arm/mach-sa1100/Makefile
index 61ff91e..ebc4d58 100644
--- a/arch/arm/mach-sa1100/Makefile
+++ b/arch/arm/mach-sa1100/Makefile
@@ -3,7 +3,7 @@
 #
 
 # Common support
-obj-y := clock.o generic.o irq.o #nmi-oopser.o
+obj-y := clock.o generic.o #nmi-oopser.o
 
 # Specific board support
 obj-$(CONFIG_SA1100_ASSABET)		+= assabet.o
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index dda4927..49f372a 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -47,3 +47,4 @@ obj-$(CONFIG_KEYSTONE_IRQ)		+= irq-keystone.o
 obj-$(CONFIG_MIPS_GIC)			+= irq-mips-gic.o
 obj-$(CONFIG_ARCH_MEDIATEK)		+= irq-mtk-sysirq.o
 obj-$(CONFIG_ARCH_DIGICOLOR)		+= irq-digicolor.o
+obj-$(CONFIG_ARCH_SA1100)		+= irq-sa11x0.o
diff --git a/arch/arm/mach-sa1100/irq.c b/drivers/irqchip/irq-sa11x0.c
similarity index 96%
rename from arch/arm/mach-sa1100/irq.c
rename to drivers/irqchip/irq-sa11x0.c
index 08f929e..a5e1a54 100644
--- a/arch/arm/mach-sa1100/irq.c
+++ b/drivers/irqchip/irq-sa11x0.c
@@ -1,9 +1,9 @@
 /*
- * linux/arch/arm/mach-sa1100/irq.c
+ * drivers/irqchip/irq-sa11x0.c
  *
  * Copyright (C) 1999-2001 Nicolas Pitre
  *
- * Generic IRQ handling for the SA11x0, GPIO 11-27 IRQ demultiplexing.
+ * Generic IRQ handling for the SA11x0.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -23,7 +23,7 @@
 #include <mach/irqs.h>
 #include <asm/exception.h>
 
-#include "generic.h"
+#include "../../arch/arm/mach-sa1100/generic.h"
 
 #define ICIP	0x00  /* IC IRQ Pending reg. */
 #define ICMR	0x04  /* IC Mask Reg.        */
-- 
2.1.4
