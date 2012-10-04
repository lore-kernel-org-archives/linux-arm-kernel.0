From: tony@atomide.com (Tony Lindgren)
Date: Thu, 04 Oct 2012 15:04:52 -0700
Subject: [PATCH 08/16] ARM: OMAP2: Move plat/menelaus.h to linux/mfd/menelaus.h
In-Reply-To: <20121004213950.26676.21898.stgit@muffinssi.local>
References: <20121004213950.26676.21898.stgit@muffinssi.local>
Message-ID: <20121004220451.26676.62349.stgit@muffinssi.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can move menelaus.h to live with other mfd headers to
get it out of plat for ARM common zImage support.

Cc: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-h4.c             |    2 +-
 arch/arm/mach-omap2/board-n8x0.c           |    2 +-
 drivers/mfd/menelaus.c                     |    2 +-
 include/linux/mfd/menelaus.h               |    2 --
 4 files changed, 3 insertions(+), 5 deletions(-)
 rename arch/arm/plat-omap/include/plat/menelaus.h => include/linux/mfd/menelaus.h (96%)

diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 8d04bf8..3977a02 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -26,12 +26,12 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/input/matrix_keypad.h>
+#include <linux/mfd/menelaus.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <plat/menelaus.h>
 #include <plat/dma.h>
 #include <plat/gpmc.h>
 #include "debug-devices.h"
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index d95f727..e3e8325 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -22,13 +22,13 @@
 #include <linux/usb/musb.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
 #include <linux/platform_data/mtd-onenand-omap2.h>
+#include <linux/mfd/menelaus.h>
 #include <sound/tlv320aic3x.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 
 #include "common.h"
-#include <plat/menelaus.h>
 #include <plat/mmc.h>
 
 #include "mux.h"
diff --git a/drivers/mfd/menelaus.c b/drivers/mfd/menelaus.c
index 55d5899..998ce8c 100644
--- a/drivers/mfd/menelaus.c
+++ b/drivers/mfd/menelaus.c
@@ -41,11 +41,11 @@
 #include <linux/rtc.h>
 #include <linux/bcd.h>
 #include <linux/slab.h>
+#include <linux/mfd/menelaus.h>
 
 #include <asm/mach/irq.h>
 
 #include <asm/gpio.h>
-#include <plat/menelaus.h>
 
 #define DRIVER_NAME			"menelaus"
 
diff --git a/arch/arm/plat-omap/include/plat/menelaus.h b/include/linux/mfd/menelaus.h
similarity index 96%
rename from arch/arm/plat-omap/include/plat/menelaus.h
rename to include/linux/mfd/menelaus.h
index 4a970ec..f097e89 100644
--- a/arch/arm/plat-omap/include/plat/menelaus.h
+++ b/include/linux/mfd/menelaus.h
@@ -1,6 +1,4 @@
 /*
- * arch/arm/plat-omap/include/mach/menelaus.h
- *
  * Functions to access Menelaus power management chip
  */
 
