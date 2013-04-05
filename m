From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 5 Apr 2013 16:22:53 +0200
Subject: [PATCH 11/14] ARM: ux500: make irqs.h local to platform
In-Reply-To: <1365171776-8463-1-git-send-email-linus.walleij@stericsson.com>
References: <1365171776-8463-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1365171776-8463-12-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

With the PRCMU out of the way, nothing outside of mach-ux500
uses mach/irqs.h any more, so we can make it a local header file,
including the two sub-headers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-audio.c                   | 2 +-
 arch/arm/mach-ux500/board-mop500-u8500uib.c                | 2 +-
 arch/arm/mach-ux500/board-mop500.c                         | 2 +-
 arch/arm/mach-ux500/board-mop500.h                         | 2 +-
 arch/arm/mach-ux500/cpu-db8500.c                           | 2 +-
 arch/arm/mach-ux500/devices-common.c                       | 2 +-
 arch/arm/mach-ux500/devices-db8500.c                       | 2 +-
 arch/arm/mach-ux500/devices-db8500.h                       | 2 +-
 arch/arm/mach-ux500/{include/mach => }/irqs-board-mop500.h | 0
 arch/arm/mach-ux500/{include/mach => }/irqs-db8500.h       | 0
 arch/arm/mach-ux500/{include/mach => }/irqs.h              | 4 ++--
 arch/arm/mach-ux500/timer.c                                | 2 +-
 12 files changed, 11 insertions(+), 11 deletions(-)
 rename arch/arm/mach-ux500/{include/mach => }/irqs-board-mop500.h (100%)
 rename arch/arm/mach-ux500/{include/mach => }/irqs-db8500.h (100%)
 rename arch/arm/mach-ux500/{include/mach => }/irqs.h (95%)

diff --git a/arch/arm/mach-ux500/board-mop500-audio.c b/arch/arm/mach-ux500/board-mop500-audio.c
index 96e62ef..def0637 100644
--- a/arch/arm/mach-ux500/board-mop500-audio.c
+++ b/arch/arm/mach-ux500/board-mop500-audio.c
@@ -11,7 +11,7 @@
 #include <linux/platform_data/dma-ste-dma40.h>
 
 #include <mach/devices.h>
-#include <mach/irqs.h>
+#include "irqs.h"
 #include <linux/platform_data/asoc-ux500-msp.h>
 
 #include "ste-dma40-db8500.h"
diff --git a/arch/arm/mach-ux500/board-mop500-u8500uib.c b/arch/arm/mach-ux500/board-mop500-u8500uib.c
index 0b5e14a..d397c19 100644
--- a/arch/arm/mach-ux500/board-mop500-u8500uib.c
+++ b/arch/arm/mach-ux500/board-mop500-u8500uib.c
@@ -12,7 +12,7 @@
 #include <linux/mfd/tc3589x.h>
 #include <linux/input/matrix_keypad.h>
 
-#include <mach/irqs.h>
+#include "irqs.h"
 
 #include "board-mop500.h"
 
diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index e1b38ef..6e8ee11 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -43,7 +43,7 @@
 
 #include <mach/setup.h>
 #include <mach/devices.h>
-#include <mach/irqs.h>
+#include "irqs.h"
 #include <linux/platform_data/crypto-ux500.h>
 
 #include "ste-dma40-db8500.h"
diff --git a/arch/arm/mach-ux500/board-mop500.h b/arch/arm/mach-ux500/board-mop500.h
index eb81caf1..16bf1ac 100644
--- a/arch/arm/mach-ux500/board-mop500.h
+++ b/arch/arm/mach-ux500/board-mop500.h
@@ -8,7 +8,7 @@
 #define __BOARD_MOP500_H
 
 /* For NOMADIK_NR_GPIO */
-#include <mach/irqs.h>
+#include "irqs.h"
 #include <linux/platform_data/asoc-ux500-msp.h>
 #include <linux/amba/mmci.h>
 
diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index d726c06..e11f87d 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -30,7 +30,7 @@
 
 #include <mach/setup.h>
 #include <mach/devices.h>
