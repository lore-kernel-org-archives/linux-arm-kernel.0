Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE393C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:14:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C14EE2084F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gzHao86r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C14EE2084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=B5O4UCvs7YrZDJkZP9bZ4V5BZb//lddsd14FsOkIYmc=; b=gzHao86rR0TNJS
	J+guk9R/lWqraxhgRfloL9ahnd2AmFpGTiWbGYKoRFVjyhuptYtWJ6h8fgLxJ28hoqWEDkEzKZZXe
	DMdUXJm8tk75aPZF2Jx/hkUGl3aIPDMyQxGdQ+MqteECgrrbQr7rVLvpRiW/HBtzDOPX1LhWKCSN/
	8JrYKxwfROZBlSPgjhJFemLxPjGHxqKusU1fHtL8mUTx64vIN04h05w67sNJSZaESM7Xm5NpKX4ZP
	/xi9Z5/5FNcyYZWJfU6Aeup6Caztpd11QzXY7QjrzfP3/iWADkf/dYOmejzvcMS50DsDyfq4TlAMx
	fvEkvNku2vQIyjv42sFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxX7r-0005cq-UQ; Sat, 23 Feb 2019 13:13:55 +0000
Received: from skedge04.snt-world.com ([91.208.41.69])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxX7i-0005Uw-Cl; Sat, 23 Feb 2019 13:13:52 +0000
Received: from sntmail11s.snt-is.com (unknown [10.203.32.181])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by skedge04.snt-world.com (Postfix) with ESMTPS id 1198367A7B0;
 Sat, 23 Feb 2019 14:13:44 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail11s.snt-is.com
 (10.203.32.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 23 Feb
 2019 14:13:43 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Sat, 23 Feb 2019 14:13:43 +0100
From: Schrempf Frieder <frieder.schrempf@kontron.de>
To: Miquel Raynal <miquel.raynal@bootlin.com>, Boris Brezillon
 <bbrezillon@kernel.org>, Richard Weinberger <richard@nod.at>, David Woodhouse
 <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, "Marek
 Vasut" <marek.vasut@gmail.com>, Tudor Ambarus <Tudor.Ambarus@microchip.com>
Subject: Re: [PATCH 10/15] mtd: rawnand: Move all page cache related fields to
 a sub-struct
Thread-Topic: [PATCH 10/15] mtd: rawnand: Move all page cache related fields
 to a sub-struct
Thread-Index: AQHUycZ3sE9bZ84yAUyu8ATNMOat3aXtTuKA
Date: Sat, 23 Feb 2019 13:13:43 +0000
Message-ID: <60aa5a1f-b67c-a6e0-f1b7-07ea9e6bc5e7@kontron.de>
References: <20190221091527.20497-1-miquel.raynal@bootlin.com>
 <20190221091527.20497-11-miquel.raynal@bootlin.com>
In-Reply-To: <20190221091527.20497-11-miquel.raynal@bootlin.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.43]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-ID: <6A3C818FDDB2C44BA1997E35A7B078B3@snt-world.com>
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 1198367A7B0.A4111
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
X-CRM114-CacheID: sfid-20190223_051347_200727_FC606309 
X-CRM114-Status: GOOD (  23.71  )
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
> Looking at the field names it's hard to tell what ->data_buf, ->pagebuf
> and ->pagebuf_bitflips are for. Clarify that by moving those fields
> in a sub-struct named pagecache.
> 
> Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

