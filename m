From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 14 Aug 2011 00:14:06 +0800
Subject: [PATCH v2 7/8] gpio/mxs: move irq_to_gpio() into gpio-mxs driver
In-Reply-To: <1313252047-8820-1-git-send-email-shawn.guo@linaro.org>
References: <1313252047-8820-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1313252047-8820-8-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As irq_to_gpio() is only being used by gpio-mxs driver, it should be
moved from mach/gpio.h into gpio-mxs.c.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-mxs/include/mach/gpio.h |    2 --
 drivers/gpio/gpio-mxs.c               |    2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mxs/include/mach/gpio.h b/arch/arm/mach-mxs/include/mach/gpio.h
index bb11e63..8aea2ec 100644
--- a/arch/arm/mach-mxs/include/mach/gpio.h
+++ b/arch/arm/mach-mxs/include/mach/gpio.h
@@ -22,6 +22,4 @@
 
 #define MXS_GPIO_NR(bank, nr)	((bank) * 32 + (nr))
 
-#define irq_to_gpio(irq)	((irq) - MXS_GPIO_IRQ_START)
-
 #endif /* __MACH_MXS_GPIO_H__ */
diff --git a/drivers/gpio/gpio-mxs.c b/drivers/gpio/gpio-mxs.c
index af55a85..292b504 100644
--- a/drivers/gpio/gpio-mxs.c
+++ b/drivers/gpio/gpio-mxs.c
@@ -49,6 +49,8 @@
 #define GPIO_INT_LEV_MASK	(1 << 0)
 #define GPIO_INT_POL_MASK	(1 << 1)
 
+#define irq_to_gpio(irq)	((irq) - MXS_GPIO_IRQ_START)
+
 struct mxs_gpio_port {
 	void __iomem *base;
 	int id;
-- 
1.7.4.1
