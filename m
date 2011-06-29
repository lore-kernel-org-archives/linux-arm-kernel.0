From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 29 Jun 2011 20:00:14 +0200
Subject: use dmaengine for atmel ssc/pcm dai drivers
Message-ID: <1309370419-22810-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series is built on top of ASoC git tree for-3.1 branch.

It will add the DMA use through dmaengine to the SSC/PCM Atmel drivers. These
drivers are curently using the PDC DMA feature which has been replaced by a DMA
controller in some chips. The dmaengine driver curently used is at_hdmac.

The first patch is a little update to wm8731 codec driver.

Nicolas Ferre (5):
      ASoC: wm8731: rework power management
      ASoC: atmel-ssc: add phybase in device structure
      ASoC: atmel-ssc: dmaengine usage switch depending on cpu
      ASoC: atmel_ssc_dai/atmel-pcm: adapt to dmaengine usage
      ASoC: atmel_ssc_dai: PM: actually stopping clock on suspend/resume

 drivers/misc/atmel-ssc.c        |    1 +
 include/linux/atmel-ssc.h       |    4 +
 sound/soc/atmel/atmel-pcm.c     |  382 +++++++++++++++++++++++++++++++++++---
 sound/soc/atmel/atmel-pcm.h     |    4 +-
 sound/soc/atmel/atmel_ssc_dai.c |   53 ++++--
 sound/soc/codecs/wm8731.c       |    5 +-
 6 files changed, 395 insertions(+), 54 deletions(-)
