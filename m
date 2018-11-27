From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 27 Nov 2018 17:48:28 +0530
Subject: [GIT PULL] DaVinci fixes for v4.20
Message-ID: <fc5a2899-f847-5193-2406-2672713aa400@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-fixes-for-v4.20

for you to fetch changes up to 27df7977099c2b8d32399cd1752f527c5a343dfa:

  ARM: davinci: dm644x: set the GPIO base to 0 (2018-11-27 13:43:27 +0530)

----------------------------------------------------------------
DaVinci: fix GPIO breakage after v4.19

This set of changes is needed to fix the broken GPIO support
for DaVinci boards in legacy mode after certain changes made to the
GPIO driver in 4.19, namely: commits 587f7a694f01 ("gpio: davinci: Use
dev name for label and automatic base selection") and eb3744a2dd01
("gpio: davinci: Do not assume continuous IRQ numbering").

----------------------------------------------------------------
Bartosz Golaszewski (12):
      ARM: davinci: da8xx: define gpio interrupts as separate resources
      ARM: davinci: dm365: define gpio interrupts as separate resources
      ARM: davinci: dm646x: define gpio interrupts as separate resources
      ARM: davinci: dm355: define gpio interrupts as separate resources
      ARM: davinci: dm644x: define gpio interrupts as separate resources
      gpio: davinci: restore a way to manually specify the GPIO base
      ARM: davinci: da850: set the GPIO base to 0
      ARM: davinci: dm365: set the GPIO base to 0
      ARM: davinci: dm646x: set the GPIO base to 0
      ARM: davinci: dm355: set the GPIO base to 0
      ARM: davinci: da830: set the GPIO base to 0
      ARM: davinci: dm644x: set the GPIO base to 0

 arch/arm/mach-davinci/da830.c              |  4 ++-
 arch/arm/mach-davinci/da850.c              |  4 ++-
 arch/arm/mach-davinci/devices-da8xx.c      | 40 ++++++++++++++++++++++++++++++
 arch/arm/mach-davinci/dm355.c              | 32 ++++++++++++++++++++++++
 arch/arm/mach-davinci/dm365.c              | 37 +++++++++++++++++++++++++++
 arch/arm/mach-davinci/dm644x.c             | 22 ++++++++++++++++
 arch/arm/mach-davinci/dm646x.c             | 12 +++++++++
 drivers/gpio/gpio-davinci.c                |  2 +-
 include/linux/platform_data/gpio-davinci.h |  2 ++
 9 files changed, 152 insertions(+), 3 deletions(-)
