From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Mar 2013 22:51:06 +0100
Subject: [PATCH 1/9] ARM: ux500: move mach/msp.h to
 include/linux/platform_data.h
In-Reply-To: <1363902674-6456-1-git-send-email-arnd@arndb.de>
References: <1363866553-15054-1-git-send-email-linus.walleij@stericsson.com>
 <1363902674-6456-1-git-send-email-arnd@arndb.de>
Message-ID: <1363902674-6456-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This header file only contains platform data structure definitions,
so it's straightforward to move.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-ux500/board-mop500-audio.c                                | 2 +-
 arch/arm/mach-ux500/board-mop500.h                                      | 2 +-
 .../include/mach/msp.h => include/linux/platform_data/asoc-ux500-msp.h  | 0
 sound/soc/ux500/ux500_msp_dai.c                                         | 2 +-
 sound/soc/ux500/ux500_msp_i2s.c                                         | 2 +-
 sound/soc/ux500/ux500_msp_i2s.h                                         | 2 +-
 6 files changed, 5 insertions(+), 5 deletions(-)
 rename arch/arm/mach-ux500/include/mach/msp.h => include/linux/platform_data/asoc-ux500-msp.h (100%)

diff --git a/arch/arm/mach-ux500/board-mop500-audio.c b/arch/arm/mach-ux500/board-mop500-audio.c
index c8167bf..96e62ef 100644
--- a/arch/arm/mach-ux500/board-mop500-audio.c
+++ b/arch/arm/mach-ux500/board-mop500-audio.c
@@ -12,7 +12,7 @@
 
 #include <mach/devices.h>
 #include <mach/irqs.h>
-#include <mach/msp.h>
+#include <linux/platform_data/asoc-ux500-msp.h>
 
 #include "ste-dma40-db8500.h"
 #include "board-mop500.h"
diff --git a/arch/arm/mach-ux500/board-mop500.h b/arch/arm/mach-ux500/board-mop500.h
index eaa605f..eb81caf1 100644
--- a/arch/arm/mach-ux500/board-mop500.h
+++ b/arch/arm/mach-ux500/board-mop500.h
@@ -9,7 +9,7 @@
 
 /* For NOMADIK_NR_GPIO */
 #include <mach/irqs.h>
-#include <mach/msp.h>
+#include <linux/platform_data/asoc-ux500-msp.h>
 #include <linux/amba/mmci.h>
 
 /* Snowball specific GPIO assignments, this board has no GPIO expander */
diff --git a/arch/arm/mach-ux500/include/mach/msp.h b/include/linux/platform_data/asoc-ux500-msp.h
similarity index 100%
rename from arch/arm/mach-ux500/include/mach/msp.h
rename to include/linux/platform_data/asoc-ux500-msp.h
diff --git a/sound/soc/ux500/ux500_msp_dai.c b/sound/soc/ux500/ux500_msp_dai.c
index 94a3e57..1e671f4 100644
--- a/sound/soc/ux500/ux500_msp_dai.c
+++ b/sound/soc/ux500/ux500_msp_dai.c
@@ -21,7 +21,7 @@
 #include <linux/mfd/dbx500-prcmu.h>
 
 #include <mach/hardware.h>
-#include <mach/msp.h>
+#include <linux/platform_data/asoc-ux500-msp.h>
 
 #include <sound/soc.h>
 #include <sound/soc-dai.h>
diff --git a/sound/soc/ux500/ux500_msp_i2s.c b/sound/soc/ux500/ux500_msp_i2s.c
index a26c6bf..124a78a 100644
--- a/sound/soc/ux500/ux500_msp_i2s.c
+++ b/sound/soc/ux500/ux500_msp_i2s.c
@@ -22,7 +22,7 @@
 #include <linux/of.h>
 
 #include <mach/hardware.h>
-#include <mach/msp.h>
+#include <linux/platform_data/asoc-ux500-msp.h>
 
 #include <sound/soc.h>
 
diff --git a/sound/soc/ux500/ux500_msp_i2s.h b/sound/soc/ux500/ux500_msp_i2s.h
index 1311c0d..31223ca 100644
--- a/sound/soc/ux500/ux500_msp_i2s.h
+++ b/sound/soc/ux500/ux500_msp_i2s.h
@@ -17,7 +17,7 @@
 
 #include <linux/platform_device.h>
 
-#include <mach/msp.h>
+#include <linux/platform_data/asoc-ux500-msp.h>
 
 #define MSP_INPUT_FREQ_APB 48000000
 
-- 
1.8.1.2
