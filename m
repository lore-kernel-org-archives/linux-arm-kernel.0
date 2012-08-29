From: robherring2@gmail.com (Rob Herring)
Date: Wed, 29 Aug 2012 17:31:35 -0500
Subject: [PATCH 09/10] ARM: omap1: add explict mach/gpio.h includes
In-Reply-To: <1346279496-26286-1-git-send-email-robherring2@gmail.com>
References: <1346279496-26286-1-git-send-email-robherring2@gmail.com>
Message-ID: <1346279496-26286-10-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

In preparation to remove implicit inclusion of mach/gpio.h, add explict
include of mach/gpio.h.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/board-ams-delta.c |    1 +
 arch/arm/mach-omap1/board-osk.c       |    1 +
 arch/arm/mach-omap1/gpio15xx.c        |    1 +
 arch/arm/mach-omap1/gpio16xx.c        |    1 +
 arch/arm/mach-omap1/gpio7xx.c         |    1 +
 arch/arm/mach-omap1/leds-h2p2-debug.c |    1 +
 arch/arm/mach-omap1/leds.c            |    1 +
 7 files changed, 7 insertions(+)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index c534698..ad80fd0 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -39,6 +39,7 @@
 #include <plat/mux.h>
 #include <plat/board.h>
 
+#include <mach/gpio.h>
 #include <mach/hardware.h>
 #include <mach/ams-delta-fiq.h>
 #include <mach/camera.h>
diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index 8784705..5cbb780 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -48,6 +48,7 @@
 #include <plat/mux.h>
 #include <plat/tc.h>
 
+#include <mach/gpio.h>
 #include <mach/hardware.h>
 #include <mach/usb.h>
 
diff --git a/arch/arm/mach-omap1/gpio15xx.c b/arch/arm/mach-omap1/gpio15xx.c
index ebef15e..c54efb4 100644
--- a/arch/arm/mach-omap1/gpio15xx.c
+++ b/arch/arm/mach-omap1/gpio15xx.c
@@ -17,6 +17,7 @@
  */
 
 #include <linux/gpio.h>
+#include <mach/gpio.h>
 
 #define OMAP1_MPUIO_VBASE		OMAP1_MPUIO_BASE
 #define OMAP1510_GPIO_BASE		0xFFFCE000
diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gpio16xx.c
index 2a48cd2..fd934bf 100644
--- a/arch/arm/mach-omap1/gpio16xx.c
+++ b/arch/arm/mach-omap1/gpio16xx.c
@@ -17,6 +17,7 @@
  */
 
 #include <linux/gpio.h>
+#include <mach/gpio.h>
 
 #define OMAP1610_GPIO1_BASE		0xfffbe400
 #define OMAP1610_GPIO2_BASE		0xfffbec00
diff --git a/arch/arm/mach-omap1/gpio7xx.c b/arch/arm/mach-omap1/gpio7xx.c
index acf12b7..20d33c0 100644
--- a/arch/arm/mach-omap1/gpio7xx.c
+++ b/arch/arm/mach-omap1/gpio7xx.c
@@ -17,6 +17,7 @@
  */
 
 #include <linux/gpio.h>
+#include <mach/gpio.h>
 
 #define OMAP7XX_GPIO1_BASE		0xfffbc000
 #define OMAP7XX_GPIO2_BASE		0xfffbc800
diff --git a/arch/arm/mach-omap1/leds-h2p2-debug.c b/arch/arm/mach-omap1/leds-h2p2-debug.c
index f6b14a1..c7e16db 100644
--- a/arch/arm/mach-omap1/leds-h2p2-debug.c
+++ b/arch/arm/mach-omap1/leds-h2p2-debug.c
@@ -15,6 +15,7 @@
 #include <linux/sched.h>
 #include <linux/io.h>
 
+#include <mach/gpio.h>
 #include <mach/hardware.h>
 #include <asm/leds.h>
 #include <asm/mach-types.h>
diff --git a/arch/arm/mach-omap1/leds.c b/arch/arm/mach-omap1/leds.c
index ae6dd93..de155dc 100644
--- a/arch/arm/mach-omap1/leds.c
+++ b/arch/arm/mach-omap1/leds.c
@@ -10,6 +10,7 @@
 #include <asm/leds.h>
 #include <asm/mach-types.h>
 
+#include <mach/gpio.h>
 #include <plat/mux.h>
 
 #include "leds.h"
-- 
1.7.9.5