> ---
>   drivers/mtd/nand/raw/nand_base.c | 28 ++++++++++++++--------------
>   include/linux/mtd/rawnand.h      | 18 +++++++++++-------
>   2 files changed, 25 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index 07985d2b91ac..256d16903d54 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -493,8 +493,8 @@ static int nand_do_write_oob(struct nand_chip *chip, loff_t to,
>   	}
>   
>   	/* Invalidate the page cache, if we write to the cached page */
> -	if (page == chip->pagebuf)
> -		chip->pagebuf = -1;
> +	if (page == chip->pagecache.page)
> +		chip->pagecache.page = -1;
>   
>   	nand_fill_oob(chip, ops->oobbuf, ops->ooblen, ops);
>   
> @@ -3204,7 +3204,7 @@ static int nand_do_read_ops(struct nand_chip *chip, loff_t from,
>   			use_bufpoi = 0;
>   
>   		/* Is the current page in the buffer? */
> -		if (realpage != chip->pagebuf || oob) {
> +		if (realpage != chip->pagecache.page || oob) {
>   			bufpoi = use_bufpoi ? chip->data_buf : buf;
>   
>   			if (use_bufpoi && aligned)
> @@ -3230,7 +3230,7 @@ static int nand_do_read_ops(struct nand_chip *chip, loff_t from,
>   			if (ret < 0) {
>   				if (use_bufpoi)
>   					/* Invalidate page cache */
> -					chip->pagebuf = -1;
> +					chip->pagecache.page = -1;
>   				break;
>   			}
>   
> @@ -3239,11 +3239,11 @@ static int nand_do_read_ops(struct nand_chip *chip, loff_t from,
>   				if (!NAND_HAS_SUBPAGE_READ(chip) && !oob &&
>   				    !(mtd->ecc_stats.failed - ecc_failures) &&
>   				    (ops->mode != MTD_OPS_RAW)) {
> -					chip->pagebuf = realpage;
> -					chip->pagebuf_bitflips = ret;
> +					chip->pagecache.page = realpage;
> +					chip->pagecache.bitflips = ret;
>   				} else {
>   					/* Invalidate page cache */
> -					chip->pagebuf = -1;
> +					chip->pagecache.page = -1;
>   				}
>   				memcpy(buf, chip->data_buf + col, bytes);
>   			}
> @@ -3283,7 +3283,7 @@ static int nand_do_read_ops(struct nand_chip *chip, loff_t from,
>   			memcpy(buf, chip->data_buf + col, bytes);
>   			buf += bytes;
>   			max_bitflips = max_t(unsigned int, max_bitflips,
> -					     chip->pagebuf_bitflips);
> +					     chip->pagecache.bitflips);
>   		}
>   
>   		readlen -= bytes;
> @@ -4002,9 +4002,9 @@ static int nand_do_write_ops(struct nand_chip *chip, loff_t to,
>   	page = realpage & chip->pagemask;
>   
>   	/* Invalidate the page cache, when we write to the cached page */
> -	if (to <= ((loff_t)chip->pagebuf << chip->page_shift) &&
> -	    ((loff_t)chip->pagebuf << chip->page_shift) < (to + ops->len))
> -		chip->pagebuf = -1;
> +	if (to <= ((loff_t)chip->pagecache.page << chip->page_shift) &&
> +	    ((loff_t)chip->pagecache.page << chip->page_shift) < (to + ops->len))
> +		chip->pagecache.page = -1;
>   
>   	/* Don't allow multipage oob writes with offset */
>   	if (oob && ops->ooboffs && (ops->ooboffs + ops->ooblen > oobmaxlen)) {
> @@ -4241,9 +4241,9 @@ int nand_erase_nand(struct nand_chip *chip, struct erase_info *instr,
>   		 * Invalidate the page cache, if we erase the block which
>   		 * contains the current cached page.
>   		 */
> -		if (page <= chip->pagebuf && chip->pagebuf <
> +		if (page <= chip->pagecache.page && chip->pagecache.page <
>   		    (page + pages_per_block))
> -			chip->pagebuf = -1;
> +			chip->pagecache.page = -1;
>   
>   		if (chip->legacy.erase)
>   			status = chip->legacy.erase(chip,
> @@ -5817,7 +5817,7 @@ static int nand_scan_tail(struct nand_chip *chip)
>   	chip->state = FL_READY;
>   
>   	/* Invalidate the pagebuffer reference */
> -	chip->pagebuf = -1;
> +	chip->pagecache.page = -1;
>   
>   	/* Large page NAND with SOFT_ECC should support subpage reads */
>   	switch (ecc->mode) {
> diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
> index e62c3ab4e0f7..00a8795b215d 100644
> --- a/include/linux/mtd/rawnand.h
> +++ b/include/linux/mtd/rawnand.h
> @@ -1019,10 +1019,10 @@ struct nand_legacy {
>    * @chipsize:		[INTERN] the size of one chip for multichip arrays
>    * @pagemask:		[INTERN] page number mask = number of (pages / chip) - 1
>    * @data_buf:		[INTERN] buffer for data, size is (page size + oobsize).
> - * @pagebuf:		[INTERN] holds the pagenumber which is currently in
> - *			data_buf.
> - * @pagebuf_bitflips:	[INTERN] holds the bitflip count for the page which is
> - *			currently in data_buf.
> + * @pagecache:		Structure containing page cache related fields
> + * @pagecache.bitflips:	Number of bitflips of the cached page
> + * @pagecache.page:	Page number currently in the cache. -1 means no page is
> + *			currently cached
>    * @subpagesize:	[INTERN] holds the subpagesize
>    * @id:			[INTERN] holds NAND ID
>    * @parameters:		[INTERN] holds generic parameters under an easily
> @@ -1069,8 +1069,12 @@ struct nand_chip {
>   	uint64_t chipsize;
>   	int pagemask;
>   	u8 *data_buf;
> -	int pagebuf;
> -	unsigned int pagebuf_bitflips;
> +
> +	struct {
> +		unsigned int bitflips;
> +		int page;
> +	} pagecache;
> +
>   	int subpagesize;
>   	uint8_t bits_per_cell;
>   	uint16_t ecc_strength_ds;
> @@ -1374,7 +1378,7 @@ void nand_deselect_target(struct nand_chip *chip);
>    */
>   static inline void *nand_get_data_buf(struct nand_chip *chip)
>   {
> -	chip->pagebuf = -1;
> +	chip->pagecache.page = -1;
>   
>   	return chip->data_buf;
>   }
> 
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
