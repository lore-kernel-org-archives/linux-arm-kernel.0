From: philipp.zabel@gmail.com (Philipp Zabel)
Date: Wed, 27 Apr 2011 20:49:45 +0200
Subject: [PATCH] pxa/magician: align MAGICIAN_EGPIO_BASE with NR_BUILTIN_GPIO
Message-ID: <1303930187.14964.5.camel@flow>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit a0a4dcbca73a418477f439e812193e2591b46751
"ARM: pxa: align NR_BUILTIN_GPIO with GPIO interrupt number"
increased NR_BUILTIN_GPIO from 128 to PXA_GPIO_IRQ_NUM (192).
Adjust the previously hardcoded MAGICIAN_EGPIO_BASE accordingly.

Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
---
 arch/arm/mach-pxa/include/mach/magician.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/magician.h b/arch/arm/mach-pxa/include/mach/magician.h
index 0a2efcf..e9e6162 100644
--- a/arch/arm/mach-pxa/include/mach/magician.h
+++ b/arch/arm/mach-pxa/include/mach/magician.h
@@ -12,6 +12,7 @@
 #ifndef _MAGICIAN_H_
 #define _MAGICIAN_H_
 
+#include <mach/gpio.h>
 #include <mach/irqs.h>
 
 /*
@@ -77,7 +78,7 @@
  * CPLD EGPIOs
  */
 
-#define MAGICIAN_EGPIO_BASE			0x80 /* GPIO_BOARD_START */
+#define MAGICIAN_EGPIO_BASE			NR_BUILTIN_GPIO
 #define MAGICIAN_EGPIO(reg,bit) \
 	(MAGICIAN_EGPIO_BASE + 8*reg + bit)
 
-- 
1.7.4.4
