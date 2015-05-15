From: shawnguo@kernel.org (shawnguo at kernel.org)
Date: Fri, 15 May 2015 16:11:46 +0800
Subject: [PATCH 8/9] ARM: imx: remove platform headers from timer driver
In-Reply-To: <1431677507-27420-1-git-send-email-shawnguo@kernel.org>
References: <1431677507-27420-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1431677507-27420-9-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

With the cleanup done before, the platform specific headers now can be
removed.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/time.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c
index 174c553a3bb7..ecf043f6c6fd 100644
--- a/arch/arm/mach-imx/time.c
+++ b/arch/arm/mach-imx/time.c
@@ -35,9 +35,6 @@
 
 #include <asm/mach/time.h>
 
-#include "common.h"
-#include "hardware.h"
-
 /*
  * There are 4 versions of the timer hardware on Freescale MXC hardware.
  *  - MX1/MXL
@@ -79,9 +76,6 @@
 
 #define V2_TIMER_RATE_OSC_DIV8	3000000
 
-#define timer_is_v1()	(cpu_is_mx1() || cpu_is_mx21() || cpu_is_mx27())
-#define timer_is_v2()	(!timer_is_v1())
-
 static struct clock_event_device clockevent_mxc;
 static enum clock_event_mode clockevent_mode = CLOCK_EVT_MODE_UNUSED;
 
-- 
1.9.1
