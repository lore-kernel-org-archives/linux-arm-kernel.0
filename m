Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F50C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:00:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77D2620675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NLlmgFRj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77D2620675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=g45fT3X1GB0FpU+CDsVtkMBIcW6Gz1MHTfatzR55X/Q=; b=NLlmgFRjw9VMVu
	6q2x2cehoCIrwGo9exvtMZ8npMJh8tvFP2ZmqHYxu7RCYkD6OUQbGFHLahQ67OgWM9bILDz1qjn9b
	7SzQJtaQT1KbrBJeZ1rF/fzcsPH52uZnK/GH+eiiFOTw7J5UiLk/LLD44PHKzmUH/oierdZ1Spmbl
	lLnmZLARHbwhVYfEQrMGboPD2rc5A2GdSpB0pWB9oZdpxSCOoqOnmwjWV2DjJbBkkl8dTe1q02hc8
	MMY1LcbV2vgvVppOAZtE81zFz8XZnv7dA3vJfZIep70AJCmbyHFsimBvkhI2KRXQHItazp5IRoWrv
	N/iWW0XqoMoY6NYdVevg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxWut-0003U1-19; Sat, 23 Feb 2019 13:00:31 +0000
Received: from skedge04.snt-world.com ([91.208.41.69])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxWun-0003T7-DE; Sat, 23 Feb 2019 13:00:28 +0000
Received: from sntmail14r.snt-is.com (unknown [10.203.32.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by skedge04.snt-world.com (Postfix) with ESMTPS id 8B8B367A7D4;
 Sat, 23 Feb 2019 14:00:15 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail14r.snt-is.com
 (10.203.32.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 23 Feb
 2019 14:00:14 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Sat, 23 Feb 2019 14:00:14 +0100
From: Schrempf Frieder <frieder.schrempf@kontron.de>
To: Miquel Raynal <miquel.raynal@bootlin.com>, Boris Brezillon
 <bbrezillon@kernel.org>, Richard Weinberger <richard@nod.at>, David Woodhouse
 <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, "Marek
 Vasut" <marek.vasut@gmail.com>, Tudor Ambarus <Tudor.Ambarus@microchip.com>
Subject: Re: [PATCH 07/15] mtd: rawnand: Fill memorg during detection
Thread-Topic: [PATCH 07/15] mtd: rawnand: Fill memorg during detection
Thread-Index: AQHUycZr9ZtG7bS1jEKIexInFgZ6m6XtSx4A
Date: Sat, 23 Feb 2019 13:00:14 +0000
Message-ID: <2442d400-d50d-bbe9-4275-cce2241f6609@kontron.de>
References: <20190221091527.20497-1-miquel.raynal@bootlin.com>
 <20190221091527.20497-8-miquel.raynal@bootlin.com>
In-Reply-To: <20190221091527.20497-8-miquel.raynal@bootlin.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.43]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-ID: <BB56438D82402A4A88001632C0757491@snt-world.com>
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 8B8B367A7D4.A3363
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
X-CRM114-CacheID: sfid-20190223_050025_778243_6597B314 
X-CRM114-Status: GOOD (  22.79  )
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
> If we want to use the generic NAND layer, we need to have the memorg
> struct appropriately filled. Patch the detection code to fill this
> struct.
> 
> Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>   drivers/mtd/nand/raw/denali.c       |  5 +++
>   drivers/mtd/nand/raw/diskonchip.c   |  4 ++
>   drivers/mtd/nand/raw/jz4740_nand.c  |  4 ++
>   drivers/mtd/nand/raw/nand_amd.c     | 11 ++++--
>   drivers/mtd/nand/raw/nand_base.c    | 60 ++++++++++++++++++++++++++---
>   drivers/mtd/nand/raw/nand_hynix.c   | 48 +++++++++++++++--------
>   drivers/mtd/nand/raw/nand_jedec.c   | 22 ++++++++---
>   drivers/mtd/nand/raw/nand_onfi.c    | 23 ++++++++---
>   drivers/mtd/nand/raw/nand_samsung.c | 24 ++++++++----
>   drivers/mtd/nand/raw/nand_toshiba.c |  9 ++++-
>   drivers/mtd/nand/raw/nandsim.c      |  6 +++
>   11 files changed, 172 insertions(+), 44 deletions(-)
> 
[...]
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index d3092c9a3e21..cb03877c775c 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -4530,21 +4530,30 @@ static int nand_get_bits_per_cell(u8 cellinfo)
>    */
>   void nand_decode_ext_id(struct nand_chip *chip)
>   {
> +	struct nand_memory_organization *memorg;
>   	struct mtd_info *mtd = nand_to_mtd(chip);
>   	int extid;
>   	u8 *id_data = chip->id.data;
> +
> +	memorg = nanddev_get_memorg(&chip->base);
> +
>   	/* The 3rd id byte holds MLC / multichip data */
> +	memorg->bits_per_cell = nand_get_bits_per_cell(id_data[2]);
>   	chip->bits_per_cell = nand_get_bits_per_cell(id_data[2]);
>   	/* The 4th id byte is the important one */
>   	extid = id_data[3];
>   
>   	/* Calc pagesize */
> -	mtd->writesize = 1024 << (extid & 0x03);
> +	memorg->pagesize = 1024 << (extid & 0x03);
> +	mtd->writesize = memorg->pagesize;
>   	extid >>= 2;
>   	/* Calc oobsize */
> -	mtd->oobsize = (8 << (extid & 0x01)) * (mtd->writesize >> 9);
> +	memorg->oobsize = (8 << (extid & 0x01)) * (mtd->writesize >> 9);
> +	mtd->oobsize = memorg->oobsize;
>   	extid >>= 2;
>   	/* Calc blocksize. Blocksize is multiples of 64KiB */
> +	memorg->pages_per_eraseblock = ((64 * 1024) << (extid & 0x03)) /
> +				       memorg->pagesize;
>   	mtd->erasesize = (64 * 1024) << (extid & 0x03);
>   	extid >>= 2;
>   	/* Get buswidth information */
> @@ -4561,12 +4570,19 @@ EXPORT_SYMBOL_GPL(nand_decode_ext_id);
>   static void nand_decode_id(struct nand_chip *chip, struct nand_flash_dev *type)
>   {
>   	struct mtd_info *mtd = nand_to_mtd(chip);
> +	struct nand_memory_organization *memorg;
>   
> +	memorg = nanddev_get_memorg(&chip->base);
> +
> +	memorg->pages_per_eraseblock = type->erasesize / type->pagesize;
>   	mtd->erasesize = type->erasesize;
> -	mtd->writesize = type->pagesize;
> -	mtd->oobsize = mtd->writesize / 32;
> +	memorg->pagesize = type->pagesize;
> +	mtd->writesize = memorg->pagesize;
> +	memorg->oobsize = memorg->pagesize / 32;
> +	mtd->oobsize = memorg->oobsize;
>   
>   	/* All legacy ID NAND are small-page, SLC */
> +	memorg->bits_per_cell = 1;
>   	chip->bits_per_cell = 1;
>   }
>   
> @@ -4595,13 +4611,21 @@ static bool find_full_id_nand(struct nand_chip *chip,
>   			      struct nand_flash_dev *type)
>   {
>   	struct mtd_info *mtd = nand_to_mtd(chip);
> +	struct nand_memory_organization *memorg;
>   	u8 *id_data = chip->id.data;
>   
> +	memorg = nanddev_get_memorg(&chip->base);
> +
>   	if (!strncmp(type->id, id_data, type->id_len)) {
> -		mtd->writesize = type->pagesize;
> +		memorg->pagesize = type->pagesize;
> +		mtd->writesize = memorg->pagesize;
> +		memorg->pages_per_eraseblock = type->erasesize /
> +					       type->erasesize;

This should be:
		memorg->pages_per_eraseblock = type->erasesize /
					       type->pagesize;

>   		mtd->erasesize = type->erasesize;
> -		mtd->oobsize = type->oobsize;
> +		memorg->oobsize = type->oobsize;
> +		mtd->oobsize = memorg->oobsize;
>   
> +		memorg->bits_per_cell = nand_get_bits_per_cell(id_data[2]);
>   		chip->bits_per_cell = nand_get_bits_per_cell(id_data[2]);
>   		chip->chipsize = (uint64_t)type->chipsize << 20;
>   		chip->options |= type->options;
> @@ -4632,7 +4656,12 @@ static void nand_manufacturer_detect(struct nand_chip *chip)
>   	 */
>   	if (chip->manufacturer.desc && chip->manufacturer.desc->ops &&
>   	    chip->manufacturer.desc->ops->detect) {
> +		struct nand_memory_organization *memorg;
> +
> +		memorg = nanddev_get_memorg(&chip->base);
> +
>   		/* The 3rd id byte holds MLC / multichip data */
> +		memorg->bits_per_cell = nand_get_bits_per_cell(chip->id.data[2]);
>   		chip->bits_per_cell = nand_get_bits_per_cell(chip->id.data[2]);
>   		chip->manufacturer.desc->ops->detect(chip);
>   	} else {
> @@ -4682,10 +4711,20 @@ static int nand_detect(struct nand_chip *chip, struct nand_flash_dev *type)
>   {
>   	const struct nand_manufacturer *manufacturer;
>   	struct mtd_info *mtd = nand_to_mtd(chip);
> +	struct nand_memory_organization *memorg;
>   	int busw, ret;
>   	u8 *id_data = chip->id.data;
>   	u8 maf_id, dev_id;
>   
> +	/*
> +	 * Let's start by initializing memorg fields that might be left
> +	 * unassigned by the ID-based detection logic.
> +	 */
> +	memorg = nanddev_get_memorg(&chip->base);
> +	memorg->planes_per_lun = 1;
> +	memorg->luns_per_target = 1;
> +	memorg->ntargets = 1;
> +
>   	/*
>   	 * Reset the chip, required by some chips (e.g. Micron MT29FxGxxxxx)
>   	 * after power-up.
> @@ -4790,6 +4829,11 @@ static int nand_detect(struct nand_chip *chip, struct nand_flash_dev *type)
>   	/* Get chip options */
>   	chip->options |= type->options;
>   
> +	memorg->eraseblocks_per_lun =
> +			DIV_ROUND_DOWN_ULL((u64)type->chipsize << 20,
> +					   memorg->pagesize *
> +					   memorg->pages_per_eraseblock);
> +
>   ident_done:
>   	if (!mtd->name)
>   		mtd->name = chip->parameters.model;
> @@ -5016,10 +5060,13 @@ static int nand_scan_ident(struct nand_chip *chip, unsigned int maxchips,
>   			   struct nand_flash_dev *table)
>   {
>   	struct mtd_info *mtd = nand_to_mtd(chip);
> +	struct nand_memory_organization *memorg;
>   	int nand_maf_id, nand_dev_id;
>   	unsigned int i;
>   	int ret;
>   
> +	memorg = nanddev_get_memorg(&chip->base);
> +
>   	/* Assume all dies are deselected when we enter nand_scan_ident(). */
>   	chip->cur_cs = -1;
>   
> @@ -5081,6 +5128,7 @@ static int nand_scan_ident(struct nand_chip *chip, unsigned int maxchips,
>   		pr_info("%d chips detected\n", i);
>   
>   	/* Store the number of chips and calc total size for mtd */
> +	memorg->ntargets = i;
>   	chip->numchips = i;
>   	mtd->size = i * chip->chipsize;
>   
[...]
> --- a/drivers/mtd/nand/raw/nandsim.c
> +++ b/drivers/mtd/nand/raw/nandsim.c
> @@ -2302,6 +2302,11 @@ static int __init ns_init_module(void)
>   
>   	if (overridesize) {
>   		uint64_t new_size = (uint64_t)nsmtd->erasesize << overridesize;
> +		struct nand_memory_organization *memorg;
> +		u64 targetsize;

This variable is not used yet. It rather belongs into patch 13.

> +
> +		memorg = nanddev_get_memorg(&chip->base);
> +
>   		if (new_size >> overridesize != nsmtd->erasesize) {
>   			NS_ERR("overridesize is too big\n");
>   			retval = -EINVAL;
> @@ -2309,6 +2314,7 @@ static int __init ns_init_module(void)
>   		}
>   		/* N.B. This relies on nand_scan not doing anything with the size before we change it */
>   		nsmtd->size = new_size;
> +		memorg->eraseblocks_per_lun = 1 << overridesize;
>   		chip->chipsize = new_size;
>   		chip->chip_shift = ffs(nsmtd->erasesize) + overridesize - 1;
>   		chip->pagemask = (chip->chipsize >> chip->page_shift) - 1;
> 
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
