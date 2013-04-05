From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 5 Apr 2013 16:22:45 +0200
Subject: [PATCH 03/14] ARM: ux500: move mach/msp.h to <linux/platform_data/*>
In-Reply-To: <1365171776-8463-1-git-send-email-linus.walleij@stericsson.com>
References: <1365171776-8463-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1365171776-8463-4-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

This header file only contains platform data structure definitions,
so it's straightforward to move.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
[Delete one include rather than move it]
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-audio.c                                | 2 +-
 arch/arm/mach-ux500/board-mop500.h                                      | 2 +-
 .../include/mach/msp.h => include/linux/platform_data/asoc-ux500-msp.h  | 0
 sound/soc/ux500/ux500_msp_dai.c                                         | 2 +-
 sound/soc/ux500/ux500_msp_i2s.c                                         | 2 +-
 sound/soc/ux500/ux500_msp_i2s.h                                         | 2 --
 6 files changed, 4 insertions(+), 6 deletions(-)
 rename arch/arm/mach-ux500/include/mach/msp.h => include/linux/platform_data/asoc-ux500-msp.h (100%)

diff --git a/arch/arm/mach-ux500/board-mop500-audio.c b/arch/arm/mach-ux500/board-mop500-audio.c
index 7209db7..43bbee1 100644
--- a/arch/arm/mach-ux500/board-mop500-audio.c
+++ b/arch/arm/mach-ux500/board-mop500-audio.c
@@ -13,7 +13,7 @@
 #include <mach/devices.h>
 #include <mach/hardware.h>
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
index 94a3e57..0d9713e 100644
--- a/sound/soc/ux500/ux500_msp_dai.c
+++ b/sound/soc/ux500/ux500_msp_dai.c
@@ -19,9 +19,9 @@
 #include <linux/clk.h>
 #include <linux/regulator/consumer.h>
 #include <linux/mfd/dbx500-prcmu.h>
+#include <linux/platform_data/asoc-ux500-msp.h>
 
 #include <mach/hardware.h>
-#include <mach/msp.h>
 
 #include <sound/soc.h>
 #include <sound/soc-dai.h>
diff --git a/sound/soc/ux500/ux500_msp_i2s.c b/sound/soc/ux500/ux500_msp_i2s.c
index a26c6bf..a582007 100644
--- a/sound/soc/ux500/ux500_msp_i2s.c
+++ b/sound/soc/ux500/ux500_msp_i2s.c
@@ -20,9 +20,9 @@
 #include <linux/slab.h>
 #include <linux/io.h>
 #include <linux/of.h>
+#include <linux/platform_data/asoc-ux500-msp.h>
 
 #include <mach/hardware.h>
-#include <mach/msp.h>
 
 #include <sound/soc.h>
 
diff --git a/sound/soc/ux500/ux500_msp_i2s.h b/sound/soc/ux500/ux500_msp_i2s.h
index 1311c0d..437f0c0 100644
--- a/sound/soc/ux500/ux500_msp_i2s.h
+++ b/sound/soc/ux500/ux500_msp_i2s.h
@@ -17,8 +17,6 @@
 
 #include <linux/platform_device.h>
 
-#include <mach/msp.h>
-
 #define MSP_INPUT_FREQ_APB 48000000
 
 /*** Stereo mode. Used for APB data accesses as 16 bits accesses (mono),
-- 
1.7.11.3
