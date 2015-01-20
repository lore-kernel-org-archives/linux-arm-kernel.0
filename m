From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 20 Jan 2015 20:35:24 +0530
Subject: [GIT PULL] DaVinci EDMA updates for v3.20
Message-ID: <1421766325-28293-1-git-send-email-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v3.20/edma

for you to fetch changes up to bf92c8471b1db35548482fdc1dbae4c15dcc399b:

  ARM: common: edma.c: Remove some unused functions (2015-01-14 15:29:40 +0530)

----------------------------------------------------------------
Remove EDMA api from platform_data header file.
Also, cleans up EDMA header file usage in ASoC
(acked by Mark).
This is in preparation for eventual removal
of arch/arm/common/edma.c

----------------------------------------------------------------
Peter Ujfalusi (3):
      ASoC: davinci-evm: Do not include edma headers
      ARM: edma: Rename header file for dmaengine filter function definition
      ARM: edma: Split up header file to platform_data and API file

Rickard Strandqvist (1):
      ARM: common: edma.c: Remove some unused functions

 arch/arm/common/edma.c                     |   11 +-
 arch/arm/mach-davinci/devices.c            |    1 +
 arch/arm/mach-davinci/include/mach/da8xx.h |    1 +
 drivers/dma/edma.c                         |    2 +-
 drivers/mmc/host/davinci_mmc.c             |    3 +-
 drivers/spi/spi-davinci.c                  |    2 +-
 include/linux/edma-dmaengine.h             |   29 ++++++
 include/linux/edma.h                       |  152 +++++++++++++++++++++++++---
 include/linux/platform_data/edma.h         |  148 ++-------------------------
 sound/soc/davinci/davinci-evm.c            |    3 -
 sound/soc/davinci/davinci-pcm.h            |    1 +
 sound/soc/davinci/edma-pcm.c               |    2 +-
 12 files changed, 182 insertions(+), 173 deletions(-)
 create mode 100644 include/linux/edma-dmaengine.h
