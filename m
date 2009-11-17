From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Tue, 17 Nov 2009 22:15:47 +0100
Subject: [PATCH 08/10] IXP4xx: Remove unused Motorola PrPMC1100 platform
	macros.
Message-ID: <1258492549-16873-8-git-send-email-khc@pm.waw.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Krzysztof Ha?asa <khc@pm.waw.pl>

PrPMC1100 is handled by IXDP425 platform code, there is no need for
duplicate set of macros. Remove them.

Signed-off-by: Krzysztof Ha?asa <khc@pm.waw.pl>
---
 arch/arm/mach-ixp4xx/include/mach/hardware.h  |    3 --
 arch/arm/mach-ixp4xx/include/mach/irqs.h      |    8 ------
 arch/arm/mach-ixp4xx/include/mach/prpmc1100.h |   33 -------------------------
 3 files changed, 0 insertions(+), 44 deletions(-)
 delete mode 100644 arch/arm/mach-ixp4xx/include/mach/prpmc1100.h

diff --git a/arch/arm/mach-ixp4xx/include/mach/hardware.h b/arch/arm/mach-ixp4xx/include/mach/hardware.h
index 8558073..f9d1c43 100644
--- a/arch/arm/mach-ixp4xx/include/mach/hardware.h
+++ b/arch/arm/mach-ixp4xx/include/mach/hardware.h
@@ -43,7 +43,4 @@
 /* Platform helper functions and definitions */
 #include "platform.h"
 
-/* Platform specific details */
-#include "prpmc1100.h"
-
 #endif  /* _ASM_ARCH_HARDWARE_H */
diff --git a/arch/arm/mach-ixp4xx/include/mach/irqs.h b/arch/arm/mach-ixp4xx/include/mach/irqs.h
index e256997..dbc20bf 100644
--- a/arch/arm/mach-ixp4xx/include/mach/irqs.h
+++ b/arch/arm/mach-ixp4xx/include/mach/irqs.h
@@ -70,12 +70,4 @@
 
 #define	XSCALE_PMU_IRQ		(IRQ_IXP4XX_XSCALE_PMU)
 
-/*
- * PrPMC1100 Board IRQs
- */
-#define	IRQ_PRPMC1100_PCI_INTA	IRQ_IXP4XX_GPIO11
-#define	IRQ_PRPMC1100_PCI_INTB	IRQ_IXP4XX_GPIO10
-#define	IRQ_PRPMC1100_PCI_INTC	IRQ_IXP4XX_GPIO9
-#define	IRQ_PRPMC1100_PCI_INTD	IRQ_IXP4XX_GPIO8
-
 #endif
diff --git a/arch/arm/mach-ixp4xx/include/mach/prpmc1100.h b/arch/arm/mach-ixp4xx/include/mach/prpmc1100.h
deleted file mode 100644
index 17274a2..0000000
--- a/arch/arm/mach-ixp4xx/include/mach/prpmc1100.h
+++ /dev/null
@@ -1,33 +0,0 @@
-/*
- * arch/arm/mach-ixp4xx/include/mach/prpmc1100.h
- *
- * Motorolla PrPMC1100 platform specific definitions
- *
- * Author: Deepak Saxena <dsaxena@plexity.net>
- *
- * Copyright 2004 (c) MontaVista, Software, Inc. 
- * 
- * This file is licensed under  the terms of the GNU General Public 
- * License version 2. This program is licensed "as is" without any 
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __ASM_ARCH_HARDWARE_H__
-#error "Do not include this directly, instead #include <mach/hardware.h>"
-#endif
-
-#define	PRPMC1100_FLASH_BASE	IXP4XX_EXP_BUS_CS0_BASE_PHYS
-#define	PRPMC1100_FLASH_SIZE	IXP4XX_EXP_BUS_CSX_REGION_SIZE
-
-#define	PRPMC1100_PCI_MIN_DEVID	10
-#define	PRPMC1100_PCI_MAX_DEVID	16
-#define	PRPMC1100_PCI_IRQ_LINES	4
-
-
-/* PCI controller GPIO to IRQ pin mappings */
-#define PRPMC1100_PCI_INTA_PIN	11
-#define PRPMC1100_PCI_INTB_PIN	10
-#define	PRPMC1100_PCI_INTC_PIN	9
-#define	PRPMC1100_PCI_INTD_PIN	8
-
-
-- 
1.6.5.2
