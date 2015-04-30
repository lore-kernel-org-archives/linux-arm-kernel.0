From: shenwei.wang@freescale.com (Shenwei Wang)
Date: Thu, 30 Apr 2015 09:44:32 -0500
Subject: [PATCH 17/18] ARM: imx: Codes clean up
In-Reply-To: <1430405073-13106-1-git-send-email-shenwei.wang@freescale.com>
References: <1430405073-13106-1-git-send-email-shenwei.wang@freescale.com>
Message-ID: <1430405073-13106-18-git-send-email-shenwei.wang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Removed the unused SoC relating codes.

Signed-off-by: Shenwei Wang <shenwei.wang@freescale.com>
---
 arch/arm/mach-imx/time.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c
index da4dc29..f8dd53d 100644
--- a/arch/arm/mach-imx/time.c
+++ b/arch/arm/mach-imx/time.c
@@ -35,8 +35,6 @@
 
 #include <asm/mach/time.h>
 
-#include "common.h"
-#include "hardware.h"
 
 /*
  * There are 4 versions of the timer hardware on Freescale MXC hardware.
@@ -79,8 +77,6 @@
 
 #define V2_TIMER_RATE_OSC_DIV8	3000000
 
-#define timer_is_v1()	(cpu_is_mx1() || cpu_is_mx21() || cpu_is_mx27())
-#define timer_is_v2()	(!timer_is_v1())
 
 #define IMX_TIMER_V0         (0)
 #define IMX_TIMER_V1         (1)
@@ -97,8 +93,6 @@ struct imx_timer {
 	void (*gpt_irq_acknowledge)(struct imx_timer *);
 };
 
-static struct clock_event_device clockevent_mxc;
-
 static void gpt_irq_disable_v0_v1(struct imx_timer *tm)
 {
 	unsigned int tmp;
-- 
1.9.1
