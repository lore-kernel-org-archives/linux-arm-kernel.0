From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 28 Mar 2014 15:12:49 +0000
Subject: [PATCH 00/75] l2c series
Message-ID: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is another posting of the L2 cache controller series.  I'm not
planning for this for the upcoming merge window, but the one after,
as people need to test it and still need to feed back to me on
various issues.  Hence, this is not a finalised series.

There are still various issues which I've raised, and have had no
feedback on.

This series is being posted with Cc's on the individual patches.

 arch/arm/Kconfig                                   |   51 -
 arch/arm/boot/dts/imx6qdl.dtsi                     |    2 +
 arch/arm/boot/dts/imx6sl.dtsi                      |    2 +
 arch/arm/boot/dts/marco.dtsi                       |    2 +-
 arch/arm/boot/dts/prima2.dtsi                      |    2 +-
 arch/arm/include/asm/hardware/cache-l2x0.h         |  104 +-
 arch/arm/include/asm/outercache.h                  |   67 +-
 arch/arm/mach-berlin/berlin.c                      |    2 +-
 arch/arm/mach-cns3xxx/core.c                       |   10 +-
 arch/arm/mach-exynos/common.c                      |    5 +-
 arch/arm/mach-highbank/highbank.c                  |   18 +-
 arch/arm/mach-imx/mach-vf610.c                     |    2 +-
 arch/arm/mach-imx/system.c                         |    8 +-
 arch/arm/mach-mvebu/armada-370-xp.c                |    2 +-
 arch/arm/mach-nomadik/cpu-8815.c                   |    2 +-
 arch/arm/mach-omap2/omap-mpuss-lowpower.c          |    2 +-
 arch/arm/mach-omap2/omap4-common.c                 |   79 +-
 arch/arm/mach-prima2/l2x0.c                        |   35 +-
 arch/arm/mach-prima2/pm.c                          |    1 -
 arch/arm/mach-realview/realview_eb.c               |    9 +-
 arch/arm/mach-realview/realview_pb1176.c           |    8 +-
 arch/arm/mach-realview/realview_pb11mp.c           |    9 +-
 arch/arm/mach-realview/realview_pbx.c              |    4 +-
 arch/arm/mach-rockchip/rockchip.c                  |    2 +-
 .../board-armadillo800eva-reference.c              |    4 +-
 arch/arm/mach-shmobile/board-armadillo800eva.c     |    4 +-
 arch/arm/mach-shmobile/board-kzm9g-reference.c     |    4 +-
 arch/arm/mach-shmobile/board-kzm9g.c               |    4 +-
 arch/arm/mach-shmobile/setup-r8a7778.c             |    4 +-
 arch/arm/mach-shmobile/setup-r8a7779.c             |    4 +-
 arch/arm/mach-socfpga/socfpga.c                    |    2 +-
 arch/arm/mach-spear/platsmp.c                      |   19 +-
 arch/arm/mach-spear/spear13xx.c                    |    8 +-
 arch/arm/mach-sti/board-dt.c                       |   12 +-
 arch/arm/mach-tegra/sleep.h                        |    8 +-
 arch/arm/mach-tegra/tegra.c                        |   18 +-
 arch/arm/mach-ux500/cache-l2x0.c                   |   32 +-
 arch/arm/mach-vexpress/ct-ca9x4.c                  |   28 +-
 arch/arm/mach-zynq/common.c                        |    2 +-
 arch/arm/mm/Kconfig                                |   51 +
 arch/arm/mm/Makefile                               |    1 +
 arch/arm/mm/cache-feroceon-l2.c                    |    1 -
 arch/arm/mm/cache-l2x0.c                           | 1520 +++++++++++++-------
 arch/arm/mm/l2c-common.c                           |   20 +
 arch/arm/plat-samsung/s5p-sleep.S                  |    8 +-
 45 files changed, 1382 insertions(+), 800 deletions(-)


-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
