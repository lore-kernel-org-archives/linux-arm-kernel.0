From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 20 Jun 2014 13:02:25 +0100
Subject: [PATCH] gpio: crystalcove: Fix implicit declaration of function
 'seq_printf' error
In-Reply-To: <1403265753-25851-1-git-send-email-lee.jones@linaro.org>
References: <1403265753-25851-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1403265753-25851-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drivers/gpio/gpio-crystalcove.c: In function 'crystalcove_gpio_dbg_show':
drivers/gpio/gpio-crystalcove.c:286:3: error: implicit declaration of function 'seq_printf'
   seq_printf(s, " gpio-%-2d %s %s %s %s ctlo=%2x,%s %s %s\n",

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpio/gpio-crystalcove.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-crystalcove.c b/drivers/gpio/gpio-crystalcove.c
index 5a98499..934462f 100644
--- a/drivers/gpio/gpio-crystalcove.c
+++ b/drivers/gpio/gpio-crystalcove.c
@@ -18,6 +18,7 @@
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
+#include <linux/seq_file.h>
 #include <linux/bitops.h>
 #include <linux/regmap.h>
 #include <linux/mfd/intel_soc_pmic.h>
-- 
1.8.3.2
