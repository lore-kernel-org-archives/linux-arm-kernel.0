From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Sun, 25 Oct 2009 00:20:39 +0400
Subject: [PATCH 14/20] SA1100: h3100/h3600: merge h3600.h and h3600_gpio.h
	into h3xxx.h
In-Reply-To: <1256415643-22853-1-git-send-email-mad_soft@inbox.ru>
References: <1256415376-22778-1-git-send-email-mad_soft@inbox.ru>
	<1256415643-22853-1-git-send-email-mad_soft@inbox.ru>
Message-ID: <1256415643-22853-2-git-send-email-mad_soft@inbox.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Combine both headers into one, rename to h3xxx.h and change all
users accordingly.

Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
---
 arch/arm/mach-sa1100/h3600.c                       |    3 +-
 arch/arm/mach-sa1100/include/mach/h3600.h          |   36 --------------------
 .../include/mach/{h3600_gpio.h => h3xxx.h}         |   16 +++++++--
 drivers/pcmcia/sa1100_h3600.c                      |    3 +-
 4 files changed, 15 insertions(+), 43 deletions(-)
 delete mode 100644 arch/arm/mach-sa1100/include/mach/h3600.h
 rename arch/arm/mach-sa1100/include/mach/{h3600_gpio.h => h3xxx.h} (86%)

diff --git a/arch/arm/mach-sa1100/h3600.c b/arch/arm/mach-sa1100/h3600.c
index 3d52190..dd39f90 100644
--- a/arch/arm/mach-sa1100/h3600.c
+++ b/arch/arm/mach-sa1100/h3600.c
@@ -44,8 +44,7 @@
 #include <asm/mach/map.h>
 #include <asm/mach/serial_sa1100.h>
 
-#include <mach/h3600.h>
-#include <mach/h3600_gpio.h>
+#include <mach/h3xxx.h>
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-sa1100/include/mach/h3600.h b/arch/arm/mach-sa1100/include/mach/h3600.h
deleted file mode 100644
index e420422..0000000
--- a/arch/arm/mach-sa1100/include/mach/h3600.h
+++ /dev/null
@@ -1,36 +0,0 @@
-/*
- *
- * Definitions for H3600 Handheld Computer
- *
- * Copyright 2000 Compaq Computer Corporation.
- *
- * Use consistent with the GNU GPL is permitted,
- * provided that this copyright notice is
- * preserved in its entirety in all copies and derived works.
- *
- * COMPAQ COMPUTER CORPORATION MAKES NO WARRANTIES, EXPRESSED OR IMPLIED,
- * AS TO THE USEFULNESS OR CORRECTNESS OF THIS CODE OR ITS
- * FITNESS FOR ANY PARTICULAR PURPOSE.
- *
- * Author: Jamey Hicks.
- *
- * History:
- *
- * 2001-10-??	Andrew Christian   Added support for iPAQ H3800
- *
- */
-
-#ifndef _INCLUDE_H3600_H_
-#define _INCLUDE_H3600_H_
-
-/* Physical memory regions corresponding to chip selects */
-#define H3600_EGPIO_PHYS	(SA1100_CS5_PHYS + 0x01000000)
-#define H3600_BANK_2_PHYS	SA1100_CS2_PHYS
-#define H3600_BANK_4_PHYS	SA1100_CS4_PHYS
-
-/* Virtual memory regions corresponding to chip selects 2 & 4 (used on sleeves) */
-#define H3600_EGPIO_VIRT	0xf0000000
-#define H3600_BANK_2_VIRT	0xf1000000
-#define H3600_BANK_4_VIRT	0xf3800000
-
-#endif /* _INCLUDE_H3600_H_ */
diff --git a/arch/arm/mach-sa1100/include/mach/h3600_gpio.h b/arch/arm/mach-sa1100/include/mach/h3xxx.h
similarity index 86%
rename from arch/arm/mach-sa1100/include/mach/h3600_gpio.h
rename to arch/arm/mach-sa1100/include/mach/h3xxx.h
index 2537f35..7f1e130 100644
--- a/arch/arm/mach-sa1100/include/mach/h3600_gpio.h
+++ b/arch/arm/mach-sa1100/include/mach/h3xxx.h
@@ -20,8 +20,18 @@
  *
  */
 
-#ifndef _INCLUDE_H3600_GPIO_H_
-#define _INCLUDE_H3600_GPIO_H_
+#ifndef _INCLUDE_H3XXX_H_
+#define _INCLUDE_H3XXX_H_
+
+/* Physical memory regions corresponding to chip selects */
+#define H3600_EGPIO_PHYS	(SA1100_CS5_PHYS + 0x01000000)
+#define H3600_BANK_2_PHYS	SA1100_CS2_PHYS
+#define H3600_BANK_4_PHYS	SA1100_CS4_PHYS
+
+/* Virtual memory regions corresponding to chip selects 2 & 4 (used on sleeves) */
+#define H3600_EGPIO_VIRT	0xf0000000
+#define H3600_BANK_2_VIRT	0xf1000000
+#define H3600_BANK_4_VIRT	0xf3800000
 
 /*
  * gpiolib numbers for all iPAQs
@@ -77,4 +87,4 @@
 #define H3600_EGPIO_LCD_5V_ON		(H3XXX_EGPIO_BASE + 14) /* enable 5V to LCD. active high. */
 #define H3600_EGPIO_LVDD_ON		(H3XXX_EGPIO_BASE + 15) /* enable 9V and -6.5V to LCD. */
 
-#endif /* _INCLUDE_H3600_GPIO_H_ */
+#endif /* _INCLUDE_H3XXX_H_ */
diff --git a/drivers/pcmcia/sa1100_h3600.c b/drivers/pcmcia/sa1100_h3600.c
index 4afd348..4717aca 100644
--- a/drivers/pcmcia/sa1100_h3600.c
+++ b/drivers/pcmcia/sa1100_h3600.c
@@ -15,8 +15,7 @@
 #include <mach/hardware.h>
 #include <asm/irq.h>
 #include <asm/mach-types.h>
-#include <mach/h3600.h>
-#include <mach/h3600_gpio.h>
+#include <mach/h3xxx.h>
 
 #include "sa1100_generic.h"
 
-- 
1.6.5.1.63.ga9d7.dirty
