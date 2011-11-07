From: balbi@ti.com (Felipe Balbi)
Date: Mon,  7 Nov 2011 19:56:57 +0200
Subject: [PATCH] arm: omap2+: hwmod: fix breakage introduced by d6504acd
Message-ID: <1320688617-4543-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit d6504acd (OMAP2+: hwmod: remove OMAP_CHIP*) has
mistakenly added MUSB as a hwmod available only on ES2.0
of OMAP3430.

MUSB hwmod has always be available on all OMAP revisions
since OMAP2430.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 3008e16..74f1454 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -3232,7 +3232,6 @@ static __initdata struct omap_hwmod *omap3430es1_hwmods[] = {
 /* 3430ES2+-only hwmods */
 static __initdata struct omap_hwmod *omap3430es2plus_hwmods[] = {
 	&omap3xxx_dss_core_hwmod,
-	&omap3xxx_usbhsotg_hwmod,
 	NULL
 };
 
@@ -3240,6 +3239,7 @@ static __initdata struct omap_hwmod *omap3430es2plus_hwmods[] = {
 static __initdata struct omap_hwmod *omap34xx_hwmods[] = {
 	&omap34xx_sr1_hwmod,
 	&omap34xx_sr2_hwmod,
+	&omap3xxx_usbhsotg_hwmod,
 	NULL
 };
 
-- 
1.7.8.rc0
