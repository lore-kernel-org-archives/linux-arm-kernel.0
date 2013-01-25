From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 Jan 2013 23:35:51 +0000
Subject: [PATCH 08/13] ARM: spear: move generic.h and pl080.h into private dir
In-Reply-To: <1359156956-32404-1-git-send-email-arnd@arndb.de>
References: <1359156956-32404-1-git-send-email-arnd@arndb.de>
Message-ID: <1359156956-32404-9-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No file outside of mach-spear includes these files any more,
so they don't have to be globally visible now.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-spear/{include/mach => }/generic.h | 0
 arch/arm/mach-spear/include/mach/hardware.h      | 1 -
 arch/arm/mach-spear/{include/plat => }/pl080.h   | 0
 arch/arm/mach-spear/platsmp.c                    | 2 +-
 arch/arm/mach-spear/restart.c                    | 2 +-
 arch/arm/mach-spear/spear1310.c                  | 2 +-
 arch/arm/mach-spear/spear1340.c                  | 2 +-
 arch/arm/mach-spear/spear13xx.c                  | 2 +-
 arch/arm/mach-spear/spear300.c                   | 2 +-
 arch/arm/mach-spear/spear310.c                   | 2 +-
 arch/arm/mach-spear/spear320.c                   | 2 +-
 arch/arm/mach-spear/spear3xx.c                   | 4 ++--
 arch/arm/mach-spear/spear6xx.c                   | 4 ++--
 arch/arm/mach-spear/time.c                       | 2 +-
 14 files changed, 13 insertions(+), 14 deletions(-)
 rename arch/arm/mach-spear/{include/mach => }/generic.h (100%)
 delete mode 100644 arch/arm/mach-spear/include/mach/hardware.h
 rename arch/arm/mach-spear/{include/plat => }/pl080.h (100%)

diff --git a/arch/arm/mach-spear/include/mach/generic.h b/arch/arm/mach-spear/generic.h
similarity index 100%
rename from arch/arm/mach-spear/include/mach/generic.h
rename to arch/arm/mach-spear/generic.h
diff --git a/arch/arm/mach-spear/include/mach/hardware.h b/arch/arm/mach-spear/include/mach/hardware.h
deleted file mode 100644
index 40a8c17..0000000
--- a/arch/arm/mach-spear/include/mach/hardware.h
+++ /dev/null
@@ -1 +0,0 @@
-/* empty */
diff --git a/arch/arm/mach-spear/include/plat/pl080.h b/arch/arm/mach-spear/pl080.h
similarity index 100%
rename from arch/arm/mach-spear/include/plat/pl080.h
rename to arch/arm/mach-spear/pl080.h
diff --git a/arch/arm/mach-spear/platsmp.c b/arch/arm/mach-spear/platsmp.c
index 2eaa3fa..a9de941 100644
--- a/arch/arm/mach-spear/platsmp.c
+++ b/arch/arm/mach-spear/platsmp.c
@@ -19,7 +19,7 @@
 #include <asm/hardware/gic.h>
 #include <asm/smp_scu.h>
 #include <mach/spear.h>
-#include <mach/generic.h>
+#include "generic.h"
 
 static DEFINE_SPINLOCK(boot_lock);
 
diff --git a/arch/arm/mach-spear/restart.c b/arch/arm/mach-spear/restart.c
index 4f99011..34f7f3d 100644
--- a/arch/arm/mach-spear/restart.c
+++ b/arch/arm/mach-spear/restart.c
@@ -14,7 +14,7 @@
 #include <asm/system_misc.h>
 #include <asm/hardware/sp810.h>
 #include <mach/spear.h>
-#include <mach/generic.h>
+#include "generic.h"
 
 #define SPEAR13XX_SYS_SW_RES			(VA_MISC_BASE + 0x204)
 void spear_restart(char mode, const char *cmd)
diff --git a/arch/arm/mach-spear/spear1310.c b/arch/arm/mach-spear/spear1310.c
index 02f4724..cddb8fe 100644
--- a/arch/arm/mach-spear/spear1310.c
+++ b/arch/arm/mach-spear/spear1310.c
@@ -19,7 +19,7 @@
 #include <asm/hardware/gic.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
-#include <mach/generic.h>
+#include "generic.h"
 #include <mach/spear.h>
 
 /* Base addresses */
