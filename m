Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A94FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:39:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA666207E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r7U885Ls";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVbysrqn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA666207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6VjPi57hL+7A/dCRqBpaR4pOML6kwwwPv6JaO6TRQRA=; b=r7U885LsUainsT
	Er0/WQ+pjObdczfnudDnunAOZ/DtbINj/V/3s4Dut5Yk8c8XvhyAUiJ/TWNhZ7CG0VZQJxxpN3G67
	PKVAyI9aoIk0q7W+CjscjBsuCSPweu+iGTeQRDjaxYGZMXXlj+LRSyHc3a+t084FIcuMIw+UY9iEv
	nBERSf0yx1Dr53LEAgnsWsh1jON1i158NXtwQhzx7jWIA6wjLE47rDde6iQ8pE/Nk5M8h2pJ0B63o
	6g4SsXpN6QB1XMEn+W/7E7nhbMuJHAX0rRCHQZNFjbha5cmx0YBHeGq4YJxEuPz3+Ru/zVBP6/oI2
	CfVmCEePXKtqJ/udpWEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxByh-0002nB-An; Fri, 22 Feb 2019 14:39:03 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxBye-0002mg-I9; Fri, 22 Feb 2019 14:39:02 +0000
Received: from localhost (91-160-177-164.subs.proxad.net [91.160.177.164])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E66C32075A;
 Fri, 22 Feb 2019 14:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550846340;
 bh=zjinuR813AkGthV/dSUOKPEjfqFS2Hzi/KUrQT9O0Os=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=mVbysrqnDOioD+lRxLiXps2k+ztmvDk353SSMBnr4uzUHVUnN12t/aQWIroz6RKvO
 7W3yrwmj3vPpRXpddNymFofTK81YHYEUnfz3zl0YihOV+nPYYgE24mFRhAxAzs+ELC
 iaTnq6/n5JM8tOESRF4sfbHV8buAMAKBT7TvxC9c=
Date: Fri, 22 Feb 2019 15:38:53 +0100
From: Boris Brezillon <bbrezillon@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [RFC PATCH 24/27] mtd: spinand: Instantiate a SPI-NAND on-die
 ECC engine
Message-ID: <20190222153853.3347b253@kernel.org>
In-Reply-To: <20190221125806.28875-12-miquel.raynal@bootlin.com>
References: <20190221125806.28875-1-miquel.raynal@bootlin.com>
 <20190221125806.28875-12-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_063900_633445_6BC30191 
X-CRM114-Status: GOOD (  22.00  )
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
Cc: Mason Yang <masonccyang@mxic.com.tw>, Vignesh R <vigneshr@ti.com>,
 Tudor Ambarus <Tudor.Ambarus@microchip.com>, Julien Su <juliensu@mxic.com.tw>,
 Richard Weinberger <richard@nod.at>,
 Schrempf Frieder <frieder.schrempf@kontron.de>,
 Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 21 Feb 2019 13:58:03 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Make use of the existing functions taken from the SPI-NAND core to
> instantiate an on-die ECC engine specific to the SPI-NAND core. The
> next step will be to tweak the core to use this object instead of
> calling the helpers directly.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/mtd/nand/spi/on-die-ecc-engine.c   | 105 +++++++++++++++++++++

Maybe on-die-ecc.c is enough. To be honest, given the amount of code,
I'd even prefer to have this code directly in core.c.


>  include/linux/mtd/nand-spi-on-die-engine.h |  35 +++++++

Hm, let's make those defs part of the spinand.h file instead of
creating a new one.


