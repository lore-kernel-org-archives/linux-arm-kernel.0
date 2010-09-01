From: konkers@google.com (Erik Gilling)
Date: Wed, 1 Sep 2010 15:14:16 -0700
Subject: [PATCH 0/9] [ARM] tegra: Additional core support for Tegra2 SOCs
In-Reply-To: <AANLkTinhoBrzYmypsKNcLPar-pKWiYm60GL6YBfd1jT9@mail.gmail.com>
References: <1280449771-24043-1-git-send-email-ccross@google.com>
	<AANLkTinhoBrzYmypsKNcLPar-pKWiYm60GL6YBfd1jT9@mail.gmail.com>
Message-ID: <AANLkTin_N_Oq8x3Z--oW5_NTEkvDew8tzQ7MnTHmv__t@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These changes have been pushed to

  git://android.kernel.org/kernel/tegra.git for-next

Colin Cross (10):
      [ARM] tegra: update iomap
      [ARM] tegra: Add legacy irq support
      [ARM] tegra: pinmux: add safe values, move tegra2, add suspend
      [ARM] tegra: gpio: Add suspend and wake support
      [ARM] tegra: Add support for reading fuses
      [ARM] tegra: clock: Add dvfs support, bug fixes, and cleanups
      [ARM] tegra: common: Update common clock init table
      [ARM] tegra: Add cpufreq support
      [ARM] tegra: Add tegra_defconfig
      [ARM] tegra: Add APB DMA support

Gary King (1):
      [ARM] tegra: add suspend and mirror irqs to legacy controller

 arch/arm/Kconfig                              |    1 +
 arch/arm/configs/tegra_defconfig              | 1095 +++++++++++++++++++++++++
 arch/arm/mach-tegra/Kconfig                   |    7 +
 arch/arm/mach-tegra/Makefile                  |    7 +-
 arch/arm/mach-tegra/clock.c                   |  267 ++++++-
 arch/arm/mach-tegra/clock.h                   |   58 +-
 arch/arm/mach-tegra/common.c                  |   13 +-
 arch/arm/mach-tegra/cpu-tegra.c               |  185 +++++
 arch/arm/mach-tegra/dma.c                     |  752 +++++++++++++++++
 arch/arm/mach-tegra/fuse.c                    |   84 ++
 arch/arm/mach-tegra/fuse.h                    |   24 +
 arch/arm/mach-tegra/gpio.c                    |  104 +++-
 arch/arm/mach-tegra/include/mach/clk.h        |    5 +
 arch/arm/mach-tegra/include/mach/dma.h        |  155 ++++
 arch/arm/mach-tegra/include/mach/gpio.h       |    4 +-
 arch/arm/mach-tegra/include/mach/io.h         |    6 +
 arch/arm/mach-tegra/include/mach/iomap.h      |   33 +-
 arch/arm/mach-tegra/include/mach/irqs.h       |    2 +
 arch/arm/mach-tegra/include/mach/legacy_irq.h |   31 +
 arch/arm/mach-tegra/include/mach/pinmux-t2.h  |  174 ++++
 arch/arm/mach-tegra/include/mach/pinmux.h     |  210 ++----
 arch/arm/mach-tegra/io.c                      |    6 +
 arch/arm/mach-tegra/irq.c                     |  137 +++
 arch/arm/mach-tegra/legacy_irq.c              |  114 +++
 arch/arm/mach-tegra/pinmux-t2-tables.c        |  260 ++++++
 arch/arm/mach-tegra/pinmux.c                  |  354 +++------
 arch/arm/mach-tegra/tegra2_clocks.c           |  778 ++++++++++++++----
 arch/arm/mach-tegra/tegra2_dvfs.c             |   86 ++
 arch/arm/mach-tegra/tegra2_dvfs.h             |   20 +
 29 files changed, 4344 insertions(+), 628 deletions(-)
 create mode 100644 arch/arm/configs/tegra_defconfig
 create mode 100644 arch/arm/mach-tegra/cpu-tegra.c
 create mode 100644 arch/arm/mach-tegra/dma.c
 create mode 100644 arch/arm/mach-tegra/fuse.c
 create mode 100644 arch/arm/mach-tegra/fuse.h
 create mode 100644 arch/arm/mach-tegra/include/mach/dma.h
 create mode 100644 arch/arm/mach-tegra/include/mach/legacy_irq.h
 create mode 100644 arch/arm/mach-tegra/include/mach/pinmux-t2.h
 create mode 100644 arch/arm/mach-tegra/legacy_irq.c
 create mode 100644 arch/arm/mach-tegra/pinmux-t2-tables.c
 create mode 100644 arch/arm/mach-tegra/tegra2_dvfs.c
 create mode 100644 arch/arm/mach-tegra/tegra2_dvfs.h
