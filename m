From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 2 Apr 2013 22:07:35 +0800
Subject: [PATCH] ARM: imx: remove mx6q.h
Message-ID: <1364911655-22609-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Those stuff defined in mx6q.h is used nowhere now.  Remove the header.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/hardware.h |    1 -
 arch/arm/mach-imx/mx6q.h     |   31 -------------------------------
 2 files changed, 32 deletions(-)
 delete mode 100644 arch/arm/mach-imx/mx6q.h

diff --git a/arch/arm/mach-imx/hardware.h b/arch/arm/mach-imx/hardware.h
index 911e9b3..356131f 100644
--- a/arch/arm/mach-imx/hardware.h
+++ b/arch/arm/mach-imx/hardware.h
@@ -102,7 +102,6 @@
 
 #include "mxc.h"
 
-#include "mx6q.h"
 #include "mx51.h"
 #include "mx53.h"
 #include "mx3x.h"
diff --git a/arch/arm/mach-imx/mx6q.h b/arch/arm/mach-imx/mx6q.h
deleted file mode 100644
index 19d3f54..0000000
--- a/arch/arm/mach-imx/mx6q.h
+++ /dev/null
@@ -1,31 +0,0 @@
-/*
- * Copyright 2011 Freescale Semiconductor, Inc. All Rights Reserved.
- * Copyright 2011 Linaro Ltd.
- *
- * The code contained herein is licensed under the GNU General Public
- * License. You may obtain a copy of the GNU General Public License
- * Version 2 or later at the following locations:
- *
- * http://www.opensource.org/licenses/gpl-license.html
- * http://www.gnu.org/copyleft/gpl.html
- */
-
-#ifndef __MACH_MX6Q_H__
-#define __MACH_MX6Q_H__
-
-#define MX6Q_IO_P2V(x)			IMX_IO_P2V(x)
-#define MX6Q_IO_ADDRESS(x)		IOMEM(MX6Q_IO_P2V(x))
-
-/*
- * The following are the blocks that need to be statically mapped.
- * For other blocks, the base address really should be retrieved from
- * device tree.
- */
-#define MX6Q_SCU_BASE_ADDR		0x00a00000
-#define MX6Q_SCU_SIZE			0x1000
-#define MX6Q_CCM_BASE_ADDR		0x020c4000
-#define MX6Q_CCM_SIZE			0x4000
-#define MX6Q_ANATOP_BASE_ADDR		0x020c8000
-#define MX6Q_ANATOP_SIZE		0x1000
-
-#endif	/* __MACH_MX6Q_H__ */
-- 
1.7.9.5
