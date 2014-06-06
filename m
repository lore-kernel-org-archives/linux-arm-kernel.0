From: nm@ti.com (Nishanth Menon)
Date: Thu, 5 Jun 2014 22:35:57 -0500
Subject: [RFC PATCH 3/7] ARM: OMAP4+: PRM: remove "wkup" event
In-Reply-To: <1402025761-16831-1-git-send-email-nm@ti.com>
References: <1402025761-16831-1-git-send-email-nm@ti.com>
Message-ID: <1402025761-16831-4-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"wkup" event at bit offset 0 exists only on OMAP3.
OMAP4430/60 PRM_IRQSTATUS_A9, OMAP5/DRA7 PRM_IRQSTATUS_MPU

register bit 0 is DPLL_CORE_RECAL_ST not wakeup event like OMAP3.

The same applies to AM437x as well.

Remove the wrong definition.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/prm44xx.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index d4d745e..1ecf244 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -32,7 +32,6 @@
 /* Static data */
 
 static const struct omap_prcm_irq omap4_prcm_irqs[] = {
-	OMAP_PRCM_IRQ("wkup",   0,      0),
 	OMAP_PRCM_IRQ("io",     9,      1),
 };
 
-- 
1.7.9.5
