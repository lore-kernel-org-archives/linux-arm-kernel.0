From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 28 Apr 2014 20:24:19 +0100
Subject: [PATCH 00/98] Full L2C patch series
Message-ID: <20140428192419.GV26756@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Not much to say which hasn't already been said... except I'm reaching
the end of my teather with this series.

I'll push it out shortly as my "to-build" branch - which is a branch
which gets automatic separate build testing by Olof's system.

 arch/arm/Kconfig                                   |   51 -
 arch/arm/boot/dts/marco.dtsi                       |    2 +-
 arch/arm/boot/dts/prima2.dtsi                      |    2 +-
 arch/arm/include/asm/hardware/cache-l2x0.h         |  104 +-
 arch/arm/include/asm/mach/arch.h                   |    3 +
 arch/arm/include/asm/outercache.h                  |   67 +-
 arch/arm/kernel/irq.c                              |   12 +
 arch/arm/mach-bcm/bcm_5301x.c                      |    9 +-
 arch/arm/mach-berlin/berlin.c                      |   17 +-
 arch/arm/mach-cns3xxx/core.c                       |   10 +-
 arch/arm/mach-exynos/common.h                      |    1 -
 arch/arm/mach-exynos/exynos.c                      |   21 +-
 arch/arm/mach-exynos/sleep.S                       |   30 +-
 arch/arm/mach-highbank/highbank.c                  |   21 +-
 arch/arm/mach-imx/mach-vf610.c                     |    9 +-
 arch/arm/mach-imx/suspend-imx6.S                   |   24 +-
 arch/arm/mach-imx/system.c                         |    8 +-
 arch/arm/mach-mvebu/board-v7.c                     |    9 +-
 arch/arm/mach-nomadik/cpu-8815.c                   |   13 +-
 arch/arm/mach-omap2/Kconfig                        |    1 +
 arch/arm/mach-omap2/common.h                       |    1 +
 arch/arm/mach-omap2/io.c                           |    2 +
 arch/arm/mach-omap2/omap-mpuss-lowpower.c          |   16 +-
 arch/arm/mach-omap2/omap4-common.c                 |   86 +-
 arch/arm/mach-prima2/Makefile                      |    1 -
 arch/arm/mach-prima2/common.c                      |    6 +
 arch/arm/mach-prima2/l2x0.c                        |   49 -
 arch/arm/mach-prima2/pm.c                          |    1 -
 arch/arm/mach-realview/realview_eb.c               |    9 +-
 arch/arm/mach-realview/realview_pb1176.c           |    8 +-
 arch/arm/mach-realview/realview_pb11mp.c           |    9 +-
 arch/arm/mach-realview/realview_pbx.c              |    4 +-
 arch/arm/mach-rockchip/rockchip.c                  |    9 +-
 .../board-armadillo800eva-reference.c              |    4 +-
 arch/arm/mach-shmobile/board-armadillo800eva.c     |    4 +-
 arch/arm/mach-shmobile/board-kzm9g-reference.c     |    4 +-
 arch/arm/mach-shmobile/board-kzm9g.c               |    4 +-
 arch/arm/mach-shmobile/setup-r8a7778.c             |    4 +-
 arch/arm/mach-shmobile/setup-r8a7779.c             |    4 +-
 arch/arm/mach-socfpga/socfpga.c                    |    9 +-
 arch/arm/mach-spear/platsmp.c                      |   19 +-
 arch/arm/mach-spear/spear13xx.c                    |    8 +-
 arch/arm/mach-sti/board-dt.c                       |   26 +-
 arch/arm/mach-tegra/pm.h                           |    2 -
 arch/arm/mach-tegra/reset-handler.S                |   11 +-
 arch/arm/mach-tegra/sleep.h                        |   31 -
 arch/arm/mach-tegra/tegra.c                        |   32 +-
 arch/arm/mach-ux500/cache-l2x0.c                   |   32 +-
 arch/arm/mach-vexpress/ct-ca9x4.c                  |   28 +-
 arch/arm/mach-vexpress/v2m.c                       |    3 +-
 arch/arm/mach-zynq/common.c                        |    8 +-
 arch/arm/mm/Kconfig                                |   51 +
 arch/arm/mm/Makefile                               |    3 +-
 arch/arm/mm/cache-feroceon-l2.c                    |    1 -
 arch/arm/mm/cache-l2x0.c                           | 1504 +++++++++++++-------
 arch/arm/mm/l2c-common.c                           |   20 +
 arch/arm/mm/l2c-l2x0-resume.S                      |   58 +
 arch/arm/plat-samsung/s5p-sleep.S                  |    1 -
 58 files changed, 1470 insertions(+), 1016 deletions(-)

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
