From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Thu,  5 Jul 2018 12:27:25 +0200
Subject: [PATCH 0/8] mtd: rawnand: Bunch of cleanup
Message-ID: <20180705102733.29673-1-boris.brezillon@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

These are just random cleanups that I did while working on the raw NAND
API sanitization (see here [1] for a preview of the upcoming changes).

Regards,

Boris

[1]https://github.com/bbrezillon/linux-0day/commits/nand/api-cleanup

Boris Brezillon (8):
  mtd: rawnand: Kill cafe_nand_bug()
  mtd: rawnand: Remove nand_do_read() prototype from rawnand.h
  mtd: rawnand: Remove forward declaration of mtd_info
  mtd: rawnand: Remove forward declaration of device_node
  mtd: rawnand: Rename nand_default_bbt() into nand_create_bbt()
  mtd: rawnand: Kill the chip->scan_bbt() hook
  mtd: rawnand: orion_nand: Kill orion_nand_data.dev_ready()
  mtd: rawnand: plat_nand: Kill pdata->ctrl.{hwcontrol,read_byte}()

 arch/arm/mach-pxa/balloon3.c                 |  1 -
 arch/arm/mach-pxa/em-x270.c                  |  1 -
 drivers/mtd/nand/raw/cafe_nand.c             |  8 --------
 drivers/mtd/nand/raw/diskonchip.c            |  4 ++--
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c   |  2 +-
 drivers/mtd/nand/raw/nand_base.c             |  4 +---
 drivers/mtd/nand/raw/nand_bbt.c              | 10 +++++-----
 drivers/mtd/nand/raw/nandsim.c               |  2 +-
 drivers/mtd/nand/raw/orion_nand.c            |  3 ---
 drivers/mtd/nand/raw/plat_nand.c             |  2 --
 include/linux/mtd/rawnand.h                  | 12 ++----------
 include/linux/platform_data/mtd-orion_nand.h |  1 -
 12 files changed, 12 insertions(+), 38 deletions(-)

-- 
2.14.1
