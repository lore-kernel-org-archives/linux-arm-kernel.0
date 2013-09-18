From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 18 Sep 2013 15:47:11 -0400
Subject: [PATCH 00/26] ARM: provide common arch init for DT clocks
In-Reply-To: <1379526839-14798-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1379526839-14798-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130918194711.GR19937@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sebastian,

On Wed, Sep 18, 2013 at 07:53:33PM +0200, Sebastian Hesselbarth wrote:
...
> Sebastian Hesselbarth (26):
>   ARM: nomadik: move mtu setup to clocksource init
>   clk: nomadik: move src init out of nomadik_clk_init
>   clk: nomadik: declare OF clock provider
>   clk: prima2: declare OF clock provider
>   ARM: socfgpa: prepare for arch-wide .init_time callback
>   clk: sunxi: declare OF clock provider
>   clk: vt8500: parse pmc_base from clock driver
>   ARM: vt8500: prepare for arch-wide .init_time callback
>   ARM: call of_clk_init from default time_init handler
>   ARM: bcm2835: remove custom .init_time hook
>   ARM: dove: remove custom .init_time hook
>   ARM: exynos: remove custom .init_time hook
>   ARM: highbank: remove custom .init_time hook
>   ARM: imx: remove custom .init_time hook
>   ARM: kirkwood: remove custom .init_time hook
>   ARM: mxs: remove custom .init_time hook
>   ARM: nomadik: remove custom .init_time hook
>   ARM: nspire: remove custom .init_time hook
>   ARM: prima2: remove custom .init_time hook
>   ARM: rockchip: remove custom .init_time hook
>   ARM: socfpga: remove custom .init_time hook
>   ARM: sti: remove custom .init_time hook
>   ARM: sunxi: remove custom .init_time hook
>   ARM: tegra: remove custom .init_time hook
>   ARM: vexpress: remove custom .init_time hook
>   ARM: vt8500: remove custom .init_time hook
> 
>  arch/arm/kernel/time.c                    |   27 ++---
>  arch/arm/mach-bcm2835/bcm2835.c           |    2 -
>  arch/arm/mach-dove/board-dt.c             |   11 --
>  arch/arm/mach-exynos/common.c             |    8 --
>  arch/arm/mach-exynos/common.h             |    1 -
>  arch/arm/mach-exynos/mach-exynos4-dt.c    |    2 -
>  arch/arm/mach-exynos/mach-exynos5-dt.c    |    2 -
>  arch/arm/mach-highbank/highbank.c         |   23 ++---
>  arch/arm/mach-imx/clk-imx51-imx53.c       |   29 ++----
>  arch/arm/mach-imx/common.h                |    4 -
>  arch/arm/mach-imx/imx51-dt.c              |    6 --
>  arch/arm/mach-imx/mach-imx53.c            |    6 --
>  arch/arm/mach-imx/mach-imx6q.c            |   14 +--
>  arch/arm/mach-imx/mach-imx6sl.c           |    7 --
>  arch/arm/mach-imx/mach-vf610.c            |    9 --
>  arch/arm/mach-kirkwood/board-dt.c         |    8 --
>  arch/arm/mach-mxs/mach-mxs.c              |   13 ---
>  arch/arm/mach-nomadik/cpu-8815.c          |   36 -------
>  arch/arm/mach-nspire/nspire.c             |    9 --
>  arch/arm/mach-prima2/common.c             |   11 --
>  arch/arm/mach-prima2/common.h             |    1 -
>  arch/arm/mach-rockchip/rockchip.c         |    9 --
>  arch/arm/mach-socfpga/socfpga.c           |    2 -
>  arch/arm/mach-sti/board-dt.c              |   10 +-
>  arch/arm/mach-sunxi/sunxi.c               |   10 --
>  arch/arm/mach-tegra/tegra.c               |    9 --
>  arch/arm/mach-vexpress/v2m.c              |   14 +--
>  arch/arm/mach-vt8500/common.h             |   24 -----
>  arch/arm/mach-vt8500/vt8500.c             |    6 --
>  drivers/clk/clk-bcm2835.c                 |    8 --
>  drivers/clk/clk-highbank.c                |   10 +-
>  drivers/clk/clk-nomadik.c                 |  161 ++++++++++++++---------------
>  drivers/clk/clk-prima2.c                  |   29 ++----
>  drivers/clk/clk-vt8500.c                  |   31 ++++--
>  drivers/clk/mxs/clk-imx23.c               |   15 +--
>  drivers/clk/mxs/clk-imx28.c               |   16 +--
>  drivers/clk/sunxi/clk-sunxi.c             |   11 +-
>  drivers/clocksource/nomadik-mtu.c         |   11 ++
>  include/linux/clk/mxs.h                   |    2 -
>  include/linux/clk/sunxi.h                 |   22 ----
>  include/linux/platform_data/clk-nomadik.h |    2 -
>  41 files changed, 182 insertions(+), 449 deletions(-)
>  delete mode 100644 arch/arm/mach-vt8500/common.h
>  delete mode 100644 include/linux/clk/sunxi.h
>  delete mode 100644 include/linux/platform_data/clk-nomadik.h

How would you like to handle this series?

thx,

Jason.
