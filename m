From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  7 Jun 2013 17:22:07 +0900
Subject: [PATCH 09/11] ARM: shmobile: marzen: Use INTC External IRQ pin driver
 for SMSC
In-Reply-To: <1370593329-27559-1-git-send-email-horms+renesas@verge.net.au>
References: <1370593329-27559-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370593329-27559-10-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the marzen board to use the INTC External IRQ pin driver for SMSC.

This code was originally posted by Magnus Damm as part of
"ARM: shmobile: INTC External IRQ pin driver on r8a7779"
but somehow omitted when I applied that patch.

Cc: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-marzen.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index fac9e0f..71f174e 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -69,7 +69,7 @@ static struct resource smsc911x_resources[] = {
 		.flags		= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start		= gic_iid(0x3c), /* IRQ 1 */
+		.start		= irq_pin(1), /* IRQ 1 */
 		.flags		= IORESOURCE_IRQ,
 	},
 };
@@ -405,6 +405,7 @@ static void __init marzen_init(void)
 	pinctrl_register_mappings(marzen_pinctrl_map,
 				  ARRAY_SIZE(marzen_pinctrl_map));
 	r8a7779_pinmux_init();
+	r8a7779_init_irq_extpin(1); /* IRQ1 as individual interrupt */
 
 	r8a7779_add_standard_devices();
 	platform_add_devices(marzen_devices, ARRAY_SIZE(marzen_devices));
-- 
1.8.2.1
