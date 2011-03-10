From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 9 Mar 2011 18:48:24 -0700 (MST)
Subject: [PATCH] OMAP4: hwmod: Disable hardware-controlled idle for GPT1
Message-ID: <alpine.DEB.2.00.1103091847150.15132@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


From: Rajendra Nayak <rnayak@ti.com>

Some issues seen (which cause lockups in suspend) with GPT1
after the MPU<->L4_WKUP static dependency was cleared can be
Worked-around for now by forcing GPT1 in software
controlled idle.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Beno?t Cousson <b-cousson@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 7b72316..cfe957a 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -4005,6 +4005,7 @@ static struct omap_hwmod_ocp_if *omap44xx_timer1_slaves[] = {
 static struct omap_hwmod omap44xx_timer1_hwmod = {
 	.name		= "timer1",
 	.class		= &omap44xx_timer_1ms_hwmod_class,
+	.flags		= HWMOD_SWSUP_SIDLE,
 	.mpu_irqs	= omap44xx_timer1_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_timer1_irqs),
 	.main_clk	= "timer1_fck",
-- 
1.7.2.3
