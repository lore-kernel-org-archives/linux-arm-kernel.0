From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 27 Nov 2014 12:41:28 +0200
Subject: [PATCH 0/3] ARM: edma: Correct header file usage
Message-ID: <1417084891-17990-1-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The linux/platform_data/edma.h file was used for API definition as well, which
is not correct since the header should only contain platform data related
structures, defines, etc.

Mark: I think this series can go via arm since it is just changing include stuff
under ASoC.

Regards,
Peter
---
Peter Ujfalusi (3):
  ASoC: davinci-evm: Do not include edma headers
  ARM: edma: Rename header file for dmaengine filter function definition
  ARM: edma: Split up header file to platform_data and API file

 arch/arm/common/edma.c                     |   3 +-
 arch/arm/mach-davinci/devices.c            |   1 +
 arch/arm/mach-davinci/include/mach/da8xx.h |   1 +
 drivers/dma/edma.c                         |   2 +-
 drivers/mmc/host/davinci_mmc.c             |   3 +-
 drivers/spi/spi-davinci.c                  |   2 +-
 include/linux/edma-dmaengine.h             |  29 ++++++
 include/linux/edma.h                       | 152 ++++++++++++++++++++++++++---
 include/linux/platform_data/edma.h         | 148 ++--------------------------
 sound/soc/davinci/davinci-evm.c            |   3 -
 sound/soc/davinci/davinci-pcm.h            |   1 +
 sound/soc/davinci/edma-pcm.c               |   2 +-
 12 files changed, 182 insertions(+), 165 deletions(-)
 create mode 100644 include/linux/edma-dmaengine.h

-- 
2.1.3
