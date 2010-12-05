From: ccross@android.com (Colin Cross)
Date: Sun,  5 Dec 2010 15:08:54 -0800
Subject: [PATCH 07/21] ARM: tegra: Add prototypes for subsystem suspend
	functions
In-Reply-To: <1291590548-7341-1-git-send-email-ccross@android.com>
References: <1291590548-7341-1-git-send-email-ccross@android.com>
Message-ID: <1291590548-7341-8-git-send-email-ccross@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Colin Cross <ccross@android.com>
---
 arch/arm/mach-tegra/dma.c                  |    1 +
 arch/arm/mach-tegra/gpio.c                 |    1 +
 arch/arm/mach-tegra/include/mach/suspend.h |   38 ++++++++++++++++++++++++++++
 arch/arm/mach-tegra/irq.c                  |    1 +
 arch/arm/mach-tegra/pinmux-t2-tables.c     |    1 +
 arch/arm/mach-tegra/tegra2_clocks.c        |    1 +
 arch/arm/mach-tegra/timer.c                |    1 +
 7 files changed, 44 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-tegra/include/mach/suspend.h

diff --git a/arch/arm/mach-tegra/dma.c b/arch/arm/mach-tegra/dma.c
index edda6ec..a2a252d 100644
--- a/arch/arm/mach-tegra/dma.c
+++ b/arch/arm/mach-tegra/dma.c
@@ -30,6 +30,7 @@
 #include <mach/dma.h>
 #include <mach/irqs.h>
 #include <mach/iomap.h>
+#include <mach/suspend.h>
 
 #define APB_DMA_GEN				0x000
 #define GEN_ENABLE				(1<<31)
diff --git a/arch/arm/mach-tegra/gpio.c b/arch/arm/mach-tegra/gpio.c
index 0775265..1bf92e5 100644
--- a/arch/arm/mach-tegra/gpio.c
+++ b/arch/arm/mach-tegra/gpio.c
@@ -25,6 +25,7 @@
 #include <linux/gpio.h>
 
 #include <mach/iomap.h>
+#include <mach/suspend.h>
 
 #define GPIO_BANK(x)		((x) >> 5)
 #define GPIO_PORT(x)		(((x) >> 3) & 0x3)
diff --git a/arch/arm/mach-tegra/include/mach/suspend.h b/arch/arm/mach-tegra/include/mach/suspend.h
new file mode 100644
index 0000000..5af8715
--- /dev/null
+++ b/arch/arm/mach-tegra/include/mach/suspend.h
@@ -0,0 +1,38 @@
+/*
+ * arch/arm/mach-tegra/include/mach/suspend.h
+ *
+ * Copyright (C) 2010 Google, Inc.
+ *
+ * Author:
+ *	Colin Cross <ccross@google.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+
+#ifndef _MACH_TEGRA_SUSPEND_H_
+#define _MACH_TEGRA_SUSPEND_H_
+
+void tegra_pinmux_suspend(void);
+void tegra_irq_suspend(void);
+void tegra_gpio_suspend(void);
+void tegra_clk_suspend(void);
+void tegra_dma_suspend(void);
+void tegra_timer_suspend(void);
+
+void tegra_pinmux_resume(void);
+void tegra_irq_resume(void);
+void tegra_gpio_resume(void);
+void tegra_clk_resume(void);
+void tegra_dma_resume(void);
+void tegra_timer_resume(void);
+
+#endif /* _MACH_TEGRA_SUSPEND_H_ */
diff --git a/arch/arm/mach-tegra/irq.c b/arch/arm/mach-tegra/irq.c
index 37b4f97..2de626f 100644
--- a/arch/arm/mach-tegra/irq.c
+++ b/arch/arm/mach-tegra/irq.c
@@ -26,6 +26,7 @@
 #include <asm/hardware/gic.h>
 
 #include <mach/iomap.h>
+#include <mach/suspend.h>
 
 #include "board.h"
 
diff --git a/arch/arm/mach-tegra/pinmux-t2-tables.c b/arch/arm/mach-tegra/pinmux-t2-tables.c
index a6ea34e..4d97d5c 100644
--- a/arch/arm/mach-tegra/pinmux-t2-tables.c
+++ b/arch/arm/mach-tegra/pinmux-t2-tables.c
@@ -29,6 +29,7 @@
 
 #include <mach/iomap.h>
 #include <mach/pinmux.h>
+#include <mach/suspend.h>
 
 #define DRIVE_PINGROUP(pg_name, r)				\
 	[TEGRA_DRIVE_PINGROUP_ ## pg_name] = {			\
diff --git a/arch/arm/mach-tegra/tegra2_clocks.c b/arch/arm/mach-tegra/tegra2_clocks.c
index ae3b308..c6fa5e7 100644
--- a/arch/arm/mach-tegra/tegra2_clocks.c
+++ b/arch/arm/mach-tegra/tegra2_clocks.c
@@ -28,6 +28,7 @@
 #include <asm/clkdev.h>
 
 #include <mach/iomap.h>
+#include <mach/suspend.h>
 
 #include "clock.h"
 #include "fuse.h"
diff --git a/arch/arm/mach-tegra/timer.c b/arch/arm/mach-tegra/timer.c
index b49f2f5..ef2fc29 100644
--- a/arch/arm/mach-tegra/timer.c
+++ b/arch/arm/mach-tegra/timer.c
@@ -32,6 +32,7 @@
 
 #include <mach/iomap.h>
 #include <mach/irqs.h>
+#include <mach/suspend.h>
 
 #include "board.h"
 #include "clock.h"
-- 
1.7.3.1
