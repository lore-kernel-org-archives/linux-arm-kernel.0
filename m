From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 30 Jul 2013 22:49:32 +0200
Subject: [PATCHv2 03/10] ARM: sunxi: Add the Allwinner A31 compatible to the
 machine definition
In-Reply-To: <1375217379-15126-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1375217379-15126-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1375217379-15126-4-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner A31 is a quad-Cortex-A7 based SoC, which shares a lot of
IPs with the previous SoCs from Allwinner, like the PIO, I2C, UARTs,
timers, watchdog IPs, but also differs by dropping the WEMAC ethernet
controller and most notably dropping the in-house IRQ controller in
favor of a ARM GIC one.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/mach-sunxi/Kconfig | 2 ++
 arch/arm/mach-sunxi/sunxi.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index 5b045e3..3ab2f65 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -10,3 +10,5 @@ config ARCH_SUNXI
 	select SPARSE_IRQ
 	select SUN4I_TIMER
 	select PINCTRL_SUNXI
+	select ARM_GIC
+	select HAVE_SMP
diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
index 38a3c55..11326d9 100644
--- a/arch/arm/mach-sunxi/sunxi.c
+++ b/arch/arm/mach-sunxi/sunxi.c
@@ -96,6 +96,7 @@ static const char * const sunxi_board_dt_compat[] = {
 	"allwinner,sun4i-a10",
 	"allwinner,sun5i-a10s",
 	"allwinner,sun5i-a13",
+	"allwinner,sun6i-a31",
 	NULL,
 };
 
-- 
1.8.3.4
