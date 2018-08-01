From: hayashibara.keiji@socionext.com (Keiji Hayashibara)
Date: Wed,  1 Aug 2018 16:29:10 +0900
Subject: [PATCH v3 0/2] add SPI controller driver for UniPhier SoCs
Message-ID: <1533108552-19878-1-git-send-email-hayashibara.keiji@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for SPI controller driver implemented on UniPhier SoCs.

Changes since v2:
- remove check code of clock divider in uniphier_spi_set_baudrate().
- change irq from struct variable to stack variable.
- other trivial change.

Keiji Hayashibara (1):
  spi: add SPI controller driver for UniPhier SoC

Kunihiko Hayashi (1):
  dt-bindings: spi: add DT bindings for UniPhier SPI controller

 .../devicetree/bindings/spi/spi-uniphier.txt       |  22 +
 drivers/spi/Kconfig                                |  13 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-uniphier.c                         | 525 +++++++++++++++++++++
 4 files changed, 561 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-uniphier.txt
 create mode 100644 drivers/spi/spi-uniphier.c

-- 
2.7.4
