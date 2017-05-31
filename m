From: jiada_wang@mentor.com (jiada_wang at mentor.com)
Date: Wed, 31 May 2017 02:19:55 -0700
Subject: [PATCH v2 linux-next 0/3] i.MX ECSPI controller slave mode support
Message-ID: <1496222398-3192-1-git-send-email-jiada_wang@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jiada Wang <jiada_wang@mentor.com>


Changes in v2:
re-workd i.MX ECSPI controller slave mode support based on Geert's work

Jiada Wang (3):
  spi: imx: add selection for iMX53 and iMX6 controller
  ARM: dts: imx: change compatiblity for SPI controllers on imx53 later
    soc
  spi: imx: Add support for SPI Slave mode

 .../devicetree/bindings/spi/fsl-imx-cspi.txt       |   1 +
 arch/arm/boot/dts/imx53.dtsi                       |   4 +-
 arch/arm/boot/dts/imx6q.dtsi                       |   2 +-
 arch/arm/boot/dts/imx6qdl.dtsi                     |   8 +-
 arch/arm/boot/dts/imx6sl.dtsi                      |   8 +-
 arch/arm/boot/dts/imx6sx.dtsi                      |   8 +-
 arch/arm/boot/dts/imx6ul.dtsi                      |   8 +-
 drivers/spi/spi-imx.c                              | 273 ++++++++++++++++++---
 8 files changed, 257 insertions(+), 55 deletions(-)

-- 
2.7.4
