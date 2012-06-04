From: zhangfei.gao@marvell.com (Zhangfei Gao)
Date: Mon,  4 Jun 2012 14:37:26 +0800
Subject: [PATCH v1 0/5] mmp audio support 
Message-ID: <1338791851-21038-1-git-send-email-zhangfei.gao@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v0->v1: 
dmaengine -> soc-dmaengine.
update according to Mark's suggestion

These patches provide mmp audio support under alsa via dmaengine
Support platfrom pxa688 and pxa910
mmp_tdma.c and mmp-pcm.c is shared for pxa688 and pxa910
pxa688 (mmp2) use mmp2-sspa.c
pxa910 directly use pxa-ssp.c
mmp_tdma.c is under dmaengine framework

Verified on brownstone (pxa688) and ttc-dkb


Qiao Zhou (1):
  ASoC: add ttc-dkb machine support

Zhangfei Gao (4):
  dmaengine: mmp_tdma: add mmp tdma support
  ASoC: mmp: add audio dma support
  ASOC: mmp: add sspa support
  ASoC: add mmp brownstone support

 drivers/dma/Kconfig                     |   10 +
 drivers/dma/Makefile                    |    1 +
 drivers/dma/mmp_tdma.c                  |  649 +++++++++++++++++++++++++++++++
 include/linux/platform_data/mmp_audio.h |   22 +
 include/linux/platform_data/mmp_dma.h   |   20 +
 sound/soc/pxa/Kconfig                   |   42 ++
 sound/soc/pxa/Makefile                  |    8 +
 sound/soc/pxa/brownstone.c              |  178 +++++++++
 sound/soc/pxa/mmp-pcm.c                 |  317 +++++++++++++++
 sound/soc/pxa/mmp-sspa.c                |  496 +++++++++++++++++++++++
 sound/soc/pxa/mmp-sspa.h                |   92 +++++
 sound/soc/pxa/ttc-dkb.c                 |  173 ++++++++
 12 files changed, 2008 insertions(+), 0 deletions(-)
 create mode 100644 drivers/dma/mmp_tdma.c
 create mode 100644 include/linux/platform_data/mmp_audio.h
 create mode 100644 include/linux/platform_data/mmp_dma.h
 create mode 100644 sound/soc/pxa/brownstone.c
 create mode 100644 sound/soc/pxa/mmp-pcm.c
 create mode 100644 sound/soc/pxa/mmp-sspa.c
 create mode 100644 sound/soc/pxa/mmp-sspa.h
 create mode 100644 sound/soc/pxa/ttc-dkb.c
