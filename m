From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 21 Sep 2013 09:11:45 -0500
Subject: [PATCH 1/2] ARM: sunxi: Split out the DT machines for sun6i and sun7i
Message-ID: <1379772706-7028-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A20 and A31 SMP code have a different way of bringing up a new core.
This will prevent us from using the same set of smp_operations for the
two SoCs family.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/mach-sunxi/sunxi.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
index e79fb34..e0641dd 100644
--- a/arch/arm/mach-sunxi/sunxi.c
+++ b/arch/arm/mach-sunxi/sunxi.c
@@ -133,8 +133,6 @@ static const char * const sunxi_board_dt_compat[] = {
 	"allwinner,sun4i-a10",
 	"allwinner,sun5i-a10s",
 	"allwinner,sun5i-a13",
-	"allwinner,sun6i-a31",
-	"allwinner,sun7i-a20",
 	NULL,
 };
 
@@ -143,3 +141,25 @@ DT_MACHINE_START(SUNXI_DT, "Allwinner A1X (Device Tree)")
 	.init_time	= sunxi_timer_init,
 	.dt_compat	= sunxi_board_dt_compat,
 MACHINE_END
+
+static const char * const sun6i_board_dt_compat[] = {
+	"allwinner,sun6i-a31",
+	NULL,
+};
+
+DT_MACHINE_START(SUN6I_DT, "Allwinner sun6i (A31) Family")
+	.init_machine	= sunxi_dt_init,
+	.init_time	= sunxi_timer_init,
+	.dt_compat	= sun6i_board_dt_compat,
+MACHINE_END
+
+static const char * const sun7i_board_dt_compat[] = {
+	"allwinner,sun7i-a20",
+	NULL,
+};
+
+DT_MACHINE_START(SUN7I_DT, "Allwinner sun7i (A20) Family")
+	.init_machine	= sunxi_dt_init,
+	.init_time	= sunxi_timer_init,
+	.dt_compat	= sun7i_board_dt_compat,
+MACHINE_END
-- 
1.8.4
