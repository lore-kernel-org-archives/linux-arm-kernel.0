From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 5 Apr 2013 16:22:54 +0200
Subject: [PATCH 12/14] ARM: ux500: make remaining headers local
In-Reply-To: <1365171776-8463-1-git-send-email-linus.walleij@stericsson.com>
References: <1365171776-8463-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1365171776-8463-13-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

mach/setup.h and mach/devices.h are only needed from inside of mach-ux500
now, so we can simply move them out of the include/mach directory.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-audio.c         | 2 +-
 arch/arm/mach-ux500/board-mop500-sdi.c           | 2 +-
 arch/arm/mach-ux500/board-mop500.c               | 4 ++--
 arch/arm/mach-ux500/cpu-db8500.c                 | 4 ++--
 arch/arm/mach-ux500/cpu.c                        | 4 ++--
 arch/arm/mach-ux500/devices-db8500.c             | 2 +-
 arch/arm/mach-ux500/devices.c                    | 2 +-
 arch/arm/mach-ux500/{include/mach => }/devices.h | 0
 arch/arm/mach-ux500/hotplug.c                    | 2 +-
 arch/arm/mach-ux500/id.c                         | 2 +-
 arch/arm/mach-ux500/platsmp.c                    | 2 +-
 arch/arm/mach-ux500/{include/mach => }/setup.h   | 0
 arch/arm/mach-ux500/timer.c                      | 2 +-
 drivers/clocksource/clksrc-dbx500-prcmu.c        | 2 --
 14 files changed, 14 insertions(+), 16 deletions(-)
 rename arch/arm/mach-ux500/{include/mach => }/devices.h (100%)
 rename arch/arm/mach-ux500/{include/mach => }/setup.h (100%)

diff --git a/arch/arm/mach-ux500/board-mop500-audio.c b/arch/arm/mach-ux500/board-mop500-audio.c
index def0637..aba9e56 100644
--- a/arch/arm/mach-ux500/board-mop500-audio.c
+++ b/arch/arm/mach-ux500/board-mop500-audio.c
@@ -10,7 +10,7 @@
 #include <linux/platform_data/pinctrl-nomadik.h>
 #include <linux/platform_data/dma-ste-dma40.h>
 
-#include <mach/devices.h>
+#include "devices.h"
 #include "irqs.h"
 #include <linux/platform_data/asoc-ux500-msp.h>
 
diff --git a/arch/arm/mach-ux500/board-mop500-sdi.c b/arch/arm/mach-ux500/board-mop500-sdi.c
index 0ada767..f76be4a 100644
--- a/arch/arm/mach-ux500/board-mop500-sdi.c
+++ b/arch/arm/mach-ux500/board-mop500-sdi.c
@@ -14,7 +14,7 @@
 #include <linux/platform_data/dma-ste-dma40.h>
 
 #include <asm/mach-types.h>
-#include <mach/devices.h>
+#include "devices.h"
 
 #include "db8500-regs.h"
 #include "devices-db8500.h"
diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 6e8ee11..0d59e1a 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -41,8 +41,8 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-#include <mach/setup.h>
-#include <mach/devices.h>
+#include "setup.h"
+#include "devices.h"
 #include "irqs.h"
 #include <linux/platform_data/crypto-ux500.h>
 
diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index e11f87d..7a66a81 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -28,8 +28,8 @@
 #include <asm/mach/map.h>
 #include <asm/mach/arch.h>
 
-#include <mach/setup.h>
-#include <mach/devices.h>
+#include "setup.h"
+#include "devices.h"
 #include "irqs.h"
 
 #include "devices-db8500.h"
diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index aa14c5f..915e263 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -24,8 +24,8 @@
 
 #include <asm/mach/map.h>
 
-#include <mach/setup.h>
-#include <mach/devices.h>
+#include "setup.h"
+#include "devices.h"
 
 #include "board-mop500.h"
 #include "db8500-regs.h"
