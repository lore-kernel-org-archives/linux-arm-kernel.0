From: marex@denx.de (Marek Vasut)
Date: Fri,  3 Aug 2012 17:26:05 +0200
Subject: [PATCH 00/10 V3] MXS SPI driver
Message-ID: <1344007575-11448-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds SPI master support for Freescale i.MX233/i.MX28.
This is rebased on top of next-20120713. Please consider applying,
bugs shall now be squashed during the previous two review rounds.

Marek Vasut (10):
  mmc: spi: Move SSP register definitions into separate file
  mmc: spi: Rename IMX2[38]_MMC to IMX2[38]_SSP
  mmc: spi: Add necessary bits into mxs-spi.h
  mmc: spi: Pull out parts shared between MMC and SPI
  mmc: spi: Pull out the SSP clock configuration function
  spi: Add SPI driver for mx233/mx28
  mmc: spi: Pull out common DMA parts from MXS MMC
  spi: Add DMA support into SPI driver
  spi: Add SSP/SPI device tree documentation
  ARM: mx28: Add SPI pinmux into imx28.dtsi

 Documentation/devicetree/bindings/spi/mxs-spi.txt |   18 +
 arch/arm/boot/dts/imx28.dtsi                      |   39 ++
 drivers/clk/mxs/Makefile                          |    2 +-
 drivers/clk/mxs/clk-ssp.c                         |   62 ++
 drivers/mmc/host/mxs-mmc.c                        |  325 ++++-------
 drivers/spi/Kconfig                               |    7 +
 drivers/spi/Makefile                              |    1 +
 drivers/spi/spi-mxs.c                             |  631 +++++++++++++++++++++
 include/linux/spi/mxs-spi.h                       |  150 +++++
 9 files changed, 1016 insertions(+), 219 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/mxs-spi.txt
 create mode 100644 drivers/clk/mxs/clk-ssp.c
 create mode 100644 drivers/spi/spi-mxs.c
 create mode 100644 include/linux/spi/mxs-spi.h

Cc: Attila Kinali <attila@kinali.ch>
Cc: Chris Ball <cjb@laptop.org>
CC: Dong Aisheng <b29396@freescale.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Linux ARM kernel <linux-arm-kernel@lists.infradead.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
-- 
1.7.10.4