diff --git a/arch/arm/mach-spear/spear1340.c b/arch/arm/mach-spear/spear1340.c
index 7a183c3..36c9638 100644
--- a/arch/arm/mach-spear/spear1340.c
+++ b/arch/arm/mach-spear/spear1340.c
@@ -20,7 +20,7 @@
 #include <linux/of_platform.h>
 #include <asm/hardware/gic.h>
 #include <asm/mach/arch.h>
-#include <mach/generic.h>
+#include "generic.h"
 #include <mach/spear.h>
 
 #include "spear13xx-dma.h"
diff --git a/arch/arm/mach-spear/spear13xx.c b/arch/arm/mach-spear/spear13xx.c
index fcf5cc2..82d53b7 100644
--- a/arch/arm/mach-spear/spear13xx.c
+++ b/arch/arm/mach-spear/spear13xx.c
@@ -22,7 +22,7 @@
 #include <asm/hardware/gic.h>
 #include <asm/mach/map.h>
 #include <asm/smp_twd.h>
-#include <mach/generic.h>
+#include "generic.h"
 #include <mach/spear.h>
 
 #include "spear13xx-dma.h"
diff --git a/arch/arm/mach-spear/spear300.c b/arch/arm/mach-spear/spear300.c
index 7a1d8d9..5ffb25f 100644
--- a/arch/arm/mach-spear/spear300.c
+++ b/arch/arm/mach-spear/spear300.c
@@ -17,7 +17,7 @@
 #include <linux/of_platform.h>
 #include <asm/hardware/vic.h>
 #include <asm/mach/arch.h>
-#include <mach/generic.h>
+#include "generic.h"
 #include <mach/spear.h>
 
 /* DMAC platform data's slave info */
diff --git a/arch/arm/mach-spear/spear310.c b/arch/arm/mach-spear/spear310.c
index ec3c631..0527816 100644
--- a/arch/arm/mach-spear/spear310.c
+++ b/arch/arm/mach-spear/spear310.c
@@ -18,7 +18,7 @@
 #include <linux/of_platform.h>
 #include <asm/hardware/vic.h>
 #include <asm/mach/arch.h>
-#include <mach/generic.h>
+#include "generic.h"
 #include <mach/spear.h>
 
 #define SPEAR310_UART1_BASE		UL(0xB2000000)
diff --git a/arch/arm/mach-spear/spear320.c b/arch/arm/mach-spear/spear320.c
index 6ccfc89..1b98989 100644
--- a/arch/arm/mach-spear/spear320.c
+++ b/arch/arm/mach-spear/spear320.c
@@ -20,7 +20,7 @@
 #include <asm/hardware/vic.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
-#include <mach/generic.h>
+#include "generic.h"
 #include <mach/spear.h>
 
 #define SPEAR320_UART1_BASE		UL(0xA3000000)
diff --git a/arch/arm/mach-spear/spear3xx.c b/arch/arm/mach-spear/spear3xx.c
index c93f38b..b502672 100644
--- a/arch/arm/mach-spear/spear3xx.c
+++ b/arch/arm/mach-spear/spear3xx.c
@@ -22,8 +22,8 @@
 #include <asm/hardware/pl080.h>
 #include <asm/hardware/vic.h>
 #include <asm/mach/map.h>
-#include <plat/pl080.h>
-#include <mach/generic.h>
+#include "pl080.h"
+#include "generic.h"
 #include <mach/spear.h>
 
 /* ssp device registration */
diff --git a/arch/arm/mach-spear/spear6xx.c b/arch/arm/mach-spear/spear6xx.c
index 42250e8..32d7d47 100644
--- a/arch/arm/mach-spear/spear6xx.c
+++ b/arch/arm/mach-spear/spear6xx.c
@@ -25,8 +25,8 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <asm/mach/map.h>
-#include <plat/pl080.h>
-#include <mach/generic.h>
+#include "pl080.h"
+#include "generic.h"
 #include <mach/spear.h>
 
 /* dmac device registration */
diff --git a/arch/arm/mach-spear/time.c b/arch/arm/mach-spear/time.c
index 03321af..d7bfc89 100644
--- a/arch/arm/mach-spear/time.c
+++ b/arch/arm/mach-spear/time.c
@@ -23,7 +23,7 @@
 #include <linux/time.h>
 #include <linux/irq.h>
 #include <asm/mach/time.h>
-#include <mach/generic.h>
+#include "generic.h"
 
 /*
  * We would use TIMER0 and TIMER1 as clockevent and clocksource.
-- 
1.8.0
