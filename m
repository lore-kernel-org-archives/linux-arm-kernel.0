Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FD6C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:04:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7CBC20675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tAgf3H77"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7CBC20675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WEiqVeq2Zfa/tw0KAabpSyJDw6wJ+wbTkNrllSa7f0Y=; b=tAgf3H77TCg38x
	TOwF15W8di1d2l9SlI5w41ROvNbFKcG9yMv/nF4eIvrysCEHT/trucwZ+mi81tMB657JHMm1IYQmM
	iD6YDL6W2jOPmNYERruT1GE0BWTwC180GS46RoTmxFfB2fzwOvpKCdnQV7xXgAL65MMhl3zqT2TBs
	Nb21bL6jPOnoqzMKrB1VSMe1Vc9FFeqtxOlzPn6dNm5H/lw4Mh3q/VvsxsXizukfOsGOgyB0bDHRR
	IPyITmGVxspK4JTW+QyyiikFySenjOpD8hK/MmaZNKsV4ZmSVCUff/vXOK1AQ6xuu4fzGkS2omcza
	pNoSEZeJ5e6ngh8/LEbw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxWyC-0004wu-MW; Sat, 23 Feb 2019 13:03:56 +0000
Received: from skedge03.snt-world.com ([91.208.41.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxWy8-0004wU-QW; Sat, 23 Feb 2019 13:03:54 +0000
Received: from sntmail14r.snt-is.com (unknown [10.203.32.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by skedge03.snt-world.com (Postfix) with ESMTPS id 9182460B8F4;
 Sat, 23 Feb 2019 14:03:50 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail14r.snt-is.com
 (10.203.32.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 23 Feb
 2019 14:03:50 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Sat, 23 Feb 2019 14:03:50 +0100
From: Schrempf Frieder <frieder.schrempf@kontron.de>
To: Miquel Raynal <miquel.raynal@bootlin.com>, Boris Brezillon
 <bbrezillon@kernel.org>, Richard Weinberger <richard@nod.at>, David Woodhouse
 <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, "Marek
 Vasut" <marek.vasut@gmail.com>, Tudor Ambarus <Tudor.Ambarus@microchip.com>
Subject: Re: [PATCH 01/15] mtd: nand: Add max_bad_eraseblocks_per_lun info to
 memorg
Thread-Topic: [PATCH 01/15] mtd: nand: Add max_bad_eraseblocks_per_lun info to
 memorg
Thread-Index: AQHUycZQSdEBI9YvP0mHhYRCPXh82qXtTB+A
Date: Sat, 23 Feb 2019 13:03:50 +0000
Message-ID: <28f2aaea-6821-0bdd-ee2b-611f9f76e3a4@kontron.de>
References: <20190221091527.20497-1-miquel.raynal@bootlin.com>
 <20190221091527.20497-2-miquel.raynal@bootlin.com>
In-Reply-To: <20190221091527.20497-2-miquel.raynal@bootlin.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.43]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-ID: <1905F3D678E1F04F9B3CC758440C1FEA@snt-world.com>
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 9182460B8F4.A0082
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
X-CRM114-CacheID: sfid-20190223_050353_191041_44B33CC5 
X-CRM114-Status: GOOD (  22.96  )
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
> NAND datasheets usually give the maximum number of bad blocks per LUN
> and this number can be used to help upper layers decide how much blocks
> they should reserve for bad block handling.
> 
> Add a max_bad_eraseblocks_per_lun to the nand_memory_organization
> struct and update the NAND_MEMORG() macro (and its users) accordingly.
> 
> We also provide a default mtd->_max_bad_blocks() implementation.
> 
> Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

> ---
>   drivers/mtd/nand/core.c           | 34 +++++++++++++++++++++++++++++++
>   drivers/mtd/nand/spi/gigadevice.c |  6 +++---
>   drivers/mtd/nand/spi/macronix.c   |  4 ++--
>   drivers/mtd/nand/spi/micron.c     |  2 +-
>   drivers/mtd/nand/spi/toshiba.c    |  2 +-
>   drivers/mtd/nand/spi/winbond.c    |  4 ++--
>   include/linux/mtd/nand.h          |  6 +++++-
>   7 files changed, 48 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/mtd/nand/core.c b/drivers/mtd/nand/core.c
> index e6554b401813..0a2be5e6d669 100644
> --- a/drivers/mtd/nand/core.c
> +++ b/drivers/mtd/nand/core.c
> @@ -173,6 +173,40 @@ int nanddev_mtd_erase(struct mtd_info *mtd, struct erase_info *einfo)
>   }
>   EXPORT_SYMBOL_GPL(nanddev_mtd_erase);
>   
> +/**
> + * nanddev_mtd_max_bad_blocks() - Get the maximum number of bad eraseblock on
> + *				  a specific region of the NAND device
> + * @mtd: MTD device
> + * @offs: offset of the NAND region
> + * @len: length of the NAND region
> + *
> + * Default implementation for mtd->_max_bad_blocks(). Only works if
> + * nand->memorg.max_bad_eraseblocks_per_lun is > 0.
> + *
> + * Return: a positive number encoding the maximum number of eraseblocks on a
> + * portion of memory, a negative error code otherwise.
> + */
> +int nanddev_mtd_max_bad_blocks(struct mtd_info *mtd, loff_t offs, size_t len)
> +{
> +	struct nand_device *nand = mtd_to_nanddev(mtd);
> +	struct nand_pos pos, end;
> +	unsigned int max_bb = 0;
> +
> +	if (!nand->memorg.max_bad_eraseblocks_per_lun)
> +		return -ENOTSUPP;
> +
> +	nanddev_offs_to_pos(nand, offs, &pos);
> +	nanddev_offs_to_pos(nand, offs + len, &end);
> +
> +	for (nanddev_offs_to_pos(nand, offs, &pos);
> +	     nanddev_pos_cmp(&pos, &end) < 0;
> +	     nanddev_pos_next_lun(nand, &pos))
> +		max_bb += nand->memorg.max_bad_eraseblocks_per_lun;
> +
> +	return max_bb;
> +}
> +EXPORT_SYMBOL_GPL(nanddev_mtd_max_bad_blocks);
> +
>   /**
>    * nanddev_init() - Initialize a NAND device
>    * @nand: NAND device
> diff --git a/drivers/mtd/nand/spi/gigadevice.c b/drivers/mtd/nand/spi/gigadevice.c
> index e4141c20947a..c434fbed3ce5 100644
> --- a/drivers/mtd/nand/spi/gigadevice.c
> +++ b/drivers/mtd/nand/spi/gigadevice.c
> @@ -88,7 +88,7 @@ static const struct mtd_ooblayout_ops gd5fxgq4xa_ooblayout = {
>   
>   static const struct spinand_info gigadevice_spinand_table[] = {
>   	SPINAND_INFO("GD5F1GQ4xA", 0xF1,
> -		     NAND_MEMORG(1, 2048, 64, 64, 1024, 1, 1, 1),
> +		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
>   		     NAND_ECCREQ(8, 512),
>   		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>   					      &write_cache_variants,
> @@ -97,7 +97,7 @@ static const struct spinand_info gigadevice_spinand_table[] = {
>   		     SPINAND_ECCINFO(&gd5fxgq4xa_ooblayout,
>   				     gd5fxgq4xa_ecc_get_status)),
>   	SPINAND_INFO("GD5F2GQ4xA", 0xF2,
> -		     NAND_MEMORG(1, 2048, 64, 64, 2048, 1, 1, 1),
> +		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 1, 1, 1),
>   		     NAND_ECCREQ(8, 512),
>   		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>   					      &write_cache_variants,
> @@ -106,7 +106,7 @@ static const struct spinand_info gigadevice_spinand_table[] = {
>   		     SPINAND_ECCINFO(&gd5fxgq4xa_ooblayout,
>   				     gd5fxgq4xa_ecc_get_status)),
>   	SPINAND_INFO("GD5F4GQ4xA", 0xF4,
> -		     NAND_MEMORG(1, 2048, 64, 64, 4096, 1, 1, 1),
> +		     NAND_MEMORG(1, 2048, 64, 64, 4096, 40, 1, 1, 1),
>   		     NAND_ECCREQ(8, 512),
>   		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>   					      &write_cache_variants,
> diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macronix.c
> index 98f6b9c4b684..c6300d9d63f9 100644
> --- a/drivers/mtd/nand/spi/macronix.c
> +++ b/drivers/mtd/nand/spi/macronix.c
> @@ -94,7 +94,7 @@ static int mx35lf1ge4ab_ecc_get_status(struct spinand_device *spinand,
>   
>   static const struct spinand_info macronix_spinand_table[] = {
>   	SPINAND_INFO("MX35LF1GE4AB", 0x12,
> -		     NAND_MEMORG(1, 2048, 64, 64, 1024, 1, 1, 1),
> +		     NAND_MEMORG(1, 2048, 64, 64, 1024, 40, 1, 1, 1),
>   		     NAND_ECCREQ(4, 512),
>   		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>   					      &write_cache_variants,
> @@ -103,7 +103,7 @@ static const struct spinand_info macronix_spinand_table[] = {
>   		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
>   				     mx35lf1ge4ab_ecc_get_status)),
>   	SPINAND_INFO("MX35LF2GE4AB", 0x22,
> -		     NAND_MEMORG(1, 2048, 64, 64, 2048, 2, 1, 1),
> +		     NAND_MEMORG(1, 2048, 64, 64, 2048, 20, 2, 1, 1),
>   		     NAND_ECCREQ(4, 512),
>   		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>   					      &write_cache_variants,
> diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
> index 9c4381d6847b..7d7b1f7fcf71 100644
> --- a/drivers/mtd/nand/spi/micron.c
> +++ b/drivers/mtd/nand/spi/micron.c
> @@ -92,7 +92,7 @@ static int mt29f2g01abagd_ecc_get_status(struct spinand_device *spinand,
>   
>   static const struct spinand_info micron_spinand_table[] = {
>   	SPINAND_INFO("MT29F2G01ABAGD", 0x24,
> -		     NAND_MEMORG(1, 2048, 128, 64, 2048, 2, 1, 1),
> +		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 2, 1, 1),
>   		     NAND_ECCREQ(8, 512),
>   		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>   					      &write_cache_variants,
> diff --git a/drivers/mtd/nand/spi/toshiba.c b/drivers/mtd/nand/spi/toshiba.c
> index 081265557e70..00ddab08e6c6 100644
> --- a/drivers/mtd/nand/spi/toshiba.c
> +++ b/drivers/mtd/nand/spi/toshiba.c
> @@ -95,7 +95,7 @@ static int tc58cvg2s0h_ecc_get_status(struct spinand_device *spinand,
>   
>   static const struct spinand_info toshiba_spinand_table[] = {
>   	SPINAND_INFO("TC58CVG2S0H", 0xCD,
> -		     NAND_MEMORG(1, 4096, 256, 64, 2048, 1, 1, 1),
> +		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
>   		     NAND_ECCREQ(8, 512),
>   		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>   					      &write_cache_variants,
> diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
> index 5d944580b898..a6c17e0cace8 100644
> --- a/drivers/mtd/nand/spi/winbond.c
> +++ b/drivers/mtd/nand/spi/winbond.c
> @@ -76,7 +76,7 @@ static int w25m02gv_select_target(struct spinand_device *spinand,
>   
>   static const struct spinand_info winbond_spinand_table[] = {
>   	SPINAND_INFO("W25M02GV", 0xAB,
> -		     NAND_MEMORG(1, 2048, 64, 64, 1024, 1, 1, 2),
> +		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 2),
>   		     NAND_ECCREQ(1, 512),
>   		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>   					      &write_cache_variants,
> @@ -85,7 +85,7 @@ static const struct spinand_info winbond_spinand_table[] = {
>   		     SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL),
>   		     SPINAND_SELECT_TARGET(w25m02gv_select_target)),
>   	SPINAND_INFO("W25N01GV", 0xAA,
> -		     NAND_MEMORG(1, 2048, 64, 64, 1024, 1, 1, 1),
> +		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
>   		     NAND_ECCREQ(1, 512),
>   		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>   					      &write_cache_variants,
> diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
> index 7f53ece2c039..d32bb623d532 100644
> --- a/include/linux/mtd/nand.h
> +++ b/include/linux/mtd/nand.h
> @@ -19,6 +19,7 @@
>    * @oobsize: OOB area size
>    * @pages_per_eraseblock: number of pages per eraseblock
>    * @eraseblocks_per_lun: number of eraseblocks per LUN (Logical Unit Number)
> + * @max_bad_eraseblocks_per_lun: maximum number of eraseblocks per LUN
>    * @planes_per_lun: number of planes per LUN
>    * @luns_per_target: number of LUN per target (target is a synonym for die)
>    * @ntargets: total number of targets exposed by the NAND device
> @@ -29,18 +30,20 @@ struct nand_memory_organization {
>   	unsigned int oobsize;
>   	unsigned int pages_per_eraseblock;
>   	unsigned int eraseblocks_per_lun;
> +	unsigned int max_bad_eraseblocks_per_lun;
>   	unsigned int planes_per_lun;
>   	unsigned int luns_per_target;
>   	unsigned int ntargets;
>   };
>   
> -#define NAND_MEMORG(bpc, ps, os, ppe, epl, ppl, lpt, nt)	\
> +#define NAND_MEMORG(bpc, ps, os, ppe, epl, mbb, ppl, lpt, nt)	\
>   	{							\
>   		.bits_per_cell = (bpc),				\
>   		.pagesize = (ps),				\
>   		.oobsize = (os),				\
>   		.pages_per_eraseblock = (ppe),			\
>   		.eraseblocks_per_lun = (epl),			\
> +		.max_bad_eraseblocks_per_lun = (mbb),		\
>   		.planes_per_lun = (ppl),			\
>   		.luns_per_target = (lpt),			\
>   		.ntargets = (nt),				\
> @@ -729,5 +732,6 @@ static inline bool nanddev_bbt_is_initialized(struct nand_device *nand)
>   
>   /* MTD -> NAND helper functions. */
>   int nanddev_mtd_erase(struct mtd_info *mtd, struct erase_info *einfo);
> +int nanddev_mtd_max_bad_blocks(struct mtd_info *mtd, loff_t offs, size_t len);
>   
>   #endif /* __LINUX_MTD_NAND_H */
> 
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
