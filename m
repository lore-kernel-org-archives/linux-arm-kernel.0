From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 20 Aug 2015 12:00:03 +0200
Subject: [PATCH v2 0/4] regmap: i2c block support
Message-ID: <1440064807-26346-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series adds support for i2c block read/writes. To support the maximum 32
byte read/write operations, the regmap core is extended by max_raw_read and
max_raw_write. bulk operations are splitted depending of the size of
max_raw_read/write.

These patches were included in the previous series "Regmap max_raw_io and
bmc150 SPI support". The patches are based on "regmap: fixes".

I am not able to perform any tests for the last patch of this series as I don't
have hardware to test this on.

Changes in v2:
- max_raw_io splitted into max_raw_read/write
- Use E2BIG as error value in the block read/write functions

Best Regards,

Markus


Markus Pargmann (4):
  regmap: Introduce max_raw_read/write for regmap_bulk_read/write
  regmap: regmap max_raw_read/write getter functions
  regmap: Add raw_write/read checks for max_raw_write/read sizes
  regmap-i2c: Add smbus i2c block support

 drivers/base/regmap/internal.h   |   4 ++
 drivers/base/regmap/regmap-i2c.c |  49 +++++++++++++++++
 drivers/base/regmap/regmap.c     | 113 +++++++++++++++++++++++++++++++++------
 include/linux/regmap.h           |   6 +++
 4 files changed, 157 insertions(+), 15 deletions(-)

-- 
2.4.6
