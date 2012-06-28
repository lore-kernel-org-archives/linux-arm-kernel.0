From: josh.wu@atmel.com (Josh Wu)
Date: Thu, 28 Jun 2012 16:21:35 +0800
Subject: [PATCH v12 0/2] MTD: at91: Add PMECC support for at91 nand flash
 driver
Message-ID: <1340871698-477-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Those patches is based on the l2-mtd.git three.

Since there are two patches of v11 already pushed, so this version v12 only includes the left two patches.
which includes the modification according to Richard Genoud's review suggestion.

Changes since v11,
	add documentation for atmel nand reg parameter and one example for PMECC support.
	fix the bug: no error reported when fail to get resoures of PMECC ERRLOC or ROM.
	fix the bug: no correction when ecc data has bit flipped.
	add clearer debug information for data correction.

Josh Wu (2):
  MTD: at91: add dt parameters for Atmel PMECC
  MTD: at91: atmel_nand: Update driver to support Programmable Multibit
    ECC controller

 .../devicetree/bindings/mtd/atmel-nand.txt         |   40 +-
 drivers/mtd/nand/atmel_nand.c                      |  801 +++++++++++++++++++-
 drivers/mtd/nand/atmel_nand_ecc.h                  |  114 ++-
 3 files changed, 951 insertions(+), 4 deletions(-)

-- 
1.7.9.5
