From: zonque@gmail.com (Daniel Mack)
Date: Mon, 12 Aug 2013 10:42:36 +0200
Subject: [PATCH 0/5] ASoC: pxa dmaengine preparation patches
Message-ID: <1376296961-20564-1-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

This series is an excerpt of my pxa-dma rework that can be merged
independently in the next merge window.

The rest of the series will take some time to get sorted out, and given
that -rc5 is released already, I don't think the entire series will
make it in time.


Thanks,
Daniel

Daniel Mack (5):
  ALSA: move dmaengine implementation from ASoC to ALSA core
  ASoC: pxa: pxa-ssp: add DT bindings
  ASoC: pxa: use snd_dmaengine_dai_dma_data
  ASoC: pxa: pxa-ssp: set dma filter data from startup hook
  ASoC: pxa: add DT bindings for pxa2xx-pcm

 .../devicetree/bindings/sound/mrvl,pxa-ssp.txt     |  28 ++
 .../devicetree/bindings/sound/mrvl,pxa2xx-pcm.txt  |  15 +
 include/sound/pxa2xx-lib.h                         |   7 -
 sound/arm/pxa2xx-ac97.c                            |  26 +-
 sound/arm/pxa2xx-pcm-lib.c                         |  52 ++-
 sound/arm/pxa2xx-pcm.c                             |   5 +-
 sound/arm/pxa2xx-pcm.h                             |   6 +-
 sound/core/Kconfig                                 |   3 +
 sound/core/Makefile                                |   3 +
 sound/core/pcm_dmaengine.c                         | 367 +++++++++++++++++++++
 sound/soc/Kconfig                                  |   5 +-
 sound/soc/Makefile                                 |   4 -
 sound/soc/omap/Kconfig                             |   2 +-
 sound/soc/pxa/Kconfig                              |   2 +-
 sound/soc/pxa/mmp-pcm.c                            |   8 +-
 sound/soc/pxa/mmp-sspa.c                           |  12 +-
 sound/soc/pxa/pxa-ssp.c                            |  76 +++--
 sound/soc/pxa/pxa2xx-ac97.c                        |  67 ++--
 sound/soc/pxa/pxa2xx-i2s.c                         |  28 +-
 sound/soc/pxa/pxa2xx-pcm.c                         |  21 +-
 sound/soc/soc-dmaengine-pcm.c                      | 367 ---------------------
 sound/soc/spear/Kconfig                            |   2 +-
 22 files changed, 607 insertions(+), 499 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/mrvl,pxa-ssp.txt
 create mode 100644 Documentation/devicetree/bindings/sound/mrvl,pxa2xx-pcm.txt
 create mode 100644 sound/core/pcm_dmaengine.c
 delete mode 100644 sound/soc/soc-dmaengine-pcm.c

-- 
1.8.3.1
