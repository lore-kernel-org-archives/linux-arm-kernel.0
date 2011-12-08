From: hong.xu@atmel.com (Hong Xu)
Date: Thu,  8 Dec 2011 14:53:38 +0800
Subject: [PATCH 1/2] MTD: atmel_nand: Update Kconfig to support PMECC
Message-ID: <1323327219-17895-1-git-send-email-hong.xu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Hong Xu <hong.xu@atmel.com>
---
 drivers/mtd/nand/Kconfig |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index cce7b70..bc12d50 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -365,6 +365,23 @@ config MTD_NAND_ATMEL_ECC_HW
 
 	  If unsure, say Y
 
+config MTD_NAND_ATMEL_PMECC_HW
+	bool "Programmable Hardware ECC (BCH code)"
+	depends on ARCH_AT91SAM9X5 || ARCH_AT91SAM9N12
+	help
+	  Use Programmable Hardware ECC (PMECC) controller.
+
+	  The PMECC Controller is a programmable binary BCH (Bose, Chaudhuri
+	  and Hocquenghem) encoder/decoder. This controller can be used to
+	  generate redundancy information for both SLC and MLC NAND Flash
+	  devices.
+
+	  NB : hardware and software ECC schemes are incompatible.
+	  If you switch from one to another, you'll have to erase your
+	  mtd partition.
+
+	  If unsure, say Y
+
 config MTD_NAND_ATMEL_ECC_SOFT
 	bool "Software ECC"
 	help
-- 
1.7.3.3
