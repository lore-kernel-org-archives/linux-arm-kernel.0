From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 29 May 2015 21:12:27 +0800
Subject: [PATCH] clocksource: timer-imx-gpt: remove include of
 <asm/mach/time.h>
Message-ID: <1432905147-23754-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The include of <asm/mach/time.h> is not needed at all, and causes build
error in powerpc allyesconfig.  Remove it.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/clocksource/timer-imx-gpt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clocksource/timer-imx-gpt.c b/drivers/clocksource/timer-imx-gpt.c
index ec144ce9f880..a98d1104b3fd 100644
--- a/drivers/clocksource/timer-imx-gpt.c
+++ b/drivers/clocksource/timer-imx-gpt.c
@@ -34,8 +34,6 @@
 #include <linux/of_irq.h>
 #include <soc/imx/timer.h>
 
-#include <asm/mach/time.h>
-
 /*
  * There are 4 versions of the timer hardware on Freescale MXC hardware.
  *  - MX1/MXL
-- 
1.9.1
