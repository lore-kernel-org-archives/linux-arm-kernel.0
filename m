Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1CBC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:01:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 672D320675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oKQsnhHq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 672D320675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tcKtjs0E1m7nB3vG4wIOvjbxRIyY+d0OAtO2h0bJEBM=; b=oKQsnhHqbpLMUE
	zlr7/XdosuAGlDKLGlhD5O5gJC+eaSzut24ZdrbN6PaZXP8pwTR0nQMKwaiKlKMLtob+byJsp5BX9
	m3tGwhhg1gX3+43+gOAmkZadu8p+0pd9ErIi4hIw2ymp6PrRIdapaoOM6UOypuIrkGQHjJLlyViwy
	a2oPc4FwUUcrtSg/8iOe0KVEI46T1EersPimiewL/wQ0rBO6M2gnhFnGdyYLgBSNGvnycj3VqHETX
	ZOPm/G+Hr4Fdm5AQFd4QyXn2UkxH8Jyrkz8QWCD4uhaTOyNTe+XytA1ilJWqfwy7+jbs2BPjzJFKV
	FZevjbYl8uQFPbww8mgw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxWvn-000435-HN; Sat, 23 Feb 2019 13:01:27 +0000
Received: from skedge03.snt-world.com ([91.208.41.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxWvj-00042f-LP; Sat, 23 Feb 2019 13:01:25 +0000
Received: from sntmail12r.snt-is.com (unknown [10.203.32.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by skedge03.snt-world.com (Postfix) with ESMTPS id 49A2460B8F1;
 Sat, 23 Feb 2019 14:01:20 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail12r.snt-is.com
 (10.203.32.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 23 Feb
 2019 14:01:19 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Sat, 23 Feb 2019 14:01:19 +0100
From: Schrempf Frieder <frieder.schrempf@kontron.de>
To: Miquel Raynal <miquel.raynal@bootlin.com>, Boris Brezillon
 <bbrezillon@kernel.org>, Richard Weinberger <richard@nod.at>, David Woodhouse
 <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, "Marek
 Vasut" <marek.vasut@gmail.com>, Tudor Ambarus <Tudor.Ambarus@microchip.com>
Subject: Re: [PATCH 13/15] mtd: rawnand: Get rid of chip->chipsize
Thread-Topic: [PATCH 13/15] mtd: rawnand: Get rid of chip->chipsize
Thread-Index: AQHUycbp37zRMqkWC0alrcXfLCsAJKXtS2uA
Date: Sat, 23 Feb 2019 13:01:19 +0000
Message-ID: <fd48669d-fe1f-b455-231c-e5f9a798d201@kontron.de>
References: <20190221091527.20497-1-miquel.raynal@bootlin.com>
 <20190221091527.20497-14-miquel.raynal@bootlin.com>
In-Reply-To: <20190221091527.20497-14-miquel.raynal@bootlin.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.43]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-ID: <714383B8744D0C40ABB29DB2175285A0@snt-world.com>
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 49A2460B8F1.AFBD2
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
X-CRM114-CacheID: sfid-20190223_050124_019951_1F85E043 
X-CRM114-Status: GOOD (  18.69  )
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
> The target size can now be returned by nanddev_get_targetsize(). Get
> rid of the chip->chipsize field and use this helper instead.
> 
> Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>   .../mtd/nand/raw/bcm47xxnflash/ops_bcm4706.c  |  2 +-
>   drivers/mtd/nand/raw/denali.c                 |  1 -
>   drivers/mtd/nand/raw/fsl_elbc_nand.c          |  2 +-
>   drivers/mtd/nand/raw/fsl_ifc_nand.c           |  2 +-
>   drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c    |  2 +-
>   drivers/mtd/nand/raw/jz4740_nand.c            |  2 +-
>   drivers/mtd/nand/raw/nand_base.c              | 21 +++++++++-------
>   drivers/mtd/nand/raw/nand_bbt.c               | 25 ++++++++++++-------
>   drivers/mtd/nand/raw/nand_jedec.c             |  2 --
>   drivers/mtd/nand/raw/nand_onfi.c              |  2 --
>   drivers/mtd/nand/raw/nandsim.c                |  5 ++--
>   drivers/mtd/nand/raw/sh_flctl.c               |  9 ++++---
>   include/linux/mtd/rawnand.h                   |  2 --
>   13 files changed, 41 insertions(+), 36 deletions(-)
> 
[...]
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index 00fe124fcb44..674505a0021c 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -4587,7 +4587,10 @@ static bool find_full_id_nand(struct nand_chip *chip,
>   		mtd->oobsize = memorg->oobsize;
>   
>   		memorg->bits_per_cell = nand_get_bits_per_cell(id_data[2]);
> -		chip->chipsize = (uint64_t)type->chipsize << 20;
> +		memorg->eraseblocks_per_lun =
> +			DIV_ROUND_DOWN_ULL((u64)type->chipsize << 20,
> +					   memorg->pagesize *
> +					   memorg->pages_per_eraseblock);

Shouldn't the assignment of memorg->eraseblocks_per_lun here already be 
part of patch 7?

>   		chip->options |= type->options;
>   		chip->ecc_strength_ds = NAND_ECC_STRENGTH(type);
>   		chip->ecc_step_ds = NAND_ECC_STEP(type);
> @@ -4674,6 +4677,7 @@ static int nand_detect(struct nand_chip *chip, struct nand_flash_dev *type)
>   	int busw, ret;
>   	u8 *id_data = chip->id.data;
>   	u8 maf_id, dev_id;
> +	u64 targetsize;
>   
>   	/*
>   	 * Let's start by initializing memorg fields that might be left
> @@ -4778,8 +4782,6 @@ static int nand_detect(struct nand_chip *chip, struct nand_flash_dev *type)
>   	if (!chip->parameters.model)
>   		return -ENOMEM;
>   
> -	chip->chipsize = (uint64_t)type->chipsize << 20;
> -
>   	if (!type->pagesize)
>   		nand_manufacturer_detect(chip);
>   	else
> @@ -4821,14 +4823,15 @@ static int nand_detect(struct nand_chip *chip, struct nand_flash_dev *type)
>   	/* Calculate the address shift from the page size */
>   	chip->page_shift = ffs(mtd->writesize) - 1;
>   	/* Convert chipsize to number of pages per chip -1 */
> -	chip->pagemask = (chip->chipsize >> chip->page_shift) - 1;
> +	targetsize = nanddev_target_size(&chip->base);
> +	chip->pagemask = (targetsize >> chip->page_shift) - 1;
>   
>   	chip->bbt_erase_shift = chip->phys_erase_shift =
>   		ffs(mtd->erasesize) - 1;
> -	if (chip->chipsize & 0xffffffff)
> -		chip->chip_shift = ffs((unsigned)chip->chipsize) - 1;
> +	if (targetsize & 0xffffffff)
> +		chip->chip_shift = ffs((unsigned)targetsize) - 1;
>   	else {
> -		chip->chip_shift = ffs((unsigned)(chip->chipsize >> 32));
> +		chip->chip_shift = ffs((unsigned)(targetsize >> 32));
>   		chip->chip_shift += 32 - 1;
>   	}
>   
> @@ -4844,7 +4847,7 @@ static int nand_detect(struct nand_chip *chip, struct nand_flash_dev *type)
>   	pr_info("%s %s\n", nand_manufacturer_name(manufacturer),
>   		chip->parameters.model);
>   	pr_info("%d MiB, %s, erase size: %d KiB, page size: %d, OOB size: %d\n",
> -		(int)(chip->chipsize >> 20), nand_is_slc(chip) ? "SLC" : "MLC",
> +		(int)(targetsize >> 20), nand_is_slc(chip) ? "SLC" : "MLC",
>   		mtd->erasesize >> 10, mtd->writesize, mtd->oobsize);
>   	return 0;
>   
> @@ -5089,7 +5092,7 @@ static int nand_scan_ident(struct nand_chip *chip, unsigned int maxchips,
>   	/* Store the number of chips and calc total size for mtd */
>   	memorg->ntargets = i;
>   	chip->numchips = i;
> -	mtd->size = i * chip->chipsize;
> +	mtd->size = i * nanddev_target_size(&chip->base);
>   
>   	return 0;
>   }
[...]
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
