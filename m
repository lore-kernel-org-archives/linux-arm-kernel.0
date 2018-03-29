From: ssuloev@orpaltech.com (Sergey Suloev)
Date: Thu, 29 Mar 2018 21:59:01 +0300
Subject: [PATCH 0/6] spi: Add support for DMA transfers in sun4i SPI driver
Message-ID: <20180329185907.27281-1-ssuloev@orpaltech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patchset provides corrections for PIO-mode
and support for DMA transfers in sun4i SPI driver.

Sergey Suloev (6):
  spi: core: handle timeout error from transfer_one()
  spi: sun4i: restrict transfer length in PIO-mode
  spi: sun4i: coding style/readability improvements
  spi: sun4i: use completion provided by SPI core driver
  spi: sun4i: introduce register set/unset helpers
  spi: sun4i: add DMA transfers support

 drivers/spi/spi-sun4i.c | 443 ++++++++++++++++++++++++++++++++++++------------
 drivers/spi/spi.c       |   5 +-
 2 files changed, 341 insertions(+), 107 deletions(-)

-- 
2.16.2
