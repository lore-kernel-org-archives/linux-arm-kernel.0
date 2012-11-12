From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 12 Nov 2012 18:20:35 +0100
Subject: [PATCH 2/6] arm: mvebu: don't list all boards in dt compat field for
 Armada 370/XP
In-Reply-To: <1352740839-13586-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1352740839-13586-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1352740839-13586-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of listing explicitly all boards in the .dt_compat field of
the DT_MACHINE_START structure for Armada 370/XP, use instead a
compatible string that is common to all boards using the Armada
370/XP.

This allows to add new boards by just using a different Device Tree,
without having to modify the source code of the kernel.

Note that the name of the array containing the compatible string is
also renamed, to reflect the fact that it no longer contains the list
of all boards.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Tested-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
This might be considered 3.7 material if not late. Otherwise, there's
no big deal if it goes into 3.8.
---
 arch/arm/mach-mvebu/armada-370-xp.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-mvebu/armada-370-xp.c b/arch/arm/mach-mvebu/armada-370-xp.c
index 49d7915..29c27cd 100644
--- a/arch/arm/mach-mvebu/armada-370-xp.c
+++ b/arch/arm/mach-mvebu/armada-370-xp.c
@@ -46,9 +46,8 @@ static void __init armada_370_xp_dt_init(void)
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
-static const char * const armada_370_xp_dt_board_dt_compat[] = {
-	"marvell,a370-db",
-	"marvell,axp-db",
+static const char * const armada_370_xp_dt_compat[] = {
+	"marvell,armada-370-xp",
 	NULL,
 };
 
@@ -59,5 +58,5 @@ DT_MACHINE_START(ARMADA_XP_DT, "Marvell Aramada 370/XP (Device Tree)")
 	.handle_irq     = armada_370_xp_handle_irq,
 	.timer		= &armada_370_xp_timer,
 	.restart	= mvebu_restart,
-	.dt_compat	= armada_370_xp_dt_board_dt_compat,
+	.dt_compat	= armada_370_xp_dt_compat,
 MACHINE_END
-- 
1.7.9.5
