From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 13 Aug 2012 13:58:14 +0200
Subject: [PATCH 6/7] ARM: u300: move DMA channel header into mach-u300
Message-ID: <1344859094-29480-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

We were broadcasting <mach/dma_channels.h> to the entire kernel
for no reason at all, push this down into the machine folder
where it belongs.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-u300/core.c                      |  2 +-
 arch/arm/mach-u300/dma_channels.h              | 60 ++++++++++++++++++++++++++
 arch/arm/mach-u300/include/mach/dma_channels.h | 60 --------------------------
 arch/arm/mach-u300/spi.c                       |  2 +-
 4 files changed, 62 insertions(+), 62 deletions(-)
 create mode 100644 arch/arm/mach-u300/dma_channels.h
 delete mode 100644 arch/arm/mach-u300/include/mach/dma_channels.h

diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
index bc23391..31cc926 100644
--- a/arch/arm/mach-u300/core.c
+++ b/arch/arm/mach-u300/core.c
@@ -45,12 +45,12 @@
 #include <mach/coh901318.h>
 #include <mach/hardware.h>
 #include <mach/syscon.h>
-#include <mach/dma_channels.h>
 
 #include "timer.h"
 #include "spi.h"
 #include "i2c.h"
 #include "u300-gpio.h"
+#include "dma_channels.h"
 
 /*
  * Static I/O mappings that are needed for booting the U300 platforms. The
diff --git a/arch/arm/mach-u300/dma_channels.h b/arch/arm/mach-u300/dma_channels.h
new file mode 100644
index 0000000..4e8a88f
--- /dev/null
+++ b/arch/arm/mach-u300/dma_channels.h
@@ -0,0 +1,60 @@
+/*
+ *
+ * arch/arm/mach-u300/include/mach/dma_channels.h
+ *
+ *
+ * Copyright (C) 2007-2012 ST-Ericsson
+ * License terms: GNU General Public License (GPL) version 2
+ * Map file for the U300 dma driver.
+ * Author: Per Friden <per.friden@stericsson.com>
+ */
+
+#ifndef DMA_CHANNELS_H
+#define DMA_CHANNELS_H
+
+#define U300_DMA_MSL_TX_0             0
+#define U300_DMA_MSL_TX_1             1
+#define U300_DMA_MSL_TX_2             2
+#define U300_DMA_MSL_TX_3             3
+#define U300_DMA_MSL_TX_4             4
+#define U300_DMA_MSL_TX_5             5
+#define U300_DMA_MSL_TX_6             6
+#define U300_DMA_MSL_RX_0             7
+#define U300_DMA_MSL_RX_1             8
+#define U300_DMA_MSL_RX_2             9
+#define U300_DMA_MSL_RX_3             10
+#define U300_DMA_MSL_RX_4             11
+#define U300_DMA_MSL_RX_5             12
+#define U300_DMA_MSL_RX_6             13
+#define U300_DMA_MMCSD_RX_TX          14
+#define U300_DMA_MSPRO_TX             15
+#define U300_DMA_MSPRO_RX             16
+#define U300_DMA_UART0_TX             17
+#define U300_DMA_UART0_RX             18
+#define U300_DMA_APEX_TX              19
+#define U300_DMA_APEX_RX              20
+#define U300_DMA_PCM_I2S0_TX          21
+#define U300_DMA_PCM_I2S0_RX          22
+#define U300_DMA_PCM_I2S1_TX          23
+#define U300_DMA_PCM_I2S1_RX          24
+#define U300_DMA_XGAM_CDI             25
+#define U300_DMA_XGAM_PDI             26
+#define U300_DMA_SPI_TX               27
+#define U300_DMA_SPI_RX               28
+#define U300_DMA_GENERAL_PURPOSE_0    29
+#define U300_DMA_GENERAL_PURPOSE_1    30
+#define U300_DMA_GENERAL_PURPOSE_2    31
+#define U300_DMA_GENERAL_PURPOSE_3    32
+#define U300_DMA_GENERAL_PURPOSE_4    33
+#define U300_DMA_GENERAL_PURPOSE_5    34
+#define U300_DMA_GENERAL_PURPOSE_6    35
+#define U300_DMA_GENERAL_PURPOSE_7    36
+#define U300_DMA_GENERAL_PURPOSE_8    37
+#define U300_DMA_UART1_TX             38
+#define U300_DMA_UART1_RX             39
+
+#define U300_DMA_DEVICE_CHANNELS      32
+#define U300_DMA_CHANNELS             40
+
+
+#endif /* DMA_CHANNELS_H */
diff --git a/arch/arm/mach-u300/include/mach/dma_channels.h b/arch/arm/mach-u300/include/mach/dma_channels.h
deleted file mode 100644
index 4e8a88f..0000000
--- a/arch/arm/mach-u300/include/mach/dma_channels.h
+++ /dev/null
@@ -1,60 +0,0 @@
-/*
- *
- * arch/arm/mach-u300/include/mach/dma_channels.h
- *
- *
- * Copyright (C) 2007-2012 ST-Ericsson
- * License terms: GNU General Public License (GPL) version 2
- * Map file for the U300 dma driver.
- * Author: Per Friden <per.friden@stericsson.com>
- */
-
-#ifndef DMA_CHANNELS_H
-#define DMA_CHANNELS_H
-
-#define U300_DMA_MSL_TX_0             0
-#define U300_DMA_MSL_TX_1             1
-#define U300_DMA_MSL_TX_2             2
-#define U300_DMA_MSL_TX_3             3
-#define U300_DMA_MSL_TX_4             4
-#define U300_DMA_MSL_TX_5             5
-#define U300_DMA_MSL_TX_6             6
-#define U300_DMA_MSL_RX_0             7
-#define U300_DMA_MSL_RX_1             8
-#define U300_DMA_MSL_RX_2             9
-#define U300_DMA_MSL_RX_3             10
-#define U300_DMA_MSL_RX_4             11
-#define U300_DMA_MSL_RX_5             12
-#define U300_DMA_MSL_RX_6             13
-#define U300_DMA_MMCSD_RX_TX          14
-#define U300_DMA_MSPRO_TX             15
-#define U300_DMA_MSPRO_RX             16
-#define U300_DMA_UART0_TX             17
-#define U300_DMA_UART0_RX             18
-#define U300_DMA_APEX_TX              19
-#define U300_DMA_APEX_RX              20
-#define U300_DMA_PCM_I2S0_TX          21
-#define U300_DMA_PCM_I2S0_RX          22
-#define U300_DMA_PCM_I2S1_TX          23
-#define U300_DMA_PCM_I2S1_RX          24
-#define U300_DMA_XGAM_CDI             25
-#define U300_DMA_XGAM_PDI             26
-#define U300_DMA_SPI_TX               27
-#define U300_DMA_SPI_RX               28
-#define U300_DMA_GENERAL_PURPOSE_0    29
-#define U300_DMA_GENERAL_PURPOSE_1    30
-#define U300_DMA_GENERAL_PURPOSE_2    31
-#define U300_DMA_GENERAL_PURPOSE_3    32
-#define U300_DMA_GENERAL_PURPOSE_4    33
-#define U300_DMA_GENERAL_PURPOSE_5    34
-#define U300_DMA_GENERAL_PURPOSE_6    35
-#define U300_DMA_GENERAL_PURPOSE_7    36
-#define U300_DMA_GENERAL_PURPOSE_8    37
-#define U300_DMA_UART1_TX             38
-#define U300_DMA_UART1_RX             39
-
-#define U300_DMA_DEVICE_CHANNELS      32
-#define U300_DMA_CHANNELS             40
-
-
-#endif /* DMA_CHANNELS_H */
diff --git a/arch/arm/mach-u300/spi.c b/arch/arm/mach-u300/spi.c
index a1affac..02e6659 100644
--- a/arch/arm/mach-u300/spi.c
+++ b/arch/arm/mach-u300/spi.c
@@ -12,7 +12,7 @@
 #include <linux/amba/pl022.h>
 #include <linux/err.h>
 #include <mach/coh901318.h>
-#include <mach/dma_channels.h>
+#include "dma_channels.h"
 
 /*
  * The following is for the actual devices on the SSP/SPI bus
-- 
1.7.11.3
