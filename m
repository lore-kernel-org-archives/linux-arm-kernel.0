From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 20 Aug 2015 11:12:31 +0200
Subject: [PATCH v2 0/5] regmap: fixes
Message-ID: <1440061956-29064-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These are some regmap fixes from the previous series
"Regmap max_raw_io and bmc150 SPI support". They are now splitted from the
other patches.

Changes in v2:
- Fixed free_context typo
- use_single_rw is now internally split into use_single_read/write
- Removed patches that wrongly tried to fix things
- Added simpler patches which check for the existence of bus->read/write to
  avoid null dereferences

Best Regards,

Markus


Markus Pargmann (5):
  regmap: Add missing comments about struct regmap_bus
  regmap: Fix regmap_bulk_write for bus writes
  regmap: Split use_single_rw internally into use_single_read/write
  regmap: regmap_raw_read return error on !bus->read
  regmap: No multi_write support if bus->write does not exist

 drivers/base/regmap/internal.h   |  6 ++++--
 drivers/base/regmap/regcache.c   |  2 +-
 drivers/base/regmap/regmap-irq.c |  4 ++--
 drivers/base/regmap/regmap.c     | 31 ++++++++++++++++++++++++++-----
 include/linux/regmap.h           |  4 +++-
 5 files changed, 36 insertions(+), 11 deletions(-)

-- 
2.4.6
