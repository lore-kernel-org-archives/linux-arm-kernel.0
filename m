From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  8 Dec 2014 12:53:30 +0000
Subject: [PATCH v3 0/4] spi: st: New driver for ST's SPI Controller
Message-ID: <1418043214-14324-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a new driver which controls the SPI component of ST's
Synchronous Serial Controller (SSC).
 
v2 => v3:
- Fixes Patrice's review comments
- Removed COMPILE_TEST (at least until Will Deacon's patch lands)

v1 => v2:
- New, more specific CONFIG symbol
- Increased Runtime PM functionality
- Make use of new Pinctrl API
- Convert from SPI Bitbang => Transfer One
- Omit functionality which Core can handle
- Removal of *cough* debug code

Lee Jones (4):
  spi: Add new driver for STMicroelectronics' SPI Controller
  spi: st: Provide Device Tree binding documentation
  ARM: sti: Provide DT nodes for SSC[0..4]
  ARM: sti: Provide DT nodes for SBC SSC[0..2]

 Documentation/devicetree/bindings/spi/spi-st.txt |  40 ++
 arch/arm/boot/dts/stih407.dtsi                   |  85 ++++
 drivers/spi/Kconfig                              |   7 +
 drivers/spi/Makefile                             |   1 +
 drivers/spi/spi-st-ssc4.c                        | 509 +++++++++++++++++++++++
 5 files changed, 642 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-st.txt
 create mode 100644 drivers/spi/spi-st-ssc4.c

-- 
1.9.1
