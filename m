From: nsekhar@ti.com (Nori, Sekhar)
Date: Wed, 9 May 2012 18:27:13 +0000
Subject: [GIT PULL v2] DaVinci fixes and cleanups for v3.5
Message-ID: <DF0F476B391FA8409C78302C7BA518B63EA0A59F@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Can you please pull the following DaVinci fixes and cleanups for v3.5?

Thanks,
Sekhar

The following changes since commit 0034102808e0dbbf3a2394b82b1bb40b5778de9e:

  Linux 3.4-rc2 (2012-04-07 18:30:41 -0700)

are available in the git repository at:

  git://gitorious.org/linux-davinci/linux-davinci.git tags/v3.5-fixes-and-cleanups

for you to fetch changes up to 98e3b3393ff25f79399dd7cdcf6450788788acae:

  arm: davinci: use for_each_set_bit_from (2012-05-09 17:22:07 +0530)

----------------------------------------------------------------
DaVinci fixes and cleanups for v3.5

This pull request:

1) improves code readability by using for_each_set_bit_from in DMA driver.
2) fixes incorrect bit position being used in power domain switching code
3) fixes not marking some variables as const when they could be const
4) fixes section mismatch warning in da850 evm code

----------------------------------------------------------------
Akinobu Mita (1):
      arm: davinci: use for_each_set_bit_from

Murali Karicheri (1):
      ARM: davinci: fix incorrect pdctl next bit position

Uwe Kleine-K?nig (2):
      ARM: davinci: mark spi_board_info arguments as const
      ARM: davinci: da850-evm: fix section mismatch

 arch/arm/mach-davinci/board-da850-evm.c    |    2 +-
 arch/arm/mach-davinci/davinci.h            |    4 ++--
 arch/arm/mach-davinci/devices-da8xx.c      |    2 +-
 arch/arm/mach-davinci/dm355.c              |    2 +-
 arch/arm/mach-davinci/dm365.c              |    2 +-
 arch/arm/mach-davinci/dma.c                |    6 +++---
 arch/arm/mach-davinci/include/mach/da8xx.h |    3 ++-
 arch/arm/mach-davinci/include/mach/psc.h   |    2 +-
 8 files changed, 12 insertions(+), 11 deletions(-)
