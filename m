From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 14 May 2013 16:03:16 +0100
Subject: [PATCH] picoxcell: remove redundant common.h
Message-ID: <1368543796-19230-1-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We don't need this now - everything lives in common.c so no need for a
separate header.

Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/mach-picoxcell/common.c |  2 --
 arch/arm/mach-picoxcell/common.h | 17 -----------------
 2 files changed, 19 deletions(-)
 delete mode 100644 arch/arm/mach-picoxcell/common.h

diff --git a/arch/arm/mach-picoxcell/common.c b/arch/arm/mach-picoxcell/common.c
index 70b441a..f6f71bb 100644
--- a/arch/arm/mach-picoxcell/common.c
+++ b/arch/arm/mach-picoxcell/common.c
@@ -20,8 +20,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include "common.h"
-
 #define PHYS_TO_IO(x)			(((x) & 0x00ffffff) | 0xfe000000)
 #define PICOXCELL_PERIPH_BASE		0x80000000
 #define PICOXCELL_PERIPH_LENGTH		SZ_4M
diff --git a/arch/arm/mach-picoxcell/common.h b/arch/arm/mach-picoxcell/common.h
deleted file mode 100644
index 481b42a..0000000
--- a/arch/arm/mach-picoxcell/common.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/*
- * Copyright (c) 2011 Picochip Ltd., Jamie Iles
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * All enquiries to support at picochip.com
- */
-#ifndef __PICOXCELL_COMMON_H__
-#define __PICOXCELL_COMMON_H__
-
-#include <asm/mach/time.h>
-
-extern void dw_apb_timer_init(void);
-
-#endif /* __PICOXCELL_COMMON_H__ */
-- 
1.8.1.2
