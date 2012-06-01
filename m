From: josh.wu@atmel.com (Josh Wu)
Date: Fri,  1 Jun 2012 18:13:11 +0800
Subject: [PATCH v10 0/3] MTD: at91: Add PMECC support for at91 nand flash
 driver
Message-ID: <1338545594-18483-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Code is based on 3.4-rc2

Changes since v9,
	use jiffies for timeout test to read PMECC status register.
	modified according to J.C and Artem's comments.
	add rom lookup table offset as DT variables.
	refine coding style and error handling.

Changes since v8,
	use _relaxed read/write in most place. use writel in operations of Control Register since it needs memory barrier.
	allocate the data for PMECC computation.
	add pmecc prefix for related variable/functions.
	modify code according to J.C's suggestion. except:

Josh Wu (3):
  moves hw ecc initialization code to one function.
  add DT support for PMECC parameters.
  update driver to support Programmable Multibit ECC controller.

 .../devicetree/bindings/mtd/atmel-nand.txt         |    9 +
 drivers/mtd/nand/atmel_nand.c                      |  914 ++++++++++++++++++--
 drivers/mtd/nand/atmel_nand_ecc.h                  |  114 ++-
 3 files changed, 974 insertions(+), 63 deletions(-)

-- 
1.7.10
