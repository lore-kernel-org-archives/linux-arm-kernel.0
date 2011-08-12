From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 12 Aug 2011 15:55:00 +0800
Subject: [PATCH 5/6] gpio/mxc: move irq_to_gpio() into gpio-mxc driver
In-Reply-To: <1313135701-22456-1-git-send-email-shawn.guo@linaro.org>
References: <1313135701-22456-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1313135701-22456-6-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As irq_to_gpio() is only being used by gpio-mxc driver, it should be
moved from mach/gpio.h into gpio-mxc.c.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
 arch/arm/plat-mxc/include/mach/gpio.h |    2 --
 drivers/gpio/gpio-mxc.c               |    2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/gpio.h b/arch/arm/plat-mxc/include/mach/gpio.h
index 9a7c750..8e5276c 100644
--- a/arch/arm/plat-mxc/include/mach/gpio.h
+++ b/arch/arm/plat-mxc/include/mach/gpio.h
@@ -27,6 +27,4 @@
 /* range e.g. GPIO_1_5 is gpio 5 under linux */
 #define IMX_GPIO_NR(bank, nr)		(((bank) - 1) * 32 + (nr))
 
-#define irq_to_gpio(irq)	((irq) - MXC_GPIO_IRQ_START)
-
 #endif
diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
index 64aff20..b588f8a 100644
--- a/drivers/gpio/gpio-mxc.c
+++ b/drivers/gpio/gpio-mxc.c
@@ -31,6 +31,8 @@
 #include <linux/of_device.h>
 #include <asm-generic/bug.h>
 
+#define irq_to_gpio(irq)	((irq) - MXC_GPIO_IRQ_START)
+
 enum mxc_gpio_hwtype {
 	IMX1_GPIO,	/* runs on i.mx1 */
 	IMX21_GPIO,	/* runs on i.mx21 and i.mx27 */
-- 
1.7.4.1
