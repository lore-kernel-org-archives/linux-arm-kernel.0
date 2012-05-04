From: nsekhar@ti.com (Nori, Sekhar)
Date: Fri, 4 May 2012 13:04:42 +0000
Subject: [GIT PULL] DaVinci fixes for v3.5
Message-ID: <DF0F476B391FA8409C78302C7BA518B63E9FF67D@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull these DaVinci fixes for v3.5 kernel. The definition of "fix" is 
admittedly broad here, but I did not want to create too many separate pull 
requests either. This itself is a pretty small one as such.

This is also a first signed-tag pull request from me, so let me know it is not 
correct for some reason.

Thanks,
Sekhar

The following changes since commit 0034102808e0dbbf3a2394b82b1bb40b5778de9e:

  Linux 3.4-rc2 (2012-04-07 18:30:41 -0700)

are available in the git repository at:

  git://gitorious.org/linux-davinci/linux-davinci.git tags/v3.5-fixes

for you to fetch changes up to b1cb237602563db2d69d010a708a90149850e832:

  ARM: davinci: optimize the DMA ISR (2012-05-01 00:54:57 +0530)

----------------------------------------------------------------
DaVinci fixes for v3.5

This patch set has fixes for

1) incorrect bit position being used in power domain switching code
2) not marking some variables as const when they could be const
3) section mismatch warning in da850 evm code
4) remove excessive register access in DMA ISR to speed up execution.

----------------------------------------------------------------
Murali Karicheri (1):
      ARM: davinci: fix incorrect pdctl next bit position

Sebastian Andrzej Siewior (1):
      ARM: davinci: optimize the DMA ISR

Uwe Kleine-K?nig (2):
      ARM: davinci: mark spi_board_info arguments as const
      ARM: davinci: da850-evm: fix section mismatch

 arch/arm/mach-davinci/board-da850-evm.c    |    2 +-
 arch/arm/mach-davinci/davinci.h            |    4 +-
 arch/arm/mach-davinci/devices-da8xx.c      |    2 +-
 arch/arm/mach-davinci/dm355.c              |    2 +-
 arch/arm/mach-davinci/dm365.c              |    2 +-
 arch/arm/mach-davinci/dma.c                |   69 ++++++++++++++--------------
 arch/arm/mach-davinci/include/mach/da8xx.h |    3 +-
 arch/arm/mach-davinci/include/mach/psc.h   |    2 +-
 8 files changed, 43 insertions(+), 43 deletions(-)
