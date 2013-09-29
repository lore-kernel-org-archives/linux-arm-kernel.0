From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sun, 29 Sep 2013 21:38:10 +0200
Subject: [GIT PULL] ARM: provide common arch init for DT clocks for v3.13
Message-ID: <1380483490-12173-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Kevin, Olof,

please pull these patches for the arch-wide call to of_clk_init for v3.13.
There are two dependencies for this patch set, one for tegra and one for nomadik.

The pull request for the tegra dependencies can be found here:
http://www.spinics.net/lists/arm-kernel/msg273957.html

The patch for nomadik, that should hit before v3.13 can be found here:
http://www.spinics.net/lists/arm-kernel/msg273376.html

As this is my first PR ever, please do not hesitate to report back any issues
with this PR as soon as possible.

----------------------------------------------------------------

The following changes since commit eb6b036dde364c528807f53ee8c8e5c9b0e46c34:

  clk: nomadik: set all timers to use 2.4 MHz TIMCLK (2013-09-22 19:52:46 +0200)

are available in the git repository at:

  https://github.com/shesselba/linux-dove.git clk-of-init-v2_for-3.13

for you to fetch changes up to 64cc69abbb32e17aa44d2c696eca65cb6f9364ca:

  ARM: vt8500: remove custom .init_time hook (2013-09-29 21:09:49 +0200)

----------------------------------------------------------------
Matt Porter (1):
      ARM: bcm: provide common arch init for DT clocks

Sebastian Hesselbarth (26):
      ARM: nomadik: remove mtu initalization from .init_time
      clk: nomadik: move src init out of nomadik_clk_init
      clk: nomadik: declare OF clock provider
      clk: prima2: declare OF clock provider
      ARM: socfgpa: prepare for arch-wide .init_time callback
      clk: sunxi: declare OF clock provider
      clk: vt8500: parse pmc_base from clock driver
      ARM: vt8500: prepare for arch-wide .init_time callback
      ARM: call of_clk_init from default time_init handler
      ARM: bcm2835: remove custom .init_time hook
      ARM: dove: remove custom .init_time hook
      ARM: exynos: remove custom .init_time hook
      ARM: highbank: remove custom .init_time hook
      ARM: imx: remove custom .init_time hook
      ARM: kirkwood: remove custom .init_time hook
      ARM: mxs: remove custom .init_time hook
      ARM: nomadik: remove custom .init_time hook
      ARM: nspire: remove custom .init_time hook
      ARM: prima2: remove custom .init_time hook
      ARM: rockchip: remove custom .init_time hook
      ARM: socfpga: remove custom .init_time hook
      ARM: sti: remove custom .init_time hook
      ARM: sunxi: remove custom .init_time hook
      ARM: tegra: remove custom .init_time hook
      ARM: vexpress: remove custom .init_time hook
      ARM: vt8500: remove custom .init_time hook

 arch/arm/kernel/time.c                    |   29 +++--
 arch/arm/mach-bcm/board_bcm281xx.c        |    1 -
 arch/arm/mach-bcm2835/bcm2835.c           |    2 -
 arch/arm/mach-dove/board-dt.c             |   11 --
 arch/arm/mach-exynos/common.c             |    8 --
 arch/arm/mach-exynos/common.h             |    1 -
 arch/arm/mach-exynos/mach-exynos4-dt.c    |    2 -
 arch/arm/mach-exynos/mach-exynos5-dt.c    |    2 -
 arch/arm/mach-highbank/highbank.c         |   23 ++--
 arch/arm/mach-imx/clk-imx51-imx53.c       |   29 ++---
 arch/arm/mach-imx/common.h                |    4 -
 arch/arm/mach-imx/imx51-dt.c              |    6 -
 arch/arm/mach-imx/mach-imx53.c            |    6 -
 arch/arm/mach-imx/mach-imx6q.c            |   14 +--
 arch/arm/mach-imx/mach-imx6sl.c           |    7 --
 arch/arm/mach-imx/mach-vf610.c            |    9 --
 arch/arm/mach-kirkwood/board-dt.c         |    8 --
 arch/arm/mach-mxs/mach-mxs.c              |   13 --
 arch/arm/mach-nomadik/cpu-8815.c          |   36 ------
 arch/arm/mach-nspire/nspire.c             |    9 --
 arch/arm/mach-prima2/common.c             |   11 --
 arch/arm/mach-prima2/common.h             |    1 -
 arch/arm/mach-rockchip/rockchip.c         |    9 --
 arch/arm/mach-socfpga/socfpga.c           |    2 -
 arch/arm/mach-sti/board-dt.c              |   10 +-
 arch/arm/mach-sunxi/sunxi.c               |   10 --
 arch/arm/mach-tegra/tegra.c               |    9 --
 arch/arm/mach-vexpress/v2m.c              |   14 +--
 arch/arm/mach-vt8500/common.h             |   24 ----
 arch/arm/mach-vt8500/vt8500.c             |    6 -
 drivers/clk/clk-bcm2835.c                 |    8 --
 drivers/clk/clk-highbank.c                |   10 +-
 drivers/clk/clk-nomadik.c                 |  187 ++++++++++++++---------------
 drivers/clk/clk-prima2.c                  |   29 +----
 drivers/clk/clk-vt8500.c                  |   34 ++++--
 drivers/clk/mxs/clk-imx23.c               |   15 +--
 drivers/clk/mxs/clk-imx28.c               |   16 +--
 drivers/clk/sunxi/clk-sunxi.c             |   11 +-
 include/linux/clk/mxs.h                   |    2 -
 include/linux/clk/sunxi.h                 |   22 ----
 include/linux/platform_data/clk-nomadik.h |    2 -
 41 files changed, 189 insertions(+), 463 deletions(-)
 delete mode 100644 arch/arm/mach-vt8500/common.h
 delete mode 100644 include/linux/clk/sunxi.h
 delete mode 100644 include/linux/platform_data/clk-nomadik.h