diff --git a/arch/arm/mach-ux500/devices-db8500.c b/arch/arm/mach-ux500/devices-db8500.c
index 45ec955..1cf94ce 100644
--- a/arch/arm/mach-ux500/devices-db8500.c
+++ b/arch/arm/mach-ux500/devices-db8500.c
@@ -15,7 +15,7 @@
 #include <linux/platform_data/dma-ste-dma40.h>
 #include <linux/mfd/dbx500-prcmu.h>
 
-#include <mach/setup.h>
+#include "setup.h"
 #include "irqs.h"
 
 #include "db8500-regs.h"
diff --git a/arch/arm/mach-ux500/devices.c b/arch/arm/mach-ux500/devices.c
index f63a512..0f9e52b 100644
--- a/arch/arm/mach-ux500/devices.c
+++ b/arch/arm/mach-ux500/devices.c
@@ -11,7 +11,7 @@
 #include <linux/io.h>
 #include <linux/amba/bus.h>
 
-#include <mach/setup.h>
+#include "setup.h"
 
 #include "db8500-regs.h"
 
diff --git a/arch/arm/mach-ux500/include/mach/devices.h b/arch/arm/mach-ux500/devices.h
similarity index 100%
rename from arch/arm/mach-ux500/include/mach/devices.h
rename to arch/arm/mach-ux500/devices.h
diff --git a/arch/arm/mach-ux500/hotplug.c b/arch/arm/mach-ux500/hotplug.c
index 2f6af25..87abcf2 100644
--- a/arch/arm/mach-ux500/hotplug.c
+++ b/arch/arm/mach-ux500/hotplug.c
@@ -15,7 +15,7 @@
 #include <asm/cacheflush.h>
 #include <asm/smp_plat.h>
 
-#include <mach/setup.h>
+#include "setup.h"
 
 /*
  * platform-specific code to shutdown a CPU
diff --git a/arch/arm/mach-ux500/id.c b/arch/arm/mach-ux500/id.c
index a847cf2..0d33d1a 100644
--- a/arch/arm/mach-ux500/id.c
+++ b/arch/arm/mach-ux500/id.c
@@ -14,7 +14,7 @@
 #include <asm/cacheflush.h>
 #include <asm/mach/map.h>
 
-#include <mach/setup.h>
+#include "setup.h"
 
 #include "db8500-regs.h"
 #include "id.h"
diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
index 8a9c070..12ad8ad 100644
--- a/arch/arm/mach-ux500/platsmp.c
+++ b/arch/arm/mach-ux500/platsmp.c
@@ -22,7 +22,7 @@
 #include <asm/smp_plat.h>
 #include <asm/smp_scu.h>
 
-#include <mach/setup.h>
+#include "setup.h"
 
 #include "db8500-regs.h"
 #include "id.h"
diff --git a/arch/arm/mach-ux500/include/mach/setup.h b/arch/arm/mach-ux500/setup.h
similarity index 100%
rename from arch/arm/mach-ux500/include/mach/setup.h
rename to arch/arm/mach-ux500/setup.h
diff --git a/arch/arm/mach-ux500/timer.c b/arch/arm/mach-ux500/timer.c
index 2dbbaef..290b9c5 100644
--- a/arch/arm/mach-ux500/timer.c
+++ b/arch/arm/mach-ux500/timer.c
@@ -13,7 +13,7 @@
 
 #include <asm/smp_twd.h>
 
-#include <mach/setup.h>
+#include "setup.h"
 #include "irqs.h"
 
 #include "db8500-regs.h"
diff --git a/drivers/clocksource/clksrc-dbx500-prcmu.c b/drivers/clocksource/clksrc-dbx500-prcmu.c
index 4f34093..54f3d11 100644
--- a/drivers/clocksource/clksrc-dbx500-prcmu.c
+++ b/drivers/clocksource/clksrc-dbx500-prcmu.c
@@ -17,8 +17,6 @@
 
 #include <asm/sched_clock.h>
 
-#include <mach/setup.h>
-
 #define RATE_32K		32768
 
 #define TIMER_MODE_CONTINOUS	0x1
-- 
1.7.11.3
