From: josh.wu@atmel.com (Josh Wu)
Date: Wed, 23 May 2012 15:47:51 +0800
Subject: [PATCH v8 0/3] Add PMECC support for at91 nand flash driver
Message-ID: <1337759274-9921-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Code is based on 3.4-rc2

Changes since v7,
	add time out for PMECC status reading.
	modify the oobfree[0].offset to 2.
	fix coding style.

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
