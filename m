From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 12 Sep 2017 11:37:29 +0900
Subject: [PATCH 0/2] mtd: nand: introduce NAND_ROW_ADDR_3 flag and improve
 Denali driver
Message-ID: <1505183851-29355-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, Denali NAND driver always expects 3 row address cycle
devices because the driver init code hard-code the register setting.
I will fix it in 2/2.

Many drivers check chip->chipsize if the third row address cycle
is needed or not.  This is not nice because 32MB, 128MB are
magic numbers.  nand_scan_ident can decide it and provide a
driver-friendly flag.

1/2 is touching verious drivers.
I hope Acked-by from driver maintainers if this change looks good.



Masahiro Yamada (2):
  mtd: nand: introduce NAND_ROW_ADDR_3 flag
  mtd: nand: denali: support two row address cycle devices

 drivers/mtd/nand/atmel/nand-controller.c | 3 +--
 drivers/mtd/nand/au1550nd.c              | 3 +--
 drivers/mtd/nand/denali.c                | 4 ++--
 drivers/mtd/nand/diskonchip.c            | 3 +--
 drivers/mtd/nand/hisi504_nand.c          | 3 +--
 drivers/mtd/nand/mxc_nand.c              | 3 +--
 drivers/mtd/nand/nand_base.c             | 9 +++++----
 drivers/mtd/nand/nuc900_nand.c           | 2 +-
 include/linux/mtd/rawnand.h              | 3 +++
 9 files changed, 16 insertions(+), 17 deletions(-)

-- 
2.7.4
