From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 5 Feb 2013 20:48:33 +0100
Subject: [PATCH 12/14] ARM: ux500: use real AB8500 IRQ numbers instead of
 virtual ones
In-Reply-To: <1360093715-6348-1-git-send-email-linus.walleij@stericsson.com>
References: <1360093715-6348-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1360093715-6348-13-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lee Jones <lee.jones@linaro.org>

Any devices wishing to use the AB8500's GPIO IRQs were forced to
request virtual IRQs from the gpio-ab8500 driver. Now that
responsibility has been passed back to the AB8500 core driver,
devices can request real IRQ numbers instead. This patch removes
any traces of the old virtual IRQ conversion handlers, which will
force any drivers requesting IRQs to use real IRQS.

Cc: arm at kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Requesting an ACK from the ARM SoC maintainers on this patch.
---
 arch/arm/mach-ux500/include/mach/irqs-board-mop500.h | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/arm/mach-ux500/include/mach/irqs-board-mop500.h b/arch/arm/mach-ux500/include/mach/irqs-board-mop500.h
index 7d34c52..d526dd8 100644
--- a/arch/arm/mach-ux500/include/mach/irqs-board-mop500.h
+++ b/arch/arm/mach-ux500/include/mach/irqs-board-mop500.h
@@ -38,15 +38,7 @@
 #define MOP500_STMPE1601_IRQ_END	\
 	MOP500_STMPE1601_IRQ(STMPE_NR_INTERNAL_IRQS)
 
-/* AB8500 virtual gpio IRQ */
-#define AB8500_VIR_GPIO_NR_IRQS			16
-
-#define MOP500_AB8500_VIR_GPIO_IRQ_BASE		\
-	MOP500_STMPE1601_IRQ_END
-#define MOP500_AB8500_VIR_GPIO_IRQ_END		\
-	(MOP500_AB8500_VIR_GPIO_IRQ_BASE + AB8500_VIR_GPIO_NR_IRQS)
-
-#define MOP500_NR_IRQS		MOP500_AB8500_VIR_GPIO_IRQ_END
+#define MOP500_NR_IRQS		MOP500_STMPE1601_IRQ_END
 
 #define MOP500_IRQ_END		MOP500_NR_IRQS
 
-- 
1.7.11.3
