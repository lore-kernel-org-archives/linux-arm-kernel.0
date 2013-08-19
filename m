From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 19 Aug 2013 17:05:53 +0200
Subject: [PATCH v11 0/7] ASoC: fsl-ssi: ac97-slave support
Message-ID: <1376924761-4054-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this series implements ac97-slave support for fsl-ssi and adds a simple generic
DT sound card.

Regards,

Markus

Changes in v11:
 - Dropped phycard specific sound patches
 - Added a generic simple DT sound card with support for ac97 using ac97-codec
 - Some new bugfix patches

Markus Pargmann (5):
      ASoC: imx-pcm-dma: Add missing include
      ASoC: core: Generic ac97 link reset functions
      ASoC: generic: simple DT sound card
      ASoC: fsl: Kconfig, visible config items for simple card
      ASoC: fsl-ssi: ac97-slave support

Michael Grzeschik (2):
      ASoC: fsl-ssi: imx-pcm-fiq bugfix
      ASoC: fsl: disable ssi irq for imx

Steffen Trumtrar (1):
      ASoC: fsl-ssi: add SSIEN errata work around

 .../devicetree/bindings/sound/fsl,ssi.txt          |   4 +
 .../bindings/sound/generic,simple-dt-card.txt      |  28 ++
 .../devicetree/bindings/sound/soc-ac97link.txt     |  28 ++
 include/sound/soc.h                                |   2 +
 sound/soc/fsl/Kconfig                              |  23 +-
 sound/soc/fsl/fsl_ssi.c                            | 369 ++++++++++++++++-----
 sound/soc/fsl/imx-pcm-dma.c                        |   1 +
 sound/soc/generic/Kconfig                          |   1 +
 sound/soc/generic/Makefile                         |   3 +-
 sound/soc/generic/simple-dt-card.c                 | 186 +++++++++++
 sound/soc/soc-core.c                               | 153 +++++++++
 11 files changed, 711 insertions(+), 87 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/generic,simple-dt-card.txt
 create mode 100644 Documentation/devicetree/bindings/sound/soc-ac97link.txt
 create mode 100644 sound/soc/generic/simple-dt-card.c
