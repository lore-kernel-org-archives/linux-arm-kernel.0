From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 12 Aug 2011 15:54:59 +0800
Subject: [PATCH 4/6] arm/imx: remove gpio_to_irq() from mach/gpio.h
In-Reply-To: <1313135701-22456-1-git-send-email-shawn.guo@linaro.org>
References: <1313135701-22456-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1313135701-22456-5-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As all the users of gpio_to_irq() has migrated to IMX_GPIO_TO_IRQ,
gpio_to_irq() can be removed from mach/gpio.h now.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/gpio.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/gpio.h b/arch/arm/plat-mxc/include/mach/gpio.h
index 3e1ffc8..9a7c750 100644
--- a/arch/arm/plat-mxc/include/mach/gpio.h
+++ b/arch/arm/plat-mxc/include/mach/gpio.h
@@ -27,7 +27,6 @@
 /* range e.g. GPIO_1_5 is gpio 5 under linux */
 #define IMX_GPIO_NR(bank, nr)		(((bank) - 1) * 32 + (nr))
 
-#define gpio_to_irq(gpio)	(MXC_GPIO_IRQ_START + (gpio))
 #define irq_to_gpio(irq)	((irq) - MXC_GPIO_IRQ_START)
 
 #endif
-- 
1.7.4.1
