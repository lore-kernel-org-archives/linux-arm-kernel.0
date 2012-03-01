From: alan@signal11.us (Alan Ott)
Date: Thu,  1 Mar 2012 14:26:46 -0500
Subject: [PATCH 4/8] ARM: tegra: build localtimer support only when needed
In-Reply-To: <1330630010-11241-1-git-send-email-alan@signal11.us>
References: <1330630010-11241-1-git-send-email-alan@signal11.us>
Message-ID: <1330630010-11241-5-git-send-email-alan@signal11.us>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

It is possible to build a tegra kernel without localtimer
support, so the tegra specific parts should only be built
when that is indeed enabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-tegra/Makefile |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index e120ff5..a956df8 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -13,7 +13,8 @@ obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= tegra2_emc.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= pinmux-tegra20-tables.o
 obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= pinmux-tegra30-tables.o
 obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= board-dt-tegra30.o
-obj-$(CONFIG_SMP)                       += platsmp.o localtimer.o headsmp.o
+obj-$(CONFIG_SMP)                       += platsmp.o headsmp.o
+obj-$(CONFIG_LOCAL_TIMERS)		+= localtimer.o
 obj-$(CONFIG_HOTPLUG_CPU)               += hotplug.o
 obj-$(CONFIG_TEGRA_SYSTEM_DMA)		+= dma.o
 obj-$(CONFIG_CPU_FREQ)                  += cpu-tegra.o
-- 
1.7.0.4
