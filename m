From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 16 Aug 2013 15:37:27 +0530
Subject: [PATCH] ARM: davinci: nand: specify ecc strength
Message-ID: <1376647647-13681-1-git-send-email-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Starting with kernel v3.5, it is mandatory
to specify ECC strength when using hardware
ECC. Without this, kernel panics with a warning
of the sort:

Driver must set ecc.strength when using hardware ECC
------------[ cut here ]------------
kernel BUG at drivers/mtd/nand/nand_base.c:3519!

Fix this by specifying ECC strength for the boards
which were missing this.

Reported-by: Holger Freyther <holger@freyther.de>
Cc: <stable@vger.kernel.org> #v3.5+
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-davinci/board-dm355-leopard.c |    1 +
 arch/arm/mach-davinci/board-dm644x-evm.c    |    1 +
 arch/arm/mach-davinci/board-dm646x-evm.c    |    1 +
 arch/arm/mach-davinci/board-neuros-osd2.c   |    1 +
 4 files changed, 4 insertions(+)

diff --git a/arch/arm/mach-davinci/board-dm355-leopard.c b/arch/arm/mach-davinci/board-dm355-leopard.c
index dff4ddc..139e42d 100644
--- a/arch/arm/mach-davinci/board-dm355-leopard.c
+++ b/arch/arm/mach-davinci/board-dm355-leopard.c
@@ -75,6 +75,7 @@ static struct davinci_nand_pdata davinci_nand_data = {
 	.parts			= davinci_nand_partitions,
 	.nr_parts		= ARRAY_SIZE(davinci_nand_partitions),
 	.ecc_mode		= NAND_ECC_HW_SYNDROME,
+	.ecc_bits		= 4,
 	.bbt_options		= NAND_BBT_USE_FLASH,
 };
 
diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index a33686a..fa4bfaf 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -153,6 +153,7 @@ static struct davinci_nand_pdata davinci_evm_nandflash_data = {
 	.parts		= davinci_evm_nandflash_partition,
 	.nr_parts	= ARRAY_SIZE(davinci_evm_nandflash_partition),
 	.ecc_mode	= NAND_ECC_HW,
+	.ecc_bits	= 1,
 	.bbt_options	= NAND_BBT_USE_FLASH,
 	.timing		= &davinci_evm_nandflash_timing,
 };
diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index fbb8e5a..0c005e8 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -90,6 +90,7 @@ static struct davinci_nand_pdata davinci_nand_data = {
 	.parts			= davinci_nand_partitions,
 	.nr_parts		= ARRAY_SIZE(davinci_nand_partitions),
 	.ecc_mode		= NAND_ECC_HW,
+	.ecc_bits		= 1,
 	.options		= 0,
 };
 
diff --git a/arch/arm/mach-davinci/board-neuros-osd2.c b/arch/arm/mach-davinci/board-neuros-osd2.c
index 2bc112a..808233b 100644
--- a/arch/arm/mach-davinci/board-neuros-osd2.c
+++ b/arch/arm/mach-davinci/board-neuros-osd2.c
@@ -88,6 +88,7 @@ static struct davinci_nand_pdata davinci_ntosd2_nandflash_data = {
 	.parts		= davinci_ntosd2_nandflash_partition,
 	.nr_parts	= ARRAY_SIZE(davinci_ntosd2_nandflash_partition),
 	.ecc_mode	= NAND_ECC_HW,
+	.ecc_bits	= 1,
 	.bbt_options	= NAND_BBT_USE_FLASH,
 };
 
-- 
1.7.10.1
