From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 23 May 2017 15:39:31 +0200
Subject: [PATCH 0/2] spi: Add Meson SPICC driver
Message-ID: <1495546773-20479-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Meson SPICC is generic SPI controller for general purpose Full-Duplex
communications with dedicated 16 words RX/TX PIO FIFOs.
It differs completely from the SPIFC, and thus need a separate driver.

The current driver only supportd the PIO transfer mode since the DMA seems
broken on available hardware.

This driver has been tested on a Amlogic S905X board.

Neil Armstrong (2):
  dt-bindings: spi-meson: Add SPICC bindings
  spi: Add Meson SPICC driver

 .../devicetree/bindings/spi/spi-meson.txt          |  31 ++
 drivers/spi/Kconfig                                |   7 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-meson-spicc.c                      | 619 +++++++++++++++++++++
 4 files changed, 658 insertions(+)
 create mode 100644 drivers/spi/spi-meson-spicc.c

-- 
1.9.1
