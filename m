From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 22 Aug 2013 01:27:26 +0530
Subject: [GIT PULL 1/2] DaVinci SoC updates for v3.12
Message-ID: <52151BA6.2060109@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof, Kevin,

Please pull the following DaVinci SoC changes for v3.12

Thanks,
Sekhar

The following changes since commit 3b2f64d00c46e1e4e9bd0bb9bb12619adac27a4b:

  Linux 3.11-rc2 (2013-07-21 12:05:29 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v3.12/soc

for you to fetch changes up to 46c1833467c5e555f31cd6f14b342a7383f26885:

  ARM: davinci: fix clock lookup for mdio device (2013-08-22 00:39:01 +0530)

----------------------------------------------------------------
DaVinci SoC updates for v3.12
-----------------------------

This set of SoC updates contains changes to the
way UART clock is handled to enabled DT-boot to
obtain UART clock frequency instead of relying
on DT-binding being supplied. Similarly handling
of MDIO clock is fixed to make it easier to support
MDIO in DT-boot. Finally there is patch to remove
now unnecessary setting of wake-up capable flag for
RTC.

----------------------------------------------------------------
Hebbar Gururaja (1):
      ARM: davinci: da8xx: remove hard coding of rtc device wakeup

Lad, Prabhakar (1):
      ARM: davinci: fix clock lookup for mdio device

Manjunathappa, Prakash (4):
      ARM: davinci: uart: move to devid based clk_get
      ARM: davinci: da8xx: remove da8xx_uart_clk_enable
      ARM: davinci: serial: get rid of davinci_uart_config
      ARM: davinci: serial: remove davinci_serial_setup_clk()

 arch/arm/mach-davinci/board-da830-evm.c        |    6 +--
 arch/arm/mach-davinci/board-da850-evm.c        |    6 +--
 arch/arm/mach-davinci/board-dm355-evm.c        |    6 +--
 arch/arm/mach-davinci/board-dm355-leopard.c    |    6 +--
 arch/arm/mach-davinci/board-dm365-evm.c        |    6 +--
 arch/arm/mach-davinci/board-dm644x-evm.c       |    6 +--
 arch/arm/mach-davinci/board-dm646x-evm.c       |    6 +--
 arch/arm/mach-davinci/board-mityomapl138.c     |    6 +--
 arch/arm/mach-davinci/board-neuros-osd2.c      |    6 +--
 arch/arm/mach-davinci/board-omapl138-hawk.c    |    6 +--
 arch/arm/mach-davinci/board-sffsdr.c           |    6 +--
 arch/arm/mach-davinci/da830.c                  |    8 ++--
 arch/arm/mach-davinci/da850.c                  |    8 ++--
 arch/arm/mach-davinci/da8xx-dt.c               |   11 ++---
 arch/arm/mach-davinci/davinci.h                |    5 ++
 arch/arm/mach-davinci/devices-da8xx.c          |   59 +++++++++++++++---------
 arch/arm/mach-davinci/devices-tnetv107x.c      |   39 +++++++++++++---
 arch/arm/mach-davinci/dm355.c                  |   51 +++++++++++++++-----
 arch/arm/mach-davinci/dm365.c                  |   40 ++++++++++------
 arch/arm/mach-davinci/dm644x.c                 |   54 ++++++++++++++++------
 arch/arm/mach-davinci/dm646x.c                 |   54 ++++++++++++++++------
 arch/arm/mach-davinci/include/mach/common.h    |    1 -
 arch/arm/mach-davinci/include/mach/da8xx.h     |    2 +-
 arch/arm/mach-davinci/include/mach/serial.h    |   10 ++--
 arch/arm/mach-davinci/include/mach/tnetv107x.h |    3 +-
 arch/arm/mach-davinci/serial.c                 |   54 ++++++++--------------
 arch/arm/mach-davinci/tnetv107x.c              |    8 ++--
 27 files changed, 272 insertions(+), 201 deletions(-)
