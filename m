From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri,  8 Jul 2011 16:27:28 +0800
Subject: [PATCH 0/6] Add device tree support for imx spi driver
Message-ID: <1310113654-25887-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch set makes some cleanups on imx spi driver to get it ready
for adding device tree probe and then add the support.

Those two dt helper function related patches are carried here to
resolve the dependency.  They should be on the way to sit on Grant's
devicetree/next branch.

Rob Herring (1):
      dt: add helper function to read u32 arrays

Shawn Guo (5):
      ARM: mxc: remove unnecessary header file inclusion from gpio.h
      spi/imx: use soc name in spi device type naming scheme
      spi/imx: copy gpio number passed by platform data into driver private data
      dt: add empty of_property_read_u32[_array] for non-dt
      spi/imx: add device tree probe support

 .../devicetree/bindings/spi/fsl-imx-cspi.txt       |   22 +
 arch/arm/mach-imx/clock-imx25.c                    |    7 +-
 arch/arm/mach-mx5/clock-mx51-mx53.c                |   11 +-
 arch/arm/plat-mxc/devices/platform-spi_imx.c       |   12 +-
 arch/arm/plat-mxc/include/mach/gpio.h              |    2 -
 drivers/of/base.c                                  |   19 +-
 drivers/spi/Kconfig                                |   15 -
 drivers/spi/spi-imx.c                              |  468 ++++++++++----------
 include/linux/of.h                                 |   29 ++-
 9 files changed, 317 insertions(+), 268 deletions(-)
