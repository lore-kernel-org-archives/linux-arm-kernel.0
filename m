From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 17 Jun 2015 11:31:30 +0200
Subject: [PATCH 14/15] pinctrl: sh-pfc: r8a7740: Remove obsolete
 multi-platform check
In-Reply-To: <1434533491-21979-1-git-send-email-geert+renesas@glider.be>
References: <1434533491-21979-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1434533491-21979-15-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the removal of the r8a7740 legacy board code, r8a7740 is only
supported in generic ARM multi-platform builds.  Hence
CONFIG_ARCH_MULTIPLATFORM is always set, and the check can be removed.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
Please do not apply until the legacy r8a7740 SoC code has been removed.
Or just provide an ack, so Simon can apply it when appropriate.
---
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
index d0bb1459783a16d2..82ef1862dd1ba808 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
@@ -22,10 +22,6 @@
 #include <linux/kernel.h>
 #include <linux/pinctrl/pinconf-generic.h>
 
-#ifndef CONFIG_ARCH_MULTIPLATFORM
-#include <mach/irqs.h>
-#endif
-
 #include "core.h"
 #include "sh_pfc.h"
 
-- 
1.9.1
