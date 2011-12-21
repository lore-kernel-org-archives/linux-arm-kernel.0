From: olof@lixom.net (Olof Johansson)
Date: Wed, 21 Dec 2011 11:14:59 -0800
Subject: [GIT PULL 3/5] Tegra SoC updates for 3.3
Message-ID: <CAOesGMgo+isLeNhi1_ruzYdJCSesZrQKpYeq5Yd9O2r2sJWbaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Please pull the following SoC updates for Tegra for 3.3. The major
part of them is the support for Tegra3.

They are based on the for-3.3/dt branch, plus Russell's devel-stable branch.

Thanks!


The following changes since commit d695cfa54e9ec48aeb149cadc8dab1240751572a:

  Merge remote-tracking branch 'rmk/devel-stable' into for-3.3/soc
(2011-12-17 20:05:50 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/olof/tegra.git for-3.3/soc

Olof Johansson (1):
      arm/tegra: refresh defconfig for tegra30

Peter De Schrijver (14):
      arm/tegra: clk_get should not be fatal
      arm/tegra: cleanup tegra20 support
      arm/tegra: prepare clock code for multiple tegra variants
      arm/tegra: don't export clk_measure_input_freq
      arm/tegra: prepare early init for multiple tegra variants
      arm/tegra: rename board-dt.c to board-dt-tegra20.c
      arm/tegra: use PMC reset
      arm/tegra: generalize L2 cache initialization
      arm/tegra: rename tegra20 pinmux files
      arm/tegra: prepare pinmux code for multiple tegra variants
      arm/tegra: add new fields to struct tegra_pingroup_desc
      arm/tegra: pinmux tables and definitions for tegra30
      arm/tegra: implement support for tegra30
      arm/tegra: add support for tegra30 based board cardhu

Stephen Warren (5):
      arm/tegra: Fix section mismatch errors in tegra20 pinmux
      arm/tegra: Fix section mismatch errors in tegra30 pinmux
      arm/tegra: Delete tegra_init_clock()
      arm/tegra: Make MACH_TEGRA_DT depend on ARCH_TEGRA_2x_SOC
      arm/tegra: Compile tegra_dt_init_irq only when CONFIG_OF

 arch/arm/boot/dts/tegra-cardhu.dts                 |   36 ++
 arch/arm/configs/tegra_defconfig                   |    9 +-
 arch/arm/mach-tegra/Kconfig                        |   31 ++-
 arch/arm/mach-tegra/Makefile                       |    9 +-
 arch/arm/mach-tegra/Makefile.boot                  |    1 +
 .../mach-tegra/{board-dt.c => board-dt-tegra20.c}  |   19 +-
 arch/arm/mach-tegra/board-dt-tegra30.c             |   63 ++++
 arch/arm/mach-tegra/board-harmony-pcie.c           |    1 +
 arch/arm/mach-tegra/board-harmony-pinmux.c         |    1 +
 arch/arm/mach-tegra/board-harmony.c                |    2 +-
 arch/arm/mach-tegra/board-paz00-pinmux.c           |    1 +
 arch/arm/mach-tegra/board-paz00.c                  |    2 +-
 arch/arm/mach-tegra/board-seaboard-pinmux.c        |    2 +-
 arch/arm/mach-tegra/board-seaboard.c               |    6 +-
 arch/arm/mach-tegra/board-trimslice-pinmux.c       |    1 +
 arch/arm/mach-tegra/board-trimslice.c              |    2 +-
 arch/arm/mach-tegra/board.h                        |    5 +-
 arch/arm/mach-tegra/clock.c                        |   25 +--
 arch/arm/mach-tegra/clock.h                        |    4 -
 arch/arm/mach-tegra/common.c                       |   55 +++-
 arch/arm/mach-tegra/include/mach/clk.h             |    2 +-
 arch/arm/mach-tegra/include/mach/irqs.h            |    2 -
 .../include/mach/{pinmux-t2.h => pinmux-tegra20.h} |    6 +-
 arch/arm/mach-tegra/include/mach/pinmux-tegra30.h  |  320 +++++++++++++++++
 arch/arm/mach-tegra/include/mach/pinmux.h          |   88 ++++-
 ...{pinmux-t2-tables.c => pinmux-tegra20-tables.c} |   24 +-
 arch/arm/mach-tegra/pinmux-tegra30-tables.c        |  376 ++++++++++++++++++++
 arch/arm/mach-tegra/pinmux.c                       |  153 ++++++---
 arch/arm/mach-tegra/tegra2_clocks.c                |   19 +-
 arch/arm/mach-tegra/timer.c                        |   18 +-
 30 files changed, 1116 insertions(+), 167 deletions(-)
 create mode 100644 arch/arm/boot/dts/tegra-cardhu.dts
 rename arch/arm/mach-tegra/{board-dt.c => board-dt-tegra20.c} (91%)
 create mode 100644 arch/arm/mach-tegra/board-dt-tegra30.c
 rename arch/arm/mach-tegra/include/mach/{pinmux-t2.h => pinmux-tegra20.h} (96%)
 create mode 100644 arch/arm/mach-tegra/include/mach/pinmux-tegra30.h
 rename arch/arm/mach-tegra/{pinmux-t2-tables.c =>
pinmux-tegra20-tables.c} (95%)
 create mode 100644 arch/arm/mach-tegra/pinmux-tegra30-tables.c
