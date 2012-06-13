From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 13 Jun 2012 15:55:47 +0200
Subject: [PATCH] arm: tegra: build powergate unconditionally
Message-ID: <1339595767-9140-1-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

powergate functions are needed for tegra30 as well (see common.c), so
build it always. Fixes:

arch/arm/mach-tegra/built-in.o: In function `tegra30_init_early':
apbio.c:(.init.text+0x78): undefined reference to `tegra_powergate_init'

(using "allnoconfig" with tegra30 enabled)

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 arch/arm/mach-tegra/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index 2eb4445..35253fd 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -8,9 +8,9 @@ obj-y                                   += timer.o
 obj-y					+= fuse.o
 obj-y					+= pmc.o
 obj-y					+= flowctrl.o
+obj-y					+= powergate.o
 obj-$(CONFIG_CPU_IDLE)			+= cpuidle.o
 obj-$(CONFIG_CPU_IDLE)			+= sleep.o
-obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= powergate.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += tegra2_clocks.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= tegra2_emc.o
 obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= board-dt-tegra30.o
-- 
1.7.10
