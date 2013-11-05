From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue,  5 Nov 2013 10:30:14 +0100
Subject: [PATCH 3/4] pinctrl: at91: copy define to driver
Message-ID: <1383643814-14308-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The #define for the maximum number of GPIO blocks was retrieved
into pinctrl-at91.c by implicit inclusion of <mach/gpio.h>
from <linux/gpio.h> creating a dependency on machine-local
<mach/gpio.h>. Break the depenency by copying this single
define into the driver.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
This will be applied directly to the pinctrl tree unless there
are specific protests.
---
 drivers/pinctrl/pinctrl-at91.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index f350fd2e170e..0dfb8c7b58df 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -33,6 +33,7 @@
 
 #include "core.h"
 
+#define MAX_GPIO_BANKS		5
 #define MAX_NB_GPIO_PER_BANK	32
 
 struct at91_pinctrl_mux_ops;
-- 
1.8.3.1
