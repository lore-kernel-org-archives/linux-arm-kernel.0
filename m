From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 20 Jun 2014 18:53:08 +0200
Subject: [PATCH 8/9] ARM: shmobile: Move sh7372.h
In-Reply-To: <1403283189-21688-1-git-send-email-geert+renesas@glider.be>
References: <1403283189-21688-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1403283189-21688-9-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change location of sh7372.h so it can be included as "sh7372.h"
instead of the old style <mach/sh7372.h>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/board-mackerel.c            | 4 +++-
 arch/arm/mach-shmobile/pm-sh7372.c                 | 4 +++-
 arch/arm/mach-shmobile/setup-sh7372.c              | 4 +++-
 arch/arm/mach-shmobile/{include/mach => }/sh7372.h | 0
 4 files changed, 9 insertions(+), 3 deletions(-)
 rename arch/arm/mach-shmobile/{include/mach => }/sh7372.h (100%)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 0ece865cbc4d..304b76f3bf4a 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -51,6 +51,7 @@
 #include <linux/tca6416_keypad.h>
 #include <linux/usb/renesas_usbhs.h>
 #include <linux/dma-mapping.h>
+
 #include <video/sh_mobile_hdmi.h>
 #include <video/sh_mobile_lcdc.h>
 #include <media/sh_mobile_ceu.h>
@@ -58,13 +59,14 @@
 #include <media/soc_camera_platform.h>
 #include <sound/sh_fsi.h>
 #include <sound/simple_card.h>
-#include <mach/sh7372.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
+
 #include "common.h"
 #include "irqs.h"
 #include "pm-rmobile.h"
 #include "sh-gpio.h"
+#include "sh7372.h"
 
 /*
  * Address	Interface		BusWidth	note
diff --git a/arch/arm/mach-shmobile/pm-sh7372.c b/arch/arm/mach-shmobile/pm-sh7372.c
index 7ef9a0126780..7e5c2676c489 100644
--- a/arch/arm/mach-shmobile/pm-sh7372.c
+++ b/arch/arm/mach-shmobile/pm-sh7372.c
@@ -21,13 +21,15 @@
 #include <linux/irq.h>
 #include <linux/bitrev.h>
 #include <linux/console.h>
+
 #include <asm/cpuidle.h>
 #include <asm/io.h>
 #include <asm/tlbflush.h>
 #include <asm/suspend.h>
-#include <mach/sh7372.h>
+
 #include "common.h"
 #include "pm-rmobile.h"
+#include "sh7372.h"
 
 /* DBG */
 #define DBGREG1 IOMEM(0xe6100020)
diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
index 5571f867c611..9cdfcdfd38fc 100644
--- a/arch/arm/mach-shmobile/setup-sh7372.c
+++ b/arch/arm/mach-shmobile/setup-sh7372.c
@@ -33,15 +33,17 @@
 #include <linux/pm_domain.h>
 #include <linux/dma-mapping.h>
 #include <linux/platform_data/sh_ipmmu.h>
-#include <mach/sh7372.h>
+
 #include <asm/mach/map.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
+
 #include "common.h"
 #include "dma-register.h"
 #include "irqs.h"
 #include "pm-rmobile.h"
+#include "sh7372.h"
 
 static struct map_desc sh7372_io_desc[] __initdata = {
 	/* create a 1:1 entity map for 0xe6xxxxxx
diff --git a/arch/arm/mach-shmobile/include/mach/sh7372.h b/arch/arm/mach-shmobile/sh7372.h
similarity index 100%
rename from arch/arm/mach-shmobile/include/mach/sh7372.h
rename to arch/arm/mach-shmobile/sh7372.h
-- 
1.9.1
