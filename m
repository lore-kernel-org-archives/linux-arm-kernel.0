From: radu_nicolae.pirea@upb.ro (Radu Pirea)
Date: Wed, 21 Nov 2018 13:27:29 +0200
Subject: [PATCH 0/3] Add PM and DMA support for AT91 USART as SPI
Message-ID: <20181121112732.15690-1-radu_nicolae.pirea@upb.ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch series improves the SPI driver for AT91 USART IP and
adds support for DMA transfers, updates the bindings of driver
and PM callback functions.

I decided to use DMA only for transfers long than 16 bytes. DMA
setup introduces a little overhead and is better to use PIO for
short transfers.

Radu Pirea (3):
  spi: at91-usart: add power management support
  dt-bindings: mfd: atmel-usart: add DMA bindings for SPI mode
  spi: at91-usart: add DMA support

 .../devicetree/bindings/mfd/atmel-usart.txt   |  15 +-
 drivers/spi/spi-at91-usart.c                  | 284 +++++++++++++++++-
 2 files changed, 292 insertions(+), 7 deletions(-)

-- 
2.19.1
