From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 8 Apr 2013 17:00:21 +0800
Subject: [GIT PULL 4/4] ARM: mxs: device tree changes for 3.10
In-Reply-To: <1365411621-18422-1-git-send-email-shawn.guo@linaro.org>
References: <1365411621-18422-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1365411621-18422-4-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

This is the mxs device tree changes for 3.10.  It's based on
mxs-cleanup-3.10 to avoid some nasty conflicts.  Please pull, thanks.

Shawn

The following changes since commit e933a1a12a02f42e0013cda87bba37ccb59efc47:

  clocksource: mxs_timer: Add semicolon at end of line (2013-04-03 10:30:08 +0800)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/mxs-dt-3.10

for you to fetch changes up to 4344429d3d926d219671f607125cff51223a140a:

  video: mxsfb: Introduce regulator support (2013-04-08 15:44:55 +0800)

----------------------------------------------------------------
The mxs device tree changes for 3.10:

* Move enet_out clk into device tree and have fec driver handle it.
* Convert mxsfb driver to generic display timings bindings, and remove
  the mxsfb auxdata from platform code.
* Add generic DMA device tree binding for mxs-dma, and convert the most
  of client device drivers to it.
* Change mxsfb driver to use regulator for controlling power of panel.
* A few device tree source updates

----------------------------------------------------------------
Alexandre Belloni (3):
      ARM: cfa10036: add one wire bitbanging to the cfa10049
      pinctrl: pinctrl-mxs: document the missing pull-ups
      ARM: dts: cfa10036: Add touchscreen support to the CFA-10049

Alexandre Pereira da Silva (1):
      ARM: dts: imx23-olinuxino: mark sdcard cd as broken

Fabio Estevam (1):
      video: mxsfb: Introduce regulator support

Shawn Guo (16):
      net: fec: handle optional clk_ptp more gracefully
      ARM: mxs: remove unneeded enet_out clk initialization
      video: mxsfb: use devm_* managed functions
      video: mxsfb: remove fb_phys/fb_size from platform_data
      video: mxsfb: remove dotclk_delay from platform_data
      video: mxsfb: get display timings from device tree
      ARM: mxs: move display timing configurations into device tree
      video: mxsfb: remove mxsfb_platform_data
      ARM: dts: add generic DMA device tree binding for mxs-dma
      dma: mxs-dma: use devm_* managed functions
      dma: mxs-dma: move to generic device tree binding
      mmc: mxs-mmc: move to use generic DMA helper
      spi: mxs-spi: move to use generic DMA helper
      i2c: i2c-mxs: move to use generic DMA helper
      mtd: gpmi: move to use generic DMA helper
      serial: mxs-auart: move to use generic DMA helper

Wolfram Sang (2):
      net: freescale: fec: add support for optional enet_out clk
      ARM: dts: mxs: add enet_out clock to devicetree

 .../devicetree/bindings/dma/fsl-mxs-dma.txt        |   49 +++-
 Documentation/devicetree/bindings/fb/mxsfb.txt     |   36 ++-
 Documentation/devicetree/bindings/i2c/i2c-mxs.txt  |   12 +-
 Documentation/devicetree/bindings/mmc/mxs-mmc.txt  |   12 +-
 .../devicetree/bindings/mtd/gpmi-nand.txt          |   17 +-
 .../bindings/pinctrl/fsl,mxs-pinctrl.txt           |    4 +
 Documentation/devicetree/bindings/spi/mxs-spi.txt  |   12 +-
 .../bindings/tty/serial/fsl-mxs-auart.txt          |   16 +-
 arch/arm/boot/dts/imx23-evk.dts                    |   36 ++-
 arch/arm/boot/dts/imx23-olinuxino.dts              |    1 +
 arch/arm/boot/dts/imx23.dtsi                       |   42 +++-
 arch/arm/boot/dts/imx28-apf28dev.dts               |   25 ++
 arch/arm/boot/dts/imx28-apx4devkit.dts             |   25 ++
 arch/arm/boot/dts/imx28-cfa10049.dts               |   50 +++-
 arch/arm/boot/dts/imx28-evk.dts                    |   36 ++-
 arch/arm/boot/dts/imx28-m28evk.dts                 |   27 ++
 arch/arm/boot/dts/imx28.dtsi                       |   62 ++++-
 arch/arm/boot/dts/imx6qdl.dtsi                     |    8 +-
 arch/arm/mach-mxs/mach-mxs.c                       |  170 -------------
 drivers/dma/mxs-dma.c                              |  109 +++++---
 drivers/i2c/busses/i2c-mxs.c                       |   40 +--
 drivers/mmc/host/mxs-mmc.c                         |   48 +---
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c             |   51 +---
 drivers/mtd/nand/gpmi-nand/gpmi-nand.h             |    3 +-
 drivers/net/ethernet/freescale/fec.c               |   18 +-
 drivers/net/ethernet/freescale/fec.h               |    1 +
 drivers/spi/spi-mxs.c                              |   60 +----
 drivers/tty/serial/mxs-auart.c                     |   52 +---
 drivers/video/Kconfig                              |    2 +
 drivers/video/mxsfb.c                              |  260 ++++++++++++--------
 include/linux/mxsfb.h                              |   52 ----
 include/linux/spi/mxs-spi.h                        |    4 +-
 32 files changed, 696 insertions(+), 644 deletions(-)
 delete mode 100644 include/linux/mxsfb.h
