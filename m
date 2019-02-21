Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218AAC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:02:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0AEA2070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PoZFXI/J";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QRA1IoFP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0AEA2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wE+o3wQfKyIn3r4uesijFo8064DQ84E4XwkXD0P1u30=; b=PoZFXI/Jy7sfpF
	Zq7pFZQgvFEHP1LD8yZ0litTMP2j3CJiGjfPuaVcBspTydJaSW6VDQr8iphK+6F5/QEYel/I148PM
	qpZKtpzTK2/MBeM6ZF/4p1CoYmV/jQ3vKPsGmapZ2CuCXgr07dMqmvksp3plbuBSpPAHLaSgx1Wsr
	MN8YvyD5XrvJxP4mV0lfc1Ls1rR6a3zGpm0oWQBsYVXaYtis3r1NU1Y59eIL9blqK5YyEG7+LrE/Y
	Vfk8ueRt4rso3P1bOPOzmnrs278Q7b637T08MKlkHfe2uZ+Dl04tvFjpxVKFfZBiJHuStSinW18WB
	CIb+gXLqVKpg7rRhDQkQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwnzK-000098-Gt; Thu, 21 Feb 2019 13:02:06 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwnwB-0003Kp-CF; Thu, 21 Feb 2019 12:58:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WjXDRE0SNBnMplUpw3lCf+g1Z4tZNd2z/VGo5Mzh9BU=; b=QRA1IoFPFyONSnIEYoBO8B6Dkd
 y0zMGmGCsRZYgK+zB8Zz5nctu/YgOsuW+YtIIHKGIxTqAX1wmBOugB3aWay+IsVBDG1EsFGa64KtY
 Viv2jNeWFvoFEo24L8WM9xOX8JJEVBUQXuhZAzh21PUNBZZWn5WjaCQHSuKh7E+w4gnw17xAqkDSm
 7DFhCXWB5v6WfwZy7pfYcuj/HQhnIVie607w42Goio4wporio8wBFMlmXbFpQi9L4Npkxrqhj2Ayg
 zqj/e83KLJbk7p0kSX64XrVKM4lS/jHl4EXKYGE5MDFvf8plmSSL+Yzj4klBLZVz0yk8GaQY0d0Wx
 d5XrwYuA==;
Received: from relay6-d.mail.gandi.net ([217.70.183.198])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwnw7-0000PP-E0; Thu, 21 Feb 2019 12:58:49 +0000
X-Originating-IP: 90.88.23.190
Received: from localhost.localdomain
 (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr [90.88.23.190])
 (Authenticated sender: miquel.raynal@bootlin.com)
 by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id E7A4DC0004;
 Thu, 21 Feb 2019 12:58:16 +0000 (UTC)
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Boris Brezillon <bbrezillon@kernel.org>,
 Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Marek Vasut <marek.vasut@gmail.com>,
 Tudor Ambarus <Tudor.Ambarus@microchip.com>
Subject: [RFC PATCH 14/27] mtd: nand: ecc: Turn the software Hamming
 implementation generic
Date: Thu, 21 Feb 2019 13:57:53 +0100
Message-Id: <20190221125806.28875-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190221125806.28875-1-miquel.raynal@bootlin.com>
References: <20190221125806.28875-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_075847_825714_D158A3EB 
X-CRM114-Status: GOOD (  26.21  )
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
 Julien Su <juliensu@mxic.com.tw>,
 Schrempf Frieder <frieder.schrempf@kontron.de>, linux-mtd@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Mason Yang <masonccyang@mxic.com.tw>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add helpers in the raw NAND core to call the generic functions that
will be re-used by the SPI-NAND layer.

While at it, do some cleanup in the file and its header.

There are two drivers (not even raw NAND controller drivers) using the
bare helpers __ecc_sw_hamming_calculate/correct(): mtd_nandecctest.c
and sm_ftl.c. It would be nice to find another way to call these
functions and finish to clean the driver.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/ecc/sw-hamming-engine.c   | 122 +++++++++------------
 drivers/mtd/nand/raw/cs553x_nand.c         |   3 +-
 drivers/mtd/nand/raw/fsmc_nand.c           |   2 +-
 drivers/mtd/nand/raw/lpc32xx_slc.c         |   2 +-
 drivers/mtd/nand/raw/nand_base.c           |  85 +++++++++++++-
 drivers/mtd/nand/raw/ndfc.c                |   3 +-
 drivers/mtd/nand/raw/sharpsl.c             |   2 +-
 drivers/mtd/nand/raw/tmio_nand.c           |   6 +-
 drivers/mtd/nand/raw/txx9ndfmc.c           |   4 +-
 drivers/mtd/sm_ftl.c                       |  27 +++--
 drivers/mtd/tests/mtd_nandecctest.c        |  29 +++--
 include/linux/mtd/nand-sw-hamming-engine.h |  50 +++++----
 include/linux/mtd/rawnand.h                |   9 ++
 13 files changed, 208 insertions(+), 136 deletions(-)

