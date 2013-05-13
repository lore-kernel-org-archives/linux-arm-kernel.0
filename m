From: shc_work@mail.ru (Alexander Shiyan)
Date: Mon, 13 May 2013 21:07:28 +0400
Subject: [PATCH 06/15] ARM: clps711x: autcpu12: Move remaining specific
 definitions to board file
In-Reply-To: <1368464857-5038-1-git-send-email-shc_work@mail.ru>
References: <1368464857-5038-1-git-send-email-shc_work@mail.ru>
Message-ID: <1368464857-5038-9-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-clps711x/board-autcpu12.c        |  9 +++++-
 arch/arm/mach-clps711x/include/mach/autcpu12.h | 44 --------------------------
 2 files changed, 8 insertions(+), 45 deletions(-)
 delete mode 100644 arch/arm/mach-clps711x/include/mach/autcpu12.h

diff --git a/arch/arm/mach-clps711x/board-autcpu12.c b/arch/arm/mach-clps711x/board-autcpu12.c
index 91a3ab5..cd50314 100644
--- a/arch/arm/mach-clps711x/board-autcpu12.c
+++ b/arch/arm/mach-clps711x/board-autcpu12.c
@@ -42,7 +42,6 @@
 #include <asm/page.h>
 
 #include <asm/mach/map.h>
-#include <mach/autcpu12.h>
 
 #include "common.h"
 #include "devices.h"
@@ -50,6 +49,14 @@
 /* NOR flash */
 #define AUTCPU12_FLASH_BASE	(CS0_PHYS_BASE)
 
+/* Board specific hardware definitions */
+#define AUTCPU12_CHAR_LCD_BASE	(CS1_PHYS_BASE + 0x00000000)
+#define AUTCPU12_CSAUX1_BASE	(CS1_PHYS_BASE + 0x04000000)
+#define AUTCPU12_CAN_BASE	(CS1_PHYS_BASE + 0x08000000)
+#define AUTCPU12_TOUCH_BASE	(CS1_PHYS_BASE + 0x0a000000)
+#define AUTCPU12_IO_BASE	(CS1_PHYS_BASE + 0x0c000000)
+#define AUTCPU12_LPT_BASE	(CS1_PHYS_BASE + 0x0e000000)
+
 /* NVRAM */
 #define AUTCPU12_NVRAM_BASE	(CS1_PHYS_BASE + 0x02000000)
 
diff --git a/arch/arm/mach-clps711x/include/mach/autcpu12.h b/arch/arm/mach-clps711x/include/mach/autcpu12.h
deleted file mode 100644
index 0e00148..0000000
--- a/arch/arm/mach-clps711x/include/mach/autcpu12.h
+++ /dev/null
@@ -1,44 +0,0 @@
-/*
- * AUTCPU12 specific defines
- *
- * (c) 2001 Thomas Gleixner, autronix automation <gleixner@autronix.de>
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
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-#ifndef __ASM_ARCH_AUTCPU12_H
-#define __ASM_ARCH_AUTCPU12_H
-
-/* offset for device specific information structure */
-#define AUTCPU12_LCDINFO_OFFS		(0x00010000)	
-
-/* Videomemory in the internal SRAM (CS 6) */
-#define AUTCPU12_PHYS_VIDEO		CS6_PHYS_BASE
-
-/*
-* All special IO's are tied to CS1
-*/
-#define AUTCPU12_PHYS_CHAR_LCD         	CS1_PHYS_BASE +0x00000000  /* physical */
-
-#define AUTCPU12_PHYS_CSAUX1           	CS1_PHYS_BASE +0x04000000  /* physical */
-
-#define AUTCPU12_PHYS_CAN              	CS1_PHYS_BASE +0x08000000  /* physical */
-
-#define AUTCPU12_PHYS_TOUCH            	CS1_PHYS_BASE +0x0A000000  /* physical */
-
-#define AUTCPU12_PHYS_IO               	CS1_PHYS_BASE +0x0C000000  /* physical */
-
-#define AUTCPU12_PHYS_LPT              	CS1_PHYS_BASE +0x0E000000  /* physical */
-
-#endif
-- 
1.8.1.5
