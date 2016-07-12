From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 12 Jul 2016 11:29:41 +0200
Subject: [GIT PULL] Ux500 cleanups from Arnd
Message-ID: <CACRpkdYv8iT1gry8X+27Nj5w5_M38DVQ0ws-VKMf_fFrb2sP2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC people,

here is a batch of nice cleanups from Arnd that have been sitting
in development for too long.

They are tested by me and ACKed by respective subsystem
maintainer and can now be pulled in for v4.8.

Maybe it is late, then consider pulling it as late cleanup or early
for the next kernel cycle.

Yours,
Linus Walleij

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/ux500-cleanup-bundle

for you to fetch changes up to a16729ea822806a6f87415bcb523eaeb7f4b4ebd:

  ARM: ux500: consolidate base platform files (2016-07-12 11:24:09 +0200)

----------------------------------------------------------------
This is a set of cleanups for the Ux500 that reduce the number
of machine-local files and boardfile-type data for regulators
and ASoC.

----------------------------------------------------------------
Arnd Bergmann (11):
      ARM: ux500: remove unused regulator data
      ARM: ux500: move ab8500_regulator_plat_data into driver
      ASoC: ab8500-codec: remove platform data based probe
      mfd: db8500 stop passing around platform data
      ARM: ux500: move l2x0 init to .init_irq
      ARM: ux500: use CLK_OF_DECLARE()
      ARM: ux500: remove cpu_is_u* helpers
      ARM: ux500: consolidate soc_device code in id.c
      ARM: ux500: call ux500_setup_id later
      ARM: ux500: move soc_id driver to drivers/soc
      ARM: ux500: consolidate base platform files

 MAINTAINERS                                   |    1 -
 arch/arm/mach-ux500/Makefile                  |    6 +-
 arch/arm/mach-ux500/board-mop500-regulators.c | 1065 -------------------------
 arch/arm/mach-ux500/board-mop500-regulators.h |   24 -
 arch/arm/mach-ux500/cache-l2x0.c              |   67 --
 arch/arm/mach-ux500/cpu-db8500.c              |  139 ++--
 arch/arm/mach-ux500/cpu.c                     |  148 ----
 arch/arm/mach-ux500/id.c                      |  116 ---
 arch/arm/mach-ux500/id.h                      |  144 ----
 arch/arm/mach-ux500/platsmp.c                 |    1 -
 arch/arm/mach-ux500/setup.h                   |   12 -
 drivers/clk/ux500/u8500_of_clk.c              |   16 +-
 drivers/clk/ux500/u8540_clk.c                 |   16 +-
 drivers/clk/ux500/u9540_clk.c                 |    4 +-
 drivers/mfd/ab8500-core.c                     |    4 -
 drivers/mfd/ab8500-sysctrl.c                  |   34 -
 drivers/mfd/db8500-prcmu.c                    |   10 +-
 drivers/regulator/ab8500-ext.c                |  465 ++++++++++-
 drivers/soc/Kconfig                           |    1 +
 drivers/soc/Makefile                          |    1 +
 drivers/soc/ux500/Kconfig                     |    7 +
 drivers/soc/ux500/Makefile                    |    1 +
 drivers/soc/ux500/ux500-soc-id.c              |  222 ++++++
 include/linux/mfd/abx500/ab8500-sysctrl.h     |    6 -
 include/linux/mfd/dbx500-prcmu.h              |   10 -
 include/linux/platform_data/clk-ux500.h       |   17 -
 sound/soc/codecs/ab8500-codec.c               |   33 +-
 27 files changed, 786 insertions(+), 1784 deletions(-)
 delete mode 100644 arch/arm/mach-ux500/board-mop500-regulators.c
 delete mode 100644 arch/arm/mach-ux500/board-mop500-regulators.h
 delete mode 100644 arch/arm/mach-ux500/cache-l2x0.c
 delete mode 100644 arch/arm/mach-ux500/cpu.c
 delete mode 100644 arch/arm/mach-ux500/id.c
 delete mode 100644 arch/arm/mach-ux500/id.h
 create mode 100644 drivers/soc/ux500/Kconfig
 create mode 100644 drivers/soc/ux500/Makefile
 create mode 100644 drivers/soc/ux500/ux500-soc-id.c
 delete mode 100644 include/linux/platform_data/clk-ux500.h
