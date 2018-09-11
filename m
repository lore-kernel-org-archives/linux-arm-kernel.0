From: tudor.ambarus@microchip.com (Tudor Ambarus)
Date: Tue, 11 Sep 2018 11:22:29 +0300
Subject: [PATCH v2 0/3] mtd: spi-nor: add Global Block Unlock support
Message-ID: <20180911082232.28678-1-tudor.ambarus@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To avoid inadvertent writes during power-up, SST26 flash memories are
write-protected by default after a power-on reset cycle. Unlock the serial
flash memory by using the Global Block Protection Unlock command - it offers
a single command cycle that unlocks the entire memory array.

v2:
- add Cyrille's reviewed-by tag
- add cover letter
- fix link to initial work done by Anurag Kumar Vulisha

Tudor Ambarus (3):
  mtd: spi-nor: add Global Block Unlock support
  mtd: spi-nor: unlock global block protection on sst26vf064b
  mtd: spi-nor: add support for Microchip SST26 QSPI flash memories

 drivers/mtd/spi-nor/spi-nor.c | 47 ++++++++++++++++++++++++++++++++++++++++++-
 include/linux/mtd/spi-nor.h   |  1 +
 2 files changed, 47 insertions(+), 1 deletion(-)

-- 
2.9.4
