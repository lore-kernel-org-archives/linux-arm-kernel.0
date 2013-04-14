From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun, 14 Apr 2013 13:42:44 +0200
Subject: [PATCH v3 00/15] ASoC: fsl-ssi: ac97-slave support
Message-ID: <1365939779-4507-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series adds DT support for phycore-ac97. It is now based on the pcm dma
cleanups from Lars. Beside ac97 support, the series adds fsl-ssi imx-pcm-fiq
and generic DMA binding handling.

@Lars:
There are 4 new patches at the beginning of the series that fix some problems
of your cleanups. I think they were in the changes you posted. If not, could you
please add them to your branch?

Regards,

Markus


Changes in v3:
 - Rebased onto pcm dma cleanup patches
 - A lot of cleanups for the fsl-ssi ac97 integration
 - Some small changes which are listed in the notes of the patches.


Markus Pargmann (15):
      ASoC: imx-ssi: Fix includes
      ASoC: dmaengine-pcm: Replace of specific helper function
      ASoC: dmaengine-pcm: Fix function name
      ASoC: dmaengine-pcm: Fix pcm_request_chan function name
      ASoC: phycore-ac97: Add DT support
      ASoC: imx-pcm-dma: DT support
      ASoC: imx-pcm-fiq: Introduce pcm-fiq-params
      ASoC: fsl-ssi: Add SACNT definitions
      ASoC: fsl-ssi: Add support for imx-pcm-fiq
      ASoC: fsl-ssi: Use generic DMA bindings if possible
      ARM: imx: Export ac97 reset functions
      ASoC: fsl-ssi: imx ac97 support
      ASoC: fsl: Kconfig: Use fsl-ssi for phycore-ac97
      ASoC: fsl: Move fsl-ssi binding doc to sound/
      ASoC: fsl: Update fsl-ssi binding doc

 Documentation/devicetree/bindings/{powerpc/fsl/ssi.txt => sound/fsl,ssi.txt} |   7 +
 Documentation/devicetree/bindings/sound/phytec,phycore-ac97.txt              |  12 ++
 arch/arm/mach-imx/mach-pca100.c                                              |   7 +-
 arch/arm/mach-imx/mach-pcm043.c                                              |   7 +-
 include/sound/dmaengine_pcm.h                                                |   2 +-
 sound/soc/fsl/Kconfig                                                        |   2 +-
 sound/soc/fsl/fsl_ssi.c                                                      | 484 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------
 sound/soc/fsl/fsl_ssi.h                                                      |   8 ++
 sound/soc/fsl/imx-pcm-dma.c                                                  |   4 +-
 sound/soc/fsl/imx-pcm-fiq.c                                                  |  16 ++-
 sound/soc/fsl/imx-pcm.h                                                      |   9 ++
 sound/soc/fsl/imx-ssi.c                                                      |   7 +-
 sound/soc/fsl/imx-ssi.h                                                      |   2 +
 sound/soc/fsl/phycore-ac97.c                                                 | 184 +++++++++++++++++++++++----
 sound/soc/soc-generic-dmaengine-pcm.c                                        |   9 +-
 sound/soc/spear/spear_pcm.c                                                  |   2 +-
 16 files changed, 634 insertions(+), 128 deletions(-)
 rename Documentation/devicetree/bindings/{powerpc/fsl/ssi.txt => sound/fsl,ssi.txt} (92%)
 create mode 100644 Documentation/devicetree/bindings/sound/phytec,phycore-ac97.txt
