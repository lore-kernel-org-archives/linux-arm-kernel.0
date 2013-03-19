From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 19 Mar 2013 11:19:33 +0900
Subject: [PATCH 11/14] ARM: shmobile: Make sh73a0 INTC irqpin platform data
 static
In-Reply-To: <1363659576-6333-1-git-send-email-horms+renesas@verge.net.au>
References: <1363659576-6333-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363659576-6333-12-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

The platform data for the INTC irq pin driver
seems to be global symbols, make it static to
allow multi-soc build.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-sh73a0.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index 638735f..e8cd93a 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -812,7 +812,7 @@ static struct platform_device ipmmu_device = {
 	.num_resources  = ARRAY_SIZE(ipmmu_resources),
 };
 
-struct renesas_intc_irqpin_config irqpin0_platform_data = {
+static struct renesas_intc_irqpin_config irqpin0_platform_data = {
 	.irq_base = irq_pin(0), /* IRQ0 -> IRQ7 */
 };
 
@@ -842,7 +842,7 @@ static struct platform_device irqpin0_device = {
 	},
 };
 
-struct renesas_intc_irqpin_config irqpin1_platform_data = {
+static struct renesas_intc_irqpin_config irqpin1_platform_data = {
 	.irq_base = irq_pin(8), /* IRQ8 -> IRQ15 */
 	.control_parent = true, /* Disable spurious IRQ10 */
 };
@@ -873,7 +873,7 @@ static struct platform_device irqpin1_device = {
 	},
 };
 
-struct renesas_intc_irqpin_config irqpin2_platform_data = {
+static struct renesas_intc_irqpin_config irqpin2_platform_data = {
 	.irq_base = irq_pin(16), /* IRQ16 -> IRQ23 */
 };
 
@@ -903,7 +903,7 @@ static struct platform_device irqpin2_device = {
 	},
 };
 
-struct renesas_intc_irqpin_config irqpin3_platform_data = {
+static struct renesas_intc_irqpin_config irqpin3_platform_data = {
 	.irq_base = irq_pin(24), /* IRQ24 -> IRQ31 */
 };
 
-- 
1.7.10.4
