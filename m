From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 20 Jun 2013 15:20:19 +0200
Subject: ASoC: fsl-ssi: ac97-slave support
Message-ID: <1371734429-6081-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series adds DT support for phycore-ac97. Beside ac97 support, the series
adds imx-pcm-fiq and generic DMA bindings to fsl-ssi.

Version 9 contains some style fixes.

Regards,

Markus

Changes in v9:
 - Style and compile fixes.
 - Removed "ASoC: fsl: Kconfig: Use fsl-ssi for phycore-ac97". This patch is
   not necessary with the seperated phycore-ac97-dt driver.

Changes in v8:
 - Fix build issues in phycore-ac97.

Changes in v7:
 - Only one soc_ac97_ops struct for both ssi drivers (fsl-ssi and imx-ssi) to
   make it possible to compile a kernel with both drivers.
 - Other small bug/style fixes described in the changelogs of the patches.

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
      ASoC: imx-pcm-dma: DT support
      ASoC: imx-pcm-fiq: Introduce pcm-fiq-params
      ASoC: fsl: Move soc_ac97_ops from imx-ssi to fsl_ssi
      ASoC: fsl-ssi: Add support for imx-pcm-fiq
      ASoC: fsl-ssi: Use generic DMA bindings if possible
      ASoC: fsl-ssi: imx ac97 support
      ARM: imx: Export ac97 reset functions
      ASoC: Add phycore-ac97-dt driver
      ASoC: fsl: Move fsl-ssi binding doc to sound/
      ASoC: fsl: Update fsl-ssi binding doc

 .../{powerpc/fsl/ssi.txt => sound/fsl,ssi.txt}     |  10 +
 .../bindings/sound/phytec,phycore-ac97.txt         |  14 +
 arch/arm/mach-imx/mach-pca100.c                    |   7 +-
 arch/arm/mach-imx/mach-pcm043.c                    |   7 +-
 sound/soc/fsl/Kconfig                              |  17 +-
 sound/soc/fsl/Makefile                             |   2 +
 sound/soc/fsl/fsl_ssi.c                            | 451 +++++++++++++++++----
 sound/soc/fsl/fsl_ssi.h                            |   7 +
 sound/soc/fsl/imx-pcm-dma.c                        |   1 -
 sound/soc/fsl/imx-pcm-fiq.c                        |  18 +-
 sound/soc/fsl/imx-pcm.h                            |  15 +-
 sound/soc/fsl/imx-ssi.c                            |  14 +-
 sound/soc/fsl/imx-ssi.h                            |   1 +
 sound/soc/fsl/phycore-ac97-dt.c                    | 242 +++++++++++
 sound/soc/fsl/phycore-ac97.c                       |  13 +-
 15 files changed, 704 insertions(+), 115 deletions(-)
 rename Documentation/devicetree/bindings/{powerpc/fsl/ssi.txt => sound/fsl,ssi.txt} (88%)
 create mode 100644 Documentation/devicetree/bindings/sound/phytec,phycore-ac97.txt
 create mode 100644 sound/soc/fsl/phycore-ac97-dt.c
