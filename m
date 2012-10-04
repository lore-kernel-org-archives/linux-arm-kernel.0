From: tony@atomide.com (Tony Lindgren)
Date: Thu, 04 Oct 2012 15:04:47 -0700
Subject: [PATCH 06/16] ARM: OMAP: Move plat/led.h to
 include/linux/platform_data
In-Reply-To: <20121004213950.26676.21898.stgit@muffinssi.local>
References: <20121004213950.26676.21898.stgit@muffinssi.local>
Message-ID: <20121004220447.26676.84489.stgit@muffinssi.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to move this away from plat for ARM common
zImage support.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/board-palmtt.c      |    2 +-
 arch/arm/mach-omap2/board-apollon.c     |    2 +-
 include/linux/platform_data/leds-omap.h |    2 --
 3 files changed, 2 insertions(+), 4 deletions(-)
 rename arch/arm/plat-omap/include/plat/led.h => include/linux/platform_data/leds-omap.h (91%)

diff --git a/arch/arm/mach-omap1/board-palmtt.c b/arch/arm/mach-omap1/board-palmtt.c
index dece125..7f7fa3e 100644
--- a/arch/arm/mach-omap1/board-palmtt.c
+++ b/arch/arm/mach-omap1/board-palmtt.c
@@ -28,12 +28,12 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
 #include <linux/platform_data/omap1_bl.h>
+#include <linux/platform_data/leds-omap.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <plat/led.h>
 #include <mach/flash.h>
 #include <mach/mux.h>
 #include <plat/dma.h>
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index cea3aba..a299ea4 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -28,12 +28,12 @@
 #include <linux/clk.h>
 #include <linux/smc91x.h>
 #include <linux/gpio.h>
+#include <linux/platform_data/leds-omap.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
 
-#include <plat/led.h>
 #include "common.h"
 #include <plat/gpmc.h>
 
diff --git a/arch/arm/plat-omap/include/plat/led.h b/include/linux/platform_data/leds-omap.h
similarity index 91%
rename from arch/arm/plat-omap/include/plat/led.h
rename to include/linux/platform_data/leds-omap.h
index 25e451e..56c9b2a 100644
--- a/arch/arm/plat-omap/include/plat/led.h
+++ b/include/linux/platform_data/leds-omap.h
@@ -1,6 +1,4 @@
 /*
- *  arch/arm/plat-omap/include/mach/led.h
- *
  *  Copyright (C) 2006 Samsung Electronics
  *  Kyungmin Park <kyungmin.park@samsung.com>
  *
