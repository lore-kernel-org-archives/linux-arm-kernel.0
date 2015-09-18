From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Fri, 18 Sep 2015 17:49:24 +0200
Subject: [PATCH linux-next 0/4] mtd: spi-nor: fix Quad SPI memory support
Message-ID: <cover.1442590224.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

this series of patches fixes the QSPI support mostly for Micron and
Macronix memories. There are also some updates for Spansion memories.
There are also many comments to explain the implementation choices based
on the datasheets from memory manufacturers.

The series was backported to a at91-4.1 kernel then tested on a sama5d2
xplained board, which embeds a at25df321a memory on a SPI controller and
a Micron n25q128a13 QSPI memory on the new Atmel QSPI controller.

The at25 memory was used to check non regression on the m25p80 driver
whereas the Micron memory was used to test the fixes of the spi-nor
framework. The driver for the Atmel QSPI controller will be sent in a
dedicated series.

Best Regards,

Cyrille

Cyrille Pitchen (4):
  mtd: spi-nor: remove unused read_xfer/write_xfer hooks
  mtd: spi-nor: properly detect the memory when it boots in Quad or Dual
    mode
  mtd: spi-nor: fix Quad SPI mode support for Spansion, Micron and
    Macronix
  mtd: m25p80: add support of dual and quad spi protocols to all
    commands

 drivers/mtd/devices/m25p80.c  | 254 ++++++++++---
 drivers/mtd/spi-nor/spi-nor.c | 811 ++++++++++++++++++++++++++++++++++++------
 include/linux/mtd/spi-nor.h   |  69 ++--
 3 files changed, 954 insertions(+), 180 deletions(-)

-- 
1.8.2.2