-#include <mach/irqs.h>
+#include "irqs.h"
 
 #include "devices-db8500.h"
 #include "ste-dma40-db8500.h"
diff --git a/arch/arm/mach-ux500/devices-common.c b/arch/arm/mach-ux500/devices-common.c
index 94868b7..f71b3d7 100644
--- a/arch/arm/mach-ux500/devices-common.c
+++ b/arch/arm/mach-ux500/devices-common.c
@@ -13,7 +13,7 @@
 #include <linux/platform_device.h>
 #include <linux/platform_data/pinctrl-nomadik.h>
 
-#include <mach/irqs.h>
+#include "irqs.h"
 
 #include "devices-common.h"
 
diff --git a/arch/arm/mach-ux500/devices-db8500.c b/arch/arm/mach-ux500/devices-db8500.c
index 4c0ef14..45ec955 100644
--- a/arch/arm/mach-ux500/devices-db8500.c
+++ b/arch/arm/mach-ux500/devices-db8500.c
@@ -16,7 +16,7 @@
 #include <linux/mfd/dbx500-prcmu.h>
 
 #include <mach/setup.h>
-#include <mach/irqs.h>
+#include "irqs.h"
 
 #include "db8500-regs.h"
 #include "devices-db8500.h"
diff --git a/arch/arm/mach-ux500/devices-db8500.h b/arch/arm/mach-ux500/devices-db8500.h
index c9db210..3219983 100644
--- a/arch/arm/mach-ux500/devices-db8500.h
+++ b/arch/arm/mach-ux500/devices-db8500.h
@@ -9,7 +9,7 @@
 #define __DEVICES_DB8500_H
 
 #include <linux/platform_data/usb-musb-ux500.h>
-#include <mach/irqs.h>
+#include "irqs.h"
 #include "db8500-regs.h"
 #include "devices-common.h"
 
diff --git a/arch/arm/mach-ux500/include/mach/irqs-board-mop500.h b/arch/arm/mach-ux500/irqs-board-mop500.h
similarity index 100%
rename from arch/arm/mach-ux500/include/mach/irqs-board-mop500.h
rename to arch/arm/mach-ux500/irqs-board-mop500.h
diff --git a/arch/arm/mach-ux500/include/mach/irqs-db8500.h b/arch/arm/mach-ux500/irqs-db8500.h
similarity index 100%
rename from arch/arm/mach-ux500/include/mach/irqs-db8500.h
rename to arch/arm/mach-ux500/irqs-db8500.h
diff --git a/arch/arm/mach-ux500/include/mach/irqs.h b/arch/arm/mach-ux500/irqs.h
similarity index 95%
rename from arch/arm/mach-ux500/include/mach/irqs.h
rename to arch/arm/mach-ux500/irqs.h
index 829947d..15b2af6 100644
--- a/arch/arm/mach-ux500/include/mach/irqs.h
+++ b/arch/arm/mach-ux500/irqs.h
@@ -34,14 +34,14 @@
 /* This will be overridden by SoC-specific irq headers */
 #define IRQ_SOC_END		IRQ_SOC_START
 
-#include <mach/irqs-db8500.h>
+#include "irqs-db8500.h"
 
 #define IRQ_BOARD_START		IRQ_SOC_END
 /* This will be overridden by board-specific irq headers */
 #define IRQ_BOARD_END		IRQ_BOARD_START
 
 #ifdef CONFIG_MACH_MOP500
-#include <mach/irqs-board-mop500.h>
+#include "irqs-board-mop500.h"
 #endif
 
 #define UX500_NR_IRQS		IRQ_BOARD_END
diff --git a/arch/arm/mach-ux500/timer.c b/arch/arm/mach-ux500/timer.c
index 5b91fac..2dbbaef 100644
--- a/arch/arm/mach-ux500/timer.c
+++ b/arch/arm/mach-ux500/timer.c
@@ -14,7 +14,7 @@
 #include <asm/smp_twd.h>
 
 #include <mach/setup.h>
-#include <mach/irqs.h>
+#include "irqs.h"
 
 #include "db8500-regs.h"
 #include "id.h"
-- 
1.7.11.3
