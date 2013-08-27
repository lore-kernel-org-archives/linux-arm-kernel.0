From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 28 Aug 2013 02:58:13 +0530
Subject: [GIT PULL] DaVinci GPIO driver updates for v3.12
Message-ID: <521D19ED.5030109@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin, Arnd, Olof,

Can you please pull the following GPIO driver updates? The patches have 
Linus W's ack. I have based the branch on the SoC updates sent earlier 
to avoid some conflicts. I did a test merge of this branch with latest 
linux-next/master and there were no conflicts.

I know its coming late, but hopefully still in time to get merged.

Thanks,
Sekhar

The following changes since commit 46c1833467c5e555f31cd6f14b342a7383f26885:

  ARM: davinci: fix clock lookup for mdio device (2013-08-22 00:39:01 +0530)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v3.12/gpio

for you to fetch changes up to 856b63608b6b48dd92c8b41fbbd6a2edde07738d:

  ARM: davinci: gpio: use gpiolib API instead of inline functions (2013-08-28 02:01:37 +0530)

----------------------------------------------------------------
GPIO driver updates for DaVinci
-------------------------------

This pull request moves DaVinci GPIO
driver to use platform device framework
and the corresponding changes needed to
keep GPIO working on existing DaVinci
boards.

platform device conversion is needed
before DT support is enabled for GPIO.

----------------------------------------------------------------
KV Sujith (2):
      gpio: davinci: move to platform device
      ARM: davinci: da8xx: support gpio platform device

Philip Avinash (5):
      gpio: davinci: coding style correction
      ARM: davinci: support gpio platform device
      ARM: davinci: da8xx boards: gpio device creation
      ARM: davinci: board: gpio device creation
      ARM: davinci: gpio: use gpiolib API instead of inline functions

 arch/arm/Kconfig                                  |    1 -
 arch/arm/mach-davinci/board-da830-evm.c           |   28 ++--
 arch/arm/mach-davinci/board-da850-evm.c           |   16 ++-
 arch/arm/mach-davinci/board-dm355-evm.c           |   33 +++--
 arch/arm/mach-davinci/board-dm355-leopard.c       |   30 +++--
 arch/arm/mach-davinci/board-dm365-evm.c           |   30 +++--
 arch/arm/mach-davinci/board-dm644x-evm.c          |   40 +++---
 arch/arm/mach-davinci/board-dm646x-evm.c          |   37 +++---
 arch/arm/mach-davinci/board-neuros-osd2.c         |   18 ++-
 arch/arm/mach-davinci/board-omapl138-hawk.c       |   10 +-
 arch/arm/mach-davinci/da830.c                     |   26 ++--
 arch/arm/mach-davinci/da850.c                     |   30 +++--
 arch/arm/mach-davinci/davinci.h                   |   20 ++-
 arch/arm/mach-davinci/devices-da8xx.c             |   26 ++++
 arch/arm/mach-davinci/devices.c                   |   13 ++
 arch/arm/mach-davinci/dm355.c                     |   53 +++++---
 arch/arm/mach-davinci/dm365.c                     |   57 +++++---
 arch/arm/mach-davinci/dm644x.c                    |   46 +++++--
 arch/arm/mach-davinci/dm646x.c                    |   46 +++++--
 arch/arm/mach-davinci/include/mach/da8xx.h        |   23 ++--
 arch/arm/mach-davinci/include/mach/gpio-davinci.h |   91 -------------
 arch/arm/mach-davinci/include/mach/gpio.h         |   88 -------------
 arch/arm/mach-davinci/tnetv107x.c                 |   14 +-
 drivers/gpio/gpio-davinci.c                       |  143 ++++++++++++++-------
 drivers/gpio/gpio-tnetv107x.c                     |    5 +-
 include/linux/platform_data/gpio-davinci.h        |   60 +++++++++
 26 files changed, 558 insertions(+), 426 deletions(-)
 delete mode 100644 arch/arm/mach-davinci/include/mach/gpio-davinci.h
 delete mode 100644 arch/arm/mach-davinci/include/mach/gpio.h
 create mode 100644 include/linux/platform_data/gpio-davinci.h
