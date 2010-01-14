From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 14 Jan 2010 13:53:22 -0700
Subject: [PATCH] ep93xx: include correct irq.h in core.c
Message-ID: <201001141353.23018.hartleys@visionengravers.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ep93xx: include correct irq.h in core.c

Currently <asm/mach/irq.h> is included by core.c. This header
includes <linux/irq.h> and defines a number of internal functions.
These internal functions are not needed by this file. Change the
include so that we just get what is needed.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <ryan@bluewatersys.com>

---

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 1f0d665..2f39264 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -20,6 +20,7 @@
 #include <linux/interrupt.h>
 #include <linux/dma-mapping.h>
 #include <linux/timex.h>
+#include <linux/irq.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
 #include <linux/leds.h>
@@ -35,7 +36,6 @@
 
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
-#include <asm/mach/irq.h>
 
 #include <asm/hardware/vic.h>
 
