From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 31 May 2011 16:31:23 -0700
Subject: [PATCH 4/8] mtd: nand: rename NAND_USE_FLASH_BBT
In-Reply-To: <1306884687-1824-1-git-send-email-computersforpeace@gmail.com>
References: <1306884687-1824-1-git-send-email-computersforpeace@gmail.com>
Message-ID: <1306884687-1824-5-git-send-email-computersforpeace@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Recall the recently added prefix requirements:
 * "NAND_" for flags in nand.h, used in nand_chip.options
 * "NAND_BBT_" for flags in bbm.h, used in nand_chip.bbt_options
        or in nand_bbt_descr.options

Thus, I am changing NAND_USE_FLASH_BBT to NAND_BBT_USE_FLASH.

Again, this flag is found in bbm.h and so should NOT be used in the
"nand_chip.options" field.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 Documentation/DocBook/mtdnand.tmpl             |    2 +-
 arch/arm/mach-davinci/board-da830-evm.c        |    2 +-
 arch/arm/mach-davinci/board-da850-evm.c        |    2 +-
 arch/arm/mach-davinci/board-dm355-evm.c        |    2 +-
 arch/arm/mach-davinci/board-dm355-leopard.c    |    2 +-
 arch/arm/mach-davinci/board-dm365-evm.c        |    2 +-
 arch/arm/mach-davinci/board-dm644x-evm.c       |    2 +-
 arch/arm/mach-davinci/board-mityomapl138.c     |    2 +-
 arch/arm/mach-davinci/board-neuros-osd2.c      |    2 +-
 arch/arm/mach-davinci/board-tnetv107x-evm.c    |    2 +-
 arch/arm/mach-davinci/include/mach/nand.h      |    2 +-
 arch/arm/mach-orion5x/ts78xx-setup.c           |    2 +-
 arch/cris/arch-v32/drivers/mach-a3/nandflash.c |    2 +-
 arch/cris/arch-v32/drivers/mach-fs/nandflash.c |    2 +-
 drivers/mtd/nand/atmel_nand.c                  |    2 +-
 drivers/mtd/nand/autcpu12.c                    |    4 ++--
 drivers/mtd/nand/bcm_umi_nand.c                |    2 +-
 drivers/mtd/nand/cafe_nand.c                   |    2 +-
 drivers/mtd/nand/cs553x_nand.c                 |    2 +-
 drivers/mtd/nand/davinci_nand.c                |    2 +-
 drivers/mtd/nand/denali.c                      |    2 +-
 drivers/mtd/nand/diskonchip.c                  |    2 +-
 drivers/mtd/nand/fsl_elbc_nand.c               |    2 +-
 drivers/mtd/nand/mpc5121_nfc.c                 |    2 +-
 drivers/mtd/nand/mxc_nand.c                    |    2 +-
 drivers/mtd/nand/nand_base.c                   |    2 +-
 drivers/mtd/nand/nand_bbt.c                    |   12 ++++++------
 drivers/mtd/nand/nandsim.c                     |    2 +-
 drivers/mtd/nand/pasemi_nand.c                 |    2 +-
 drivers/mtd/nand/s3c2410.c                     |    2 +-
 include/linux/mtd/bbm.h                        |    2 +-
 31 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/Documentation/DocBook/mtdnand.tmpl b/Documentation/DocBook/mtdnand.tmpl
index 05cc83e..8c07540 100644
--- a/Documentation/DocBook/mtdnand.tmpl
+++ b/Documentation/DocBook/mtdnand.tmpl
@@ -572,7 +572,7 @@ static void board_select_chip (struct mtd_info *mtd, int chip)
 			</para>
 			<para>
 				The simplest way to activate the FLASH based bad block table support 
-				is to set the option NAND_USE_FLASH_BBT in the bbt_option field of
+				is to set the option NAND_BBT_USE_FLASH in the bbt_option field of
 				the nand chip structure before calling nand_scan(). For AG-AND
 				chips is this done by default.
 				This activates the default FLASH based bad block table functionality 
diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index 788adc8..80368a1 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -377,7 +377,7 @@ static struct davinci_nand_pdata da830_evm_nand_pdata = {
 	.nr_parts	= ARRAY_SIZE(da830_evm_nand_partitions),
 	.ecc_mode	= NAND_ECC_HW,
 	.ecc_bits	= 4,
-	.bbt_options	= NAND_USE_FLASH_BBT,
+	.bbt_options	= NAND_BBT_USE_FLASH,
 	.bbt_td		= &da830_evm_nand_bbt_main_descr,
 	.bbt_md		= &da830_evm_nand_bbt_mirror_descr,
 	.timing         = &da830_evm_nandflash_timing,
diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 8bfad01..8bfde41 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -225,7 +225,7 @@ static struct davinci_nand_pdata da850_evm_nandflash_data = {
 	.nr_parts	= ARRAY_SIZE(da850_evm_nandflash_partition),
 	.ecc_mode	= NAND_ECC_HW,
 	.ecc_bits	= 4,
-	.bbt_options	= NAND_USE_FLASH_BBT,
+	.bbt_options	= NAND_BBT_USE_FLASH,
 	.timing		= &da850_evm_nandflash_timing,
 };
 
diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
index d857b70..530d44a 100644
--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -77,7 +77,7 @@ static struct davinci_nand_pdata davinci_nand_data = {
 	.parts			= davinci_nand_partitions,
 	.nr_parts		= ARRAY_SIZE(davinci_nand_partitions),
 	.ecc_mode		= NAND_ECC_HW,
-	.bbt_options		= NAND_USE_FLASH_BBT,
+	.bbt_options		= NAND_BBT_USE_FLASH,
 	.ecc_bits		= 4,
 };
 
diff --git a/arch/arm/mach-davinci/board-dm355-leopard.c b/arch/arm/mach-davinci/board-dm355-leopard.c
index b24dfd0..971c4e0 100644
--- a/arch/arm/mach-davinci/board-dm355-leopard.c
+++ b/arch/arm/mach-davinci/board-dm355-leopard.c
@@ -74,7 +74,7 @@ static struct davinci_nand_pdata davinci_nand_data = {
 	.parts			= davinci_nand_partitions,
 	.nr_parts		= ARRAY_SIZE(davinci_nand_partitions),
 	.ecc_mode		= NAND_ECC_HW_SYNDROME,
-	.bbt_options		= NAND_USE_FLASH_BBT,
+	.bbt_options		= NAND_BBT_USE_FLASH,
 };
 
 static struct resource davinci_nand_resources[] = {
diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index 9a74857..1e4be46 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -139,7 +139,7 @@ static struct davinci_nand_pdata davinci_nand_data = {
 	.parts			= davinci_nand_partitions,
 	.nr_parts		= ARRAY_SIZE(davinci_nand_partitions),
 	.ecc_mode		= NAND_ECC_HW,
-	.bbt_options		= NAND_USE_FLASH_BBT,
+	.bbt_options		= NAND_BBT_USE_FLASH,
 	.ecc_bits		= 4,
 };
 
diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index 012750f..e70cb0d 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -150,7 +150,7 @@ static struct davinci_nand_pdata davinci_evm_nandflash_data = {
 	.parts		= davinci_evm_nandflash_partition,
 	.nr_parts	= ARRAY_SIZE(davinci_evm_nandflash_partition),
 	.ecc_mode	= NAND_ECC_HW,
-	.bbt_options	= NAND_USE_FLASH_BBT,
+	.bbt_options	= NAND_BBT_USE_FLASH,
 	.timing		= &davinci_evm_nandflash_timing,
 };
 
diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index ba52254..7b57373 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -395,7 +395,7 @@ static struct davinci_nand_pdata mityomapl138_nandflash_data = {
 	.parts		= mityomapl138_nandflash_partition,
 	.nr_parts	= ARRAY_SIZE(mityomapl138_nandflash_partition),
 	.ecc_mode	= NAND_ECC_HW,
-	.bbt_options	= NAND_USE_FLASH_BBT,
+	.bbt_options	= NAND_BBT_USE_FLASH,
 	.options	= NAND_BUSWIDTH_16,
 	.ecc_bits	= 1, /* 4 bit mode is not supported with 16 bit NAND */
 };
diff --git a/arch/arm/mach-davinci/board-neuros-osd2.c b/arch/arm/mach-davinci/board-neuros-osd2.c
index 89bf0b5..5eb8ef3 100644
--- a/arch/arm/mach-davinci/board-neuros-osd2.c
+++ b/arch/arm/mach-davinci/board-neuros-osd2.c
@@ -87,7 +87,7 @@ static struct davinci_nand_pdata davinci_ntosd2_nandflash_data = {
 	.parts		= davinci_ntosd2_nandflash_partition,
 	.nr_parts	= ARRAY_SIZE(davinci_ntosd2_nandflash_partition),
 	.ecc_mode	= NAND_ECC_HW,
-	.bbt_options	= NAND_USE_FLASH_BBT,
+	.bbt_options	= NAND_BBT_USE_FLASH,
 };
 
 static struct resource davinci_ntosd2_nandflash_resource[] = {
diff --git a/arch/arm/mach-davinci/board-tnetv107x-evm.c b/arch/arm/mach-davinci/board-tnetv107x-evm.c
index f98896c..c5feb9b 100644
--- a/arch/arm/mach-davinci/board-tnetv107x-evm.c
+++ b/arch/arm/mach-davinci/board-tnetv107x-evm.c
@@ -144,7 +144,7 @@ static struct davinci_nand_pdata nand_config = {
 	.parts		= nand_partitions,
 	.nr_parts	= ARRAY_SIZE(nand_partitions),
 	.ecc_mode	= NAND_ECC_HW,
-	.bbt_options	= NAND_USE_FLASH_BBT,
+	.bbt_options	= NAND_BBT_USE_FLASH,
 	.ecc_bits	= 1,
 };
 
diff --git a/arch/arm/mach-davinci/include/mach/nand.h b/arch/arm/mach-davinci/include/mach/nand.h
index 2c506f9..1cf555a 100644
--- a/arch/arm/mach-davinci/include/mach/nand.h
+++ b/arch/arm/mach-davinci/include/mach/nand.h
@@ -76,7 +76,7 @@ struct davinci_nand_pdata {		/* platform_data */
 
 	/* e.g. NAND_BUSWIDTH_16 */
 	unsigned		options;
-	/* e.g. NAND_USE_FLASH_BBT */
+	/* e.g. NAND_BBT_USE_FLASH */
 	unsigned		bbt_options;
 
 	/* Main and mirror bbt descriptor overrides */
diff --git a/arch/arm/mach-orion5x/ts78xx-setup.c b/arch/arm/mach-orion5x/ts78xx-setup.c
index e5ca57c..8ae5301 100644
--- a/arch/arm/mach-orion5x/ts78xx-setup.c
+++ b/arch/arm/mach-orion5x/ts78xx-setup.c
@@ -275,7 +275,7 @@ static struct platform_nand_data ts78xx_ts_nand_data = {
 		.partitions		= ts78xx_ts_nand_parts,
 		.nr_partitions		= ARRAY_SIZE(ts78xx_ts_nand_parts),
 		.chip_delay		= 15,
-		.bbt_options		= NAND_USE_FLASH_BBT,
+		.bbt_options		= NAND_BBT_USE_FLASH,
 	},
 	.ctrl	= {
 		/*
diff --git a/arch/cris/arch-v32/drivers/mach-a3/nandflash.c b/arch/cris/arch-v32/drivers/mach-a3/nandflash.c
index fdd11c1..7fb5212 100644
--- a/arch/cris/arch-v32/drivers/mach-a3/nandflash.c
+++ b/arch/cris/arch-v32/drivers/mach-a3/nandflash.c
@@ -163,7 +163,7 @@ struct mtd_info *__init crisv32_nand_flash_probe(void)
 	this->ecc.mode = NAND_ECC_SOFT;
 
 	/* Enable the following for a flash based bad block table */
-	/* this->bbt_options = NAND_USE_FLASH_BBT; */
+	/* this->bbt_options = NAND_BBT_USE_FLASH; */
 
 	/* Scan to find existence of the device */
 	if (nand_scan(crisv32_mtd, 1)) {
diff --git a/arch/cris/arch-v32/drivers/mach-fs/nandflash.c b/arch/cris/arch-v32/drivers/mach-fs/nandflash.c
index 3368177..e032384 100644
--- a/arch/cris/arch-v32/drivers/mach-fs/nandflash.c
+++ b/arch/cris/arch-v32/drivers/mach-fs/nandflash.c
@@ -154,7 +154,7 @@ struct mtd_info *__init crisv32_nand_flash_probe(void)
 	this->ecc.mode = NAND_ECC_SOFT;
 
 	/* Enable the following for a flash based bad block table */
-	/* this->bbt_options = NAND_USE_FLASH_BBT; */
+	/* this->bbt_options = NAND_BBT_USE_FLASH; */
 
 	/* Scan to find existence of the device */
 	if (nand_scan(crisv32_mtd, 1)) {
diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index 4afdc83..dc9b8d6 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -582,7 +582,7 @@ static int __init atmel_nand_probe(struct platform_device *pdev)
 
 	if (on_flash_bbt) {
 		printk(KERN_INFO "atmel_nand: Use On Flash BBT\n");
-		nand_chip->bbt_options |= NAND_USE_FLASH_BBT;
+		nand_chip->bbt_options |= NAND_BBT_USE_FLASH;
 	}
 
 	if (!cpu_has_dma())
diff --git a/drivers/mtd/nand/autcpu12.c b/drivers/mtd/nand/autcpu12.c
index adf934d..2e42ec2 100644
--- a/drivers/mtd/nand/autcpu12.c
+++ b/drivers/mtd/nand/autcpu12.c
@@ -172,9 +172,9 @@ static int __init autcpu12_init(void)
 
 	/* Enable the following for a flash based bad block table */
 	/*
-	   this->bbt_options = NAND_USE_FLASH_BBT;
+	   this->bbt_options = NAND_BBT_USE_FLASH;
 	 */
-	this->bbt_options = NAND_USE_FLASH_BBT;
+	this->bbt_options = NAND_BBT_USE_FLASH;
 
 	/* Scan to find existence of the device */
 	if (nand_scan(autcpu12_mtd, 1)) {
diff --git a/drivers/mtd/nand/bcm_umi_nand.c b/drivers/mtd/nand/bcm_umi_nand.c
index 8ae9ad9..7ac8607 100644
--- a/drivers/mtd/nand/bcm_umi_nand.c
+++ b/drivers/mtd/nand/bcm_umi_nand.c
@@ -474,7 +474,7 @@ static int __devinit bcm_umi_nand_probe(struct platform_device *pdev)
 
 #if NAND_ECC_BCH
 	if (board_mtd->writesize > 512) {
-		if (this->bbt_options & NAND_USE_FLASH_BBT)
+		if (this->bbt_options & NAND_BBT_USE_FLASH)
 			largepage_bbt.options = NAND_BBT_SCAN2NDPAGE;
 		this->badblock_pattern = &largepage_bbt;
 	}
diff --git a/drivers/mtd/nand/cafe_nand.c b/drivers/mtd/nand/cafe_nand.c
index 7dd7d84..d0eed49 100644
--- a/drivers/mtd/nand/cafe_nand.c
+++ b/drivers/mtd/nand/cafe_nand.c
@@ -686,7 +686,7 @@ static int __devinit cafe_nand_probe(struct pci_dev *pdev,
 	cafe->nand.chip_delay = 0;
 
 	/* Enable the following for a flash based bad block table */
-	cafe->nand.bbt_options = NAND_USE_FLASH_BBT;
+	cafe->nand.bbt_options = NAND_BBT_USE_FLASH;
 	cafe->nand.options = NAND_NO_AUTOINCR | NAND_OWN_BUFFERS;
 
 	if (skipbbt) {
diff --git a/drivers/mtd/nand/cs553x_nand.c b/drivers/mtd/nand/cs553x_nand.c
index 05adedd..b354961 100644
--- a/drivers/mtd/nand/cs553x_nand.c
+++ b/drivers/mtd/nand/cs553x_nand.c
@@ -239,7 +239,7 @@ static int __init cs553x_init_one(int cs, int mmio, unsigned long adr)
 	this->ecc.correct  = nand_correct_data;
 
 	/* Enable the following for a flash based bad block table */
-	this->bbt_options = NAND_USE_FLASH_BBT;
+	this->bbt_options = NAND_BBT_USE_FLASH;
 	this->options = NAND_NO_AUTOINCR;
 
 	/* Scan to find existence of the device */
diff --git a/drivers/mtd/nand/davinci_nand.c b/drivers/mtd/nand/davinci_nand.c
index 69f7019..a4c82b4 100644
--- a/drivers/mtd/nand/davinci_nand.c
+++ b/drivers/mtd/nand/davinci_nand.c
@@ -581,7 +581,7 @@ static int __init nand_davinci_probe(struct platform_device *pdev)
 	info->chip.chip_delay	= 0;
 	info->chip.select_chip	= nand_davinci_select_chip;
 
-	/* options such as NAND_USE_FLASH_BBT */
+	/* options such as NAND_BBT_USE_FLASH */
 	info->chip.bbt_options	= pdata->bbt_options;
 	/* options such as 16-bit widths */
 	info->chip.options	= pdata->options;
diff --git a/drivers/mtd/nand/denali.c b/drivers/mtd/nand/denali.c
index dbb6fba..ee30145 100644
--- a/drivers/mtd/nand/denali.c
+++ b/drivers/mtd/nand/denali.c
@@ -1577,7 +1577,7 @@ static int denali_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	denali->nand.bbt_md = &bbt_mirror_descr;
 
 	/* skip the scan for now until we have OOB read and write support */
-	denali->nand.bbt_options |= NAND_USE_FLASH_BBT;
+	denali->nand.bbt_options |= NAND_BBT_USE_FLASH;
 	denali->nand.options |= NAND_SKIP_BBTSCAN;
 	denali->nand.ecc.mode = NAND_ECC_HW_SYNDROME;
 
diff --git a/drivers/mtd/nand/diskonchip.c b/drivers/mtd/nand/diskonchip.c
index f70bc73..b657d7f 100644
--- a/drivers/mtd/nand/diskonchip.c
+++ b/drivers/mtd/nand/diskonchip.c
@@ -1652,7 +1652,7 @@ static int __init doc_probe(unsigned long physadr)
 	nand->ecc.mode		= NAND_ECC_HW_SYNDROME;
 	nand->ecc.size		= 512;
 	nand->ecc.bytes		= 6;
-	nand->bbt_options	= NAND_USE_FLASH_BBT;
+	nand->bbt_options	= NAND_BBT_USE_FLASH;
 
 	doc->physadr		= physadr;
 	doc->virtadr		= virtadr;
diff --git a/drivers/mtd/nand/fsl_elbc_nand.c b/drivers/mtd/nand/fsl_elbc_nand.c
index a06b59c..f3384fa 100644
--- a/drivers/mtd/nand/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/fsl_elbc_nand.c
@@ -792,7 +792,7 @@ static int fsl_elbc_chip_init(struct fsl_elbc_mtd *priv)
 
 	/* set up nand options */
 	chip->options = NAND_NO_READRDY | NAND_NO_AUTOINCR;
-	chip->bbt_options = NAND_USE_FLASH_BBT;
+	chip->bbt_options = NAND_BBT_USE_FLASH;
 
 	chip->controller = &elbc_fcm_ctrl->controller;
 	chip->priv = priv;
diff --git a/drivers/mtd/nand/mpc5121_nfc.c b/drivers/mtd/nand/mpc5121_nfc.c
index d611542..e0e0846 100644
--- a/drivers/mtd/nand/mpc5121_nfc.c
+++ b/drivers/mtd/nand/mpc5121_nfc.c
@@ -736,7 +736,7 @@ static int __devinit mpc5121_nfc_probe(struct platform_device *op)
 	chip->verify_buf = mpc5121_nfc_verify_buf;
 	chip->select_chip = mpc5121_nfc_select_chip;
 	chip->options = NAND_NO_AUTOINCR;
-	chip->bbt_options = NAND_USE_FLASH_BBT;
+	chip->bbt_options = NAND_BBT_USE_FLASH;
 	chip->ecc.mode = NAND_ECC_SOFT;
 
 	/* Support external chip-select logic on ADS5121 board */
diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index ed68fde..ca42c8f 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -1179,7 +1179,7 @@ static int __init mxcnd_probe(struct platform_device *pdev)
 		this->bbt_td = &bbt_main_descr;
 		this->bbt_md = &bbt_mirror_descr;
 		/* update flash based bbt */
-		this->bbt_options |= NAND_USE_FLASH_BBT;
+		this->bbt_options |= NAND_BBT_USE_FLASH;
 	}
 
 	init_completion(&host->op_completion);
diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index 221a76a..9343cbb 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -405,7 +405,7 @@ static int nand_default_block_markbad(struct mtd_info *mtd, loff_t ofs)
 		chip->bbt[block >> 2] |= 0x01 << ((block & 0x03) << 1);
 
 	/* Do we have a flash based bad block table ? */
-	if (chip->bbt_options & NAND_USE_FLASH_BBT)
+	if (chip->bbt_options & NAND_BBT_USE_FLASH)
 		ret = nand_update_bbt(mtd, ofs);
 	else {
 		nand_get_device(chip, mtd, FL_WRITING);
diff --git a/drivers/mtd/nand/nand_bbt.c b/drivers/mtd/nand/nand_bbt.c
index 66f93e2..dfea9fd 100644
--- a/drivers/mtd/nand/nand_bbt.c
+++ b/drivers/mtd/nand/nand_bbt.c
@@ -14,7 +14,7 @@
  *
  * When nand_scan_bbt is called, then it tries to find the bad block table
  * depending on the options in the BBT descriptor(s). If no flash based BBT
- * (NAND_USE_FLASH_BBT) is specified then the device is scanned for factory
+ * (NAND_BBT_USE_FLASH) is specified then the device is scanned for factory
  * marked good / bad blocks. This information is used to create a memory BBT.
  * Once a new bad block is discovered then the "factory" information is updated
  * on the device.
@@ -36,7 +36,7 @@
  * The table is marked in the OOB area with an ident pattern and a version
  * number which indicates which of both tables is more up to date. If the NAND
  * controller needs the complete OOB area for the ECC information then the
- * option NAND_BBT_NO_OOB should be used (along with NAND_USE_FLASH_BBT, of
+ * option NAND_BBT_NO_OOB should be used (along with NAND_BBT_USE_FLASH, of
  * course): it moves the ident pattern and the version byte into the data area
  * and the OOB area will remain untouched.
  *
@@ -1083,14 +1083,14 @@ static void verify_bbt_descr(struct mtd_info *mtd, struct nand_bbt_descr *bd)
 	bits = bd->options & NAND_BBT_NRBITS_MSK;
 
 	BUG_ON((this->bbt_options & NAND_BBT_NO_OOB) &&
-			!(this->bbt_options & NAND_USE_FLASH_BBT));
+			!(this->bbt_options & NAND_BBT_USE_FLASH));
 	BUG_ON(!bits);
 
 	if (bd->options & NAND_BBT_VERSION)
 		pattern_len++;
 
 	if (bd->options & NAND_BBT_NO_OOB) {
-		BUG_ON(!(this->bbt_options & NAND_USE_FLASH_BBT));
+		BUG_ON(!(this->bbt_options & NAND_BBT_USE_FLASH));
 		BUG_ON(!(this->bbt_options & NAND_BBT_NO_OOB));
 		BUG_ON(bd->offs);
 		if (bd->options & NAND_BBT_VERSION)
@@ -1357,12 +1357,12 @@ int nand_default_bbt(struct mtd_info *mtd)
 			this->bbt_td = &bbt_main_descr;
 			this->bbt_md = &bbt_mirror_descr;
 		}
-		this->bbt_options |= NAND_USE_FLASH_BBT;
+		this->bbt_options |= NAND_BBT_USE_FLASH;
 		return nand_scan_bbt(mtd, &agand_flashbased);
 	}
 
 	/* Is a flash based bad block table requested ? */
-	if (this->bbt_options & NAND_USE_FLASH_BBT) {
+	if (this->bbt_options & NAND_BBT_USE_FLASH) {
 		/* Use the default pattern descriptors */
 		if (!this->bbt_td) {
 			if (this->bbt_options & NAND_BBT_NO_OOB) {
diff --git a/drivers/mtd/nand/nandsim.c b/drivers/mtd/nand/nandsim.c
index 1856c42..34c03be 100644
--- a/drivers/mtd/nand/nandsim.c
+++ b/drivers/mtd/nand/nandsim.c
@@ -2275,7 +2275,7 @@ static int __init ns_init_module(void)
 	case 2:
 		 chip->bbt_options |= NAND_BBT_NO_OOB;
 	case 1:
-		 chip->bbt_options |= NAND_USE_FLASH_BBT;
+		 chip->bbt_options |= NAND_BBT_USE_FLASH;
 	case 0:
 		break;
 	default:
diff --git a/drivers/mtd/nand/pasemi_nand.c b/drivers/mtd/nand/pasemi_nand.c
index 1c17f09..a97264e 100644
--- a/drivers/mtd/nand/pasemi_nand.c
+++ b/drivers/mtd/nand/pasemi_nand.c
@@ -156,7 +156,7 @@ static int __devinit pasemi_nand_probe(struct platform_device *ofdev)
 
 	/* Enable the following for a flash based bad block table */
 	chip->options = NAND_NO_AUTOINCR;
-	chip->bbt_options = NAND_USE_FLASH_BBT;
+	chip->bbt_options = NAND_BBT_USE_FLASH;
 
 	/* Scan to find existence of the device */
 	if (nand_scan(pasemi_nand_mtd, 1)) {
diff --git a/drivers/mtd/nand/s3c2410.c b/drivers/mtd/nand/s3c2410.c
index 370516c..ec28079 100644
--- a/drivers/mtd/nand/s3c2410.c
+++ b/drivers/mtd/nand/s3c2410.c
@@ -881,7 +881,7 @@ static void s3c2410_nand_init_chip(struct s3c2410_nand_info *info,
 	 * let the kernel fish out the BBT from the NAND, and also skip the
 	 * full NAND scan that can take 1/2s or so. Little things... */
 	if (set->flash_bbt) {
-		chip->bbt_options |= NAND_USE_FLASH_BBT;
+		chip->bbt_options |= NAND_BBT_USE_FLASH;
 		chip->options |= NAND_SKIP_BBTSCAN;
 	}
 }
diff --git a/include/linux/mtd/bbm.h b/include/linux/mtd/bbm.h
index 7929514..ff18c08 100644
--- a/include/linux/mtd/bbm.h
+++ b/include/linux/mtd/bbm.h
@@ -104,7 +104,7 @@ struct nand_bbt_descr {
  * Use a flash based bad block table. By default, OOB identifier is saved in
  * OOB area. This option is passed to the default bad block table function.
  */
-#define NAND_USE_FLASH_BBT	0x00040000
+#define NAND_BBT_USE_FLASH	0x00040000
 /* Do not store flash based bad block table in OOB area; store it in-band */
 #define NAND_BBT_NO_OOB		0x00080000
 
-- 
1.7.0.4
