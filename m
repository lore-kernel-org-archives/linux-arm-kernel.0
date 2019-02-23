Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1503C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:20:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D5F72084F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r2rlSIln"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D5F72084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2GmGA7jWWKZ7QTh6dZRNf7yb7OAte3RW1P+orSub67A=; b=r2rlSIlnHb1pPF
	1b/idPzk60DCud68tfb58c/+vfIWbDXfjIvqx9uA0gzTU1k7mrhLpEErVBZko8YVTLtirXkLwrLy/
	XBjmzNFGS7CMLWEfr0ZuDfbtgFxCHQw3HN/vQ39xdRHBBU8H4XLRC/TpBl9bIJCe8f3ugj1opSqRw
	54hJqBMz2vImRUaInnjrUJ5umFdXVfpNGM9uwqsrYpiBL9wEDw2vZiMSSG6wfJSL8VtZdqM56uYC7
	KpWDUbdynS3D4v2Doa2SWfAM1b9p1ER4dYG55M2JyOaLQrYaQe3MSCgz7YSvVqQvdOnOzGFV8aeFY
	5OKJHSHDwLSlD05rsNXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxXDu-0002Su-Jw; Sat, 23 Feb 2019 13:20:10 +0000
Received: from skedge04.snt-world.com ([91.208.41.69])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxXDq-00020i-Sz; Sat, 23 Feb 2019 13:20:08 +0000
Received: from sntmail12r.snt-is.com (unknown [10.203.32.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by skedge04.snt-world.com (Postfix) with ESMTPS id 9806867A7D4;
 Sat, 23 Feb 2019 14:20:04 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail12r.snt-is.com
 (10.203.32.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 23 Feb
 2019 14:20:04 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Sat, 23 Feb 2019 14:20:04 +0100
From: Schrempf Frieder <frieder.schrempf@kontron.de>
To: Miquel Raynal <miquel.raynal@bootlin.com>, Boris Brezillon
 <bbrezillon@kernel.org>, Richard Weinberger <richard@nod.at>, David Woodhouse
 <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, "Marek
 Vasut" <marek.vasut@gmail.com>, Tudor Ambarus <Tudor.Ambarus@microchip.com>
Subject: Re: [PATCH 08/15] mtd: rawnand: Initialize the nand_device object
Thread-Topic: [PATCH 08/15] mtd: rawnand: Initialize the nand_device object
Thread-Index: AQHUycZhBmLIPJoXaEinc4gZs5zUB6XtUKiA
Date: Sat, 23 Feb 2019 13:20:04 +0000
Message-ID: <203a9ef5-1469-9d1f-bfa1-64070b4dbb01@kontron.de>
References: <20190221091527.20497-1-miquel.raynal@bootlin.com>
 <20190221091527.20497-9-miquel.raynal@bootlin.com>
In-Reply-To: <20190221091527.20497-9-miquel.raynal@bootlin.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.43]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-ID: <947F45F9B836CA41945648A4912CC4B1@snt-world.com>
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 9806867A7D4.AE9F4
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
X-CRM114-CacheID: sfid-20190223_052007_267181_9202D206 
X-CRM114-Status: GOOD (  24.17  )
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
> In order to use some of the nanddev_xxx() helpers, we need to
> initialize the nand_device object embedded in nand_chip using
> nanddev_init(). This requires implementing nand_ops.
> 
> We also drop useless mtd->xxx initialization when they're already taken
> case of by nanddev_init().
> 
> Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

> ---
>   drivers/mtd/nand/raw/Kconfig     |  1 +
>   drivers/mtd/nand/raw/nand_base.c | 65 ++++++++++++++++++++++++++++----
>   2 files changed, 59 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> index 1a55d3e3d4c5..8c38f2c116a2 100644
> --- a/drivers/mtd/nand/raw/Kconfig
> +++ b/drivers/mtd/nand/raw/Kconfig
> @@ -14,6 +14,7 @@ menuconfig MTD_NAND
>   	tristate "Raw/Parallel NAND Device Support"
>   	depends on MTD
>   	select MTD_NAND_ECC
> +	select MTD_NAND_CORE
>   	help
>   	  This enables support for accessing all type of raw/parallel
>   	  NAND flash devices. For further information see
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index cb03877c775c..e8c1ad17f3c6 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -5519,6 +5519,50 @@ static bool nand_ecc_strength_good(struct nand_chip *chip)
>   	return corr >= ds_corr && ecc->strength >= chip->ecc_strength_ds;
>   }
>   
> +static int rawnand_erase(struct nand_device *nand, const struct nand_pos *pos)
> +{
> +	struct nand_chip *chip = container_of(nand, struct nand_chip,
> +					      base);
> +	unsigned int eb = nanddev_pos_to_row(nand, pos);
> +	int ret;
> +
> +	eb >>= nand->rowconv.eraseblock_addr_shift;
> +
> +	nand_select_target(chip, pos->target);
> +	ret = nand_erase_op(chip, eb);
> +	nand_deselect_target(chip);
> +
> +	return ret;
> +}
> +
> +static int rawnand_markbad(struct nand_device *nand,
> +			   const struct nand_pos *pos)
> +{
> +	struct nand_chip *chip = container_of(nand, struct nand_chip,
> +					      base);
> +
> +	return nand_markbad_bbm(chip, nanddev_pos_to_offs(nand, pos));
> +}
> +
> +static bool rawnand_isbad(struct nand_device *nand, const struct nand_pos *pos)
> +{
> +	struct nand_chip *chip = container_of(nand, struct nand_chip,
> +					      base);
> +	int ret;
> +
> +	nand_select_target(chip, pos->target);
> +	ret = nand_isbad_bbm(chip, nanddev_pos_to_offs(nand, pos));
> +	nand_deselect_target(chip);
> +
> +	return ret;
> +}
> +
> +static const struct nand_ops rawnand_ops = {
> +	.erase = rawnand_erase,
> +	.markbad = rawnand_markbad,
> +	.isbad = rawnand_isbad,
> +};
> +
>   /**
>    * nand_scan_tail - Scan for the NAND device
>    * @chip: NAND chip object
> @@ -5787,10 +5831,15 @@ static int nand_scan_tail(struct nand_chip *chip)
>   		break;
>   	}
>   
> +	ret = nanddev_init(&chip->base, &rawnand_ops, mtd->owner);
> +	if (ret)
> +		goto err_nand_manuf_cleanup;
> +
> +	/* Adjust the MTD_CAP_ flags when NAND_ROM is set. */
> +	if (chip->options & NAND_ROM)
> +		mtd->flags = MTD_CAP_ROM;
> +
>   	/* Fill in remaining MTD driver data */
> -	mtd->type = nand_is_slc(chip) ? MTD_NANDFLASH : MTD_MLCNANDFLASH;
> -	mtd->flags = (chip->options & NAND_ROM) ? MTD_CAP_ROM :
> -						MTD_CAP_NANDFLASH;
>   	mtd->_erase = nand_erase;
>   	mtd->_point = NULL;
>   	mtd->_unpoint = NULL;
> @@ -5807,7 +5856,6 @@ static int nand_scan_tail(struct nand_chip *chip)
>   	mtd->_block_isbad = nand_block_isbad;
>   	mtd->_block_markbad = nand_block_markbad;
>   	mtd->_max_bad_blocks = nand_max_bad_blocks;
> -	mtd->writebufsize = mtd->writesize;
>   
>   	/*
>   	 * Initialize bitflip_threshold to its default prior scan_bbt() call.
> @@ -5820,13 +5868,13 @@ static int nand_scan_tail(struct nand_chip *chip)
>   	/* Initialize the ->data_interface field. */
>   	ret = nand_init_data_interface(chip);
>   	if (ret)
> -		goto err_nand_manuf_cleanup;
> +		goto err_nanddev_cleanup;
>   
>   	/* Enter fastest possible mode on all dies. */
>   	for (i = 0; i < chip->numchips; i++) {
>   		ret = nand_setup_data_interface(chip, i);
>   		if (ret)
> -			goto err_nand_manuf_cleanup;
> +			goto err_nanddev_cleanup;
>   	}
>   
>   	/* Check, if we should skip the bad block table scan */
> @@ -5836,11 +5884,14 @@ static int nand_scan_tail(struct nand_chip *chip)
>   	/* Build bad block table */
>   	ret = nand_create_bbt(chip);
>   	if (ret)
> -		goto err_nand_manuf_cleanup;
> +		goto err_nanddev_cleanup;
>   
>   	return 0;
>   
>   
> +err_nanddev_cleanup:
> +	nanddev_cleanup(&chip->base);
> +
>   err_nand_manuf_cleanup:
>   	nand_manufacturer_cleanup(chip);
>   
> 
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
