From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Tue,  2 Feb 2010 15:59:26 -0800
Subject: [PATCH 14/16] ARM: LPC32XX: Several small sparse warning fixed
In-Reply-To: <LPC32XX architecture files (updated)>
References: <LPC32XX architecture files (updated)>
Message-ID: <1265155168-28909-15-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Wells <wellsk40@gmail.com>

Removed and extra "extern" and added an additional include to
define a function prototype. (sparse warnings)

Signed-off-by: Kevin Wells <wellsk40@gmail.com>
---
 arch/arm/mach-lpc32xx/gpiolib.c   |    1 +
 arch/arm/mach-lpc32xx/pm_events.c |    3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/gpiolib.c b/arch/arm/mach-lpc32xx/gpiolib.c
index 13930d4..05556bd 100644
--- a/arch/arm/mach-lpc32xx/gpiolib.c
+++ b/arch/arm/mach-lpc32xx/gpiolib.c
@@ -28,6 +28,7 @@
 
 #include <mach/hardware.h>
 #include <mach/platform.h>
+#include "common.h"
 
 #define GPIOBASE io_p2v(LPC32XX_GPIO_BASE)
 
diff --git a/arch/arm/mach-lpc32xx/pm_events.c b/arch/arm/mach-lpc32xx/pm_events.c
index 835207d..671736c 100644
--- a/arch/arm/mach-lpc32xx/pm_events.c
+++ b/arch/arm/mach-lpc32xx/pm_events.c
@@ -370,8 +370,7 @@ void lpc32xx_event_disable(enum lpc32xx_events event_id)
 		events[event_id].reg);
 }
 
-extern int lpc32xx_event_set(enum lpc32xx_events event_id,
-	int high_edge)
+int lpc32xx_event_set(enum lpc32xx_events event_id, int high_edge)
 {
 	u32 tmp;
 
-- 
1.6.6
