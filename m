From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 20 Aug 2012 22:20:00 +0800
Subject: [PATCH 6/6] ARM: mxs: remove mach/irqs.h
In-Reply-To: <1345472400-31262-1-git-send-email-shawn.guo@linaro.org>
References: <1345472400-31262-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1345472400-31262-7-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With SPARSE_IRQ adopted for mach-mxs, header mach/irqs.h is needed
nowhere now, so remove it.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-mxs/include/mach/irqs.h |   32 --------------------------------
 1 files changed, 0 insertions(+), 32 deletions(-)
 delete mode 100644 arch/arm/mach-mxs/include/mach/irqs.h

diff --git a/arch/arm/mach-mxs/include/mach/irqs.h b/arch/arm/mach-mxs/include/mach/irqs.h
deleted file mode 100644
index f771039..0000000
--- a/arch/arm/mach-mxs/include/mach/irqs.h
+++ /dev/null
@@ -1,32 +0,0 @@
-/*
- *  Copyright 2004-2007 Freescale Semiconductor, Inc. All Rights Reserved.
- */
-
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __MACH_MXS_IRQS_H__
-#define __MACH_MXS_IRQS_H__
-
-#define MXS_INTERNAL_IRQS	128
-
-#define MXS_GPIO_IRQ_START	MXS_INTERNAL_IRQS
-
-/* the maximum for MXS-based */
-#define MXS_GPIO_IRQS		(32 * 5)
-
-/*
- * The next 16 interrupts are for board specific purposes.  Since
- * the kernel can only run on one machine at a time, we can re-use
- * these.  If you need more, increase MXS_BOARD_IRQS, but keep it
- * within sensible limits.
- */
-#define MXS_BOARD_IRQ_START	(MXS_GPIO_IRQ_START + MXS_GPIO_IRQS)
-#define MXS_BOARD_IRQS		16
-
-#define NR_IRQS			(MXS_BOARD_IRQ_START + MXS_BOARD_IRQS)
-
-#endif /* __MACH_MXS_IRQS_H__ */
-- 
1.7.5.4