diff --git a/drivers/mtd/nand/ecc/sw-hamming-engine.c b/drivers/mtd/nand/ecc/sw-hamming-engine.c
index 6ba0205f1b4f..3918daf5547b 100644
--- a/drivers/mtd/nand/ecc/sw-hamming-engine.c
+++ b/drivers/mtd/nand/ecc/sw-hamming-engine.c
@@ -17,8 +17,6 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/mtd/mtd.h>
-#include <linux/mtd/rawnand.h>
 #include <linux/mtd/nand-sw-hamming-engine.h>
 #include <asm/byteorder.h>
 
@@ -75,7 +73,7 @@ static const char bitsperbyte[256] = {
  * addressbits is a lookup table to filter out the bits from the xor-ed
  * ECC data that identify the faulty location.
  * this is only used for repairing parity
- * see the comments in nand_correct_data for more details
+ * see the comments in ecc_sw_hamming_correct for more details
  */
 static const char addressbits[256] = {
 	0x00, 0x00, 0x01, 0x01, 0x00, 0x00, 0x01, 0x01,
@@ -112,30 +110,24 @@ static const char addressbits[256] = {
 	0x0e, 0x0e, 0x0f, 0x0f, 0x0e, 0x0e, 0x0f, 0x0f
 };
 
-/**
- * __nand_calculate_ecc - [NAND Interface] Calculate 3-byte ECC for 256/512-byte
- *			 block
- * @buf:	input buffer with raw data
- * @eccsize:	data bytes per ECC step (256 or 512)
- * @code:	output buffer with ECC
- * @sm_order:	Smart Media byte ordering
- */
-void __nand_calculate_ecc(const unsigned char *buf, unsigned int eccsize,
-			  unsigned char *code, bool sm_order)
+int __ecc_sw_hamming_calculate(const unsigned char *buf,
+			       unsigned int step_size,
+			       unsigned char *code, bool sm_order)
 {
-	int i;
-	const uint32_t *bp = (uint32_t *)buf;
-	/* 256 or 512 bytes/ecc  */
-	const uint32_t eccsize_mult = eccsize >> 8;
-	uint32_t cur;		/* current value in buffer */
+	const u32 *bp = (uint32_t *)buf;
+	const u32 eccsize_mult = step_size >> 8;
+	/* current value in buffer */
+	u32 cur;
 	/* rp0..rp15..rp17 are the various accumulated parities (per byte) */
-	uint32_t rp0, rp1, rp2, rp3, rp4, rp5, rp6, rp7;
-	uint32_t rp8, rp9, rp10, rp11, rp12, rp13, rp14, rp15, rp16;
-	uint32_t uninitialized_var(rp17);	/* to make compiler happy */
-	uint32_t par;		/* the cumulative parity for all data */
-	uint32_t tmppar;	/* the cumulative parity for this iteration;
-				   for rp12, rp14 and rp16 at the end of the
-				   loop */
+	u32 rp0, rp1, rp2, rp3, rp4, rp5, rp6, rp7;
+	u32 rp8, rp9, rp10, rp11, rp12, rp13, rp14, rp15, rp16;
+	/* Make the compiler happy */
+	u32 uninitialized_var(rp17);
+	/* Cumulative parity for all data */
+	u32 par;
+	/* Cumulative parity at the end of the loop (rp12, rp14, rp16) */
+	u32 tmppar;
+	int i;
 
 	par = 0;
 	rp4 = 0;
@@ -356,45 +348,37 @@ void __nand_calculate_ecc(const unsigned char *buf, unsigned int eccsize,
 		    (invparity[par & 0x55] << 2) |
 		    (invparity[rp17] << 1) |
 		    (invparity[rp16] << 0);
-}
-EXPORT_SYMBOL(__nand_calculate_ecc);
-
-/**
- * nand_calculate_ecc - [NAND Interface] Calculate 3-byte ECC for 256/512-byte
- *			 block
- * @chip:	NAND chip object
- * @buf:	input buffer with raw data
- * @code:	output buffer with ECC
- */
-int nand_calculate_ecc(struct nand_chip *chip, const unsigned char *buf,
-		       unsigned char *code)
-{
-	bool sm_order = chip->ecc.options & NAND_ECC_SOFT_HAMMING_SM_ORDER;
-
-	__nand_calculate_ecc(buf, chip->ecc.size, code, sm_order);
 
 	return 0;
 }
-EXPORT_SYMBOL(nand_calculate_ecc);
+EXPORT_SYMBOL(__ecc_sw_hamming_calculate);
 
 /**
- * __nand_correct_data - [NAND Interface] Detect and correct bit error(s)
- * @buf:	raw data read from the chip
- * @read_ecc:	ECC from the chip
- * @calc_ecc:	the ECC calculated from raw data
- * @eccsize:	data bytes per ECC step (256 or 512)
- * @sm_order:	Smart Media byte order
+ * ecc_sw_hamming_calculate - Calculate 3-byte ECC for 256/512-byte block
  *
- * Detect and correct a 1 bit error for eccsize byte block
+ * @nand: NAND device
+ * @buf: Input buffer with raw data
+ * @code: Output buffer with ECC
  */
-int __nand_correct_data(unsigned char *buf,
-			unsigned char *read_ecc, unsigned char *calc_ecc,
-			unsigned int eccsize, bool sm_order)
+int ecc_sw_hamming_calculate(struct nand_device *nand,
+			     const unsigned char *buf,
+			     unsigned char *code)
 {
+	struct ecc_sw_hamming_conf *engine_conf = nand->ecc.ctx.priv;
+	unsigned int step_size = nand->ecc.ctx.conf.step_size;
+
+	return __ecc_sw_hamming_calculate(buf, step_size, code,
+					  engine_conf->sm_order);
+}
+EXPORT_SYMBOL(ecc_sw_hamming_calculate);
+
+int __ecc_sw_hamming_correct(unsigned char *buf, unsigned char *read_ecc,
+			     unsigned char *calc_ecc, unsigned int step_size,
+			     bool sm_order)
+{
+	const u32 eccsize_mult = step_size >> 8;
 	unsigned char b0, b1, b2, bit_addr;
 	unsigned int byte_addr;
-	/* 256 or 512 bytes/ecc  */
-	const uint32_t eccsize_mult = eccsize >> 8;
 
 	/*
 	 * b0 to b2 indicate which bit is faulty (if any)
@@ -458,27 +442,29 @@ int __nand_correct_data(unsigned char *buf,
 	pr_err("%s: uncorrectable ECC error\n", __func__);
 	return -EBADMSG;
 }
-EXPORT_SYMBOL(__nand_correct_data);
+EXPORT_SYMBOL(__ecc_sw_hamming_correct);
 
 /**
- * nand_correct_data - [NAND Interface] Detect and correct bit error(s)
- * @chip:	NAND chip object
- * @buf:	raw data read from the chip
- * @read_ecc:	ECC from the chip
- * @calc_ecc:	the ECC calculated from raw data
+ * ecc_sw_hamming_correct - Detect and correct bit error(s)
  *
- * Detect and correct a 1 bit error for 256/512 byte block
+ * @nand: NAND device
+ * @buf: Raw data read from the chip
+ * @read_ecc: ECC bytes read from the chip
+ * @calc_ecc: ECC calculated from the raw data
+ *
+ * Detect and correct up to 1 bit error per 256/512-byte block.
  */
-int nand_correct_data(struct nand_chip *chip, unsigned char *buf,
-		      unsigned char *read_ecc, unsigned char *calc_ecc)
+int ecc_sw_hamming_correct(struct nand_device *nand, unsigned char *buf,
+			   unsigned char *read_ecc, unsigned char *calc_ecc)
 {
-	bool sm_order = chip->ecc.options & NAND_ECC_SOFT_HAMMING_SM_ORDER;
+	struct ecc_sw_hamming_conf *engine_conf = nand->ecc.ctx.priv;
+	unsigned int step_size = nand->ecc.ctx.conf.step_size;
 
-	return __nand_correct_data(buf, read_ecc, calc_ecc, chip->ecc.size,
-				   sm_order);
+	return __ecc_sw_hamming_correct(buf, read_ecc, calc_ecc, step_size,
+					engine_conf->sm_order);
 }
-EXPORT_SYMBOL(nand_correct_data);
+EXPORT_SYMBOL(ecc_sw_hamming_correct);
 
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Frans Meulenbroeks <fransmeulenbroeks@gmail.com>");
-MODULE_DESCRIPTION("Generic NAND ECC support");
+MODULE_DESCRIPTION("NAND software Hamming ECC support");
diff --git a/drivers/mtd/nand/raw/cs553x_nand.c b/drivers/mtd/nand/raw/cs553x_nand.c
index 19596ba72ac6..3fbff2a5dab1 100644
--- a/drivers/mtd/nand/raw/cs553x_nand.c
+++ b/drivers/mtd/nand/raw/cs553x_nand.c
@@ -23,7 +23,6 @@
 #include <linux/delay.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
-#include <linux/mtd/nand-sw-hamming-engine.h>
 #include <linux/mtd/partitions.h>
 
 #include <asm/msr.h>
@@ -219,7 +218,7 @@ static int __init cs553x_init_one(int cs, int mmio, unsigned long adr)
 	this->ecc.bytes = 3;
 	this->ecc.hwctl  = cs_enable_hwecc;
 	this->ecc.calculate = cs_calculate_ecc;
-	this->ecc.correct  = nand_correct_data;
+	this->ecc.correct  = rawnand_sw_hamming_correct;
 	this->ecc.strength = 1;
 
 	/* Enable the following for a flash based bad block table */
diff --git a/drivers/mtd/nand/raw/fsmc_nand.c b/drivers/mtd/nand/raw/fsmc_nand.c
index 9d11007b1ee5..91e813fe7dd8 100644
--- a/drivers/mtd/nand/raw/fsmc_nand.c
+++ b/drivers/mtd/nand/raw/fsmc_nand.c
@@ -936,7 +936,7 @@ static int fsmc_nand_attach_chip(struct nand_chip *nand)
 	case NAND_ECC_HW:
 		dev_info(host->dev, "Using 1-bit HW ECC scheme\n");
 		nand->ecc.calculate = fsmc_read_hwecc_ecc1;
-		nand->ecc.correct = nand_correct_data;
+		nand->ecc.correct = rawnand_sw_hamming_correct;
 		nand->ecc.bytes = 3;
 		nand->ecc.strength = 1;
 		nand->ecc.options |= NAND_ECC_SOFT_HAMMING_SM_ORDER;
diff --git a/drivers/mtd/nand/raw/lpc32xx_slc.c b/drivers/mtd/nand/raw/lpc32xx_slc.c
index 447c23d4f3b4..f2924ea8e126 100644
--- a/drivers/mtd/nand/raw/lpc32xx_slc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_slc.c
@@ -901,7 +901,7 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 	chip->ecc.write_oob = lpc32xx_nand_write_oob_syndrome;
 	chip->ecc.read_oob = lpc32xx_nand_read_oob_syndrome;
 	chip->ecc.calculate = lpc32xx_nand_ecc_calculate;
-	chip->ecc.correct = nand_correct_data;
+	chip->ecc.correct = rawnand_sw_hamming_correct;
 	chip->ecc.strength = 1;
 	chip->ecc.hwctl = lpc32xx_nand_ecc_enable;
 
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 395a9bde5e15..751bed07fd62 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -4843,6 +4843,72 @@ static void nand_scan_ident_cleanup(struct nand_chip *chip)
 	kfree(chip->parameters.onfi);
 }
 
+int rawnand_sw_hamming_init(struct nand_chip *chip)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	struct ecc_sw_hamming_conf *engine_conf;
+	struct nand_device *base = &chip->base;
+
+	base->ecc.user_conf.mode = NAND_ECC_SOFT;
+	base->ecc.user_conf.algo = NAND_ECC_HAMMING;
+	base->ecc.user_conf.strength = chip->ecc.strength;
+	base->ecc.user_conf.step_size = chip->ecc.size;
+
+	if (base->ecc.user_conf.strength != 1 ||
+	    (base->ecc.user_conf.step_size != 256 &&
+	     base->ecc.user_conf.step_size != 512)) {
+		pr_err("%s: unsupported strength or step size\n", __func__);
+		return -EINVAL;
+	}
+
+	engine_conf = kzalloc(sizeof(*engine_conf), GFP_KERNEL);
+	if (!engine_conf)
+		return -ENOMEM;
+
+	engine_conf->code_size = 3;
+	engine_conf->nsteps = mtd->writesize / base->ecc.user_conf.step_size;
+
+	if (chip->ecc.options & NAND_ECC_SOFT_HAMMING_SM_ORDER)
+		engine_conf->sm_order = true;
+
+	base->ecc.ctx.priv = engine_conf;
+
+	chip->ecc.steps = engine_conf->nsteps;
+	chip->ecc.bytes = engine_conf->code_size;
+
+	return 0;
+}
+EXPORT_SYMBOL(rawnand_sw_hamming_init);
+
+int rawnand_sw_hamming_calculate(struct nand_chip *chip,
+				 const unsigned char *buf,
+				 unsigned char *code)
+{
+	struct nand_device *base = &chip->base;
+
+	return ecc_sw_hamming_calculate(base, buf, code);
+}
+EXPORT_SYMBOL(rawnand_sw_hamming_calculate);
+
+int rawnand_sw_hamming_correct(struct nand_chip *chip,
+			       unsigned char *buf,
+			       unsigned char *read_ecc,
+			       unsigned char *calc_ecc)
+{
+	struct nand_device *base = &chip->base;
+
+	return ecc_sw_hamming_correct(base, buf, read_ecc, calc_ecc);
+}
+EXPORT_SYMBOL(rawnand_sw_hamming_correct);
+
+void rawnand_sw_hamming_cleanup(struct nand_chip *chip)
+{
+	struct nand_device *base = &chip->base;
+
+	kfree(base->ecc.ctx.priv);
+}
+EXPORT_SYMBOL(rawnand_sw_hamming_cleanup);
+
 int rawnand_sw_bch_init(struct nand_chip *chip)
 {
 	struct nand_device *base = &chip->base;
@@ -4916,8 +4982,8 @@ static int nand_set_ecc_soft_ops(struct nand_chip *chip)
 
 	switch (ecc->algo) {
 	case NAND_ECC_HAMMING:
-		ecc->calculate = nand_calculate_ecc;
-		ecc->correct = nand_correct_data;
+		ecc->calculate = rawnand_sw_hamming_calculate;
+		ecc->correct = rawnand_sw_hamming_correct;
 		ecc->read_page = nand_read_page_swecc;
 		ecc->read_subpage = nand_read_subpage;
 		ecc->write_page = nand_write_page_swecc;
@@ -4933,6 +4999,12 @@ static int nand_set_ecc_soft_ops(struct nand_chip *chip)
 		if (IS_ENABLED(CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC))
 			ecc->options |= NAND_ECC_SOFT_HAMMING_SM_ORDER;
 
+		ret = rawnand_sw_hamming_init(chip);
+		if (ret) {
+			WARN(1, "Hamming ECC initialization failed!\n");
+			return ret;
+		}
+
 		return 0;
 	case NAND_ECC_BCH:
 		if (!IS_ENABLED(CONFIG_MTD_NAND_ECC_SW_BCH)) {
@@ -5703,9 +5775,12 @@ EXPORT_SYMBOL(nand_scan_with_ids);
  */
 void nand_cleanup(struct nand_chip *chip)
 {
-	if (chip->ecc.mode == NAND_ECC_SOFT &&
-	    chip->ecc.algo == NAND_ECC_BCH)
-		rawnand_sw_bch_cleanup(chip);
+	if (chip->ecc.mode == NAND_ECC_SOFT) {
+		if (chip->ecc.algo == NAND_ECC_HAMMING)
+			rawnand_sw_hamming_cleanup(chip);
+		else if (chip->ecc.algo == NAND_ECC_BCH)
+			rawnand_sw_bch_cleanup(chip);
+	}
 
 	/* Free bad block table memory */
 	kfree(chip->bbt);
diff --git a/drivers/mtd/nand/raw/ndfc.c b/drivers/mtd/nand/raw/ndfc.c
index d552b727b821..e92079dc1a47 100644
--- a/drivers/mtd/nand/raw/ndfc.c
+++ b/drivers/mtd/nand/raw/ndfc.c
@@ -23,7 +23,6 @@
  */
 #include <linux/module.h>
 #include <linux/mtd/rawnand.h>
-#include <linux/mtd/nand-sw-hamming-engine.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/ndfc.h>
 #include <linux/slab.h>
@@ -151,7 +150,7 @@ static int ndfc_chip_init(struct ndfc_controller *ndfc,
 	chip->controller = &ndfc->ndfc_control;
 	chip->legacy.read_buf = ndfc_read_buf;
 	chip->legacy.write_buf = ndfc_write_buf;
-	chip->ecc.correct = nand_correct_data;
+	chip->ecc.correct = ecc_sw_hamming_correct;
 	chip->ecc.hwctl = ndfc_enable_hwecc;
 	chip->ecc.calculate = ndfc_calculate_ecc;
 	chip->ecc.mode = NAND_ECC_HW;
diff --git a/drivers/mtd/nand/raw/sharpsl.c b/drivers/mtd/nand/raw/sharpsl.c
index 32918a7ed6c4..35baff68993f 100644
--- a/drivers/mtd/nand/raw/sharpsl.c
+++ b/drivers/mtd/nand/raw/sharpsl.c
@@ -168,7 +168,7 @@ static int sharpsl_nand_probe(struct platform_device *pdev)
 	this->badblock_pattern = data->badblock_pattern;
 	this->ecc.hwctl = sharpsl_nand_enable_hwecc;
 	this->ecc.calculate = sharpsl_nand_calculate_ecc;
-	this->ecc.correct = nand_correct_data;
+	this->ecc.correct = rawnand_sw_hamming_correct;
 
 	/* Scan to find existence of the device */
 	err = nand_scan(this, 1);
diff --git a/drivers/mtd/nand/raw/tmio_nand.c b/drivers/mtd/nand/raw/tmio_nand.c
index 63f5100cf70b..7eeef6634c0c 100644
--- a/drivers/mtd/nand/raw/tmio_nand.c
+++ b/drivers/mtd/nand/raw/tmio_nand.c
@@ -295,11 +295,11 @@ static int tmio_nand_correct_data(struct nand_chip *chip, unsigned char *buf,
 	int r0, r1;
 
 	/* assume ecc.size = 512 and ecc.bytes = 6 */
-	r0 = __nand_correct_data(buf, read_ecc, calc_ecc, 256, false);
+	r0 = rawnand_sw_hamming_correct(chip, buf, read_ecc, calc_ecc);
 	if (r0 < 0)
 		return r0;
-	r1 = __nand_correct_data(buf + 256, read_ecc + 3, calc_ecc + 3, 256,
-				 false);
+	r1 = rawnand_sw_hamming_correct(chip, buf + 256, read_ecc + 3,
+					calc_ecc + 3);
 	if (r1 < 0)
 		return r1;
 	return r0 + r1;
diff --git a/drivers/mtd/nand/raw/txx9ndfmc.c b/drivers/mtd/nand/raw/txx9ndfmc.c
index f87f598b7688..85019684dee7 100644
--- a/drivers/mtd/nand/raw/txx9ndfmc.c
+++ b/drivers/mtd/nand/raw/txx9ndfmc.c
@@ -198,8 +198,8 @@ static int txx9ndfmc_correct_data(struct nand_chip *chip, unsigned char *buf,
 	int stat;
 
 	for (eccsize = chip->ecc.size; eccsize > 0; eccsize -= 256) {
-		stat = __nand_correct_data(buf, read_ecc, calc_ecc, 256,
-					   false);
+		stat = rawnand_sw_hamming_correct(chip, buf, read_ecc,
+						  calc_ecc);
 		if (stat < 0)
 			return stat;
 		corrected += stat;
diff --git a/drivers/mtd/sm_ftl.c b/drivers/mtd/sm_ftl.c
index 57a7d98d6a84..aaaa906423a9 100644
--- a/drivers/mtd/sm_ftl.c
+++ b/drivers/mtd/sm_ftl.c
@@ -219,20 +219,19 @@ static void sm_break_offset(struct sm_ftl *ftl, loff_t loffset,
 
 static int sm_correct_sector(uint8_t *buffer, struct sm_oob *oob)
 {
+	bool sm_order = IS_ENABLED(CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC);
 	uint8_t ecc[3];
 
-	__nand_calculate_ecc(buffer, SM_SMALL_PAGE, ecc,
-			     IS_ENABLED(CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC));
-	if (__nand_correct_data(buffer, ecc, oob->ecc1, SM_SMALL_PAGE,
-				IS_ENABLED(CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC)) < 0)
+	__ecc_sw_hamming_calculate(buffer, SM_SMALL_PAGE, ecc, sm_order);
+	if (__ecc_sw_hamming_correct(buffer, ecc, oob->ecc1, SM_SMALL_PAGE,
+				     sm_order) < 0)
 		return -EIO;
 
 	buffer += SM_SMALL_PAGE;
 
-	__nand_calculate_ecc(buffer, SM_SMALL_PAGE, ecc,
-			     IS_ENABLED(CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC));
-	if (__nand_correct_data(buffer, ecc, oob->ecc2, SM_SMALL_PAGE,
-				IS_ENABLED(CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC)) < 0)
+	__ecc_sw_hamming_calculate(buffer, SM_SMALL_PAGE, ecc, sm_order);
+	if (__ecc_sw_hamming_correct(buffer, ecc, oob->ecc2, SM_SMALL_PAGE,
+				     sm_order) < 0)
 		return -EIO;
 	return 0;
 }
@@ -371,6 +370,7 @@ static int sm_write_block(struct sm_ftl *ftl, uint8_t *buf,
 			  int zone, int block, int lba,
 			  unsigned long invalid_bitmap)
 {
+	bool sm_order = IS_ENABLED(CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC);
 	struct sm_oob oob;
 	int boffset;
 	int retry = 0;
@@ -397,13 +397,12 @@ static int sm_write_block(struct sm_ftl *ftl, uint8_t *buf,
 		}
 
 		if (ftl->smallpagenand) {
-			__nand_calculate_ecc(buf + boffset, SM_SMALL_PAGE,
-					oob.ecc1,
-					IS_ENABLED(CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC));
+			__ecc_sw_hamming_calculate(buf + boffset, SM_SMALL_PAGE,
+						   oob.ecc1, sm_order);
 
-			__nand_calculate_ecc(buf + boffset + SM_SMALL_PAGE,
-					SM_SMALL_PAGE, oob.ecc2,
-					IS_ENABLED(CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC));
+			__ecc_sw_hamming_calculate(buf + boffset + SM_SMALL_PAGE,
+						   SM_SMALL_PAGE, oob.ecc2,
+						   sm_order);
 		}
 		if (!sm_write_sector(ftl, zone, block, boffset,
 							buf + boffset, &oob))
diff --git a/drivers/mtd/tests/mtd_nandecctest.c b/drivers/mtd/tests/mtd_nandecctest.c
index 95a94643f955..5d1a36244e59 100644
--- a/drivers/mtd/tests/mtd_nandecctest.c
+++ b/drivers/mtd/tests/mtd_nandecctest.c
@@ -118,13 +118,13 @@ static void no_bit_error(void *error_data, void *error_ecc,
 static int no_bit_error_verify(void *error_data, void *error_ecc,
 				void *correct_data, const size_t size)
 {
+	bool sm_order = IS_ENABLED(CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC);
 	unsigned char calc_ecc[3];
 	int ret;
 
-	__nand_calculate_ecc(error_data, size, calc_ecc,
-			     IS_ENABLED(CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC));
-	ret = __nand_correct_data(error_data, error_ecc, calc_ecc, size,
-				  IS_ENABLED(CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC));
+	__ecc_sw_hamming_calculate(error_data, size, calc_ecc, sm_order);
+	ret = __ecc_sw_hamming_correct(error_data, error_ecc, calc_ecc, size,
+				       sm_order);
 	if (ret == 0 && !memcmp(correct_data, error_data, size))
 		return 0;
 
@@ -148,13 +148,13 @@ static void single_bit_error_in_ecc(void *error_data, void *error_ecc,
 static int single_bit_error_correct(void *error_data, void *error_ecc,
 				void *correct_data, const size_t size)
 {
+	bool sm_order = IS_ENABLED(CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC);
 	unsigned char calc_ecc[3];
 	int ret;
 
-	__nand_calculate_ecc(error_data, size, calc_ecc,
-			     IS_ENABLED(CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC));
-	ret = __nand_correct_data(error_data, error_ecc, calc_ecc, size,
-				  IS_ENABLED(CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC));
+	__ecc_sw_hamming_calculate(error_data, size, calc_ecc, sm_order);
+	ret = __ecc_sw_hamming_correct(error_data, error_ecc, calc_ecc, size,
+				       sm_order);
 	if (ret == 1 && !memcmp(correct_data, error_data, size))
 		return 0;
 
@@ -185,13 +185,13 @@ static void double_bit_error_in_ecc(void *error_data, void *error_ecc,
 static int double_bit_error_detect(void *error_data, void *error_ecc,
 				void *correct_data, const size_t size)
 {
+	bool sm_order = IS_ENABLED(CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC);
 	unsigned char calc_ecc[3];
 	int ret;
 
-	__nand_calculate_ecc(error_data, size, calc_ecc,
-			     IS_ENABLED(CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC));
-	ret = __nand_correct_data(error_data, error_ecc, calc_ecc, size,
-				  IS_ENABLED(CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC));
+	__ecc_sw_hamming_calculate(error_data, size, calc_ecc, sm_order);
+	ret = __ecc_sw_hamming_correct(error_data, error_ecc, calc_ecc, size,
+				       sm_order);
 
 	return (ret == -EBADMSG) ? 0 : -EINVAL;
 }
@@ -247,6 +247,7 @@ static void dump_data_ecc(void *error_data, void *error_ecc, void *correct_data,
 
 static int nand_ecc_test_run(const size_t size)
 {
+	bool sm_order = IS_ENABLED(CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC);
 	int i;
 	int err = 0;
 	void *error_data;
@@ -265,9 +266,7 @@ static int nand_ecc_test_run(const size_t size)
 	}
 
 	prandom_bytes(correct_data, size);
-	__nand_calculate_ecc(correct_data, size, correct_ecc,
-			     IS_ENABLED(CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC));
-
+	__ecc_sw_hamming_calculate(correct_data, size, correct_ecc, sm_order);
 	for (i = 0; i < ARRAY_SIZE(nand_ecc_test); i++) {
 		nand_ecc_test[i].prepare(error_data, error_ecc,
 				correct_data, correct_ecc, size);
diff --git a/include/linux/mtd/nand-sw-hamming-engine.h b/include/linux/mtd/nand-sw-hamming-engine.h
index 4ce99fa574e3..c50da3a255b7 100644
--- a/include/linux/mtd/nand-sw-hamming-engine.h
+++ b/include/linux/mtd/nand-sw-hamming-engine.h
@@ -10,30 +10,36 @@
 #ifndef __MTD_NAND_ECC_SW_HAMMING_H__
 #define __MTD_NAND_ECC_SW_HAMMING_H__
 
-struct nand_chip;
+#include <linux/mtd/nand.h>
 
-/*
- * Calculate 3 byte ECC code for eccsize byte block
+/**
+ * struct ecc_sw_hamming_conf - private software Hamming ECC engine structure
+ * @reqooblen: Save the actual user OOB length requested before overwriting it
+ * @code_size: Number of bytes needed to store a code (one code per step)
+ * @nsteps: Number of steps
+ * @calc_buf: Buffer to use when calculating ECC bytes
+ * @code_buf: Buffer to use when reading (raw) ECC bytes from the chip
+ * @sm_order: Smart Media special ordering
  */
-void __nand_calculate_ecc(const u_char *dat, unsigned int eccsize,
-			  u_char *ecc_code, bool sm_order);
+struct ecc_sw_hamming_conf {
+	unsigned int reqooblen;
+	unsigned int code_size;
+	unsigned int nsteps;
+	u8 *calc_buf;
+	u8 *code_buf;
+	unsigned int sm_order;
+};
 
-/*
- * Calculate 3 byte ECC code for 256/512 byte block
- */
-int nand_calculate_ecc(struct nand_chip *chip, const u_char *dat,
-		       u_char *ecc_code);
-
-/*
- * Detect and correct a 1 bit error for eccsize byte block
- */
-int __nand_correct_data(u_char *dat, u_char *read_ecc, u_char *calc_ecc,
-			unsigned int eccsize, bool sm_order);
-
-/*
- * Detect and correct a 1 bit error for 256/512 byte block
- */
-int nand_correct_data(struct nand_chip *chip, u_char *dat, u_char *read_ecc,
-		      u_char *calc_ecc);
+int __ecc_sw_hamming_calculate(const unsigned char *buf,
+			       unsigned int step_size,
+			       unsigned char *code, bool sm_order);
+int ecc_sw_hamming_calculate(struct nand_device *nand,
+			     const unsigned char *buf,
+			     unsigned char *code);
+int __ecc_sw_hamming_correct(unsigned char *buf, unsigned char *read_ecc,
+			     unsigned char *calc_ecc, unsigned int step_size,
+			     bool sm_order);
+int ecc_sw_hamming_correct(struct nand_device *nand, unsigned char *buf,
+			   unsigned char *read_ecc, unsigned char *calc_ecc);
 
 #endif /* __MTD_NAND_ECC_SW_HAMMING_H__ */
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index afe75e707e2c..dc6d0f899066 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1230,6 +1230,15 @@ static inline int nand_opcode_8bits(unsigned int command)
 	return 0;
 }
 
+int rawnand_sw_hamming_init(struct nand_chip *chip);
+int rawnand_sw_hamming_calculate(struct nand_chip *chip,
+				 const unsigned char *buf,
+				 unsigned char *code);
+int rawnand_sw_hamming_correct(struct nand_chip *chip,
+			       unsigned char *buf,
+			       unsigned char *read_ecc,
+			       unsigned char *calc_ecc);
+void rawnand_sw_hamming_cleanup(struct nand_chip *chip);
 int rawnand_sw_bch_init(struct nand_chip *chip);
 int rawnand_sw_bch_correct(struct nand_chip *chip, unsigned char *buf,
 			   unsigned char *read_ecc, unsigned char *calc_ecc);
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
