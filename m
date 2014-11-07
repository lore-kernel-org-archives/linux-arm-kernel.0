From: padma.v@samsung.com (Padmavathi Venna)
Date: Fri, 07 Nov 2014 12:24:38 +0530
Subject: [PATCH 0/2] add support for exynos7 I2S controller
Message-ID: <1415343280-18916-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I2S on exynos7 includes the below changes
 - has got support for lower root clock sampling frequencies like 64,
   128, 96, 192fs. I2S on previous SoCs supports only 256,512,384 and 768.
 - supports 7.1CH TDM mode for recording. exynos5 has only 7.1CH TDM mode
   for playback.
 - secondary dai works with only external DMA. on previous SoCs secondary
   dai can work with either both or only internal DMA.
 - I2S1 controller upgraded to 5.1CH with slighlty modified bit offsets
   for supporting lower RFS and more no.of BFS values.

As internal dma is not mandatory on all SoCs this patchset introduced a
quirk for the same and added a structure to hold all the modified bit offsets
across all SoCs.

This patchset is made based on linux-next master branch and tested with
exynos7 base support from the below link.
http://www.spinics.net/lists/linux-samsung-soc/msg37047.html

Padmavathi Venna (2):
  ASoC: Samsung: Add quirk for internal DMA
  ASoC: samsung: add support for exynos7 I2S controller

 .../devicetree/bindings/sound/samsung-i2s.txt      |   15 +-
 include/linux/platform_data/asoc-s3c.h             |    1 +
 sound/soc/samsung/Kconfig                          |    2 +-
 sound/soc/samsung/i2s-regs.h                       |   10 +-
 sound/soc/samsung/i2s.c                            |  228 ++++++++++++++------
 5 files changed, 180 insertions(+), 76 deletions(-)

-- 
1.7.4.4
