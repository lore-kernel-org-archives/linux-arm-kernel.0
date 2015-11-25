From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Nov 2015 17:32:22 +0100
Subject: [PATCH 09/10] ARM: realview: make all header files local
In-Reply-To: <1448469143-447355-1-git-send-email-arnd@arndb.de>
References: <1448469143-447355-1-git-send-email-arnd@arndb.de>
Message-ID: <1448469143-447355-10-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nothing includes these files any more, so we can simply move them
from arch/arm/mach-realview/include/mach/ to arch/arm/mach-realview.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-realview/{include/mach => }/board-eb.h     |  2 +-
 arch/arm/mach-realview/{include/mach => }/board-pb1176.h |  2 +-
 arch/arm/mach-realview/{include/mach => }/board-pb11mp.h |  2 +-
 arch/arm/mach-realview/{include/mach => }/board-pba8.h   |  2 +-
 arch/arm/mach-realview/{include/mach => }/board-pbx.h    |  2 +-
 arch/arm/mach-realview/core.c                            |  7 +++----
 arch/arm/mach-realview/{include/mach => }/hardware.h     |  0
 arch/arm/mach-realview/{include/mach => }/irqs-eb.h      |  0
 arch/arm/mach-realview/{include/mach => }/irqs-pb1176.h  |  0
 arch/arm/mach-realview/{include/mach => }/irqs-pb11mp.h  |  0
 arch/arm/mach-realview/{include/mach => }/irqs-pba8.h    |  0
 arch/arm/mach-realview/{include/mach => }/irqs-pbx.h     |  0
 arch/arm/mach-realview/{include/mach => }/irqs.h         | 10 +++++-----
 arch/arm/mach-realview/{include/mach => }/platform.h     |  0
 arch/arm/mach-realview/platsmp.c                         |  8 ++++----
 arch/arm/mach-realview/realview_eb.c                     |  6 +++---
 arch/arm/mach-realview/realview_pb1176.c                 |  6 +++---
 arch/arm/mach-realview/realview_pb11mp.c                 |  6 +++---
 arch/arm/mach-realview/realview_pba8.c                   |  6 +++---
 arch/arm/mach-realview/realview_pbx.c                    |  6 +++---
 arch/arm/mach-realview/{include/mach => }/uncompress.h   | 12 ++++++------
 21 files changed, 38 insertions(+), 39 deletions(-)
 rename arch/arm/mach-realview/{include/mach => }/board-eb.h (99%)
 rename arch/arm/mach-realview/{include/mach => }/board-pb1176.h (99%)
 rename arch/arm/mach-realview/{include/mach => }/board-pb11mp.h (99%)
 rename arch/arm/mach-realview/{include/mach => }/board-pba8.h (99%)
 rename arch/arm/mach-realview/{include/mach => }/board-pbx.h (99%)
 rename arch/arm/mach-realview/{include/mach => }/hardware.h (100%)
 rename arch/arm/mach-realview/{include/mach => }/irqs-eb.h (100%)
 rename arch/arm/mach-realview/{include/mach => }/irqs-pb1176.h (100%)
 rename arch/arm/mach-realview/{include/mach => }/irqs-pb11mp.h (100%)
 rename arch/arm/mach-realview/{include/mach => }/irqs-pba8.h (100%)
 rename arch/arm/mach-realview/{include/mach => }/irqs-pbx.h (100%)
 rename arch/arm/mach-realview/{include/mach => }/irqs.h (88%)
 rename arch/arm/mach-realview/{include/mach => }/platform.h (100%)
 rename arch/arm/mach-realview/{include/mach => }/uncompress.h (91%)

diff --git a/arch/arm/mach-realview/include/mach/board-eb.h b/arch/arm/mach-realview/board-eb.h
similarity index 99%
rename from arch/arm/mach-realview/include/mach/board-eb.h
rename to arch/arm/mach-realview/board-eb.h
index a301e61a5554..ac9c98f9a971 100644
--- a/arch/arm/mach-realview/include/mach/board-eb.h
+++ b/arch/arm/mach-realview/board-eb.h
@@ -21,7 +21,7 @@
 #ifndef __ASM_ARCH_BOARD_EB_H
 #define __ASM_ARCH_BOARD_EB_H
 
