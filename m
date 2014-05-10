From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Sat, 10 May 2014 15:56:30 +0900
Subject: [PATCH v4 03/11] ARM: EXYNOS: Move SYSREG definition into sys-reg
 specific file.
In-Reply-To: <1399704998-13321-1-git-send-email-pankaj.dubey@samsung.com>
References: <1399704998-13321-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1399704998-13321-4-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Young-Gun Jang <yg1004.jang@samsung.com>

While making PMU implementation to be device tree based, there are
few register offsets related with SYSREG present in regs-pmu.h, so
let's make a new header file "regs-sys.h" to keep all such SYSREG
related register offsets and remove them from "regs-pmu.h"

Signed-off-by: Young-Gun Jang <yg1004.jang@samsung.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/mach-exynos/exynos.c   |    1 +
 arch/arm/mach-exynos/pm.c       |    1 +
 arch/arm/mach-exynos/regs-pmu.h |    3 ---
 arch/arm/mach-exynos/regs-sys.h |   22 ++++++++++++++++++++++
 4 files changed, 24 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-exynos/regs-sys.h

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 288e414..e4a4be0 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -31,6 +31,7 @@
 #include "common.h"
 #include "mfc.h"
 #include "regs-pmu.h"
+#include "regs-sys.h"
 
 #define L2_AUX_VAL 0x7C470001
 #define L2_AUX_MASK 0xC200ffff
diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index b380d48..f445c49 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -36,6 +36,7 @@
 
 #include "common.h"
 #include "regs-pmu.h"
+#include "regs-sys.h"
 
 /**
  * struct exynos_wkup_irq - Exynos GIC to PMU IRQ mapping
diff --git a/arch/arm/mach-exynos/regs-pmu.h b/arch/arm/mach-exynos/regs-pmu.h
index 6c1d2db..b68b5cc 100644
--- a/arch/arm/mach-exynos/regs-pmu.h
+++ b/arch/arm/mach-exynos/regs-pmu.h
@@ -15,7 +15,6 @@
 #include <mach/map.h>
 
 #define S5P_PMUREG(x)				(S5P_VA_PMU + (x))
-#define S5P_SYSREG(x)				(S3C_VA_SYS + (x))
 
 #define S5P_CENTRAL_SEQ_CONFIGURATION		S5P_PMUREG(0x0200)
 
@@ -178,8 +177,6 @@
 
 /* For EXYNOS5 */
 
-#define EXYNOS5_SYS_I2C_CFG					S5P_SYSREG(0x0234)
-
 #define EXYNOS5_AUTO_WDTRESET_DISABLE				S5P_PMUREG(0x0408)
 #define EXYNOS5_MASK_WDTRESET_REQUEST				S5P_PMUREG(0x040C)
 
diff --git a/arch/arm/mach-exynos/regs-sys.h b/arch/arm/mach-exynos/regs-sys.h
new file mode 100644
index 0000000..84332b0
--- /dev/null
+++ b/arch/arm/mach-exynos/regs-sys.h
@@ -0,0 +1,22 @@
+/*
+ * Copyright (c) 2014 Samsung Electronics Co., Ltd.
+ *             http://www.samsung.com
+ *
+ * EXYNOS - system register definition
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_REGS_SYS_H
+#define __ASM_ARCH_REGS_SYS_H __FILE__
+
+#include <mach/map.h>
+
+#define S5P_SYSREG(x)                          (S3C_VA_SYS + (x))
+
+/* For EXYNOS5 */
+#define EXYNOS5_SYS_I2C_CFG                    S5P_SYSREG(0x0234)
+
+#endif /* __ASM_ARCH_REGS_SYS_H */
-- 
1.7.10.4
