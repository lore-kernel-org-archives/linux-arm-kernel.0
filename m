From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 21:05:56 +0900
Subject: [PATCH 12/14] ARM: shmobile: Make r8a7779 INTC irqpin platform data
 static
In-Reply-To: <1363608358-24215-1-git-send-email-horms+renesas@verge.net.au>
References: <1363608358-24215-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363608358-24215-13-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

The platform data for the INTC irq pin driver
seems to be global symbols, make it static to
allow multi-soc build.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/intc-r8a7779.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/intc-r8a7779.c b/arch/arm/mach-shmobile/intc-r8a7779.c
index fb0363c..b86dc89 100644
--- a/arch/arm/mach-shmobile/intc-r8a7779.c
+++ b/arch/arm/mach-shmobile/intc-r8a7779.c
@@ -42,7 +42,7 @@
 #define INT2NTSR0 IOMEM(0xfe700060)
 #define INT2NTSR1 IOMEM(0xfe700064)
 
-struct renesas_intc_irqpin_config irqpin0_platform_data = {
+static struct renesas_intc_irqpin_config irqpin0_platform_data = {
 	.irq_base = irq_pin(0), /* IRQ0 -> IRQ3 */
 	.sense_bitfield_width = 2,
 };
-- 
1.7.10.4
