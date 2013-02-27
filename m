From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 27 Feb 2013 23:25:36 +0800
Subject: [PATCH 00/12] ARM: mxs: move to generic DMA device tree binding
Message-ID: <1361978748-25281-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The series converts mxs-dma and its clients to generic DMA device tree
binding/helper.

Subsystem maintainers,

I need your ACKs to have the series go via arm-soc as a whole if the
patches look good to you.

Mark,

Patch "ASoC: dmaengine_pcm: support use of generic DMA helper" is not
mxs specific.  It makes more sense for you to maintain a topic branch
for that patch.  It should be useful for any dmaengine_pcm users that
want to move to generic DMA helper.

Regards,
Shawn

Shawn Guo (12):
  ARM: dts: add generic DMA device tree binding for mxs-dma
  dma: mxs-dma: use devm_* managed functions
  dma: mxs-dma: move to generic device tree binding
  mmc: mxs-mmc: move to use generic DMA helper
  spi: mxs-spi: move to use generic DMA helper
  i2c: i2c-mxs: move to use generic DMA helper
  mtd: gpmi: move to use generic DMA helper
  serial: mxs-auart: move to use generic DMA helper
  ASoC: dmaengine_pcm: support use of generic DMA helper
  ASoC: mxs: move to use generic DMA helper
  dma: mxs-dma: remove code left from generic DMA binding conversion
  ARM: dts: remove mxs-dma channel interrupt number from client nodes

 .../devicetree/bindings/dma/fsl-mxs-dma.txt        |   49 ++++++-
 Documentation/devicetree/bindings/i2c/i2c-mxs.txt  |   12 +-
 Documentation/devicetree/bindings/mmc/mxs-mmc.txt  |   12 +-
 .../devicetree/bindings/mtd/gpmi-nand.txt          |   17 ++-
 .../devicetree/bindings/sound/mxs-saif.txt         |   18 ++-
 Documentation/devicetree/bindings/spi/mxs-spi.txt  |   12 +-
 .../bindings/tty/serial/fsl-mxs-auart.txt          |   16 +--
 arch/arm/boot/dts/imx23.dtsi                       |   54 ++++++--
 arch/arm/boot/dts/imx28.dtsi                       |   94 +++++++++++---
 arch/arm/boot/dts/imx6qdl.dtsi                     |   12 +-
 drivers/dma/mxs-dma.c                              |  135 ++++++++++++--------
 drivers/i2c/busses/i2c-mxs.c                       |   40 +-----
 drivers/mmc/host/mxs-mmc.c                         |   48 +------
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c             |   51 +-------
 drivers/mtd/nand/gpmi-nand/gpmi-nand.h             |    3 +-
 drivers/spi/spi-mxs.c                              |   60 ++-------
 drivers/tty/serial/mxs-auart.c                     |   52 +-------
 include/linux/fsl/mxs-dma.h                        |   20 ---
 include/linux/spi/mxs-spi.h                        |    4 +-
 include/sound/dmaengine_pcm.h                      |    5 +
 sound/soc/mxs/mxs-pcm.c                            |   43 +------
 sound/soc/mxs/mxs-pcm.h                            |    5 -
 sound/soc/mxs/mxs-saif.c                           |   28 +---
 sound/soc/mxs/mxs-saif.h                           |    3 +-
 sound/soc/soc-dmaengine-pcm.c                      |   19 ++-
 25 files changed, 357 insertions(+), 455 deletions(-)
 delete mode 100644 include/linux/fsl/mxs-dma.h

-- 
1.7.9.5
