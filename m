From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri, 12 Mar 2010 12:26:03 -0500
Subject: [PATCH] [ARM] pxa: reserve more irq for board
Message-ID: <mailman.452.1274095154.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By default, only 16 IRQs are reserved for board IRQ. While genirq is used,
more board IRQs should be reserved. Now update the default BOARD IRQs to 64.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-pxa/include/mach/irqs.h |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/irqs.h
b/arch/arm/mach-pxa/include/mach/irqs.h
index ffc8314..010c205 100644
--- a/arch/arm/mach-pxa/include/mach/irqs.h
+++ b/arch/arm/mach-pxa/include/mach/irqs.h
@@ -127,12 +127,8 @@

 #if defined(CONFIG_MACH_H4700)
 #define IRQ_BOARD_END		(IRQ_BOARD_START + 70)
-#elif defined(CONFIG_MACH_ZYLONITE)
-#define IRQ_BOARD_END		(IRQ_BOARD_START + 32)
-#elif defined(CONFIG_PXA_EZX)
-#define IRQ_BOARD_END		(IRQ_BOARD_START + 23)
 #else
-#define IRQ_BOARD_END		(IRQ_BOARD_START + 16)
+#define IRQ_BOARD_END		(IRQ_BOARD_START + 64)
 #endif

 /*
-- 
1.5.6.5
