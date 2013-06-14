From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 14 Jun 2013 12:29:20 +0530
Subject: [GIT PULL 1/2] DaVinci SoC updates for v3.11
Message-ID: <1371193161-25224-1-git-send-email-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Arnd, Olof,

Please pull the following DaVinci SoC updates for v3.10.

On the DMA library movement, I was been waiting for acks
from Russell and Mark, but did not get them. OTOH, there
have been no objections as well. I assume the movement
is not a problem since its a movement within arch/arm
and does not end-up bringing new code in.

Thanks,
Sekhar

The following changes since commit d683b96b072dc4680fc74964eca77e6a23d1fa6e:

  Linux 3.10-rc4 (2013-06-02 17:11:17 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v3.11/soc

for you to fetch changes up to b50f23734903c8d33c9e08d93649a3ca806c90dc:

  ARM: edma: remove unused transfer controller handlers (2013-06-14 10:54:04 +0530)

----------------------------------------------------------------
This pull request moves DaVinci EDMA library to
arch/arm/common so it can be used by OMAP based
AM335x. This is a temporary step until all drivers
are converted to use the dmaengine driver in
drivers/dma/edma.c. Several drivers like SPI, MMC/SD
have already been converted. Some line audio are pending.

The other two patches in the pull request are cleanup
in nature.

----------------------------------------------------------------
Lad, Prabhakar (1):
      ARM: davinci: remove __init atrribute from function declaration

Matt Porter (2):
      ARM: davinci: move private EDMA API to arm/common
      ARM: edma: remove unused transfer controller handlers

 arch/arm/Kconfig                                   |    1 +
 arch/arm/common/Kconfig                            |    3 +
 arch/arm/common/Makefile                           |    1 +
 arch/arm/{mach-davinci/dma.c => common/edma.c}     |   39 +--------
 arch/arm/mach-davinci/Makefile                     |    2 +-
 arch/arm/mach-davinci/board-tnetv107x-evm.c        |    2 +-
 arch/arm/mach-davinci/davinci.h                    |   30 +++----
 arch/arm/mach-davinci/devices-tnetv107x.c          |    2 +-
 arch/arm/mach-davinci/devices.c                    |    6 +-
 arch/arm/mach-davinci/dm355.c                      |    2 +-
 arch/arm/mach-davinci/dm365.c                      |    2 +-
 arch/arm/mach-davinci/dm644x.c                     |    2 +-
 arch/arm/mach-davinci/dm646x.c                     |    2 +-
 arch/arm/mach-davinci/include/mach/cp_intc.h       |    4 +-
 arch/arm/mach-davinci/include/mach/da8xx.h         |   18 ++--
 arch/arm/mach-davinci/include/mach/tnetv107x.h     |    6 +-
 drivers/dma/edma.c                                 |    2 +-
 drivers/mmc/host/davinci_mmc.c                     |    1 +
 include/linux/mfd/davinci_voicecodec.h             |    3 +-
 .../mach => include/linux/platform_data}/edma.h    |   89 +-------------------
 include/linux/platform_data/spi-davinci.h          |    2 +-
 sound/soc/davinci/davinci-evm.c                    |    1 +
 sound/soc/davinci/davinci-pcm.c                    |    1 +
 sound/soc/davinci/davinci-pcm.h                    |    2 +-
 sound/soc/davinci/davinci-sffsdr.c                 |    5 +-
 25 files changed, 60 insertions(+), 168 deletions(-)
 rename arch/arm/{mach-davinci/dma.c => common/edma.c} (97%)
 rename {arch/arm/mach-davinci/include/mach => include/linux/platform_data}/edma.h (59%)
