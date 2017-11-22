From: suzuki.katsuhiro@socionext.com (Katsuhiro Suzuki)
Date: Wed, 22 Nov 2017 20:43:13 +0900
Subject: [PATCH 0/8] add UniPhier audio system support
Message-ID: <20171122114321.29196-1-suzuki.katsuhiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for Socionext audio system for
UniPhier LD11/LD20 SoCs. This driver supports I2S output
for Line-In, Line-Out and S/PDIF output.

UniPhier AIO DAI driver provides sound devices such as I2S, S/PDIF.
Since the AIO has mixed register map for those I/Os, it is hard to
split register areas for each sound devices.

UniPhier EVEA is a codec core for Line-In, Line-Out. Since this core
is only in internal of UniPhier series SoC, this driver works
independently but only UniPhier SoC can use it.

Katsuhiro Suzuki (8):
  ASoC: spdif: Add S32_LE support for S/PDIF dummy codec drivers
  ASoC: uniphier: add DT bindings documentation for UniPhier EVEA
  ASoC: uniphier: add DT bindings documentation for UniPhier AIO
  ASoC: uniphier: add support for UniPhier EVEA codec
  ASoC: uniphier: add support for UniPhier AIO driver
  ASoC: uniphier: add support for UniPhier LD11/LD20 AIO driver
  MAINTAINERS: add entries for UniPhier ASoC sound drivers
  arm64: dts: uniphier: add sound node for UniPhier

 .../devicetree/bindings/sound/uniphier,aio.txt     |  36 ++
 .../devicetree/bindings/sound/uniphier,evea.txt    |  26 +
 MAINTAINERS                                        |   6 +
 .../boot/dts/socionext/uniphier-ld11-global.dts    |  72 +++
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi   |  31 +
 .../boot/dts/socionext/uniphier-ld20-global.dts    |  72 +++
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi   |  35 ++
 sound/soc/Kconfig                                  |   1 +
 sound/soc/Makefile                                 |   1 +
 sound/soc/codecs/spdif_receiver.c                  |   5 +-
 sound/soc/codecs/spdif_transmitter.c               |   5 +-
 sound/soc/uniphier/Kconfig                         |  34 +
 sound/soc/uniphier/Makefile                        |   8 +
 sound/soc/uniphier/aio-core.c                      | 368 +++++++++++
 sound/soc/uniphier/aio-dma.c                       | 266 ++++++++
 sound/soc/uniphier/aio-ld11.c                      | 343 ++++++++++
 sound/soc/uniphier/aio-regctrl.c                   | 699 +++++++++++++++++++++
 sound/soc/uniphier/aio-regctrl.h                   | 495 +++++++++++++++
 sound/soc/uniphier/aio.h                           | 261 ++++++++
 sound/soc/uniphier/evea.c                          | 567 +++++++++++++++++
 20 files changed, 3327 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/uniphier,aio.txt
 create mode 100644 Documentation/devicetree/bindings/sound/uniphier,evea.txt
 create mode 100644 sound/soc/uniphier/Kconfig
 create mode 100644 sound/soc/uniphier/Makefile
 create mode 100644 sound/soc/uniphier/aio-core.c
 create mode 100644 sound/soc/uniphier/aio-dma.c
 create mode 100644 sound/soc/uniphier/aio-ld11.c
 create mode 100644 sound/soc/uniphier/aio-regctrl.c
 create mode 100644 sound/soc/uniphier/aio-regctrl.h
 create mode 100644 sound/soc/uniphier/aio.h
 create mode 100644 sound/soc/uniphier/evea.c

-- 
2.15.0
