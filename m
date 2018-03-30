From: ssuloev@orpaltech.com (Sergey Suloev)
Date: Fri, 30 Mar 2018 15:50:41 +0300
Subject: [PATCH v2 0/6] spi: Add support for DMA transfers in sun6i SPI driver
Message-ID: <20180330125047.13936-1-ssuloev@orpaltech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patchset provides corrections for PIO-mode
and support for DMA transfers in sun6i SPI driver.

Changes in v2:
1) Fixed issue with misplacing a piece of code that requires access
to the transfer structure into sun6i_spi_prepare_message() function
where the transfer structure is not available.

2) Fixed issue with passing an invalid argument into devm_request_irq()
function.

Sergey Suloev (6):
  spi: sun6i: coding style/readability improvements
  spi: sun6i: handle chip select polarity flag
  spi: sun6i: restrict transfer length in PIO-mode
  spi: sun6i: use completion provided by SPI core
  spi: sun6i: introduce register set/unset helpers
  spi: sun6i: add DMA transfers support

 drivers/spi/spi-sun6i.c | 507 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 381 insertions(+), 126 deletions(-)

-- 
2.16.2
