From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 18 Jun 2013 11:15:12 +0530
Subject: [GIT PULL v2] DaVinci SoC updates for v3.11
In-Reply-To: <51BEDA15.4090908@ti.com>
References: <1371193161-25224-1-git-send-email-nsekhar@ti.com>
 <20130614222519.GK17326@quad.lixom.net> <20130617090647.GX1403@sirena.org.uk>
 <51BEDA15.4090908@ti.com>
Message-ID: <51BFF3E8.4070806@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

Here is an updated version of this pull request with Mark's
and your Acks added to the dma code movement.

Thanks,
Sekhar

The following changes since commit d683b96b072dc4680fc74964eca77e6a23d1fa6e:

  Linux 3.10-rc4 (2013-06-02 17:11:17 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v3.11/soc-v2

for you to fetch changes up to 7bb5d75ce91ca3725256c0d502624ed697231cde:

  ARM: edma: remove unused transfer controller handlers (2013-06-18 10:53:13 +0530)

----------------------------------------------------------------
DaVinci SoC changes for v3.11

This pull request moves DaVinci EDMA library to
arch/arm/common so it can be used by OMAP based AM335x.
This is a temporary step until all drivers are converted
to use the dmaengine driver in drivers/dma/edma.c.

Several drivers like SPI, MMC/SD have already been converted.
Some like audio are pending.

The other two patches in the pull request are cleanup in nature.

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
 24 files changed, 56 insertions(+), 167 deletions(-)
 rename arch/arm/{mach-davinci/dma.c => common/edma.c} (97%)
 rename {arch/arm/mach-davinci/include/mach => include/linux/platform_data}/edma.h (59%)
