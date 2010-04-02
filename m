From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 02 Apr 2010 07:57:35 +0200
Subject: [PATCH] ARM: Samsung: fix broken timer irq base
Message-ID: <1270187855-9342-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Timer interrupts range is defined as 43-47, what overlaps with VIC0 range
(32-64). This is probably a typo which occured while the common interrupts
definition was refactored. This patch moves timer interrupt range to safe
area of 11-15 (just before uart range).

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-s5p/include/plat/irqs.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-s5p/include/plat/irqs.h b/arch/arm/plat-s5p/include/plat/irqs.h
index 42e757f..9ff3d71 100644
--- a/arch/arm/plat-s5p/include/plat/irqs.h
+++ b/arch/arm/plat-s5p/include/plat/irqs.h
@@ -79,7 +79,7 @@
 #define S5P_IRQ_VIC2(x)		(S5P_VIC2_BASE + (x))
 #define S5P_IRQ_VIC3(x)		(S5P_VIC3_BASE + (x))
 
-#define S5P_TIMER_IRQ(x)	S5P_IRQ(11 + (x))
+#define S5P_TIMER_IRQ(x)	(11 + (x))
 
 #define IRQ_TIMER0		S5P_TIMER_IRQ(0)
 #define IRQ_TIMER1		S5P_TIMER_IRQ(1)
-- 
1.6.4
