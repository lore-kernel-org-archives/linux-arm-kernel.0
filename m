From: nsekhar@ti.com (Nori, Sekhar)
Date: Wed, 9 May 2012 18:15:29 +0000
Subject: [GIT PULL v2] DaVinci SoC support updates
Message-ID: <DF0F476B391FA8409C78302C7BA518B63EA0A50E@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Can you please pull the following DaVinci SoC support updates.
This pull request has been restructured as per Olof's suggestion.

Thanks,
Sekhar

The following changes since commit d48b97b403d23f6df0b990cee652bdf9a52337a3:

  Linux 3.4-rc6 (2012-05-06 15:07:32 -0700)

are available in the git repository at:

  git://gitorious.org/linux-davinci/linux-davinci.git tags/v3.5-soc

for you to fetch changes up to bcd59b0f0c14b0584c1213ee3b53d5f84517c419:

  ARM: davinci: optimize the DMA ISR (2012-05-09 17:07:49 +0530)

----------------------------------------------------------------
DaVinci SoC updates for v3.5

This pull request updates the DaVinci SoC support to implement DEBUG_LL port
choice and optimizes the DMA ISR by removing unnecessary register reads.

----------------------------------------------------------------
Sebastian Andrzej Siewior (1):
      ARM: davinci: optimize the DMA ISR

Uwe Kleine-K?nig (1):
      ARM: davinci: implement DEBUG_LL port choice

 arch/arm/Kconfig.debug                           |   29 ++++++++++++++
 arch/arm/mach-davinci/dma.c                      |   69 ++++++++++++++++-----------------
 arch/arm/mach-davinci/include/mach/debug-macro.S |   58 ++++++++++-----------------
 arch/arm/mach-davinci/include/mach/hardware.h    |    2 +-
 arch/arm/mach-davinci/include/mach/serial.h      |   10 -----
 arch/arm/mach-davinci/include/mach/uncompress.h  |   30 +++++---------
 6 files changed, 94 insertions(+), 104 deletions(-)
