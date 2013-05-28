From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 28 May 2013 16:47:48 +0200
Subject: [PATCH v6 00/10] ASoC: fsl-ssi: ac97-slave support
Message-ID: <1369752478-30260-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series adds DT support for phycore-ac97. Beside ac97 support, the series
adds imx-pcm-fiq and generic DMA bindings to fsl-ssi.

Regards,

Markus

Changes in v6:
 - Rebased onto 3.10-rc3 with Shawn's pcm cleanup patches
 - Setup of reset functions moved to phycore-ac97.c

Changes in v5:
 - Pass of_node via parent device to imx-pcm-dma.

Changes in v4:
 - phycore-ac97 uses the iomux functions based on audmux phandle now.
 - fsl-ssi imx-pcm-fiq got some new comments about problems with imx-ssi and
   incompatible codecs

Changes in v3:
 - Rebased onto pcm dma cleanup patches
 - A lot of cleanups for the fsl-ssi ac97 integration
 - Some small changes which are listed in the notes of the patches.

Markus Pargmann (10):
      ASoC: phycore-ac97: Add DT support
      ASoC: imx-pcm-dma: DT support
      ASoC: imx-pcm-fiq: Introduce pcm-fiq-params
      ASoC: fsl-ssi: Add support for imx-pcm-fiq
      ASoC: fsl-ssi: Use generic DMA bindings if possible
      ARM: imx: Export ac97 reset functions
      ASoC: fsl-ssi: imx ac97 support
      ASoC: fsl: Kconfig: Use fsl-ssi for phycore-ac97
      ASoC: fsl: Move fsl-ssi binding doc to sound/
      ASoC: fsl: Update fsl-ssi binding doc

 .../{powerpc/fsl/ssi.txt => sound/fsl,ssi.txt}     |  10 +
 .../bindings/sound/phytec,phycore-ac97.txt         |  14 +
 arch/arm/mach-imx/mach-pca100.c                    |   7 +-
 arch/arm/mach-imx/mach-pcm043.c                    |   7 +-
 sound/soc/fsl/Kconfig                              |   2 +-
 sound/soc/fsl/fsl_ssi.c                            | 441 +++++++++++++++++----
 sound/soc/fsl/fsl_ssi.h                            |   7 +
 sound/soc/fsl/imx-pcm-dma.c                        |   1 -
 sound/soc/fsl/imx-pcm-fiq.c                        |  18 +-
 sound/soc/fsl/imx-pcm.h                            |  12 +-
 sound/soc/fsl/imx-ssi.c                            |   7 +-
 sound/soc/fsl/imx-ssi.h                            |   1 +
 sound/soc/fsl/phycore-ac97.c                       | 241 +++++++++--
 13 files changed, 643 insertions(+), 125 deletions(-)
 rename Documentation/devicetree/bindings/{powerpc/fsl/ssi.txt => sound/fsl,ssi.txt} (88%)
 create mode 100644 Documentation/devicetree/bindings/sound/phytec,phycore-ac97.txt
