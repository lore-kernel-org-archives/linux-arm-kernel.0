From: tony@atomide.com (Tony Lindgren)
Date: Fri, 31 Aug 2012 17:26:20 -0700
Subject: [PATCH 1/4] ARM: OMAP: Remove unused old gpio-switch.h
In-Reply-To: <20120901002534.23715.28654.stgit@muffinssi.local>
References: <20120901002534.23715.28654.stgit@muffinssi.local>
Message-ID: <20120901002620.23715.3322.stgit@muffinssi.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is no longer used anywhere.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/include/plat/gpio-switch.h |   54 -------------------------
 1 file changed, 54 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/plat/gpio-switch.h

diff --git a/arch/arm/plat-omap/include/plat/gpio-switch.h b/arch/arm/plat-omap/include/plat/gpio-switch.h
deleted file mode 100644
index 10da0e0..0000000
--- a/arch/arm/plat-omap/include/plat/gpio-switch.h
+++ /dev/null
@@ -1,54 +0,0 @@
-/*
- * GPIO switch definitions
- *
- * Copyright (C) 2006 Nokia Corporation
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __ASM_ARCH_OMAP_GPIO_SWITCH_H
-#define __ASM_ARCH_OMAP_GPIO_SWITCH_H
-
-#include <linux/types.h>
-
-/* Cover:
- *	high -> closed
- *	low  -> open
- * Connection:
- *	high -> connected
- *	low  -> disconnected
- * Activity:
- *	high -> active
- *	low  -> inactive
- *
- */
-#define OMAP_GPIO_SWITCH_TYPE_COVER		0x0000
-#define OMAP_GPIO_SWITCH_TYPE_CONNECTION	0x0001
-#define OMAP_GPIO_SWITCH_TYPE_ACTIVITY		0x0002
-#define OMAP_GPIO_SWITCH_FLAG_INVERTED		0x0001
-#define OMAP_GPIO_SWITCH_FLAG_OUTPUT		0x0002
-
-struct omap_gpio_switch {
-	const char *name;
-	s16 gpio;
-	unsigned flags:4;
-	unsigned type:4;
-
-	/* Time in ms to debounce when transitioning from
-	 * inactive state to active state. */
-	u16 debounce_rising;
-	/* Same for transition from active to inactive state. */
-	u16 debounce_falling;
-
-	/* notify board-specific code about state changes */
-	void (* notify)(void *data, int state);
-	void *notify_data;
-};
-
-/* Call at init time only */
-extern void omap_register_gpio_switches(const struct omap_gpio_switch *tbl,
-					int count);
-
-#endif
