Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730A9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:14:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4591F2084F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fFN3BfYN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i6ahRPzo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4591F2084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+PR3m5tm960QBCzWAtTjSWgw9Q/WysCAD+7RHNGkLdI=; b=fFN3BfYNUAwvip
	AMoeCsM85x70v4PRCr7CbHI1wOY5E4ThhrT6AhPQ5WD2fs+I29OZd1fPlhZGQZnVDYecF88L37e/q
	jeOkKCmbWXDn8WFXHFsZlJDfhA2Hnu0wwf22mxXM3sdv724a9/1SlZGA9frHLVIf82sPeRRDEvys6
	2EuE4qzPPd4wm7ZrJ4POUoZdg7zYHtvf4JHqMDVT8E8GzmKn6ZdKXal411cOT8ZGEyKymjQ1A6Ylx
	qIK7GEJY6sWOeqRVRV5rETZeslYsEspafnMv07gM9uNYPYCW40f0XJnWv2PjxTxSZedwwNxno9t9W
	+3F/kc93oyXOJHMaCJEQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxX8N-0006E3-HN; Sat, 23 Feb 2019 13:14:27 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxX8H-00068Q-Tl; Sat, 23 Feb 2019 13:14:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=MIME-Version:Content-Transfer-Encoding:
 Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:
 From:Sender:Reply-To:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IBYTMO3kzJdBA5HKGK2CVok4oTi2EVoOSDrbaoPsIAQ=; b=i6ahRPzoSj/NA5YocKz1WyYfVT
 xoxIlQuDxTQifBqfIAPEfccLB6j/PO/mOnvyyFCkPhhrKLU1/c3ispzxWFP6J4JqyOCGVrRXb7AXr
 iQCnI4SZ6xvmkI2y0qQl4EWU0wZtJmn0naCl2mEXTMRXKiA31cu6/kJy/KKEgOA2o9JR5C/Gb039G
 W4mp5n9/5lO+njlSUCZjfBKILScicRTD7LX8QggP13HqGmgxguluF44OtjjteR0efDU9zTKiTs1CR
 DqeKdVQJ43uO9ORaDgBJTjZ7XuYnMOfNK1rdEnhFN9KlQ4T3Mkovsbv5zGm1/F+0gmUfK8q+IoYBo
 4MLlC6wA==;
