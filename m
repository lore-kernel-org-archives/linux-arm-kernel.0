From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 21 Aug 2015 10:26:39 +0200
Subject: [PATCH v3 0/4] regmap: fixes
Message-ID: <1440145603-9612-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I changed the comments you mentioned in your review. I hope they are better
to understand now.

Best Regards,

Markus


Changes in v3:
- Change comments in patch 1 'regmap: Add missing comments about struct regmap_bus'
- Change description in patch 2 'regmap: Fix regmap_bulk_write for bus writes'

Changes in v2:
- Fixed free_context typo
- use_single_rw is now internally split into use_single_read/write
- Removed patches that wrongly tried to fix things
- Added simpler patches which check for the existence of bus->read/write to
  avoid null dereferences


Markus Pargmann (4):
  regmap: Add missing comments about struct regmap_bus
  regmap: Fix regmap_bulk_write for bus writes
  regmap: Split use_single_rw internally into use_single_read/write
  regmap: No multi_write support if bus->write does not exist

 drivers/base/regmap/internal.h   |  6 ++++--
 drivers/base/regmap/regcache.c   |  2 +-
 drivers/base/regmap/regmap-irq.c |  4 ++--
 drivers/base/regmap/regmap.c     | 30 ++++++++++++++++++++++++------
 include/linux/regmap.h           |  5 ++++-
 5 files changed, 35 insertions(+), 12 deletions(-)

-- 
2.4.6
