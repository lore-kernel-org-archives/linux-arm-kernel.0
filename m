From: robherring2@gmail.com (Rob Herring)
Date: Wed, 29 Aug 2012 17:31:34 -0500
Subject: [PATCH 08/10] ARM: omap2: add explict mach/gpio.h includes
In-Reply-To: <1346279496-26286-1-git-send-email-robherring2@gmail.com>
References: <1346279496-26286-1-git-send-email-robherring2@gmail.com>
Message-ID: <1346279496-26286-9-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

In preparation to remove implicit inclusion of mach/gpio.h, add explict
include of mach/gpio.h.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-omap2/board-zoom-display.c |    1 +
 arch/arm/mach-omap2/gpio.c               |    1 +
 arch/arm/mach-omap2/pm24xx.c             |    1 +
 arch/arm/mach-omap2/pm34xx.c             |    1 +
 drivers/gpio/gpio-omap.c                 |    2 +-
 5 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/board-zoom-display.c b/arch/arm/mach-omap2/board-zoom-display.c
index 28187f1..c1a27b8 100644
--- a/arch/arm/mach-omap2/board-zoom-display.c
+++ b/arch/arm/mach-omap2/board-zoom-display.c
@@ -17,6 +17,7 @@
 #include <plat/mcspi.h>
 #include <video/omapdss.h>
 #include <mach/board-zoom.h>
+#include <plat/cpu.h>
 
 #define LCD_PANEL_RESET_GPIO_PROD	96
 #define LCD_PANEL_RESET_GPIO_PILOT	55
diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index 9ad7d48..c090e9e 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -25,6 +25,7 @@
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
 #include <plat/omap-pm.h>
+#include <plat/gpio.h>
 
 #include "powerdomain.h"
 
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 2edeffc..95f37e9 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -39,6 +39,7 @@
 #include <plat/sram.h>
 #include <plat/dma.h>
 #include <plat/board.h>
+#include <plat/gpio.h>
 
 #include <mach/irqs.h>
 
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index e4fc88c..6373400 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -40,6 +40,7 @@
 #include <plat/prcm.h>
 #include <plat/gpmc.h>
 #include <plat/dma.h>
+#include <plat/gpio.h>
 
 #include "common.h"
 #include "cm2xxx_3xxx.h"
diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index e6efd77..06dceba 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -29,7 +29,7 @@
 #include <mach/hardware.h>
 #include <asm/irq.h>
 #include <mach/irqs.h>
-#include <asm/gpio.h>
+#include <mach/gpio.h>
 #include <asm/mach/irq.h>
 
 #define OFF_MODE	1
-- 
1.7.9.5
