Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71428C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:28:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D93720880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="vBhmZeiE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D93720880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WMfYslk+9EN/iF6tHFmvig585hHe5b3//whAi/R0/QQ=; b=vBhmZeiEaT5CHN
	oaWHnzuAFYy1sS9yljvH2rzGhmExOKndO08ljz7wb+TnYufHryXU96RoOZn2LPaKS8YkUiycYbdIc
	QqK/vTEYXdyCt6xMGMfZIr1tpIK1CkuKfHxjVQXYEzF++t1fve3nJSPDWq3Xe7k57orYH+EfaXSns
	AAZmoN4m59H73qGhQgro/3tkQglpO7CgvXqvwIFGBO5iVRgP+kHT09EtUCbzm8WxpLJEy3ak5rWEY
	9DWrXKaCakAr/HWoMkav9JxH5FODqZd94b0wndLU9+2/BOGSdBFmTwOUCpSY1CQX/yNIjQUZtBW6b
	75ZnjrXPbHLu/iyFktRg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwkeA-0004MG-F7; Thu, 21 Feb 2019 09:28:02 +0000
Received: from relay2-d.mail.gandi.net ([217.70.183.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwkdz-00047s-Cy; Thu, 21 Feb 2019 09:27:53 +0000
X-Originating-IP: 90.88.23.190
Received: from localhost.localdomain
 (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr [90.88.23.190])
 (Authenticated sender: miquel.raynal@bootlin.com)
 by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 0B7834001C;
 Thu, 21 Feb 2019 09:27:43 +0000 (UTC)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Boris Brezillon <bbrezillon@kernel.org>,
 Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Marek Vasut <marek.vasut@gmail.com>,
 Tudor Ambarus <Tudor.Ambarus@microchip.com>
Subject: [PATCH 3/6] mtd: nand: Clarify Kconfig entry for software Hamming ECC
 entries
Date: Thu, 21 Feb 2019 10:27:30 +0100
Message-Id: <20190221092734.21634-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190221092734.21634-1-miquel.raynal@bootlin.com>
References: <20190221092734.21634-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_012751_744811_48893F81 
X-CRM114-Status: GOOD (  14.64  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Vignesh R <vigneshr@ti.com>, Tudor Ambarus <tudor.ambarus@microchip.com>,
 Julien Su <juliensu@mxic.com.tw>, linux-mtd@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Mason Yang <masonccyang@mxic.com.tw>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The software Hamming ECC correction implementation is referred as
MTD_NAND_ECC which is too generic. Rename it
MTD_NAND_ECC_SW_HAMMING. Also rename MTD_NAND_ECC_SMC which is an
SMC quirk in the Hamming implementation as
MTD_NAND_ECC_SW_HAMMING_SMC.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 arch/arm/configs/nhk8815_defconfig              |  2 +-
 arch/mips/configs/generic/board-ni169445.config |  2 +-
 arch/powerpc/configs/85xx/tqm8548_defconfig     |  2 +-
 drivers/mtd/Kconfig                             |  3 +--
 drivers/mtd/nand/raw/Kconfig                    | 12 +++++-------
 drivers/mtd/nand/raw/Makefile                   |  2 +-
 drivers/mtd/nand/raw/nand_base.c                |  2 +-
 drivers/mtd/sm_ftl.c                            | 12 ++++++------
 drivers/mtd/tests/mtd_nandecctest.c             | 14 +++++++-------
 9 files changed, 24 insertions(+), 27 deletions(-)

diff --git a/arch/arm/configs/nhk8815_defconfig b/arch/arm/configs/nhk8815_defconfig
index 0ac44acd5bc4..413c65b4c7e6 100644
--- a/arch/arm/configs/nhk8815_defconfig
+++ b/arch/arm/configs/nhk8815_defconfig
@@ -49,7 +49,7 @@ CONFIG_MTD=y
 CONFIG_MTD_TESTS=m
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
-CONFIG_MTD_NAND_ECC_SMC=y
+CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC=y
 CONFIG_MTD_NAND=y
 CONFIG_MTD_NAND_FSMC=y
 CONFIG_MTD_ONENAND=y
diff --git a/arch/mips/configs/generic/board-ni169445.config b/arch/mips/configs/generic/board-ni169445.config
index 01f6ab0d47d5..e68da2e9dc7c 100644
--- a/arch/mips/configs/generic/board-ni169445.config
+++ b/arch/mips/configs/generic/board-ni169445.config
@@ -15,7 +15,7 @@ CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CMDLINE_PARTS=y
 
-CONFIG_MTD_NAND_ECC=y
+CONFIG_MTD_NAND_ECC_SW_HAMMING=y
 CONFIG_MTD_NAND_ECC_SW_BCH=y
 CONFIG_MTD_NAND=y
 CONFIG_MTD_NAND_GPIO=y
diff --git a/arch/powerpc/configs/85xx/tqm8548_defconfig b/arch/powerpc/configs/85xx/tqm8548_defconfig
index 2697e4e8a761..464ce192bc14 100644
--- a/arch/powerpc/configs/85xx/tqm8548_defconfig
+++ b/arch/powerpc/configs/85xx/tqm8548_defconfig
@@ -35,7 +35,7 @@ CONFIG_MTD=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_PHYSMAP_OF=y
-CONFIG_MTD_NAND_ECC_SMC=y
+CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC=y
 CONFIG_MTD_NAND=y
 CONFIG_MTD_NAND_FSL_UPM=y
 CONFIG_BLK_DEV_LOOP=y
diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
index 79a8ff542883..aa5a27fdfdd1 100644
--- a/drivers/mtd/Kconfig
+++ b/drivers/mtd/Kconfig
@@ -230,12 +230,11 @@ config SSFDC
 	  This enables read only access to SmartMedia formatted NAND
 	  flash. You can mount it with FAT file system.
 
-
 config SM_FTL
 	tristate "SmartMedia/xD new translation layer"
 	depends on BLOCK
 	select MTD_BLKDEVS
-	select MTD_NAND_ECC
+	select MTD_NAND_ECC_SW_HAMMING
 	help
 	  This enables EXPERIMENTAL R/W support for SmartMedia/xD
 	  FTL (Flash translation layer).
diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 849748278aed..738b04f71c59 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -1,20 +1,18 @@
-config MTD_NAND_ECC
+config MTD_NAND_ECC_SW_HAMMING
 	tristate
 
-config MTD_NAND_ECC_SMC
+config MTD_NAND_ECC_SW_HAMMING_SMC
 	bool "NAND ECC Smart Media byte order"
-	depends on MTD_NAND_ECC
+	depends on MTD_NAND_ECC_SW_HAMMING
 	default n
 	help
 	  Software ECC according to the Smart Media Specification.
 	  The original Linux implementation had byte 0 and 1 swapped.
 
-
 menuconfig MTD_NAND
 	tristate "Raw/Parallel NAND Device Support"
 	depends on MTD
-	select MTD_NAND_ECC
-	select MTD_NAND_CORE
+	select MTD_NAND_ECC_SW_HAMMING
 	help
 	  This enables support for accessing all type of raw/parallel
 	  NAND flash devices. For further information see
@@ -132,7 +130,7 @@ config MTD_NAND_S3C2410_DEBUG
 config MTD_NAND_NDFC
 	tristate "NDFC NanD Flash Controller"
 	depends on 4xx
-	select MTD_NAND_ECC_SMC
+	select MTD_NAND_ECC_SW_HAMMING_SMC
 	help
 	  NDFC Nand Flash Controllers are integrated in IBM/AMCC's 4xx SoCs
 
diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
index 7f4ae08f4c18..60ec994808c5 100644
--- a/drivers/mtd/nand/raw/Makefile
+++ b/drivers/mtd/nand/raw/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_MTD_NAND)			+= nand.o
-obj-$(CONFIG_MTD_NAND_ECC)		+= nand_ecc.o
+obj-$(CONFIG_MTD_NAND_ECC_SW_HAMMING)	+= nand_ecc.o
 obj-$(CONFIG_MTD_NAND_ECC_SW_BCH)	+= nand_bch.o
 obj-$(CONFIG_MTD_SM_COMMON) 		+= sm_common.o
 
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index eb42a8941a46..13efa206c7e6 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -5120,7 +5120,7 @@ static int nand_set_ecc_soft_ops(struct nand_chip *chip)
 		ecc->bytes = 3;
 		ecc->strength = 1;
 
-		if (IS_ENABLED(CONFIG_MTD_NAND_ECC_SMC))
+		if (IS_ENABLED(CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC))
 			ecc->options |= NAND_ECC_SOFT_HAMMING_SM_ORDER;
 
 		return 0;
diff --git a/drivers/mtd/sm_ftl.c b/drivers/mtd/sm_ftl.c
index 89227b1d036a..e0955a98a0f4 100644
--- a/drivers/mtd/sm_ftl.c
+++ b/drivers/mtd/sm_ftl.c
@@ -222,17 +222,17 @@ static int sm_correct_sector(uint8_t *buffer, struct sm_oob *oob)
 	uint8_t ecc[3];
 
 	__nand_calculate_ecc(buffer, SM_SMALL_PAGE, ecc,
-			     IS_ENABLED(CONFIG_MTD_NAND_ECC_SMC));
+			     IS_ENABLED(CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC));
 	if (__nand_correct_data(buffer, ecc, oob->ecc1, SM_SMALL_PAGE,
-				IS_ENABLED(CONFIG_MTD_NAND_ECC_SMC)) < 0)
+				IS_ENABLED(CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC)) < 0)
 		return -EIO;
 
 	buffer += SM_SMALL_PAGE;
 
 	__nand_calculate_ecc(buffer, SM_SMALL_PAGE, ecc,
-			     IS_ENABLED(CONFIG_MTD_NAND_ECC_SMC));
+			     IS_ENABLED(CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC));
 	if (__nand_correct_data(buffer, ecc, oob->ecc2, SM_SMALL_PAGE,
-				IS_ENABLED(CONFIG_MTD_NAND_ECC_SMC)) < 0)
+				IS_ENABLED(CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC)) < 0)
 		return -EIO;
 	return 0;
 }
