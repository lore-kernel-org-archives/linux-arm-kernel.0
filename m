From: dwalker@codeaurora.org (Daniel Walker)
Date: Wed, 12 May 2010 14:45:46 -0700
Subject: [PATCH 17/25] msm: add msm_iomap-7x30.h for MSM7x30 support
In-Reply-To: <>
References: <>
Message-ID: <1273700754-10256-18-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a header describing the io regions for MSM7x30.

Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
Signed-off-by: David Brown <davidb@codeaurora.org>
Signed-off-by: Gregory Bean <gbean@codeaurora.org>
Signed-off-by: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
Signed-off-by: Stepan Moskovchenko <stepanm@codeaurora.org>
---
 arch/arm/mach-msm/include/mach/msm_iomap-7x30.h |  122 +++++++++++++++++++++++
 arch/arm/mach-msm/include/mach/msm_iomap.h      |    4 +-
 2 files changed, 125 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-msm/include/mach/msm_iomap-7x30.h

diff --git a/arch/arm/mach-msm/include/mach/msm_iomap-7x30.h b/arch/arm/mach-msm/include/mach/msm_iomap-7x30.h
new file mode 100644
index 0000000..8a00c2d
--- /dev/null
+++ b/arch/arm/mach-msm/include/mach/msm_iomap-7x30.h
@@ -0,0 +1,122 @@
+/*
+ * Copyright (C) 2007 Google, Inc.
+ * Copyright (c) 2008-2010, Code Aurora Forum. All rights reserved.
+ * Author: Brian Swetland <swetland@google.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ *
+ * The MSM peripherals are spread all over across 768MB of physical
+ * space, which makes just having a simple IO_ADDRESS macro to slide
+ * them into the right virtual location rough.  Instead, we will
+ * provide a master phys->virt mapping for peripherals here.
+ *
+ */
+
+#ifndef __ASM_ARCH_MSM_IOMAP_7X30_H
+#define __ASM_ARCH_MSM_IOMAP_7X30_H
+
+/* Physical base address and size of peripherals.
+ * Ordered by the virtual base addresses they will be mapped at.
+ *
+ * MSM_VIC_BASE must be an value that can be loaded via a "mov"
+ * instruction, otherwise entry-macro.S will not compile.
+ *
+ * If you add or remove entries here, you'll want to edit the
+ * msm_io_desc array in arch/arm/mach-msm/io.c to reflect your
+ * changes.
+ *
+ */
+
+#define MSM_VIC_BASE          IOMEM(0xE0000000)
+#define MSM_VIC_PHYS          0xC0080000
+#define MSM_VIC_SIZE          SZ_4K
+
+#define MSM_CSR_BASE          IOMEM(0xE0001000)
+#define MSM_CSR_PHYS          0xC0100000
+#define MSM_CSR_SIZE          SZ_4K
+
+#define MSM_TMR_PHYS          MSM_CSR_PHYS
+#define MSM_TMR_BASE          MSM_CSR_BASE
+#define MSM_TMR_SIZE          SZ_4K
+
+#define MSM_GPT_BASE 	      (MSM_TMR_BASE + 0x4)
+#define MSM_DGT_BASE 	      (MSM_TMR_BASE + 0x24)
+
+#define MSM_DMOV_BASE         IOMEM(0xE0002000)
+#define MSM_DMOV_PHYS         0xAC400000
+#define MSM_DMOV_SIZE         SZ_4K
+
+#define MSM_GPIO1_BASE        IOMEM(0xE0003000)
+#define MSM_GPIO1_PHYS        0xAC001000
+#define MSM_GPIO1_SIZE        SZ_4K
+
+#define MSM_GPIO2_BASE        IOMEM(0xE0004000)
+#define MSM_GPIO2_PHYS        0xAC101000
+#define MSM_GPIO2_SIZE        SZ_4K
+
+#define MSM_CLK_CTL_BASE      IOMEM(0xE0005000)
+#define MSM_CLK_CTL_PHYS      0xAB800000
+#define MSM_CLK_CTL_SIZE      SZ_4K
+
+#define MSM_CLK_CTL_SH2_BASE  IOMEM(0xE0006000)
+#define MSM_CLK_CTL_SH2_PHYS  0xABA01000
+#define MSM_CLK_CTL_SH2_SIZE  SZ_4K
+
+#define MSM_ACC_BASE          IOMEM(0xE0007000)
+#define MSM_ACC_PHYS          0xC0101000
+#define MSM_ACC_SIZE          SZ_4K
+
+#define MSM_SAW_BASE          IOMEM(0xE0008000)
+#define MSM_SAW_PHYS          0xC0102000
+#define MSM_SAW_SIZE          SZ_4K
+
+#define MSM_GCC_BASE	      IOMEM(0xE0009000)
+#define MSM_GCC_PHYS	      0xC0182000
+#define MSM_GCC_SIZE	      SZ_4K
+
+#define MSM_TCSR_BASE	      IOMEM(0xE000A000)
+#define MSM_TCSR_PHYS	      0xAB600000
+#define MSM_TCSR_SIZE	      SZ_4K
+
+#define MSM_SHARED_RAM_BASE   IOMEM(0xE0100000)
+#define MSM_SHARED_RAM_PHYS   0x00100000
+#define MSM_SHARED_RAM_SIZE   SZ_1M
+
+#define MSM_UART1_PHYS        0xACA00000
+#define MSM_UART1_SIZE        SZ_4K
+
+#define MSM_UART2_PHYS        0xACB00000
+#define MSM_UART2_SIZE        SZ_4K
+
+#define MSM_UART3_PHYS        0xACC00000
+#define MSM_UART3_SIZE        SZ_4K
+
+#ifdef CONFIG_MSM_DEBUG_UART
+#define MSM_DEBUG_UART_BASE   0xE1000000
+#if CONFIG_MSM_DEBUG_UART == 1
+#define MSM_DEBUG_UART_PHYS   MSM_UART1_PHYS
+#elif CONFIG_MSM_DEBUG_UART == 2
+#define MSM_DEBUG_UART_PHYS   MSM_UART2_PHYS
+#elif CONFIG_MSM_DEBUG_UART == 3
+#define MSM_DEBUG_UART_PHYS   MSM_UART3_PHYS
+#endif
+#define MSM_DEBUG_UART_SIZE   SZ_4K
+#endif
+
+#define MSM_MDC_BASE	      IOMEM(0xE0200000)
+#define MSM_MDC_PHYS	      0xAA500000
+#define MSM_MDC_SIZE	      SZ_1M
+
+#define MSM_AD5_BASE          IOMEM(0xE0300000)
+#define MSM_AD5_PHYS          0xA7000000
+#define MSM_AD5_SIZE          (SZ_1M*13)
+
+#endif
diff --git a/arch/arm/mach-msm/include/mach/msm_iomap.h b/arch/arm/mach-msm/include/mach/msm_iomap.h
index 7043d7a..e6b1821 100644
--- a/arch/arm/mach-msm/include/mach/msm_iomap.h
+++ b/arch/arm/mach-msm/include/mach/msm_iomap.h
@@ -43,7 +43,9 @@
 #define IOMEM(x)	((void __force __iomem *)(x))
 #endif
 
-#if defined(CONFIG_ARCH_QSD8X50)
+#if defined(CONFIG_ARCH_MSM7X30)
+#include "msm_iomap-7x30.h"
+#elif defined(CONFIG_ARCH_QSD8X50)
 #include "msm_iomap-8x50.h"
 #else
 #include "msm_iomap-7x00.h"
-- 
1.6.2.3
