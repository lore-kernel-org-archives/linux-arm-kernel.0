From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:24:56 +0900
Subject: [PATCH 005/130] ARM: shmobile: add GPIO IRQ macro
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-6-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

R-Car series gpio_rcar driver can control GPIO IRQ today.
It needs base IRQ number for gpio_rcar_config :: .irq_base
This patch adds macro for GPIO IRQ.
This patch was tested on Bock-W board

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/irqs.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-shmobile/include/mach/irqs.h b/arch/arm/mach-shmobile/include/mach/irqs.h
index b2074e2..d241bfd 100644
--- a/arch/arm/mach-shmobile/include/mach/irqs.h
+++ b/arch/arm/mach-shmobile/include/mach/irqs.h
@@ -16,4 +16,9 @@
 #define IRQPIN_BASE		2000
 #define irq_pin(nr)		((nr) + IRQPIN_BASE)
 
+/* GPIO IRQ */
+#define _GPIO_IRQ_BASE		2500
+#define GPIO_IRQ_BASE(x)	(_GPIO_IRQ_BASE + (32 * x))
+#define GPIO_IRQ(x, y)		(_GPIO_IRQ_BASE + (32 * x) + y)
+
 #endif /* __ASM_MACH_IRQS_H */
-- 
1.8.2.1