@@ -399,11 +399,11 @@ static int sm_write_block(struct sm_ftl *ftl, uint8_t *buf,
 		if (ftl->smallpagenand) {
 			__nand_calculate_ecc(buf + boffset, SM_SMALL_PAGE,
 					oob.ecc1,
-					IS_ENABLED(CONFIG_MTD_NAND_ECC_SMC));
+					IS_ENABLED(CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC));
 
 			__nand_calculate_ecc(buf + boffset + SM_SMALL_PAGE,
 					SM_SMALL_PAGE, oob.ecc2,
-					IS_ENABLED(CONFIG_MTD_NAND_ECC_SMC));
+					IS_ENABLED(CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC));
 		}
 		if (!sm_write_sector(ftl, zone, block, boffset,
 							buf + boffset, &oob))
diff --git a/drivers/mtd/tests/mtd_nandecctest.c b/drivers/mtd/tests/mtd_nandecctest.c
index c71523e94580..0c0091fb3708 100644
--- a/drivers/mtd/tests/mtd_nandecctest.c
+++ b/drivers/mtd/tests/mtd_nandecctest.c
@@ -122,9 +122,9 @@ static int no_bit_error_verify(void *error_data, void *error_ecc,
 	int ret;
 
 	__nand_calculate_ecc(error_data, size, calc_ecc,
-			     IS_ENABLED(CONFIG_MTD_NAND_ECC_SMC));
+			     IS_ENABLED(CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC));
 	ret = __nand_correct_data(error_data, error_ecc, calc_ecc, size,
-				  IS_ENABLED(CONFIG_MTD_NAND_ECC_SMC));
+				  IS_ENABLED(CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC));
 	if (ret == 0 && !memcmp(correct_data, error_data, size))
 		return 0;
 
