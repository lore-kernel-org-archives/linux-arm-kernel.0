From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 30 Sep 2015 23:45:22 +0200
Subject: [PATCH v2 0/7] mtd: nand: sunxi: cleanup and improvements
Message-ID: <1443649529-9852-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series aims at cleaning up the sunxi_nand driver by factorizing
the duplicated code found in hw_ecc and hw_syndrome_ecc implementations.

It also adds support for OOB bytes protection (only on a limited amount of
OOB bytes), and add code to correctly handle the 'bitflips in erased pages'
case.

Best Regards,

Boris

Changes since v1:
- drop the first patch (already applied)
- split the second patch to ease the review
- add the 'fix bitflips in erased pages' patch

Boris Brezillon (7):
  mtd: nand: sunxi: create sunxi_nfc_hw_ecc_enable()/disable() functions
  mtd: nand: sunxi: introduce sunxi_nfc_hw_ecc_read/write_chunk()
  mtd: nand: sunxi: make use of sunxi_nfc_hw_ecc_read/write_chunk()
  mtd: nand: sunxi: factorize extra OOB bytes handling
  mtd: nand: sunxi: retrieve corrected OOB bytes
  mtd: nand: sunxi: replace the NFC_BUF_TO_USER_DATA() macro by an
    inline function
  mtd: nand: sunxi: fix bitflips in erased pages

 drivers/mtd/nand/sunxi_nand.c | 416 ++++++++++++++++++++++--------------------
 1 file changed, 220 insertions(+), 196 deletions(-)

-- 
2.1.4
