From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 11 Sep 2012 11:13:29 -0600
Subject: [PATCH] ARM: tegra: delete unused headers
Message-ID: <1347383609-26418-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Nothing includes these headers any more; remove them.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/include/mach/gpio-tegra.h |   28 ------------------
 arch/arm/mach-tegra/include/mach/suspend.h    |   38 -------------------------
 2 files changed, 0 insertions(+), 66 deletions(-)
 delete mode 100644 arch/arm/mach-tegra/include/mach/gpio-tegra.h
 delete mode 100644 arch/arm/mach-tegra/include/mach/suspend.h

diff --git a/arch/arm/mach-tegra/include/mach/gpio-tegra.h b/arch/arm/mach-tegra/include/mach/gpio-tegra.h
deleted file mode 100644
index a978b3c..0000000
--- a/arch/arm/mach-tegra/include/mach/gpio-tegra.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/*
- * arch/arm/mach-tegra/include/mach/gpio.h
- *
- * Copyright (C) 2010 Google, Inc.
- *
- * Author:
- *	Erik Gilling <konkers@google.com>
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-
-#ifndef __MACH_TEGRA_GPIO_TEGRA_H
-#define __MACH_TEGRA_GPIO_TEGRA_H
-
-#include <linux/types.h>
-#include <mach/irqs.h>
-
-#define TEGRA_NR_GPIOS		INT_GPIO_NR
-
-#endif
diff --git a/arch/arm/mach-tegra/include/mach/suspend.h b/arch/arm/mach-tegra/include/mach/suspend.h
deleted file mode 100644
index 5af8715..0000000
--- a/arch/arm/mach-tegra/include/mach/suspend.h
+++ /dev/null
@@ -1,38 +0,0 @@
-/*
- * arch/arm/mach-tegra/include/mach/suspend.h
- *
- * Copyright (C) 2010 Google, Inc.
- *
- * Author:
- *	Colin Cross <ccross@google.com>
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-
-
-#ifndef _MACH_TEGRA_SUSPEND_H_
-#define _MACH_TEGRA_SUSPEND_H_
-
-void tegra_pinmux_suspend(void);
-void tegra_irq_suspend(void);
-void tegra_gpio_suspend(void);
-void tegra_clk_suspend(void);
-void tegra_dma_suspend(void);
-void tegra_timer_suspend(void);
-
-void tegra_pinmux_resume(void);
-void tegra_irq_resume(void);
-void tegra_gpio_resume(void);
-void tegra_clk_resume(void);
-void tegra_dma_resume(void);
-void tegra_timer_resume(void);
-
-#endif /* _MACH_TEGRA_SUSPEND_H_ */
-- 
1.7.0.4
