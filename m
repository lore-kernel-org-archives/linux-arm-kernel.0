From: mpa@pengutronix.de (Markus Pargmann)
Date: Sat, 27 Jul 2013 13:31:49 +0200
Subject: [PATCH v10 0/7] ASoC: fsl-ssi: ac97-slave support
Message-ID: <1374924716-23475-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this series implements ac97-slave support for fsl-ssi and phycore ac97 DT
support.

Since v9 there were a lot of changes. I dropped the board specific ac97-link
reset functions and added generic functions to soc-core. It uses devicetree
parsed pinctrl and gpios. The audmux setup was removed from phycore-ac97-dt.
The initial setup can now be defined in DT.

Regards,

Markus


Markus Pargmann (7):
      ASoC: core: Generic ac97 link reset functions
      ASoC: codec: wm9712 simple DT bindings
      ASoC: imx-audmux: Read default configuration from devicetree
      ASoC: fsl-ssi: Add support for imx-pcm-fiq
      ASoC: fsl-ssi: Use generic DMA bindings if possible
      ASoC: fsl-ssi: ac97-slave support
      ASoC: Add phycore-ac97-dt driver

 .../devicetree/bindings/sound/fsl,ssi.txt          |  12 +
 .../devicetree/bindings/sound/imx-audmux.txt       |   9 +
 .../bindings/sound/phytec,phycore-ac97.txt         |  16 +
 .../devicetree/bindings/sound/soc-ac97link.txt     |  28 ++
 Documentation/devicetree/bindings/sound/wm9712.txt |  10 +
 include/sound/soc.h                                |   2 +
 sound/soc/codecs/wm9712.c                          |   9 +
 sound/soc/fsl/Kconfig                              |  15 +-
 sound/soc/fsl/Makefile                             |   2 +
 sound/soc/fsl/fsl_ssi.c                            | 431 +++++++++++++++++----
 sound/soc/fsl/imx-audmux.c                         |  62 +++
 sound/soc/fsl/phycore-ac97-dt.c                    | 124 ++++++
 sound/soc/fsl/phycore-ac97.c                       |  13 +-
 sound/soc/soc-core.c                               | 153 ++++++++
 14 files changed, 789 insertions(+), 97 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/phytec,phycore-ac97.txt
 create mode 100644 Documentation/devicetree/bindings/sound/soc-ac97link.txt
 create mode 100644 Documentation/devicetree/bindings/sound/wm9712.txt
 create mode 100644 sound/soc/fsl/phycore-ac97-dt.c
