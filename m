From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 29 Feb 2012 17:25:05 +0200
Subject: [PATCHv3 3/4] TEMP: ARM: OMAP4: hwmod_data: Do not get DSP out of
 reset at boot time
In-Reply-To: <1330529106-10423-1-git-send-email-t-kristo@ti.com>
References: <1330529106-10423-1-git-send-email-t-kristo@ti.com>
Message-ID: <1330529106-10423-4-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rajendra Nayak <rnayak@ti.com>

With no driver handling DSP, if brought out of reset, it stays
active and does not assert standby. This leads to IVAHD powerdomain not
transitioning and hence preventing chip retention.

This patch is no longer needed once Paul's powerdomain fixes are merged:
   http://marc.info/?l=linux-omap&m=133040749621183&w=2

Just provided for testing purposes.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index ef0524c..81d90da 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -1160,6 +1160,7 @@ static struct omap_hwmod omap44xx_dsp_hwmod = {
 	.name		= "dsp",
 	.class		= &omap44xx_dsp_hwmod_class,
 	.clkdm_name	= "tesla_clkdm",
+	.flags		= HWMOD_INIT_NO_RESET,
 	.mpu_irqs	= omap44xx_dsp_irqs,
 	.rst_lines	= omap44xx_dsp_resets,
 	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_dsp_resets),
-- 
1.7.4.1
