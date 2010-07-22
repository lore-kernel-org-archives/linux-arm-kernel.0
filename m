From: eric@eukrea.com (=?utf-8?q?Eric=20B=C3=A9nard?=)
Date: Thu, 22 Jul 2010 18:38:54 +0200
Subject: [PATCH 2/2] eukrea-baseboards: merge includes in one file
In-Reply-To: <1279816734-26094-1-git-send-email-eric@eukrea.com>
References: <1279816734-26094-1-git-send-email-eric@eukrea.com>
Message-ID: <1279816734-26094-2-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

as per suggested by Sascha

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/mach-imx/mach-cpuimx27.c                  |    2 +-
 arch/arm/mach-mx25/mach-cpuimx25.c                 |    2 +-
 arch/arm/mach-mx3/mach-cpuimx35.c                  |    2 +-
 arch/arm/plat-mxc/eukrea_mbimxsd-baseboard.c       |    1 -
 .../plat-mxc/include/mach/board-eukrea_cpuimx27.h  |   40 --------------------
 ...board-eukrea_cpuimxsd.h => eukrea-baseboards.h} |   13 ++++--
 6 files changed, 11 insertions(+), 49 deletions(-)
 delete mode 100644 arch/arm/plat-mxc/include/mach/board-eukrea_cpuimx27.h
 rename arch/arm/plat-mxc/include/mach/{board-eukrea_cpuimxsd.h => eukrea-baseboards.h} (76%)

diff --git a/arch/arm/mach-imx/mach-cpuimx27.c b/arch/arm/mach-imx/mach-cpuimx27.c
index 2a13544..575ff1a 100644
--- a/arch/arm/mach-imx/mach-cpuimx27.c
+++ b/arch/arm/mach-imx/mach-cpuimx27.c
@@ -35,7 +35,7 @@
 #include <asm/mach/time.h>
 #include <asm/mach/map.h>
 
-#include <mach/board-eukrea_cpuimx27.h>
+#include <mach/eukrea-baseboards.h>
 #include <mach/common.h>
 #include <mach/hardware.h>
 #include <mach/iomux-mx27.h>
diff --git a/arch/arm/mach-mx25/mach-cpuimx25.c b/arch/arm/mach-mx25/mach-cpuimx25.c
index 526928f..56b2e26 100644
--- a/arch/arm/mach-mx25/mach-cpuimx25.c
+++ b/arch/arm/mach-mx25/mach-cpuimx25.c
@@ -29,7 +29,7 @@
 #include <linux/usb/ulpi.h>
 #include <linux/fsl_devices.h>
 
-#include <mach/board-eukrea_cpuimxsd.h>
+#include <mach/eukrea-baseboards.h>
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-mx3/mach-cpuimx35.c b/arch/arm/mach-mx3/mach-cpuimx35.c
index a7ecd7b..63f970f 100644
--- a/arch/arm/mach-mx3/mach-cpuimx35.c
+++ b/arch/arm/mach-mx3/mach-cpuimx35.c
@@ -37,7 +37,7 @@
 #include <asm/mach/time.h>
 #include <asm/mach/map.h>
 
-#include <mach/board-eukrea_cpuimxsd.h>
+#include <mach/eukrea-baseboards.h>
 #include <mach/hardware.h>
 #include <mach/common.h>
 #include <mach/iomux-mx35.h>
diff --git a/arch/arm/plat-mxc/eukrea_mbimxsd-baseboard.c b/arch/arm/plat-mxc/eukrea_mbimxsd-baseboard.c
index 57e8e7b..bc4d48a 100644
--- a/arch/arm/plat-mxc/eukrea_mbimxsd-baseboard.c
+++ b/arch/arm/plat-mxc/eukrea_mbimxsd-baseboard.c
@@ -38,7 +38,6 @@
 
 #include <mach/hardware.h>
 #include <mach/common.h>
-#include <mach/board-eukrea_cpuimxsd.h>
 
 #if defined(CONFIG_MACH_EUKREA_CPUIMX25)
 #include <mach/iomux-mx25.h>
diff --git a/arch/arm/plat-mxc/include/mach/board-eukrea_cpuimx27.h b/arch/arm/plat-mxc/include/mach/board-eukrea_cpuimx27.h
deleted file mode 100644
index 45b2fb8..0000000
--- a/arch/arm/plat-mxc/include/mach/board-eukrea_cpuimx27.h
+++ /dev/null
@@ -1,40 +0,0 @@
-/*
- * Copyright (C) 2009 Eric Benard - eric at eukrea.com
- *
- * Based on board-pcm038.h which is :
- * Copyright (C) 2008 Juergen Beisert (kernel at pengutronix.de)
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
- * MA 02110-1301, USA.
- */
-
-#ifndef __ASM_ARCH_MXC_BOARD_EUKREA_CPUIMX27_H__
-#define __ASM_ARCH_MXC_BOARD_EUKREA_CPUIMX27_H__
-
-#ifndef __ASSEMBLY__
-/*
- * This CPU module needs a baseboard to work. After basic initializing
- * its own devices, it calls the baseboard's init function.
- * TODO: Add your own baseboard init function and call it from
- * inside eukrea_cpuimx27_init().
- *
- * This example here is for the development board. Refer
- * eukrea_mbimx27-baseboard.c
- */
-
-extern void eukrea_mbimx27_baseboard_init(void);
-
-#endif
-
-#endif /* __ASM_ARCH_MXC_BOARD_EUKREA_CPUIMX27_H__ */
diff --git a/arch/arm/plat-mxc/include/mach/board-eukrea_cpuimxsd.h b/arch/arm/plat-mxc/include/mach/eukrea-baseboards.h
similarity index 76%
rename from arch/arm/plat-mxc/include/mach/board-eukrea_cpuimxsd.h
rename to arch/arm/plat-mxc/include/mach/eukrea-baseboards.h
index 35f9583..8864da4 100644
--- a/arch/arm/plat-mxc/include/mach/board-eukrea_cpuimxsd.h
+++ b/arch/arm/plat-mxc/include/mach/eukrea-baseboards.h
@@ -19,22 +19,25 @@
  * MA 02110-1301, USA.
  */
 
-#ifndef __MACH_BOARD_EUKREA_CPUIMXSD_H__
-#define __MACH_BOARD_EUKREA_CPUIMXSD_H__
+#ifndef __MACH_EUKREA_BASEBOARDS_H__
+#define __MACH_EUKREA_BASEBOARDS_H__
 
 #ifndef __ASSEMBLY__
 /*
  * This CPU module needs a baseboard to work. After basic initializing
  * its own devices, it calls baseboard's init function.
  * TODO: Add your own baseboard init function and call it from
- * inside eukrea_cpuimx25_init() or eukrea_cpuimx35_init().
+ * inside eukrea_cpuimx25_init() eukrea_cpuimx27_init()
+ * or eukrea_cpuimx35_init().
  *
  * This example here is for the development board. Refer
- * eukrea_mbimxsd-baseboard.c
+ * plat-mxc/eukrea_mbimxsd-baseboard.c for cpuimx25 & cpuimx35
+ * mach-imx/eukrea_mbimx27-baseboard.c for cpuimx27
  */
 
 extern void eukrea_mbimxsd_baseboard_init(void);
+extern void eukrea_mbimx27_baseboard_init(void);
 
 #endif
 
-#endif /* __MACH_BOARD_EUKREA_CPUIMXSD_H__ */
+#endif /* __MACH_EUKREA_BASEBOARDS_H__ */
-- 
1.6.3.3
