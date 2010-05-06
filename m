From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu,  6 May 2010 16:24:17 -0700
Subject: [PATCH 26/34] Davinci: gpio - controller type support
In-Reply-To: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
References: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1273188265-12782-27-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cyril Chemparathy <cyril@ti.com>

This patch allows for gpio controllers that deviate from those found on
traditional davinci socs.  davinci_soc_info has an added field to indicate the
soc-specific gpio controller type.  The gpio initialization code then bails
out if necessary.

More elements (tnetv107x) to be added later into enum davinci_gpio_type.

Signed-off-by: Cyril Chemparathy <cyril@ti.com>
Tested-by: Sandeep Paulraj <s-paulraj@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/da830.c               |    2 ++
 arch/arm/mach-davinci/da850.c               |    2 ++
 arch/arm/mach-davinci/dm355.c               |    1 +
 arch/arm/mach-davinci/dm365.c               |    1 +
 arch/arm/mach-davinci/dm644x.c              |    1 +
 arch/arm/mach-davinci/dm646x.c              |    1 +
 arch/arm/mach-davinci/gpio.c                |    3 +++
 arch/arm/mach-davinci/include/mach/common.h |    1 +
 arch/arm/mach-davinci/include/mach/gpio.h   |    4 ++++
 9 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 122e61a..68e5233 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -19,6 +19,7 @@
 #include <mach/common.h>
 #include <mach/time.h>
 #include <mach/da8xx.h>
+#include <mach/gpio.h>
 
 #include "clock.h"
 #include "mux.h"
@@ -1199,6 +1200,7 @@ static struct davinci_soc_info davinci_soc_info_da830 = {
 	.intc_irq_prios		= da830_default_priorities,
 	.intc_irq_num		= DA830_N_CP_INTC_IRQ,
 	.timer_info		= &da830_timer_info,
+	.gpio_type		= GPIO_TYPE_DAVINCI,
 	.gpio_base		= IO_ADDRESS(DA8XX_GPIO_BASE),
 	.gpio_num		= 128,
 	.gpio_irq		= IRQ_DA8XX_GPIO0,
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index d0fd756..8aefcff 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -27,6 +27,7 @@
 #include <mach/da8xx.h>
 #include <mach/cpufreq.h>
 #include <mach/pm.h>
+#include <mach/gpio.h>
 
 #include "clock.h"
 #include "mux.h"
@@ -1084,6 +1085,7 @@ static struct davinci_soc_info davinci_soc_info_da850 = {
 	.intc_irq_prios		= da850_default_priorities,
 	.intc_irq_num		= DA850_N_CP_INTC_IRQ,
 	.timer_info		= &da850_timer_info,
+	.gpio_type		= GPIO_TYPE_DAVINCI,
 	.gpio_base		= IO_ADDRESS(DA8XX_GPIO_BASE),
 	.gpio_num		= 144,
 	.gpio_irq		= IRQ_DA8XX_GPIO0,
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 5efce70..f9a54ff 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -859,6 +859,7 @@ static struct davinci_soc_info davinci_soc_info_dm355 = {
 	.intc_irq_prios		= dm355_default_priorities,
 	.intc_irq_num		= DAVINCI_N_AINTC_IRQ,
 	.timer_info		= &dm355_timer_info,
+	.gpio_type		= GPIO_TYPE_DAVINCI,
 	.gpio_base		= IO_ADDRESS(DAVINCI_GPIO_BASE),
 	.gpio_num		= 104,
 	.gpio_irq		= IRQ_DM355_GPIOBNK0,
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 1ee3fc8..0566675 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -1064,6 +1064,7 @@ static struct davinci_soc_info davinci_soc_info_dm365 = {
 	.intc_irq_prios		= dm365_default_priorities,
 	.intc_irq_num		= DAVINCI_N_AINTC_IRQ,
 	.timer_info		= &dm365_timer_info,
+	.gpio_type		= GPIO_TYPE_DAVINCI,
 	.gpio_base		= IO_ADDRESS(DAVINCI_GPIO_BASE),
 	.gpio_num		= 104,
 	.gpio_irq		= IRQ_DM365_GPIO0,
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 23cbe9d..4af349e 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -748,6 +748,7 @@ static struct davinci_soc_info davinci_soc_info_dm644x = {
 	.intc_irq_prios 	= dm644x_default_priorities,
 	.intc_irq_num		= DAVINCI_N_AINTC_IRQ,
 	.timer_info		= &dm644x_timer_info,
+	.gpio_type		= GPIO_TYPE_DAVINCI,
 	.gpio_base		= IO_ADDRESS(DAVINCI_GPIO_BASE),
 	.gpio_num		= 71,
 	.gpio_irq		= IRQ_GPIOBNK0,
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index a0b3739..bdb1ace 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -832,6 +832,7 @@ static struct davinci_soc_info davinci_soc_info_dm646x = {
 	.intc_irq_prios		= dm646x_default_priorities,
 	.intc_irq_num		= DAVINCI_N_AINTC_IRQ,
 	.timer_info		= &dm646x_timer_info,
+	.gpio_type		= GPIO_TYPE_DAVINCI,
 	.gpio_base		= IO_ADDRESS(DAVINCI_GPIO_BASE),
 	.gpio_num		= 43, /* Only 33 usable */
 	.gpio_irq		= IRQ_DM646X_GPIOBNK0,
diff --git a/arch/arm/mach-davinci/gpio.c b/arch/arm/mach-davinci/gpio.c
index d241b4f..e422cd3 100644
--- a/arch/arm/mach-davinci/gpio.c
+++ b/arch/arm/mach-davinci/gpio.c
@@ -145,6 +145,9 @@ static int __init davinci_gpio_setup(void)
 	struct davinci_soc_info *soc_info = &davinci_soc_info;
 	struct davinci_gpio_regs *regs;
 
+	if (soc_info->gpio_type != GPIO_TYPE_DAVINCI)
+		return 0;
+
 	/*
 	 * The gpio banks conceptually expose a segmented bitmap,
 	 * and "ngpio" is one more than the largest zero-based
diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index 1d72883..8ffef5b 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -59,6 +59,7 @@ struct davinci_soc_info {
 	u8				*intc_irq_prios;
 	unsigned long			intc_irq_num;
 	struct davinci_timer_info	*timer_info;
+	int				gpio_type;
 	void __iomem			*gpio_base;
 	unsigned			gpio_num;
 	unsigned			gpio_irq;
diff --git a/arch/arm/mach-davinci/include/mach/gpio.h b/arch/arm/mach-davinci/include/mach/gpio.h
index 82591d0..9a71a26 100644
--- a/arch/arm/mach-davinci/include/mach/gpio.h
+++ b/arch/arm/mach-davinci/include/mach/gpio.h
@@ -21,6 +21,10 @@
 
 #define DAVINCI_GPIO_BASE 0x01C67000
 
+enum davinci_gpio_type {
+	GPIO_TYPE_DAVINCI = 0,
+};
+
 /*
  * basic gpio routines
  *
-- 
1.7.0.2
