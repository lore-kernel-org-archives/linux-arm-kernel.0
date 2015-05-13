From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 13 May 2015 11:17:35 +0300
Subject: [PATCH v3 0/4] mtd: mxc_nand: fix 8 bit ECC and large oob
Message-ID: <cover.1431504091.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series fixes mxc_nand bugs that I encountered while trying to use 8
bit ECC mode on i.MX25 with the Micron MT29F8G08ABABA flash chip.

Many thanks to Uwe Kleine-K?nig for guiding me through the process of
debugging and fixing, for contributing a clean-up patch to this series, and
for reviewing the rest.

This series applies on v4.1-rc1.

This is version 3 of the patch series, adding Reviewed-by and Acked-by tags
from Sascha Hauer and Uwe Kleine-K?nig. Patch 4/4 renamed a function as
suggested by Uwe Kleine-K?nig.

Version 2 of the patch series
(http://thread.gmane.org/gmane.linux.drivers.mtd/58687), addressed the
comments and suggestion of Uwe Kleine-K?nig on the first series
(http://thread.gmane.org/gmane.linux.ports.arm.kernel/408635). See each patch
for detailed per-patch changelog.

Baruch Siach (3):
  mtd: mxc_nand: limit the size of used oob
  mtd: mxc_nand: fix truncate of unaligned oob copying
  mtd: mxc_nand: generate nand_ecclayout for 8 bit ECC

Uwe Kleine-K?nig (1):
  mtd: nand: mxc_nand: cleanup copy_spare function

 drivers/mtd/nand/mxc_nand.c | 110 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 94 insertions(+), 16 deletions(-)

-- 
2.1.4
