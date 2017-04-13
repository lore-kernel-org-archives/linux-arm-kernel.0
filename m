From: jiada_wang@mentor.com (jiada_wang at mentor.com)
Date: Thu, 13 Apr 2017 05:13:59 -0700
Subject: [PATCH RFC 0/5] *** SPI Slave mode support ***
Message-ID: <1492085644-4195-1-git-send-email-jiada_wang@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jiada Wang <jiada_wang@mentor.com>

v1:
  add Slave mode support in SPI core
  spidev create slave device when SPI controller work in slave mode
  spi-imx support to work in slave mode

Jiada Wang (5):
  spi: core: add support to work in Slave mode
  spi: spidev: use different name for SPI controller slave mode device
  spi: imx: add selection for iMX53 and iMX6 controller
  ARM: dts: imx: change compatiblity for SPI controllers on imx53 later
    soc
  spi: imx: Add support for SPI Slave mode for imx53 and imx6 chips

 Documentation/devicetree/bindings/spi/spi-bus.txt |  27 ++-
 Documentation/spi/spi-summary                     |  19 +-
 arch/arm/boot/dts/imx53.dtsi                      |   4 +-
 arch/arm/boot/dts/imx6q.dtsi                      |   2 +-
 arch/arm/boot/dts/imx6qdl.dtsi                    |   8 +-
 arch/arm/boot/dts/imx6sl.dtsi                     |   8 +-
 arch/arm/boot/dts/imx6sx.dtsi                     |   8 +-
 arch/arm/boot/dts/imx6ul.dtsi                     |   8 +-
 drivers/spi/Kconfig                               |  14 +-
 drivers/spi/spi-imx.c                             | 216 ++++++++++++++++++++--
 drivers/spi/spi.c                                 |  23 ++-
 drivers/spi/spidev.c                              |  15 +-
 include/linux/spi/spi.h                           |  15 ++
 13 files changed, 310 insertions(+), 57 deletions(-)

-- 
2.7.4
