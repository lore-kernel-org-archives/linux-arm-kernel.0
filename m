Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A63C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:15:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB5D62084F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UcnrTyA1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB5D62084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZHX8h58LPMQApAYWGERA7XCX0D/mundZwev6rH1dd4E=; b=UcnrTyA1SFS/b4
	4qyIae6rQDZ9tC58iudfpjNbzGXpvharsXIs8JG+dQT5p9+t6327qJqG4IA6tPkdm7A8qCcZLXJyQ
	jgg9RZqIuXOS5U1o93Dlx03hhdRCFgGGf8YuTvG2EWApIPZC+BsxUnh408X5g4AL2w1ckSKGdpsIJ
	bSras+IuHQWTiF4PKkMLLAyKm5GLK46b00fH/aFxacacSVoflByfXa8rrgJ7kxjMz5a3PUjHaf4pE
	807jCProF2g6u7f0c8JF/1S8icsgz3n3e6mURdWeHcEP0kifn+OU40+BqIPyPlEHilK8sA3puIbuT
	YWfxW+p2+hcGj1Agf85w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxX93-0007Uo-SG; Sat, 23 Feb 2019 13:15:09 +0000
Received: from skedge03.snt-world.com ([91.208.41.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxX8y-0006ia-GZ; Sat, 23 Feb 2019 13:15:07 +0000
Received: from sntmail11s.snt-is.com (unknown [10.203.32.181])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by skedge03.snt-world.com (Postfix) with ESMTPS id 7A66562E569;
 Sat, 23 Feb 2019 14:15:01 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail11s.snt-is.com
 (10.203.32.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 23 Feb
 2019 14:15:01 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Sat, 23 Feb 2019 14:15:01 +0100
From: Schrempf Frieder <frieder.schrempf@kontron.de>
To: Miquel Raynal <miquel.raynal@bootlin.com>, Boris Brezillon
 <bbrezillon@kernel.org>, Richard Weinberger <richard@nod.at>, David Woodhouse
 <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, "Marek
 Vasut" <marek.vasut@gmail.com>, Tudor Ambarus <Tudor.Ambarus@microchip.com>
Subject: Re: [PATCH 14/15] mtd: rawnand: Get rid of chip->numchips
Thread-Topic: [PATCH 14/15] mtd: rawnand: Get rid of chip->numchips
Thread-Index: AQHUycbl5BOVCdzaQ0OibrDfNdAmQaXtTz0A
Date: Sat, 23 Feb 2019 13:15:00 +0000
Message-ID: <e2aab23b-73bb-808a-97ed-1ce70f5ee603@kontron.de>
References: <20190221091527.20497-1-miquel.raynal@bootlin.com>
 <20190221091527.20497-15-miquel.raynal@bootlin.com>
In-Reply-To: <20190221091527.20497-15-miquel.raynal@bootlin.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.43]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-ID: <032A330906455A499B0659FADE70792D@snt-world.com>
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 7A66562E569.A0353
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
X-CRM114-CacheID: sfid-20190223_051504_986968_2BE95EA3 
X-CRM114-Status: GOOD (  25.83  )
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
> The same information is provided by nanddev_ntargets().
> 
> Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

> ---
>   drivers/mtd/nand/raw/diskonchip.c    |  2 +-
>   drivers/mtd/nand/raw/fsl_elbc_nand.c |  2 +-
>   drivers/mtd/nand/raw/fsl_ifc_nand.c  |  2 +-
>   drivers/mtd/nand/raw/hisi504_nand.c  |  2 +-
>   drivers/mtd/nand/raw/internals.h     |  2 +-
>   drivers/mtd/nand/raw/jz4740_nand.c   |  1 -
>   drivers/mtd/nand/raw/nand_base.c     | 15 ++++-----------
>   drivers/mtd/nand/raw/nand_bbt.c      | 16 ++++++++--------
>   include/linux/mtd/rawnand.h          |  7 +++----
>   9 files changed, 20 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/diskonchip.c b/drivers/mtd/nand/raw/diskonchip.c
> index e9767e06415d..3cee832716ec 100644
> --- a/drivers/mtd/nand/raw/diskonchip.c
> +++ b/drivers/mtd/nand/raw/diskonchip.c
> @@ -1291,7 +1291,7 @@ static int __init inftl_scan_bbt(struct mtd_info *mtd)
>   	struct doc_priv *doc = nand_get_controller_data(this);
>   	struct mtd_partition parts[5];
>   
> -	if (this->numchips > doc->chips_per_floor) {
> +	if (nanddev_ntargets(&this->base) > doc->chips_per_floor) {
>   		pr_err("Multi-floor INFTL devices not yet supported.\n");
>   		return -EIO;
>   	}
> diff --git a/drivers/mtd/nand/raw/fsl_elbc_nand.c b/drivers/mtd/nand/raw/fsl_elbc_nand.c
> index 1d960a6cd691..293a5b71833a 100644
> --- a/drivers/mtd/nand/raw/fsl_elbc_nand.c
> +++ b/drivers/mtd/nand/raw/fsl_elbc_nand.c
> @@ -653,7 +653,7 @@ static int fsl_elbc_attach_chip(struct nand_chip *chip)
>   	priv->fmr |= al << FMR_AL_SHIFT;
>   
>   	dev_dbg(priv->dev, "fsl_elbc_init: nand->numchips = %d\n",
> -	        chip->numchips);
> +	        nanddev_ntargets(&chip->base));
>   	dev_dbg(priv->dev, "fsl_elbc_init: nand->chipsize = %lld\n",
>   	        nanddev_target_size(&chip->base));
>   	dev_dbg(priv->dev, "fsl_elbc_init: nand->pagemask = %8x\n",
> diff --git a/drivers/mtd/nand/raw/fsl_ifc_nand.c b/drivers/mtd/nand/raw/fsl_ifc_nand.c
> index a9e8f89aeebd..04a3dcd675bf 100644
> --- a/drivers/mtd/nand/raw/fsl_ifc_nand.c
> +++ b/drivers/mtd/nand/raw/fsl_ifc_nand.c
> @@ -722,7 +722,7 @@ static int fsl_ifc_attach_chip(struct nand_chip *chip)
>   	struct fsl_ifc_mtd *priv = nand_get_controller_data(chip);
>   
>   	dev_dbg(priv->dev, "%s: nand->numchips = %d\n", __func__,
> -							chip->numchips);
> +		nanddev_ntargets(&chip->base));
>   	dev_dbg(priv->dev, "%s: nand->chipsize = %lld\n", __func__,
>   	        nanddev_target_size(&chip->base));
>   	dev_dbg(priv->dev, "%s: nand->pagemask = %8x\n", __func__,
> diff --git a/drivers/mtd/nand/raw/hisi504_nand.c b/drivers/mtd/nand/raw/hisi504_nand.c
> index f3f9aa160cff..e4526fff9da4 100644
> --- a/drivers/mtd/nand/raw/hisi504_nand.c
> +++ b/drivers/mtd/nand/raw/hisi504_nand.c
> @@ -849,7 +849,7 @@ static int hisi_nfc_resume(struct device *dev)
>   	struct hinfc_host *host = dev_get_drvdata(dev);
>   	struct nand_chip *chip = &host->chip;
>   
> -	for (cs = 0; cs < chip->numchips; cs++)
> +	for (cs = 0; cs < nanddev_ntargets(&chip->base); cs++)
>   		hisi_nfc_send_cmd_reset(host, cs);
>   	hinfc_write(host, SET_HINFC504_PWIDTH(HINFC504_W_LATCH,
>   		    HINFC504_R_LATCH, HINFC504_RW_LATCH), HINFC504_PWIDTH);
> diff --git a/drivers/mtd/nand/raw/internals.h b/drivers/mtd/nand/raw/internals.h
> index fbf6ca015cd7..a204f9d7e123 100644
> --- a/drivers/mtd/nand/raw/internals.h
> +++ b/drivers/mtd/nand/raw/internals.h
> @@ -110,7 +110,7 @@ static inline int nand_exec_op(struct nand_chip *chip,
>   	if (!nand_has_exec_op(chip))
>   		return -ENOTSUPP;
>   
> -	if (WARN_ON(op->cs >= chip->numchips))
> +	if (WARN_ON(op->cs >= nanddev_ntargets(&chip->base)))
>   		return -EINVAL;
>   
>   	return chip->controller->ops->exec_op(chip, op, false);
> diff --git a/drivers/mtd/nand/raw/jz4740_nand.c b/drivers/mtd/nand/raw/jz4740_nand.c
> index 06690b3603b1..c992a664bdee 100644
> --- a/drivers/mtd/nand/raw/jz4740_nand.c
> +++ b/drivers/mtd/nand/raw/jz4740_nand.c
> @@ -354,7 +354,6 @@ static int jz_nand_detect_bank(struct platform_device *pdev,
>   		}
>   
>   		/* Update size of the MTD. */
> -		chip->numchips++;
>   		memorg->ntargets++;
>   		mtd->size += nanddev_target_size(&chip->base);
>   	}
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index 674505a0021c..e4bc851b099a 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -240,10 +240,10 @@ static int check_offs_len(struct nand_chip *chip, loff_t ofs, uint64_t len)
>   void nand_select_target(struct nand_chip *chip, unsigned int cs)
>   {
>   	/*
> -	 * cs should always lie between 0 and chip->numchips, when that's not
> -	 * the case it's a bug and the caller should be fixed.
> +	 * cs should always lie between 0 and nanddev_ntargets(), when that's
> +	 * not the case it's a bug and the caller should be fixed.
>   	 */
> -	if (WARN_ON(cs > chip->numchips))
> +	if (WARN_ON(cs > nanddev_ntargets(&chip->base)))
>   		return;
>   
>   	chip->cur_cs = cs;
> @@ -5042,12 +5042,6 @@ static int nand_scan_ident(struct nand_chip *chip, unsigned int maxchips,
>   	if (!mtd->name && mtd->dev.parent)
>   		mtd->name = dev_name(mtd->dev.parent);
>   
> -	/*
> -	 * Start with chips->numchips = maxchips to let nand_select_target() do
> -	 * its job. chip->numchips will be adjusted after.
> -	 */
> -	chip->numchips = maxchips;
> -
>   	/* Set the default functions */
>   	nand_set_defaults(chip);
>   
> @@ -5091,7 +5085,6 @@ static int nand_scan_ident(struct nand_chip *chip, unsigned int maxchips,
>   
>   	/* Store the number of chips and calc total size for mtd */
>   	memorg->ntargets = i;
> -	chip->numchips = i;
>   	mtd->size = i * nanddev_target_size(&chip->base);
>   
>   	return 0;
> @@ -5833,7 +5826,7 @@ static int nand_scan_tail(struct nand_chip *chip)
>   		goto err_nanddev_cleanup;
>   
>   	/* Enter fastest possible mode on all dies. */
> -	for (i = 0; i < chip->numchips; i++) {
> +	for (i = 0; i < nanddev_ntargets(&chip->base); i++) {
>   		ret = nand_setup_data_interface(chip, i);
>   		if (ret)
>   			goto err_nanddev_cleanup;
> diff --git a/drivers/mtd/nand/raw/nand_bbt.c b/drivers/mtd/nand/raw/nand_bbt.c
> index e3308857b2ee..303408039650 100644
> --- a/drivers/mtd/nand/raw/nand_bbt.c
> +++ b/drivers/mtd/nand/raw/nand_bbt.c
> @@ -269,7 +269,7 @@ static int read_abs_bbt(struct nand_chip *this, uint8_t *buf,
>   
>   	if (td->options & NAND_BBT_PERCHIP) {
>   		int offs = 0;
> -		for (i = 0; i < this->numchips; i++) {
> +		for (i = 0; i < nanddev_ntargets(&this->base); i++) {
>   			if (chip == -1 || chip == i)
>   				res = read_bbt(this, buf, td->pages[i],
>   					targetsize >> this->bbt_erase_shift,
> @@ -478,9 +478,9 @@ static int create_bbt(struct nand_chip *this, uint8_t *buf,
>   		startblock = 0;
>   		from = 0;
>   	} else {
> -		if (chip >= this->numchips) {
> +		if (chip >= nanddev_ntargets(&this->base)) {
>   			pr_warn("create_bbt(): chipnr (%d) > available chips (%d)\n",
> -			       chip + 1, this->numchips);
> +			        chip + 1, nanddev_ntargets(&this->base));
>   			return -EINVAL;
>   		}
>   		numblocks = targetsize >> this->bbt_erase_shift;
> @@ -550,7 +550,7 @@ static int search_bbt(struct nand_chip *this, uint8_t *buf,
>   
>   	/* Do we have a bbt per chip? */
>   	if (td->options & NAND_BBT_PERCHIP) {
> -		chips = this->numchips;
> +		chips = nanddev_ntargets(&this->base);
>   		bbtblocks = targetsize >> this->bbt_erase_shift;
>   		startblock &= bbtblocks - 1;
>   	} else {
> @@ -643,7 +643,7 @@ static int get_bbt_block(struct nand_chip *this, struct nand_bbt_descr *td,
>   
>   	numblocks = (int)(targetsize >> this->bbt_erase_shift);
>   	if (!(td->options & NAND_BBT_PERCHIP))
> -		numblocks *= this->numchips;
> +		numblocks *= nanddev_ntargets(&this->base);
>   
>   	/*
>   	 * Automatic placement of the bad block table. Search direction
> @@ -745,7 +745,7 @@ static int write_bbt(struct nand_chip *this, uint8_t *buf,
>   		numblocks = (int)(targetsize >> this->bbt_erase_shift);
>   		/* Full device write or specific chip? */
>   		if (chipsel == -1) {
> -			nrchips = this->numchips;
> +			nrchips = nanddev_ntargets(&this->base);
>   		} else {
>   			nrchips = chipsel + 1;
>   			chip = chipsel;
> @@ -932,7 +932,7 @@ static int check_create(struct nand_chip *this, uint8_t *buf,
>   
>   	/* Do we have a bbt per chip? */
>   	if (td->options & NAND_BBT_PERCHIP)
> -		chips = this->numchips;
> +		chips = nanddev_ntargets(&this->base);
>   	else
>   		chips = 1;
>   
> @@ -1111,7 +1111,7 @@ static void mark_bbt_region(struct nand_chip *this, struct nand_bbt_descr *td)
>   
>   	/* Do we have a bbt per chip? */
>   	if (td->options & NAND_BBT_PERCHIP) {
> -		chips = this->numchips;
> +		chips = nanddev_ntargets(&this->base);
>   		nrblocks = (int)(targetsize >> this->bbt_erase_shift);
>   	} else {
>   		chips = 1;
> diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
> index a127eb773b1a..e5a25ba75211 100644
> --- a/include/linux/mtd/rawnand.h
> +++ b/include/linux/mtd/rawnand.h
> @@ -1014,7 +1014,6 @@ struct nand_legacy {
>    *			      set to the actually used ONFI mode if the chip is
>    *			      ONFI compliant or deduced from the datasheet if
>    *			      the NAND chip is not ONFI compliant.
> - * @numchips:		[INTERN] number of physical chips
>    * @pagemask:		[INTERN] page number mask = number of (pages / chip) - 1
>    * @data_buf:		[INTERN] buffer for data, size is (page size + oobsize).
>    * @pagecache:		Structure containing page cache related fields
> @@ -1028,8 +1027,9 @@ struct nand_legacy {
>    * @data_interface:	[INTERN] NAND interface timing information
>    * @cur_cs:		currently selected target. -1 means no target selected,
>    *			otherwise we should always have cur_cs >= 0 &&
> - *			cur_cs < numchips. NAND Controller drivers should not
> - *			modify this value, but they're allowed to read it.
> + *			cur_cs < nanddev_ntargets(). NAND Controller drivers
> + *			should not modify this value, but they're allowed to
> + *			read it.
>    * @read_retries:	[INTERN] the number of read retry modes supported
>    * @bbt:		[INTERN] bad block table pointer
>    * @bbt_td:		[REPLACEABLE] bad block table descriptor for flash
> @@ -1060,7 +1060,6 @@ struct nand_chip {
>   	int phys_erase_shift;
>   	int bbt_erase_shift;
>   	int chip_shift;
> -	int numchips;
>   	int pagemask;
>   	u8 *data_buf;
>   
> 
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
