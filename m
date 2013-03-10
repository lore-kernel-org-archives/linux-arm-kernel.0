From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun, 10 Mar 2013 19:33:01 +0100
Subject: [PATCH 00/10] ASoC: imx sound: Add DT support
Message-ID: <1362940391-8338-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series adds DT support for imx-ssi and phycore-ac97. It also
contains some fixes for imx-ssi and phycore-ac97.

Patch 8 introduces a seperated function 'of_snd_dmaengine_pcm_open'
to create a DMA PCM substream using the generic DMA DT bindings.

Regards,
Markus


Sascha Hauer (3):
 imx-ssi: Fix AC97 rates
 imx-ssi: Fix occasional AC97 reset failure
 mx-ssi: flush fifos

Markus Pargmann (7):
 ASoC: Kconfig: imx-ssi needs imx-fiq and imx-dma
 ASoC: pcm030 audio fabric: remove __init from probe
 ARM: soc-audio phycore-ac97: fix driver init order
 ASoC: phycore-ac97: Add DT support
 ASoC: dmaengine_pcm: Add open function for DT DMA
 ASoC: imx-pcm-dma: Add support for DMA init by device
 ASoC: imx-ssi: Add imx27 and pca100 DT support

 b/Documentation/devicetree/bindings/sound/fsl-imx-ssi |   34 ++++
 b/arch/arm/mach-imx/mach-pca100.c                     |    7 
 b/include/sound/dmaengine_pcm.h                       |    2 
 b/sound/soc/fsl/Kconfig                               |    2 
 b/sound/soc/fsl/imx-pcm-dma.c                         |   31 ++-
 b/sound/soc/fsl/imx-pcm.h                             |    6 
 b/sound/soc/fsl/imx-ssi.c                             |    2 
 b/sound/soc/fsl/pcm030-audio-fabric.c                 |    2 
 b/sound/soc/fsl/phycore-ac97.c                        |   33 ++--
 b/sound/soc/soc-dmaengine-pcm.c                       |   89 ++++++++--
 sound/soc/fsl/imx-ssi.c                               |   95 ++++++++++-
 sound/soc/fsl/phycore-ac97.c                          |  148 +++++++++++++++---
 12 files changed, 371 insertions(+), 80 deletions(-)
