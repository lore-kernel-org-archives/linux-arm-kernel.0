From: zhangfei.gao@marvell.com (Zhangfei Gao)
Date: Fri, 25 May 2012 15:10:59 +0800
Subject: [PATCH 0/4] mmp audio support
Message-ID: <1337929863-31885-1-git-send-email-zhangfei.gao@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These four patches provide mmp audio support under alsa via dmaengine
Support platfrom pxa688 and pxa910
mmp_tdma.c and mmp-pcm.c is shared for pxa688 and pxa910
pxa688 (mmp2) use mmp2-sspa.c
pxa910 directly use pxa-ssp.c
mmp_tdma.c is under dmaengine framework

Verified on brownstone (pxa688) and ttc-dkb

Zhangfei Gao (4):
  dmaengine: mmp_tdma: add mmp tdma support
  ASoC: mmp: add audio dma support
  ASOC: mmp: add sspa support
  ASoC: add mmp brownstone support

 drivers/dma/Kconfig                     |   10 +
 drivers/dma/Makefile                    |    1 +
 drivers/dma/mmp_tdma.c                  |  677 +++++++++++++++++++++++++++++++
 include/linux/platform_data/mmp_audio.h |   22 +
 include/linux/platform_data/mmp_dma.h   |   20 +
 sound/soc/pxa/Kconfig                   |   20 +
 sound/soc/pxa/Makefile                  |    6 +
 sound/soc/pxa/brownstone.c              |  303 ++++++++++++++
 sound/soc/pxa/mmp-pcm.c                 |  448 ++++++++++++++++++++
 sound/soc/pxa/mmp-sspa.c                |  536 ++++++++++++++++++++++++
 sound/soc/pxa/mmp-sspa.h                |   92 +++++
 11 files changed, 2135 insertions(+), 0 deletions(-)
 create mode 100644 drivers/dma/mmp_tdma.c
 create mode 100644 include/linux/platform_data/mmp_audio.h
 create mode 100644 include/linux/platform_data/mmp_dma.h
 create mode 100644 sound/soc/pxa/brownstone.c
 create mode 100644 sound/soc/pxa/mmp-pcm.c
 create mode 100644 sound/soc/pxa/mmp-sspa.c
 create mode 100644 sound/soc/pxa/mmp-sspa.h
