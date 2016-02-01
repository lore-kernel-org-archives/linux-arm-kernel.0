From: andre.przywara@arm.com (Andre Przywara)
Date: Mon,  1 Feb 2016 17:39:20 +0000
Subject: [PATCH 01/11] irqchip: sun4i: fix compilation outside of arch/arm
In-Reply-To: <1454348370-3816-1-git-send-email-andre.przywara@arm.com>
References: <1454348370-3816-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1454348370-3816-2-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner sunxi specific interrupt controller cannot be compiled
for any architecture except arm:

drivers/irqchip/irq-sun4i.c:25:26: fatal error: asm/mach/irq.h: No such file or directory
compilation terminated.

It turns out that this header is actually not needed for the driver,
so remove it and allow compilation for other architectures like
arm64.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/irqchip/irq-sun4i.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/irqchip/irq-sun4i.c b/drivers/irqchip/irq-sun4i.c
index 0704362..376b280 100644
--- a/drivers/irqchip/irq-sun4i.c
+++ b/drivers/irqchip/irq-sun4i.c
@@ -22,7 +22,6 @@
 #include <linux/of_irq.h>
 
 #include <asm/exception.h>
-#include <asm/mach/irq.h>
 
 #define SUN4I_IRQ_VECTOR_REG		0x00
 #define SUN4I_IRQ_PROTECTION_REG	0x08
-- 
2.6.4