-#include <mach/platform.h>
+#include "platform.h"
 
 /*
  * RealView EB + ARM11MPCore peripheral addresses
diff --git a/arch/arm/mach-realview/include/mach/board-pb1176.h b/arch/arm/mach-realview/board-pb1176.h
similarity index 99%
rename from arch/arm/mach-realview/include/mach/board-pb1176.h
rename to arch/arm/mach-realview/board-pb1176.h
index 2a15fef94730..836433dc789c 100644
--- a/arch/arm/mach-realview/include/mach/board-pb1176.h
+++ b/arch/arm/mach-realview/board-pb1176.h
@@ -21,7 +21,7 @@
 #ifndef __ASM_ARCH_BOARD_PB1176_H
 #define __ASM_ARCH_BOARD_PB1176_H
 
-#include <mach/platform.h>
+#include "platform.h"
 
 /*
  * Peripheral addresses
diff --git a/arch/arm/mach-realview/include/mach/board-pb11mp.h b/arch/arm/mach-realview/board-pb11mp.h
similarity index 99%
rename from arch/arm/mach-realview/include/mach/board-pb11mp.h
rename to arch/arm/mach-realview/board-pb11mp.h
index aa2d4e02ea2c..e3a758b147ab 100644
--- a/arch/arm/mach-realview/include/mach/board-pb11mp.h
+++ b/arch/arm/mach-realview/board-pb11mp.h
@@ -21,7 +21,7 @@
 #ifndef __ASM_ARCH_BOARD_PB11MP_H
 #define __ASM_ARCH_BOARD_PB11MP_H
 
-#include <mach/platform.h>
+#include "platform.h"
 
 /*
  * Peripheral addresses
diff --git a/arch/arm/mach-realview/include/mach/board-pba8.h b/arch/arm/mach-realview/board-pba8.h
similarity index 99%
rename from arch/arm/mach-realview/include/mach/board-pba8.h
rename to arch/arm/mach-realview/board-pba8.h
index 4dfc67a4f45f..84232fe942d2 100644
--- a/arch/arm/mach-realview/include/mach/board-pba8.h
+++ b/arch/arm/mach-realview/board-pba8.h
@@ -21,7 +21,7 @@
 #ifndef __ASM_ARCH_BOARD_PBA8_H
 #define __ASM_ARCH_BOARD_PBA8_H
 
-#include <mach/platform.h>
+#include "platform.h"
 
 /*
  * Peripheral addresses
diff --git a/arch/arm/mach-realview/include/mach/board-pbx.h b/arch/arm/mach-realview/board-pbx.h
similarity index 99%
rename from arch/arm/mach-realview/include/mach/board-pbx.h
rename to arch/arm/mach-realview/board-pbx.h
index 848bfff6d8f1..3dab54fa9e97 100644
--- a/arch/arm/mach-realview/include/mach/board-pbx.h
+++ b/arch/arm/mach-realview/board-pbx.h
@@ -20,7 +20,7 @@
 #ifndef __ASM_ARCH_BOARD_PBX_H
 #define __ASM_ARCH_BOARD_PBX_H
 
-#include <mach/platform.h>
+#include "platform.h"
 
 /*
  * Peripheral addresses
diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index 44575edc44b1..7cd543b1eace 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -36,8 +36,7 @@
 #include <linux/memblock.h>
 
 #include <clocksource/timer-sp804.h>
-
-#include <mach/hardware.h>
+#include "hardware.h"
 #include <asm/irq.h>
 #include <asm/mach-types.h>
 #include <asm/hardware/icst.h>
@@ -46,8 +45,8 @@
 #include <asm/mach/irq.h>
 #include <asm/mach/map.h>
 
-#include <mach/platform.h>
-#include <mach/irqs.h>
+#include "platform.h"
+#include "irqs.h"
 
 #include <plat/sched_clock.h>
 
diff --git a/arch/arm/mach-realview/include/mach/hardware.h b/arch/arm/mach-realview/hardware.h
similarity index 100%
rename from arch/arm/mach-realview/include/mach/hardware.h
rename to arch/arm/mach-realview/hardware.h
diff --git a/arch/arm/mach-realview/include/mach/irqs-eb.h b/arch/arm/mach-realview/irqs-eb.h
similarity index 100%
rename from arch/arm/mach-realview/include/mach/irqs-eb.h
rename to arch/arm/mach-realview/irqs-eb.h
diff --git a/arch/arm/mach-realview/include/mach/irqs-pb1176.h b/arch/arm/mach-realview/irqs-pb1176.h
similarity index 100%
rename from arch/arm/mach-realview/include/mach/irqs-pb1176.h
rename to arch/arm/mach-realview/irqs-pb1176.h
diff --git a/arch/arm/mach-realview/include/mach/irqs-pb11mp.h b/arch/arm/mach-realview/irqs-pb11mp.h
similarity index 100%
rename from arch/arm/mach-realview/include/mach/irqs-pb11mp.h
rename to arch/arm/mach-realview/irqs-pb11mp.h
diff --git a/arch/arm/mach-realview/include/mach/irqs-pba8.h b/arch/arm/mach-realview/irqs-pba8.h
similarity index 100%
rename from arch/arm/mach-realview/include/mach/irqs-pba8.h
rename to arch/arm/mach-realview/irqs-pba8.h
diff --git a/arch/arm/mach-realview/include/mach/irqs-pbx.h b/arch/arm/mach-realview/irqs-pbx.h
similarity index 100%
rename from arch/arm/mach-realview/include/mach/irqs-pbx.h
rename to arch/arm/mach-realview/irqs-pbx.h
diff --git a/arch/arm/mach-realview/include/mach/irqs.h b/arch/arm/mach-realview/irqs.h
similarity index 88%
rename from arch/arm/mach-realview/include/mach/irqs.h
rename to arch/arm/mach-realview/irqs.h
index 78854f2fa323..1bd8a9a00337 100644
--- a/arch/arm/mach-realview/include/mach/irqs.h
+++ b/arch/arm/mach-realview/irqs.h
@@ -22,11 +22,11 @@
 #ifndef __ASM_ARCH_IRQS_H
 #define __ASM_ARCH_IRQS_H
 
-#include <mach/irqs-eb.h>
-#include <mach/irqs-pb11mp.h>
-#include <mach/irqs-pb1176.h>
-#include <mach/irqs-pba8.h>
-#include <mach/irqs-pbx.h>
+#include "irqs-eb.h"
+#include "irqs-pb11mp.h"
+#include "irqs-pb1176.h"
+#include "irqs-pba8.h"
+#include "irqs-pbx.h"
 
 #define IRQ_LOCALTIMER		29
 #define IRQ_LOCALWDOG		30
diff --git a/arch/arm/mach-realview/include/mach/platform.h b/arch/arm/mach-realview/platform.h
similarity index 100%
rename from arch/arm/mach-realview/include/mach/platform.h
rename to arch/arm/mach-realview/platform.h
diff --git a/arch/arm/mach-realview/platsmp.c b/arch/arm/mach-realview/platsmp.c
index 98e3052b7933..a2331b36ccce 100644
--- a/arch/arm/mach-realview/platsmp.c
+++ b/arch/arm/mach-realview/platsmp.c
@@ -13,13 +13,13 @@
 #include <linux/smp.h>
 #include <linux/io.h>
 
-#include <mach/hardware.h>
+#include "hardware.h"
 #include <asm/mach-types.h>
 #include <asm/smp_scu.h>
 
-#include <mach/board-eb.h>
-#include <mach/board-pb11mp.h>
-#include <mach/board-pbx.h>
+#include "board-eb.h"
+#include "board-pb11mp.h"
+#include "board-pbx.h"
 
 #include <plat/platsmp.h>
 
diff --git a/arch/arm/mach-realview/realview_eb.c b/arch/arm/mach-realview/realview_eb.c
index 4d29535abeba..8059fee79974 100644
--- a/arch/arm/mach-realview/realview_eb.c
+++ b/arch/arm/mach-realview/realview_eb.c
@@ -31,7 +31,7 @@
 #include <linux/platform_data/clk-realview.h>
 #include <linux/reboot.h>
 
-#include <mach/hardware.h>
+#include "hardware.h"
 #include <asm/irq.h>
 #include <asm/mach-types.h>
 #include <asm/pgtable.h>
@@ -43,8 +43,8 @@
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
 
-#include <mach/board-eb.h>
-#include <mach/irqs.h>
+#include "board-eb.h"
+#include "irqs.h"
 
 #include "core.h"
 
diff --git a/arch/arm/mach-realview/realview_pb1176.c b/arch/arm/mach-realview/realview_pb1176.c
index ce92c1823494..e5fd1ce9051f 100644
--- a/arch/arm/mach-realview/realview_pb1176.c
+++ b/arch/arm/mach-realview/realview_pb1176.c
@@ -34,7 +34,7 @@
 #include <linux/reboot.h>
 #include <linux/memblock.h>
 
-#include <mach/hardware.h>
+#include "hardware.h"
 #include <asm/irq.h>
 #include <asm/mach-types.h>
 #include <asm/pgtable.h>
@@ -45,8 +45,8 @@
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
 
-#include <mach/board-pb1176.h>
-#include <mach/irqs.h>
+#include "board-pb1176.h"
+#include "irqs.h"
 
 #include "core.h"
 
diff --git a/arch/arm/mach-realview/realview_pb11mp.c b/arch/arm/mach-realview/realview_pb11mp.c
index f9817bb5d8fa..10b16961f7e1 100644
--- a/arch/arm/mach-realview/realview_pb11mp.c
+++ b/arch/arm/mach-realview/realview_pb11mp.c
@@ -31,7 +31,7 @@
 #include <linux/platform_data/clk-realview.h>
 #include <linux/reboot.h>
 
-#include <mach/hardware.h>
+#include "hardware.h"
 #include <asm/irq.h>
 #include <asm/mach-types.h>
 #include <asm/pgtable.h>
@@ -43,8 +43,8 @@
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
 
-#include <mach/board-pb11mp.h>
-#include <mach/irqs.h>
+#include "board-pb11mp.h"
+#include "irqs.h"
 
 #include "core.h"
 
diff --git a/arch/arm/mach-realview/realview_pba8.c b/arch/arm/mach-realview/realview_pba8.c
index b3549a637ff0..263e37391445 100644
--- a/arch/arm/mach-realview/realview_pba8.c
+++ b/arch/arm/mach-realview/realview_pba8.c
@@ -39,9 +39,9 @@
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
 
-#include <mach/hardware.h>
-#include <mach/board-pba8.h>
-#include <mach/irqs.h>
+#include "hardware.h"
+#include "board-pba8.h"
+#include "irqs.h"
 
 #include "core.h"
 
diff --git a/arch/arm/mach-realview/realview_pbx.c b/arch/arm/mach-realview/realview_pbx.c
index f26e1e09f29e..810b15410bf2 100644
--- a/arch/arm/mach-realview/realview_pbx.c
+++ b/arch/arm/mach-realview/realview_pbx.c
@@ -41,9 +41,9 @@
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
 
-#include <mach/hardware.h>
-#include <mach/board-pbx.h>
-#include <mach/irqs.h>
+#include "hardware.h"
+#include "board-pbx.h"
+#include "irqs.h"
 
 #include "core.h"
 
diff --git a/arch/arm/mach-realview/include/mach/uncompress.h b/arch/arm/mach-realview/uncompress.h
similarity index 91%
rename from arch/arm/mach-realview/include/mach/uncompress.h
rename to arch/arm/mach-realview/uncompress.h
index cfa30d21783b..f8ac3e723628 100644
--- a/arch/arm/mach-realview/include/mach/uncompress.h
+++ b/arch/arm/mach-realview/uncompress.h
@@ -17,14 +17,14 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
-#include <mach/hardware.h>
+#include "hardware.h"
 #include <asm/mach-types.h>
 
-#include <mach/board-eb.h>
-#include <mach/board-pb11mp.h>
-#include <mach/board-pb1176.h>
-#include <mach/board-pba8.h>
-#include <mach/board-pbx.h>
+#include "board-eb.h"
+#include "board-pb11mp.h"
+#include "board-pb1176.h"
+#include "board-pba8.h"
+#include "board-pbx.h"
 
 #define AMBA_UART_DR(base)	(*(volatile unsigned char *)((base) + 0x00))
 #define AMBA_UART_LCRH(base)	(*(volatile unsigned char *)((base) + 0x2c))
-- 
2.1.0.rc2
