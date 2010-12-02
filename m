From: mattias.wallin@stericsson.com (Mattias Wallin)
Date: Thu, 2 Dec 2010 13:46:00 +0100
Subject: [PATCH] ARM: mach-ux500: AB8500 irqs is taken from header file
Message-ID: <1291293960-23124-1-git-send-email-mattias.wallin@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes the dublicated define for number of
interrupts and instead include the needed header file.

Signed-off-by: Mattias Wallin <mattias.wallin@stericsson.com>
---
 .../mach-ux500/include/mach/irqs-board-mop500.h    |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ux500/include/mach/irqs-board-mop500.h b/arch/arm/mach-ux500/include/mach/irqs-board-mop500.h
index 7ee8aaa..4a91bbd 100644
--- a/arch/arm/mach-ux500/include/mach/irqs-board-mop500.h
+++ b/arch/arm/mach-ux500/include/mach/irqs-board-mop500.h
@@ -8,7 +8,8 @@
 #ifndef __MACH_IRQS_BOARD_MOP500_H
 #define __MACH_IRQS_BOARD_MOP500_H
 
-#define AB8500_NR_IRQS			104
+/* Number of AB8500 irqs is taken from header file */
+#include <linux/mfd/ab8500.h>
 
 #define MOP500_AB8500_IRQ_BASE		IRQ_BOARD_START
 #define MOP500_AB8500_IRQ_END		(MOP500_AB8500_IRQ_BASE \
-- 
1.7.2.2
