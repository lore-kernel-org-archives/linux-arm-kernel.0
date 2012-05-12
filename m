From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 12 May 2012 16:20:53 +0800
Subject: [GIT PULL] mxs device tree support for v3.5
Message-ID: <20120512082050.GG17875@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following mxs device tree support for v3.5.  I chose
to base the branch on top of the merge of clk/mxs and
imx/pinctrl/for-3.5 (both are pulled into arm-soc now) to save
conflicts a lot.  It additionally depends on arm-soc/next/stmp-dev
to build and function.

Regards,
Shawn

The following changes since commit 844d0b5a0b42d6c73114a1dc229db751120d226f:

  Merge branches 'clk/mxs' and 'imx/pinctrl/for-3.5' into mxs/dt/for-3.5 (2012-05-12 13:32:09 +0800)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git mxs/dt/for-3.5

Dong Aisheng (5):
      ARM: mxs: add initial device tree support for imx28-evk board
      dma: mxs-dma: use global stmp_device functionality
      dma: mxs-dma: add device tree probe support
      ARM: mxs: do not add dma device by default
      ARM: mxs: add mxs-dma dt support

Shawn Guo (21):
      ARM: mxs: add initial device tree support for imx23-evk board
      ARM: mxs: always build in device tree support
      dma: mxs-dma: let dma_is_apbh and apbh_is_old take parameter
      dma: mxs-dma: make platform_device_id more generic
      gpio/mxs: use devm_* helpers to make error handling simple
      gpio/mxs: get rid of the use of cpu_is_xxx
      gpio/mxs: add device tree probe
      ARM: mxs: add gpio support for device tree boot
      mmc: mxs-mmc: use global stmp_device functionality
      mmc: mxs-mmc: let ssp_is_old take host as parameter
      mmc: mxs-mmc: get rid of the use of cpu_is_xxx
      mmc: mxs-mmc: move header from mach into linux folder
      mmc: mxs-mmc: use devm_* helper to make cleanup simpler
      mmc: mxs-mmc: have dma_channel than dma_res in mxs_mmc_host
      mmc: mxs-mmc: copy wp_gpio in struct mxs_mmc_host
      mmc: mxs-mmc: add device tree support
      ARM: dts: enable mmc for imx23-evk
      ARM: dts: enable mmc for imx28-evk
      i2c: mxs: add device tree probe support
      ARM: dts: enable i2c device for imx28-evk
      ARM: dts: enable audio support for imx28-evk

 Documentation/devicetree/bindings/arm/fsl.txt      |    8 +
 .../devicetree/bindings/dma/fsl-mxs-dma.txt        |   19 +
 .../devicetree/bindings/gpio/gpio-mxs.txt          |   87 ++++
 Documentation/devicetree/bindings/i2c/i2c-mxs.txt  |   16 +
 Documentation/devicetree/bindings/mmc/mxs-mmc.txt  |   26 +
 arch/arm/Kconfig                                   |    1 +
 arch/arm/boot/dts/imx23-evk.dts                    |   43 ++
 arch/arm/boot/dts/imx23.dtsi                       |  295 ++++++++++++
 arch/arm/boot/dts/imx28-evk.dts                    |  114 +++++
 arch/arm/boot/dts/imx28.dtsi                       |  497 ++++++++++++++++++++
 arch/arm/configs/mxs_defconfig                     |    1 +
 arch/arm/mach-mxs/Kconfig                          |   10 +
 arch/arm/mach-mxs/Makefile                         |    1 +
 arch/arm/mach-mxs/devices/Kconfig                  |    1 -
 arch/arm/mach-mxs/devices/platform-dma.c           |   21 +-
 arch/arm/mach-mxs/devices/platform-gpio-mxs.c      |   24 +-
 arch/arm/mach-mxs/devices/platform-mxs-mmc.c       |   21 +-
 arch/arm/mach-mxs/include/mach/common.h            |    7 +-
 arch/arm/mach-mxs/include/mach/devices-common.h    |    3 +-
 arch/arm/mach-mxs/mach-mxs.c                       |  121 +++++
 arch/arm/mach-mxs/mm.c                             |   16 +
 drivers/clk/mxs/clk-imx23.c                        |    9 +-
 drivers/clk/mxs/clk-imx28.c                        |   13 +-
 drivers/dma/Kconfig                                |    1 +
 drivers/dma/mxs-dma.c                              |  188 +++++---
 drivers/gpio/gpio-mxs.c                            |  156 ++++---
 drivers/i2c/busses/i2c-mxs.c                       |   13 +
 drivers/mmc/host/mxs-mmc.c                         |  197 +++++----
 include/linux/fsl/mxs-dma.h                        |   12 +-
 .../mach/mmc.h => include/linux/mmc/mxs-mmc.h      |    7 +-
 30 files changed, 1640 insertions(+), 288 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/fsl-mxs-dma.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-mxs.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mxs.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/mxs-mmc.txt
 create mode 100644 arch/arm/boot/dts/imx23-evk.dts
 create mode 100644 arch/arm/boot/dts/imx23.dtsi
 create mode 100644 arch/arm/boot/dts/imx28-evk.dts
 create mode 100644 arch/arm/boot/dts/imx28.dtsi
 create mode 100644 arch/arm/mach-mxs/mach-mxs.c
 rename arch/arm/mach-mxs/include/mach/mmc.h => include/linux/mmc/mxs-mmc.h (81%)
