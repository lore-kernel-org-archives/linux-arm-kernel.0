From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 20 Jun 2014 22:52:50 +0800
Subject: [PATCH v3 1/4] ARM: sunxi: Introduce Allwinner A23 support
In-Reply-To: <1403275973-24259-1-git-send-email-wens@csie.org>
References: <1403275973-24259-1-git-send-email-wens@csie.org>
Message-ID: <1403275973-24259-2-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner A23 is a dual-core Cortex-A7-based SoC. It re-uses most of
the IPs found in previous SoCs, notably the A31.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/mach-sunxi/Kconfig | 5 +++++
 arch/arm/mach-sunxi/sunxi.c | 9 +++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index 0fbd4f1..f776c5f 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -35,4 +35,9 @@ config MACH_SUN7I
 	select HAVE_ARM_ARCH_TIMER
 	select SUN5I_HSTIMER
 
+config MACH_SUN8I
+	bool "Allwinner A23 (sun8i) SoCs support"
+	default ARCH_SUNXI
+	select ARM_GIC
+
 endif
diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
index 3f9587b..4d09469 100644
--- a/arch/arm/mach-sunxi/sunxi.c
+++ b/arch/arm/mach-sunxi/sunxi.c
@@ -53,3 +53,12 @@ static const char * const sun7i_board_dt_compat[] = {
 DT_MACHINE_START(SUN7I_DT, "Allwinner sun7i (A20) Family")
 	.dt_compat	= sun7i_board_dt_compat,
 MACHINE_END
+
+static const char * const sun8i_board_dt_compat[] = {
+	"allwinner,sun8i-a23",
+	NULL,
+};
+
+DT_MACHINE_START(SUN8I_DT, "Allwinner sun8i (A23) Family")
+	.dt_compat	= sun8i_board_dt_compat,
+MACHINE_END
-- 
2.0.0