@@ -152,9 +152,9 @@ static int single_bit_error_correct(void *error_data, void *error_ecc,
 	int ret;
 
 	__nand_calculate_ecc(error_data, size, calc_ecc,
-			     IS_ENABLED(CONFIG_MTD_NAND_ECC_SMC));
+			     IS_ENABLED(CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC));
 	ret = __nand_correct_data(error_data, error_ecc, calc_ecc, size,
-				  IS_ENABLED(CONFIG_MTD_NAND_ECC_SMC));
+				  IS_ENABLED(CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC));
 	if (ret == 1 && !memcmp(correct_data, error_data, size))
 		return 0;
 
@@ -189,9 +189,9 @@ static int double_bit_error_detect(void *error_data, void *error_ecc,
 	int ret;
 
 	__nand_calculate_ecc(error_data, size, calc_ecc,
-			     IS_ENABLED(CONFIG_MTD_NAND_ECC_SMC));
+			     IS_ENABLED(CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC));
 	ret = __nand_correct_data(error_data, error_ecc, calc_ecc, size,
-				  IS_ENABLED(CONFIG_MTD_NAND_ECC_SMC));
+				  IS_ENABLED(CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC));
 
 	return (ret == -EBADMSG) ? 0 : -EINVAL;
 }
@@ -266,7 +266,7 @@ static int nand_ecc_test_run(const size_t size)
 
 	prandom_bytes(correct_data, size);
 	__nand_calculate_ecc(correct_data, size, correct_ecc,
-			     IS_ENABLED(CONFIG_MTD_NAND_ECC_SMC));
+			     IS_ENABLED(CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC));
 
 	for (i = 0; i < ARRAY_SIZE(nand_ecc_test); i++) {
 		nand_ecc_test[i].prepare(error_data, error_ecc,
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
