From: linux@prisktech.co.nz (Tony Prisk)
Date: Sun,  7 Oct 2012 14:02:11 +1300
Subject: [PATCH 1/4] vt8500: Remove unused headers from include/mach/
In-Reply-To: <1349571734-26233-1-git-send-email-linux@prisktech.co.nz>
References: <1349571734-26233-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <1349571734-26233-2-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove restart.h and reference in vt8500.c - unused.
Remove hardware.h - empty and now optional.
Remove i8042.h - not supported now that devicetree-only.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
 arch/arm/mach-vt8500/include/mach/hardware.h |   12 ------------
 arch/arm/mach-vt8500/include/mach/i8042.h    |   18 ------------------
 arch/arm/mach-vt8500/include/mach/restart.h  |   17 -----------------
 arch/arm/mach-vt8500/vt8500.c                |    2 --
 4 files changed, 49 deletions(-)
 delete mode 100644 arch/arm/mach-vt8500/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-vt8500/include/mach/i8042.h
 delete mode 100644 arch/arm/mach-vt8500/include/mach/restart.h

diff --git a/arch/arm/mach-vt8500/include/mach/hardware.h b/arch/arm/mach-vt8500/include/mach/hardware.h
deleted file mode 100644
index db4163f..0000000
--- a/arch/arm/mach-vt8500/include/mach/hardware.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* arch/arm/mach-vt8500/include/mach/hardware.h
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
diff --git a/arch/arm/mach-vt8500/include/mach/i8042.h b/arch/arm/mach-vt8500/include/mach/i8042.h
deleted file mode 100644
index cd7143c..0000000
--- a/arch/arm/mach-vt8500/include/mach/i8042.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* arch/arm/mach-vt8500/include/mach/i8042.h
- *
- * Copyright (C) 2010 Alexey Charkov <alchark@gmail.com>
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
-extern unsigned long wmt_i8042_base __initdata;
-extern int wmt_i8042_kbd_irq;
-extern int wmt_i8042_aux_irq;
diff --git a/arch/arm/mach-vt8500/include/mach/restart.h b/arch/arm/mach-vt8500/include/mach/restart.h
deleted file mode 100644
index 7389795..0000000
--- a/arch/arm/mach-vt8500/include/mach/restart.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/* linux/arch/arm/mach-vt8500/restart.h
- *
- * Copyright (C) 2012 Tony Prisk <linux@prisktech.co.nz>
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
-void vt8500_setup_restart(void);
-void vt8500_restart(char mode, const char *cmd);
diff --git a/arch/arm/mach-vt8500/vt8500.c b/arch/arm/mach-vt8500/vt8500.c
index 587ea95..7449886 100644
--- a/arch/arm/mach-vt8500/vt8500.c
+++ b/arch/arm/mach-vt8500/vt8500.c
@@ -31,8 +31,6 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 
-#include <mach/restart.h>
-
 #include "common.h"
 
 #define LEGACY_GPIO_BASE	0xD8110000
-- 
1.7.9.5
