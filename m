From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 16 Nov 2012 12:43:54 -0700
Subject: [GIT PULL 2/6] ARM: tegra: core SoC code enhancements
In-Reply-To: <1353095038-20031-1-git-send-email-swarren@wwwdotorg.org>
References: <1353095038-20031-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1353095038-20031-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Various small clock initialization table and driver changes to support
WiFi modules, SPI controllers, and host1x (graphics/display hardware).

Various AHB/APB-related clocks were added to the Tegra30 clock driver.

The level 2 cache initialization is now driven by data from device tree,
and the cache configuration tweaked.

AUXDATA is added to support SPI controllers and host1x.

Code to decode Tegra's "speedo" process identification fuses is added.

This pull request is based on tegra-for-3.8-cleanup.

----------------------------------------------------------------

The following changes since commit bb1de8877c960b3b3e1c8337730df970b262fd44:

  ARM: tegra: move irammap.h to mach-tegra

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git tegra-for-3.8-soc

for you to fetch changes up to d1d3b978f67c2c000f9d91387cffa630e738d529:

  ARM: tegra: Add Tegra30 host1x clock support

----------------------------------------------------------------

Danny Huang (3):
      ARM: tegra: flexible spare fuse read function
      ARM: tegra: Add speedo-based process identification
      ARM: tegra: Tegra30 speedo-based process identification

Joseph Lo (4):
      ARM: tegra30: clocks: add AHB and APB clocks
      ARM: tegra: dt: add L2 cache controller
      ARM: tegra: common: using OF api for L2 cache init
      ARM: tegra: enable data prefetch on L2

Laxman Dewangan (2):
      ARM: tegra: Add OF_DEV_AUXDATA for SLINK driver in board dt
      ARM: tegra: Add OF_DEV_AUXDATA for sflash driver in board dt

Peter De Schrijver (1):
      ARM: tegra: Implement 6395/1 for Tegra

Thierry Reding (4):
      ARM: tegra: Add AUXDATA for Tegra20 host1x
      ARM: tegra: Add Tegra20 host1x clock support
      ARM: tegra: Add AUXDATA for Tegra30 host1x
      ARM: tegra: Add Tegra30 host1x clock support

Wei Ni (1):
      ARM: tegra: set up wlan clocks for tegra dt

 arch/arm/boot/dts/tegra20.dtsi            |    9 +
 arch/arm/boot/dts/tegra30.dtsi            |    9 +
 arch/arm/mach-tegra/Makefile              |    2 +
 arch/arm/mach-tegra/board-dt-tegra20.c    |   23 ++
 arch/arm/mach-tegra/board-dt-tegra30.c    |   25 ++
 arch/arm/mach-tegra/common.c              |   17 +-
 arch/arm/mach-tegra/fuse.c                |   49 +++-
 arch/arm/mach-tegra/fuse.h                |   16 ++
 arch/arm/mach-tegra/tegra20_clocks_data.c |   11 +-
 arch/arm/mach-tegra/tegra20_speedo.c      |  109 +++++++++
 arch/arm/mach-tegra/tegra30_clocks.c      |  106 +++++++++
 arch/arm/mach-tegra/tegra30_clocks.h      |    1 +
 arch/arm/mach-tegra/tegra30_clocks_data.c |   51 ++++-
 arch/arm/mach-tegra/tegra30_speedo.c      |  292 ++++++++++++++++++++++++
 14 files changed, 696 insertions(+), 24 deletions(-)
 create mode 100644 arch/arm/mach-tegra/tegra20_speedo.c
 create mode 100644 arch/arm/mach-tegra/tegra30_speedo.c
