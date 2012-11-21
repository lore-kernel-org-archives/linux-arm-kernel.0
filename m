From: robherring2@gmail.com (Rob Herring)
Date: Tue, 20 Nov 2012 20:58:27 -0600
Subject: [PATCH 3/9] ARM: GIC: remove assembly ifdefs from gic.h
In-Reply-To: <1353466713-18967-1-git-send-email-robherring2@gmail.com>
References: <1353466713-18967-1-git-send-email-robherring2@gmail.com>
Message-ID: <1353466713-18967-4-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

With multi irq handler and all GIC users converted to it, we don't need
asm/hardware/gic.h to be included in assembly. Clean-up ifdefs and
unnecessary includes.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/include/asm/hardware/gic.h |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/include/asm/hardware/gic.h b/arch/arm/include/asm/hardware/gic.h
index 4b1ce6c..fc59698 100644
--- a/arch/arm/include/asm/hardware/gic.h
+++ b/arch/arm/include/asm/hardware/gic.h
@@ -10,8 +10,6 @@
 #ifndef __ASM_ARM_HARDWARE_GIC_H
 #define __ASM_ARM_HARDWARE_GIC_H
 
-#include <linux/compiler.h>
-
 #define GIC_CPU_CTRL			0x00
 #define GIC_CPU_PRIMASK			0x04
 #define GIC_CPU_BINPOINT		0x08
@@ -32,8 +30,6 @@
 #define GIC_DIST_CONFIG			0xc00
 #define GIC_DIST_SOFTINT		0xf00
 
-#ifndef __ASSEMBLY__
-#include <linux/irqdomain.h>
 struct device_node;
 
 extern struct irq_chip gic_arch_extn;
@@ -53,5 +49,3 @@ static inline void gic_init(unsigned int nr, int start,
 }
 
 #endif
-
-#endif
-- 
1.7.10.4
