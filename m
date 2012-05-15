From: josh.wu@atmel.com (Josh Wu)
Date: Tue, 15 May 2012 22:47:33 +0800
Subject: [PATCH v7 0/3] Add PMECC support for at91 nand flash driver
Message-ID: <1337093256-19117-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v6,
	split into 3 patches.
	remove of_flat_dt_is_compatible() function. use additional dt parameter "has-pmecc".
	refine the error handling code.
	refine original atmel_nand_init_params() function.

Changes since v5,
	add has_pmecc field to replace cpu_has_pmecc() function. Use compatible check in when proble.
	simplify the pmecc_get_ecc_bytes() function.

Changes since v4,
	fix typo and checkpatch warnings.
	fix according to JC's suggestion. replace cpu_is_xxx() with DT
	modify dt binding atmel nand document to add pmecc support.
	tested in sam9263 without break hw ecc.
	add ecc.strength.

Josh Wu (3):
  MTD: at91: extract hw ecc initialization to one function
  MTD: add dt parameters for PMECC
  MTD: atmel_nand: Update driver to support Programmable Multibit ECC controller

 .../devicetree/bindings/mtd/atmel-nand.txt         |    7 +
 drivers/mtd/nand/atmel_nand.c                      |  885 ++++++++++++++++++--
 drivers/mtd/nand/atmel_nand_ecc.h                  |  123 ++-
 3 files changed, 946 insertions(+), 69 deletions(-)

-- 
1.7.10