Received: from skedge04.snt-world.com ([91.208.41.69])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxX8E-0003b7-8t; Sat, 23 Feb 2019 13:14:19 +0000
Received: from sntmail12r.snt-is.com (unknown [10.203.32.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by skedge04.snt-world.com (Postfix) with ESMTPS id 46FEF67A7B0;
 Sat, 23 Feb 2019 14:14:14 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail12r.snt-is.com
 (10.203.32.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 23 Feb
 2019 14:14:13 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Sat, 23 Feb 2019 14:14:13 +0100
From: Schrempf Frieder <frieder.schrempf@kontron.de>
To: Miquel Raynal <miquel.raynal@bootlin.com>, Boris Brezillon
 <bbrezillon@kernel.org>, Richard Weinberger <richard@nod.at>, David Woodhouse
 <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, "Marek
 Vasut" <marek.vasut@gmail.com>, Tudor Ambarus <Tudor.Ambarus@microchip.com>
Subject: Re: [PATCH 11/15] mtd: rawnand: Use nanddev_mtd_max_bad_blocks()
Thread-Topic: [PATCH 11/15] mtd: rawnand: Use nanddev_mtd_max_bad_blocks()
Thread-Index: AQHUycZ/XbZra/gAf0qMf3lABxsKO6XtTwaA
Date: Sat, 23 Feb 2019 13:14:13 +0000
Message-ID: <ff2cb00e-696a-89da-87df-6fc83eaebae8@kontron.de>
References: <20190221091527.20497-1-miquel.raynal@bootlin.com>
 <20190221091527.20497-12-miquel.raynal@bootlin.com>
In-Reply-To: <20190221091527.20497-12-miquel.raynal@bootlin.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.43]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-ID: <09D4CA897186414AB5250609305FBB5F@snt-world.com>
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 46FEF67A7B0.A2E6A
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service
 Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: bbrezillon@kernel.org, computersforpeace@gmail.com,
 dwmw2@infradead.org, juliensu@mxic.com.tw,
 linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org,
 marek.vasut@gmail.com, masonccyang@mxic.com.tw,
 miquel.raynal@bootlin.com, richard@nod.at,
 thomas.petazzoni@bootlin.com, tudor.ambarus@microchip.com,
 vigneshr@ti.com, yamada.masahiro@socionext.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190223_081418_601937_3AC4D350 
X-CRM114-Status: GOOD (  24.28  )
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
Cc: Vignesh R <vigneshr@ti.com>, Julien Su <juliensu@mxic.com.tw>, Masahiro
 Yamada <yamada.masahiro@socionext.com>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Mason Yang <masonccyang@mxic.com.tw>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 21.02.19 10:15, Miquel Raynal wrote:
> From: Boris Brezillon <bbrezillon@kernel.org>
> 
> nanddev_mtd_max_bad_blocks() is implemented by the generic NAND layer
> and is already doing what we need. Reuse this function instead of
> having our own implementation.
> 
> While at it, get rid of the ->max_bb_per_die and ->blocks_per_die
> fields which are now unused.
> 
> Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

> ---
>   drivers/mtd/nand/raw/nand_base.c | 38 +-------------------------------
>   drivers/mtd/nand/raw/nand_onfi.c |  3 ---
>   include/linux/mtd/rawnand.h      |  5 -----
>   3 files changed, 1 insertion(+), 45 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index 256d16903d54..4c9c2660df64 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -4350,42 +4350,6 @@ static int nand_block_markbad(struct mtd_info *mtd, loff_t ofs)
>   	return nand_block_markbad_lowlevel(mtd_to_nand(mtd), ofs);
>   }
>   
> -/**
> - * nand_max_bad_blocks - [MTD Interface] Max number of bad blocks for an mtd
> - * @mtd: MTD device structure
> - * @ofs: offset relative to mtd start
> - * @len: length of mtd
> - */
> -static int nand_max_bad_blocks(struct mtd_info *mtd, loff_t ofs, size_t len)
> -{
> -	struct nand_chip *chip = mtd_to_nand(mtd);
> -	u32 part_start_block;
> -	u32 part_end_block;
> -	u32 part_start_die;
> -	u32 part_end_die;
> -
> -	/*
> -	 * max_bb_per_die and blocks_per_die used to determine
> -	 * the maximum bad block count.
> -	 */
> -	if (!chip->max_bb_per_die || !chip->blocks_per_die)
> -		return -ENOTSUPP;
> -
> -	/* Get the start and end of the partition in erase blocks. */
> -	part_start_block = mtd_div_by_eb(ofs, mtd);
> -	part_end_block = mtd_div_by_eb(len, mtd) + part_start_block - 1;
> -
> -	/* Get the start and end LUNs of the partition. */
> -	part_start_die = part_start_block / chip->blocks_per_die;
> -	part_end_die = part_end_block / chip->blocks_per_die;
> -
> -	/*
> -	 * Look up the bad blocks per unit and multiply by the number of units
> -	 * that the partition spans.
> -	 */
> -	return chip->max_bb_per_die * (part_end_die - part_start_die + 1);
> -}
> -
>   /**
>    * nand_suspend - [MTD Interface] Suspend the NAND flash
>    * @mtd: MTD device structure
> @@ -5854,7 +5818,7 @@ static int nand_scan_tail(struct nand_chip *chip)
>   	mtd->_block_isreserved = nand_block_isreserved;
>   	mtd->_block_isbad = nand_block_isbad;
>   	mtd->_block_markbad = nand_block_markbad;
> -	mtd->_max_bad_blocks = nand_max_bad_blocks;
> +	mtd->_max_bad_blocks = nanddev_mtd_max_bad_blocks;
>   
>   	/*
>   	 * Initialize bitflip_threshold to its default prior scan_bbt() call.
> diff --git a/drivers/mtd/nand/raw/nand_onfi.c b/drivers/mtd/nand/raw/nand_onfi.c
> index f3f59cf37d7f..3ca9c8923a30 100644
> --- a/drivers/mtd/nand/raw/nand_onfi.c
> +++ b/drivers/mtd/nand/raw/nand_onfi.c
> @@ -251,9 +251,6 @@ int nand_onfi_detect(struct nand_chip *chip)
>   	memorg->bits_per_cell = p->bits_per_cell;
>   	chip->bits_per_cell = p->bits_per_cell;
>   
> -	chip->max_bb_per_die = le16_to_cpu(p->bb_per_lun);
> -	chip->blocks_per_die = le32_to_cpu(p->blocks_per_lun);
> -
>   	if (le16_to_cpu(p->features) & ONFI_FEATURE_16_BIT_BUS)
>   		chip->options |= NAND_BUSWIDTH_16;
>   
> diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
> index 00a8795b215d..d748e09de480 100644
> --- a/include/linux/mtd/rawnand.h
> +++ b/include/linux/mtd/rawnand.h
> @@ -1027,9 +1027,6 @@ struct nand_legacy {
>    * @id:			[INTERN] holds NAND ID
>    * @parameters:		[INTERN] holds generic parameters under an easily
>    *			readable form.
> - * @max_bb_per_die:	[INTERN] the max number of bad blocks each die of a
> - *			this nand device will encounter their life times.
> - * @blocks_per_die:	[INTERN] The number of PEBs in a die
>    * @data_interface:	[INTERN] NAND interface timing information
>    * @cur_cs:		currently selected target. -1 means no target selected,
>    *			otherwise we should always have cur_cs >= 0 &&
> @@ -1085,8 +1082,6 @@ struct nand_chip {
>   
>   	struct nand_id id;
>   	struct nand_parameters parameters;
> -	u16 max_bb_per_die;
> -	u32 blocks_per_die;
>   
>   	struct nand_data_interface data_interface;
>   
> 
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
