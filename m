From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun,  7 Apr 2013 21:25:10 +0200
Subject: [PATCH v2 00/11] ASoC: fsl-ssi: ac97-slave support
Message-ID: <1365362721-3731-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series adds DT support for phycore-ac97 using the fsl-ssi driver. In
version 2 I discarded most of the imx-ssi work and integrated the ac97-slave
support in fsl-ssi, including support for imx-pcm-fiq as alternative to dma.
There are some other changes to get phycore-ac97 working. The first two patches
have notes about the detailed changes since version 1. The rest of the patches
is new and necessary for the ac97-slave support.

Regards,

Markus


Markus Pargmann (11):
  ASoC: phycore-ac97: Add DT support
  ASoC: imx-pcm-dma: Add support for DMA init by
  ASoC: imx-pcm-fiq: Introduce pcm-fiq-params
  ASoC: fsl-ssi: Add SACNT definitions
  ASoC: fsl-ssi: Add support for imx-pcm-fiq
  ASoC: fsl-ssi: Setup generic imx dma params
  ARM: imx: Export ac97 reset functions
  ASoC: fsl-ssi: imx ac97 support
  ASoC: fsl: Kconfig: Use fsl-ssi for phycore-ac97
  ASoC: fsl: Move fsl-ssi binding doc to sound/
  ASoC: fsl: Update fsl-ssi binding doc

 Documentation/devicetree/bindings/powerpc/fsl/ssi.txt             |   73 -
 Documentation/devicetree/bindings/sound/fsl,ssi.txt               |   13 
 b/Documentation/devicetree/bindings/sound/fsl,ssi.txt             |   73 +
 b/Documentation/devicetree/bindings/sound/phytec,phycore-ac97.txt |   12 
 b/arch/arm/mach-imx/mach-pca100.c                                 |    7 
 b/arch/arm/mach-imx/mach-pcm043.c                                 |    7 
 b/sound/soc/fsl/Kconfig                                           |    2 
 b/sound/soc/fsl/fsl_ssi.c                                         |   70 +
 b/sound/soc/fsl/fsl_ssi.h                                         |    8 
 b/sound/soc/fsl/imx-pcm-dma.c                                     |   31 
 b/sound/soc/fsl/imx-pcm-fiq.c                                     |   14 
 b/sound/soc/fsl/imx-pcm.h                                         |    6 
 b/sound/soc/fsl/imx-ssi.c                                         |    7 
 b/sound/soc/fsl/imx-ssi.h                                         |    1 
 b/sound/soc/fsl/phycore-ac97.c                                    |  185 ++++
 sound/soc/fsl/fsl_ssi.c                                           |  379 +++++++---
 sound/soc/fsl/imx-pcm.h                                           |    9 
 17 files changed, 664 insertions(+), 233 deletions(-)
