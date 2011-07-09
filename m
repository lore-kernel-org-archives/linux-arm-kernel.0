From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 10 Jul 2011 01:16:34 +0800
Subject: [PATCH v2 0/7] Add device tree support for imx spi driver
Message-ID: <1310231801-18761-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch set makes some cleanups on imx spi driver to get it ready
for adding device tree probe and then add the support.

Changes since v1:
 * Split the big patch into small ones per Sascha's comment
 * Drop the patch cleaning mxc/mach/gpio.h from the series.  Will
   post it separately later.
 * Drop dt helper patches, as they are on Grant's tree

Shawn Guo (7):
      spi/imx: do not make copy of spi_imx_devtype_data
      spi/imx: use mx21 to name SPI_IMX_VER_0_0 function and macro
      spi/imx: do not use spi_imx2_3 to name SPI_IMX_VER_2_3 function and macro
      spi/imx: merge type SPI_IMX_VER_0_7 into SPI_IMX_VER_0_4
      spi/imx: use soc name in spi device type naming scheme
      spi/imx: copy gpio number passed by platform data into driver private data
      spi/imx: add device tree probe support

 .../devicetree/bindings/spi/fsl-imx-cspi.txt       |   22 +
 arch/arm/mach-imx/clock-imx25.c                    |    7 +-
 arch/arm/mach-mx5/clock-mx51-mx53.c                |   11 +-
 arch/arm/plat-mxc/devices/platform-spi_imx.c       |   12 +-
 drivers/spi/Kconfig                                |   15 -
 drivers/spi/spi-imx.c                              |  468 ++++++++++----------
 6 files changed, 277 insertions(+), 258 deletions(-)
