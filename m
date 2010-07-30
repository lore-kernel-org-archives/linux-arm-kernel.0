From: ccross@google.com (Colin Cross)
Date: Thu, 29 Jul 2010 17:29:21 -0700
Subject: [PATCH 0/9] [ARM] tegra: Additional core support for Tegra2 SOCs
Message-ID: <1280449771-24043-1-git-send-email-ccross@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Cross <ccross@android.com>

This patch set adds support for more of the Tegra 2 core systems.  After
review, some of these changes will be merged down with the core support
that is already in the tegra for-next branch.

Colin Cross (8):
  [ARM] tegra: update iomap
  [ARM] tegra: Add legacy irq support
  [ARM] tegra: pinmux: add safe values, move tegra2, add suspend
  [ARM] tegra: gpio: Add suspend and wake support
  [ARM] tegra: Add support for reading fuses
  [ARM] tegra: clock: Add dvfs support, bug fixes, and cleanups
  [ARM] tegra: common: Update common clock init table
  [ARM] tegra: Add cpufreq support

Gary King (1):
  [ARM] tegra: add suspend and mirror irqs to legacy controller

 arch/arm/Kconfig                              |    1 +
 arch/arm/mach-tegra/Makefile                  |    6 +-
 arch/arm/mach-tegra/clock.c                   |  267 ++++++++-
 arch/arm/mach-tegra/clock.h                   |   58 ++-
 arch/arm/mach-tegra/common.c                  |    6 +-
 arch/arm/mach-tegra/cpu-tegra.c               |  185 ++++++
 arch/arm/mach-tegra/fuse.c                    |   84 +++
 arch/arm/mach-tegra/fuse.h                    |   24 +
 arch/arm/mach-tegra/gpio.c                    |  104 +++-
 arch/arm/mach-tegra/include/mach/clk.h        |    5 +
 arch/arm/mach-tegra/include/mach/gpio.h       |    4 +-
 arch/arm/mach-tegra/include/mach/io.h         |    6 +
 arch/arm/mach-tegra/include/mach/iomap.h      |   33 +-
 arch/arm/mach-tegra/include/mach/irqs.h       |    2 +
 arch/arm/mach-tegra/include/mach/legacy_irq.h |   31 +
 arch/arm/mach-tegra/include/mach/pinmux-t2.h  |  174 ++++++
 arch/arm/mach-tegra/include/mach/pinmux.h     |  210 ++-----
 arch/arm/mach-tegra/io.c                      |    6 +
 arch/arm/mach-tegra/irq.c                     |  137 +++++
 arch/arm/mach-tegra/legacy_irq.c              |  114 ++++
 arch/arm/mach-tegra/pinmux-t2-tables.c        |  260 +++++++++
 arch/arm/mach-tegra/pinmux.c                  |  354 ++++--------
 arch/arm/mach-tegra/tegra2_clocks.c           |  778 +++++++++++++++++++------
 arch/arm/mach-tegra/tegra2_dvfs.c             |   86 +++
 arch/arm/mach-tegra/tegra2_dvfs.h             |   20 +
 25 files changed, 2327 insertions(+), 628 deletions(-)
 create mode 100644 arch/arm/mach-tegra/cpu-tegra.c
 create mode 100644 arch/arm/mach-tegra/fuse.c
 create mode 100644 arch/arm/mach-tegra/fuse.h
 create mode 100644 arch/arm/mach-tegra/include/mach/legacy_irq.h
 create mode 100644 arch/arm/mach-tegra/include/mach/pinmux-t2.h
 create mode 100644 arch/arm/mach-tegra/legacy_irq.c
 create mode 100644 arch/arm/mach-tegra/pinmux-t2-tables.c
 create mode 100644 arch/arm/mach-tegra/tegra2_dvfs.c
 create mode 100644 arch/arm/mach-tegra/tegra2_dvfs.h
