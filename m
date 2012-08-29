From: robherring2@gmail.com (Rob Herring)
Date: Wed, 29 Aug 2012 17:49:57 -0500
Subject: [PATCH 3/6] ARM: picoxcell: header fixes for multi-platform
In-Reply-To: <1346280600-29395-1-git-send-email-robherring2@gmail.com>
References: <1346280600-29395-1-git-send-email-robherring2@gmail.com>
Message-ID: <1346280600-29395-4-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-picoxcell/common.c                   |    6 ++---
 arch/arm/mach-picoxcell/include/mach/map.h         |   25 --------------------
 .../mach-picoxcell/include/mach/picoxcell_soc.h    |   25 --------------------
 arch/arm/mach-picoxcell/picoxcell_soc.h            |   25 ++++++++++++++++++++
 4 files changed, 28 insertions(+), 53 deletions(-)
 delete mode 100644 arch/arm/mach-picoxcell/include/mach/map.h
 delete mode 100644 arch/arm/mach-picoxcell/include/mach/picoxcell_soc.h
 create mode 100644 arch/arm/mach-picoxcell/picoxcell_soc.h

diff --git a/arch/arm/mach-picoxcell/common.c b/arch/arm/mach-picoxcell/common.c
index 8f9a0b4..a8b70b5 100644
--- a/arch/arm/mach-picoxcell/common.c
+++ b/arch/arm/mach-picoxcell/common.c
@@ -20,11 +20,11 @@
 #include <asm/hardware/vic.h>
 #include <asm/mach/map.h>
 
-#include <mach/map.h>
-#include <mach/picoxcell_soc.h>
-
+#include "picoxcell_soc.h"
 #include "common.h"
 
+#define PHYS_TO_IO(x)		(((x) & 0x00ffffff) | 0xfe000000)
+
 #define WDT_CTRL_REG_EN_MASK	(1 << 0)
 #define WDT_CTRL_REG_OFFS	(0x00)
 #define WDT_TIMEOUT_REG_OFFS	(0x04)
diff --git a/arch/arm/mach-picoxcell/include/mach/map.h b/arch/arm/mach-picoxcell/include/mach/map.h
deleted file mode 100644
index c06afad..0000000
--- a/arch/arm/mach-picoxcell/include/mach/map.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- * Copyright (c) 2011 Picochip Ltd., Jamie Iles
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-#ifndef __PICOXCELL_MAP_H__
-#define __PICOXCELL_MAP_H__
-
-#define PHYS_TO_IO(x)		(((x) & 0x00ffffff) | 0xfe000000)
-
-#ifdef __ASSEMBLY__
-#define IO_ADDRESS(x)		PHYS_TO_IO((x))
-#else
-#define IO_ADDRESS(x)		(void __iomem __force *)(PHYS_TO_IO((x)))
-#endif
-
-#endif /* __PICOXCELL_MAP_H__ */
diff --git a/arch/arm/mach-picoxcell/include/mach/picoxcell_soc.h b/arch/arm/mach-picoxcell/include/mach/picoxcell_soc.h
deleted file mode 100644
index 5566fc8..0000000
--- a/arch/arm/mach-picoxcell/include/mach/picoxcell_soc.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- * Copyright (c) 2011 Picochip Ltd., Jamie Iles
- *
- * This file contains the hardware definitions of the picoXcell SoC devices.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-#ifndef __PICOXCELL_SOC_H__
-#define __PICOXCELL_SOC_H__
-
-#define PICOXCELL_UART1_BASE		0x80230000
-#define PICOXCELL_PERIPH_BASE		0x80000000
-#define PICOXCELL_PERIPH_LENGTH		SZ_4M
-#define PICOXCELL_VIC0_BASE		0x80060000
-#define PICOXCELL_VIC1_BASE		0x80064000
-
-#endif /* __PICOXCELL_SOC_H__ */
diff --git a/arch/arm/mach-picoxcell/picoxcell_soc.h b/arch/arm/mach-picoxcell/picoxcell_soc.h
new file mode 100644
index 0000000..5566fc8
--- /dev/null
+++ b/arch/arm/mach-picoxcell/picoxcell_soc.h
@@ -0,0 +1,25 @@
+/*
+ * Copyright (c) 2011 Picochip Ltd., Jamie Iles
+ *
+ * This file contains the hardware definitions of the picoXcell SoC devices.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#ifndef __PICOXCELL_SOC_H__
+#define __PICOXCELL_SOC_H__
+
+#define PICOXCELL_UART1_BASE		0x80230000
+#define PICOXCELL_PERIPH_BASE		0x80000000
+#define PICOXCELL_PERIPH_LENGTH		SZ_4M
+#define PICOXCELL_VIC0_BASE		0x80060000
+#define PICOXCELL_VIC1_BASE		0x80064000
+
+#endif /* __PICOXCELL_SOC_H__ */
-- 
1.7.9.5
