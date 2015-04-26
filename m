From: baruch@tkos.co.il (Baruch Siach)
Date: Sun, 26 Apr 2015 11:16:47 +0300
Subject: [PATCH 0/4] mtd: mxc_nand: fix 8 bit ECC and large oob
Message-ID: <cover.1430034929.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series fixes mxc_nand bugs that I encountered while trying to use 8
bit ECC mode on i.MX25 with the Micron MT29F8G08ABABA flash chip.

Many thanks to Uwe Kleine-K?nig for guiding me through the process of
debugging and fixing, and for contributing a clean-up patch to this series.

This series applies and tested on current Linus tree as of d19d133e432248.

Baruch Siach (3):
  mtd: mxc_nand: limit the size of used oob
  mtd: mxc_nand: fix truncate of unaligned oob copying
  mtd: mxc_nand: generate nand_ecclayout for 8 bit ECC

Uwe Kleine-K?nig (1):
  mtd: nand: mxc_nand: cleanup copy_spare function

 drivers/mtd/nand/mxc_nand.c | 74 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 58 insertions(+), 16 deletions(-)

-- 
2.1.4
