From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 19 Mar 2013 11:19:24 +0900
Subject: [PATCH 02/14] ARM: shmobile: irq_pin() for static IRQ pin assignment
In-Reply-To: <1363659576-6333-1-git-send-email-horms+renesas@verge.net.au>
References: <1363659576-6333-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363659576-6333-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add the macro irq_pin() to let board-specific code using
platform devices tie in external IRQn pins in a common way.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/irqs.h |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-shmobile/include/mach/irqs.h b/arch/arm/mach-shmobile/include/mach/irqs.h
index 992ed21..b2074e2 100644
--- a/arch/arm/mach-shmobile/include/mach/irqs.h
+++ b/arch/arm/mach-shmobile/include/mach/irqs.h
@@ -12,4 +12,8 @@
 #define INTCS_VECT(n, vect)	INTC_VECT((n), INTCS_VECT_BASE + (vect))
 #define intcs_evt2irq(evt)	evt2irq(INTCS_VECT_BASE + (evt))
 
+/* External IRQ pins */
+#define IRQPIN_BASE		2000
+#define irq_pin(nr)		((nr) + IRQPIN_BASE)
+
 #endif /* __ASM_MACH_IRQS_H */
-- 
1.7.10.4
