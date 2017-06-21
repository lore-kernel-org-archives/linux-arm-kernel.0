From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Wed, 21 Jun 2017 16:32:04 +0200
Subject: [PATCH 0/2] Add support for STM32 SPI
Message-ID: <1498055526-6918-1-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for the STM32 Serial Peripheral Interface (SPI).

It applies to STM32 platforms implementing version 2 of SPI/I2S interface
like STM32H7 series.

It supports a half-duplex, full-duplex and simplex synchronous serial
communication with external devices with 4-bit to 16/32-bit per word.
It has two 8x/16x 8-bit embedded Rx and TxFIFOs with DMA capability.
It can operate in master or slave mode, but here, only master mode is
supported.

Amelie Delaunay (2):
  dt-bindings: spi: Document the STM32 SPI bindings
  spi: add driver for STM32 SPI controller

 .../devicetree/bindings/spi/spi-stm32.txt          |   60 +
 drivers/spi/Kconfig                                |   10 +
 drivers/spi/Makefile                               |    1 +
 drivers/spi/spi-stm32.c                            | 1266 ++++++++++++++++++++
 4 files changed, 1337 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-stm32.txt
 create mode 100644 drivers/spi/spi-stm32.c

-- 
1.9.1
