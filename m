From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 25 Sep 2013 04:40:45 +0530
Subject: [GIT PULL] DaVinci GPIO changes for v3.13
Message-ID: <52421BF5.6020206@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof, Kevin,

Please pull the following changes for DaVinci GPIO driver for v3.13.
The changes have been acked by Linus W. They were sent for last merge
window as well, but did not get pulled due to the late request.

Thanks,
Sekhar

The following changes since commit 4a10c2ac2f368583138b774ca41fac4207911983:

  Linux 3.12-rc2 (2013-09-23 15:41:09 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v3.13/gpio

for you to fetch changes up to f1a4c52ff5913378b7baf05ac71f10282b341cf7:

  ARM: davinci: gpio: use gpiolib API instead of inline functions (2013-09-25 04:16:37 +0530)

----------------------------------------------------------------
GPIO driver updates for DaVinci
-------------------------------

This pull request moves DaVinci GPIO
driver to use platform device framework
and the corresponding changes needed to
keep GPIO working on existing DaVinci
boards. This is a pre-requisite to DT
support for GPIO.

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
 arch/arm/mach-davinci/board-da830-evm.c           |   14 ++-
 arch/arm/mach-davinci/board-da850-evm.c           |    6 +
 arch/arm/mach-davinci/board-dm355-evm.c           |   15 ++-
 arch/arm/mach-davinci/board-dm355-leopard.c       |   14 ++-
 arch/arm/mach-davinci/board-dm365-evm.c           |    6 +
 arch/arm/mach-davinci/board-dm644x-evm.c          |    5 +
 arch/arm/mach-davinci/board-dm646x-evm.c          |   13 +-
 arch/arm/mach-davinci/board-neuros-osd2.c         |   14 ++-
 arch/arm/mach-davinci/board-omapl138-hawk.c       |    6 +
 arch/arm/mach-davinci/da830.c                     |   16 ++-
 arch/arm/mach-davinci/da850.c                     |   16 ++-
 arch/arm/mach-davinci/davinci.h                   |    7 ++
 arch/arm/mach-davinci/devices-da8xx.c             |   26 ++++
 arch/arm/mach-davinci/devices.c                   |   13 ++
 arch/arm/mach-davinci/dm355.c                     |   35 ++++--
 arch/arm/mach-davinci/dm365.c                     |   37 ++++--
 arch/arm/mach-davinci/dm644x.c                    |   30 ++++-
 arch/arm/mach-davinci/dm646x.c                    |   30 ++++-
 arch/arm/mach-davinci/include/mach/da8xx.h        |    3 +
 arch/arm/mach-davinci/include/mach/gpio-davinci.h |   91 --------------
 arch/arm/mach-davinci/include/mach/gpio.h         |   88 --------------
 drivers/gpio/gpio-davinci.c                       |  132 ++++++++++++++-------
 drivers/gpio/gpio-tnetv107x.c                     |    1 +
 include/linux/platform_data/gpio-davinci.h        |   60 ++++++++++
 25 files changed, 402 insertions(+), 277 deletions(-)
 delete mode 100644 arch/arm/mach-davinci/include/mach/gpio-davinci.h
 delete mode 100644 arch/arm/mach-davinci/include/mach/gpio.h
 create mode 100644 include/linux/platform_data/gpio-davinci.h