>  include/linux/mtd/nand.h                   |   1 +
>  3 files changed, 141 insertions(+)
>  create mode 100644 include/linux/mtd/nand-spi-on-die-engine.h
> 
> diff --git a/drivers/mtd/nand/spi/on-die-ecc-engine.c b/drivers/mtd/nand/spi/on-die-ecc-engine.c
> index 3d5b83238e14..515b9e3efc93 100644
> --- a/drivers/mtd/nand/spi/on-die-ecc-engine.c
> +++ b/drivers/mtd/nand/spi/on-die-ecc-engine.c
> @@ -45,3 +45,108 @@ int spinand_check_ecc_status(struct spinand_device *spinand, u8 status)
>  
>  	return -EINVAL;
>  }
> +
> +static int spinand_noecc_ooblayout_ecc(struct mtd_info *mtd, int section,
> +				       struct mtd_oob_region *region)
> +{
> +	return -ERANGE;
> +}
> +
> +static int spinand_noecc_ooblayout_free(struct mtd_info *mtd, int section,
> +					struct mtd_oob_region *region)
> +{
> +	if (section)
> +		return -ERANGE;
> +
> +	/* Reserve 2 bytes for the BBM. */
> +	region->offset = 2;
> +	region->length = 62;
> +
> +	return 0;
> +}
> +
> +static const struct mtd_ooblayout_ops spinand_noecc_ooblayout = {
> +	.ecc = spinand_noecc_ooblayout_ecc,
> +	.free = spinand_noecc_ooblayout_free,
> +};
> +
> +static int ecc_spinand_ondie_init_ctx(struct nand_device *nand)
> +{
> +	struct spinand_device *spinand = nand_to_spinand(nand);
> +	struct mtd_info *mtd = nanddev_to_mtd(nand);
> +	struct ecc_sw_hamming_conf *engine_conf;
> +
> +	nand->ecc.ctx.conf.step_size = nand->ecc.requirements.step_size;
> +	nand->ecc.ctx.conf.strength = nand->ecc.requirements.strength;
> +
> +	engine_conf = kzalloc(sizeof(*engine_conf), GFP_KERNEL);
> +	if (!engine_conf)
> +		return -ENOMEM;
> +
> +	nand->ecc.ctx.priv = engine_conf;
> +
> +	if (spinand->eccinfo.ooblayout)
> +		mtd_set_ooblayout(mtd, spinand->eccinfo.ooblayout);
> +	else
> +		mtd_set_ooblayout(mtd, &spinand_noecc_ooblayout);
> +
> +	return 0;
> +}
> +
> +static void ecc_spinand_ondie_cleanup_ctx(struct nand_device *nand)
> +{
> +	kfree(nand->ecc.ctx.priv);
> +}
> +
> +static int ecc_spinand_ondie_prepare_io_req(struct nand_device *nand,
> +					    struct nand_page_io_req *req,
> +					    void *oobbuf)
> +{
> +	struct spinand_device *spinand = nand_to_spinand(nand);
> +	bool enable = (req->mode != MTD_OPS_RAW);
> +
> +	/* Only enable or disable the engine */
> +	return spinand_ecc_enable(spinand, enable);
> +}
> +
> +static int ecc_spinand_ondie_finish_io_req(struct nand_device *nand,
> +					   struct nand_page_io_req *req,
> +					   void *oobbuf)
> +{
> +	struct ecc_spinand_ondie_conf *engine_conf = nand->ecc.ctx.priv;
> +	struct spinand_device *spinand = nand_to_spinand(nand);
> +
> +	if (req->mode == MTD_OPS_RAW)
> +		return 0;
> +
> +	/* Nothing to do when finishing a page write */
> +	if (req->type == NAND_PAGE_WRITE)
> +		return 0;
> +
> +	/* Finish a page write: check the status, report errors/bitflips */
> +	return spinand_check_ecc_status(spinand, engine_conf->status);
> +}
> +
> +static struct nand_ecc_engine_ops spinand_ondie_engine_ops = {
> +	.init_ctx = ecc_spinand_ondie_init_ctx,
> +	.cleanup_ctx = ecc_spinand_ondie_cleanup_ctx,
> +	.prepare_io_req = ecc_spinand_ondie_prepare_io_req,
> +	.finish_io_req = ecc_spinand_ondie_finish_io_req,
> +};
> +
> +static struct nand_ecc_engine spinand_ondie_engine = {
> +	.ops = &spinand_ondie_engine_ops,
> +};
> +
> +void spinand_ondie_ecc_save_status(struct nand_device *nand, u8 status)
> +{
> +	struct ecc_spinand_ondie_conf *engine_conf = nand->ecc.ctx.priv;
> +
> +	if (nand->ecc.engine == &spinand_ondie_engine && engine_conf)
> +		engine_conf->status = status;
> +}
> +
> +struct nand_ecc_engine *spinand_ondie_ecc_get_engine(void)
> +{
> +	return &spinand_ondie_engine;

Hm, I was expecting to have one engine instance directly embedded in
spinand_device. The ECC engine is not a global thing here, it's
actually tied to the SPI NAND device itself.

> +}


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
