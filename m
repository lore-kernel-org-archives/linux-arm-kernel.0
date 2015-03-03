From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  3 Mar 2015 15:40:56 +0100
Subject: [PATCH v3 01/20] ARM: mvebu: add __initconst specifiers on
 DT_MACHINE_START dt_compat tables
In-Reply-To: <1425393675-17820-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1425393675-17820-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1425393675-17820-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As suggested by Stephen Boyd, this commit adds the __initconst
specifier to the dt_compat table declarations used by the
DT_MACHINE_START structures in mach-mvebu land.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/board-v7.c | 6 +++---
 arch/arm/mach-mvebu/dove.c     | 2 +-
 arch/arm/mach-mvebu/kirkwood.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
index 89a139e..31b66f2 100644
--- a/arch/arm/mach-mvebu/board-v7.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@ -184,7 +184,7 @@ static void __init mvebu_dt_init(void)
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
-static const char * const armada_370_xp_dt_compat[] = {
+static const char * const armada_370_xp_dt_compat[] __initconst = {
 	"marvell,armada-370-xp",
 	NULL,
 };
@@ -205,7 +205,7 @@ DT_MACHINE_START(ARMADA_370_XP_DT, "Marvell Armada 370/XP (Device Tree)")
 	.dt_compat	= armada_370_xp_dt_compat,
 MACHINE_END
 
-static const char * const armada_375_dt_compat[] = {
+static const char * const armada_375_dt_compat[] __initconst = {
 	"marvell,armada375",
 	NULL,
 };
@@ -219,7 +219,7 @@ DT_MACHINE_START(ARMADA_375_DT, "Marvell Armada 375 (Device Tree)")
 	.dt_compat	= armada_375_dt_compat,
 MACHINE_END
 
-static const char * const armada_38x_dt_compat[] = {
+static const char * const armada_38x_dt_compat[] __initconst = {
 	"marvell,armada380",
 	"marvell,armada385",
 	NULL,
diff --git a/arch/arm/mach-mvebu/dove.c b/arch/arm/mach-mvebu/dove.c
index b50464e..5a17415 100644
--- a/arch/arm/mach-mvebu/dove.c
+++ b/arch/arm/mach-mvebu/dove.c
@@ -27,7 +27,7 @@ static void __init dove_init(void)
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
-static const char * const dove_dt_compat[] = {
+static const char * const dove_dt_compat[] __initconst = {
 	"marvell,dove",
 	NULL
 };
diff --git a/arch/arm/mach-mvebu/kirkwood.c b/arch/arm/mach-mvebu/kirkwood.c
index 6b53108..925f75f 100644
--- a/arch/arm/mach-mvebu/kirkwood.c
+++ b/arch/arm/mach-mvebu/kirkwood.c
@@ -186,7 +186,7 @@ static void __init kirkwood_dt_init(void)
 	of_platform_populate(NULL, of_default_bus_match_table, auxdata, NULL);
 }
 
-static const char * const kirkwood_dt_board_compat[] = {
+static const char * const kirkwood_dt_board_compat[] __initconst = {
 	"marvell,kirkwood",
 	NULL
 };
-- 
2.1.0
