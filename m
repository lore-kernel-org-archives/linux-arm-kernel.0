From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 14 May 2014 17:50:39 +0200
Subject: [RFC PATCHv1 5/7] ARM: mvebu: split Armada 370 and Armada XP
 machine_desc
In-Reply-To: <1400082641-23871-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1400082641-23871-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1400082641-23871-6-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Armada 370 and Armada XP will need a different set of machine_desc
flags, so we need to separate their machine_desc definitions: one will
be taking care of the "marvell,armada370" compatible string, and the
other will be taking care of the "marvell,armadaxp" compatible string.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/board-v7.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
index 01cfce6..8b4b44b 100644
--- a/arch/arm/mach-mvebu/board-v7.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@ -176,17 +176,28 @@ static void __init mvebu_dt_init(void)
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
-static const char * const armada_370_xp_dt_compat[] = {
-	"marvell,armada-370-xp",
+static const char * const armada_370_dt_compat[] = {
+	"marvell,armada370",
 	NULL,
 };
 
-DT_MACHINE_START(ARMADA_370_XP_DT, "Marvell Armada 370/XP (Device Tree)")
-	.smp		= smp_ops(armada_xp_smp_ops),
+DT_MACHINE_START(ARMADA_370_DT, "Marvell Armada 370 (Device Tree)")
 	.init_machine	= mvebu_dt_init,
 	.init_time	= mvebu_timer_and_clk_init,
 	.restart	= mvebu_restart,
-	.dt_compat	= armada_370_xp_dt_compat,
+	.dt_compat	= armada_370_dt_compat,
+MACHINE_END
+
+static const char * const armada_xp_dt_compat[] = {
+	"marvell,armadaxp",
+	NULL,
+};
+
+DT_MACHINE_START(ARMADA_XP_DT, "Marvell Armada XP (Device Tree)")
+	.init_machine	= mvebu_dt_init,
+	.init_time	= mvebu_timer_and_clk_init,
+	.restart	= mvebu_restart,
+	.dt_compat	= armada_xp_dt_compat,
 MACHINE_END
 
 static const char * const armada_375_dt_compat[] = {
-- 
1.9.3
