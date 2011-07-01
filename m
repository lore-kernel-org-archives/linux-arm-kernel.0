From: b-cousson@ti.com (Benoit Cousson)
Date: Fri, 1 Jul 2011 22:41:37 +0200
Subject: [PATCH v2 14/18] OMAP4: hwmod data: Remove un-needed parens
In-Reply-To: <1309552901-8944-1-git-send-email-b-cousson@ti.com>
References: <1309552901-8944-1-git-send-email-b-cousson@ti.com>
Message-ID: <1309552901-8944-15-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A couple of parens were added around some flags.

Remove them, since they are not needed and not used
for any other hwmods.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 58843df..199e689 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -3733,7 +3733,7 @@ static struct omap_hwmod_ocp_if *omap44xx_mpu_masters[] = {
 static struct omap_hwmod omap44xx_mpu_hwmod = {
 	.name		= "mpu",
 	.class		= &omap44xx_mpu_hwmod_class,
-	.flags		= (HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET),
+	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
 	.mpu_irqs	= omap44xx_mpu_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_mpu_irqs),
 	.main_clk	= "dpll_mpu_m2_ck",
@@ -4744,7 +4744,7 @@ static struct omap_hwmod_ocp_if *omap44xx_uart3_slaves[] = {
 static struct omap_hwmod omap44xx_uart3_hwmod = {
 	.name		= "uart3",
 	.class		= &omap44xx_uart_hwmod_class,
-	.flags		= (HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET),
+	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
 	.mpu_irqs	= omap44xx_uart3_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_uart3_irqs),
 	.sdma_reqs	= omap44xx_uart3_sdma_reqs,
-- 
1.7.0.4
