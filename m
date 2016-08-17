From: andy.gross@linaro.org (Andy Gross)
Date: Tue, 16 Aug 2016 23:21:58 -0500
Subject: [PATCH] ARM: qcom: Cleanup/Remove unnecessary board file
Message-ID: <1471407718-4219-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes the unnecessary board file.  The generic machine
definition is sufficient for the Qualcomm platforms.

Signed-off-by: Andy Gross <andy.gross@linaro.org>
---
 arch/arm/mach-qcom/Makefile |  1 -
 arch/arm/mach-qcom/board.c  | 31 -------------------------------
 2 files changed, 32 deletions(-)
 delete mode 100644 arch/arm/mach-qcom/board.c

diff --git a/arch/arm/mach-qcom/Makefile b/arch/arm/mach-qcom/Makefile
index e324375..12878e9 100644
--- a/arch/arm/mach-qcom/Makefile
+++ b/arch/arm/mach-qcom/Makefile
@@ -1,2 +1 @@
-obj-y			:= board.o
 obj-$(CONFIG_SMP)	+= platsmp.o
diff --git a/arch/arm/mach-qcom/board.c b/arch/arm/mach-qcom/board.c
deleted file mode 100644
index d8060df..0000000
--- a/arch/arm/mach-qcom/board.c
+++ /dev/null
@@ -1,31 +0,0 @@
-/* Copyright (c) 2010-2014 The Linux Foundation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#include <linux/init.h>
-
-#include <asm/mach/arch.h>
-
-static const char * const qcom_dt_match[] __initconst = {
-	"qcom,apq8064",
-	"qcom,apq8074-dragonboard",
-	"qcom,apq8084",
-	"qcom,ipq8062",
-	"qcom,ipq8064",
-	"qcom,msm8660-surf",
-	"qcom,msm8960-cdp",
-	"qcom,mdm9615",
-	NULL
-};
-
-DT_MACHINE_START(QCOM_DT, "Qualcomm (Flattened Device Tree)")
-	.dt_compat = qcom_dt_match,
-MACHINE_END
-- 
1.9.1
