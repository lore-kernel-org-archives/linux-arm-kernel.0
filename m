From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Wed,  1 Feb 2012 09:49:47 +0100
Subject: [PATCH 08/20] ARM: OMAP3+: hwmod: add SmartReflex IRQs
In-Reply-To: <1328086199-28486-1-git-send-email-j-pihet@ti.com>
References: <1328086199-28486-1-git-send-email-j-pihet@ti.com>
Message-ID: <1328086199-28486-9-git-send-email-j-pihet@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nishanth Menon <nm@ti.com>

OMAP3 SmartReflex IRQs in hwmod structures with the same naming as
present in OMAP4. Without these IRQs being registered, SmartReflex
driver will be unable to get the IRQ numbers to handle notifications

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index a201ff5..b224ea2 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -377,6 +377,16 @@ static struct omap_hwmod_ocp_if omap3_l4_core__i2c3 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+static struct omap_hwmod_irq_info omap3_smartreflex_mpu_irqs[] = {
+	{ .name = "sr1_irq", .irq = 18},
+	{ .irq = -1 }
+};
+
+static struct omap_hwmod_irq_info omap3_smartreflex_core_irqs[] = {
+	{ .name = "sr2_irq", .irq = 19},
+	{ .irq = -1 }
+};
+
 /* L4 CORE -> SR1 interface */
 static struct omap_hwmod_addr_space omap3_sr1_addr_space[] = {
 	{
@@ -2667,6 +2677,7 @@ static struct omap_hwmod omap34xx_sr1_hwmod = {
 	.slaves		= omap3_sr1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3_sr1_slaves),
 	.dev_attr	= &sr1_dev_attr,
+	.mpu_irqs	= omap3_smartreflex_mpu_irqs,
 	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
@@ -2686,6 +2697,7 @@ static struct omap_hwmod omap36xx_sr1_hwmod = {
 	.slaves		= omap3_sr1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3_sr1_slaves),
 	.dev_attr	= &sr1_dev_attr,
+	.mpu_irqs	= omap3_smartreflex_mpu_irqs,
 };
 
 /* SR2 */
@@ -2713,6 +2725,7 @@ static struct omap_hwmod omap34xx_sr2_hwmod = {
 	.slaves		= omap3_sr2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3_sr2_slaves),
 	.dev_attr	= &sr2_dev_attr,
+	.mpu_irqs	= omap3_smartreflex_core_irqs,
 	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
@@ -2732,6 +2745,7 @@ static struct omap_hwmod omap36xx_sr2_hwmod = {
 	.slaves		= omap3_sr2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3_sr2_slaves),
 	.dev_attr	= &sr2_dev_attr,
+	.mpu_irqs	= omap3_smartreflex_core_irqs,
 };
 
 /*
-- 
1.7.5.4
