From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 22 May 2015 23:29:58 +0800
Subject: [PATCH v2 11/12] ARM: imx: remove platform headers from timer driver
In-Reply-To: <1432308599-28643-1-git-send-email-shawn.guo@linaro.org>
References: <1432308599-28643-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1432308599-28643-12-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the cleanup done before, the platform specific headers now can be
removed.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/time.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c
index 5fb8397d8fe2..ec144ce9f880 100644
--- a/arch/arm/mach-imx/time.c
+++ b/arch/arm/mach-imx/time.c
@@ -36,9 +36,6 @@
 
 #include <asm/mach/time.h>
 
-#include "common.h"
-#include "hardware.h"
-
 /*
  * There are 4 versions of the timer hardware on Freescale MXC hardware.
  *  - MX1/MXL
@@ -80,9 +77,6 @@
 
 #define V2_TIMER_RATE_OSC_DIV8	3000000
 
-#define timer_is_v1()	(cpu_is_mx1() || cpu_is_mx21() || cpu_is_mx27())
-#define timer_is_v2()	(!timer_is_v1())
-
 struct imx_timer {
 	enum imx_gpt_type type;
 	void __iomem *base;
-- 
1.9.1
