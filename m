Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DAC7C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:44:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C6EA206A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hpN2kWZ3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+kWVgXo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C6EA206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IZxAt0T0YTSnWaux2mT6cQxMwqXRaGgbN8C/aeWjeR0=; b=hpN2kWZ3wgIiie
	hEBk1SQoLt7CHbaiFbMxOwxHN4gCpuP4tkhjvBf2rzQQsKrVKPbNnD+KejoJscIgFXCe6paMvTsko
	pXQbZ0OtVmZpYqRNbiiu12zY8gdI+FKAJ4lSOulzg1d7wV+2KKvCH8klb4x2vLQ6EcrR6SMnXybQa
	Kmi2wUR8XQscwdNLkK9Ps2lMNy7sLHpC2wFHy3+Ttwod8V0GOV3e6CLmN4rv8GXd2UEGSHerTR5fl
	VojEEfCCykenwFfnoIE36vlIODIdx4lQ2SMt1MD/Ng7IlVabtjZd55g2vRI8YPzCYlJg3ghs1Ckja
	WU+H7p6FvRHOhaL68lFQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxC49-0006FO-2B; Fri, 22 Feb 2019 14:44:41 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxC46-0006Ex-BE; Fri, 22 Feb 2019 14:44:39 +0000
Received: from localhost (91-160-177-164.subs.proxad.net [91.160.177.164])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B42AC206A3;
 Fri, 22 Feb 2019 14:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550846678;
 bh=tN25kIKYaNYglinCUMie+OtgsYRXUvZu1czGWjxoA38=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=u+kWVgXoluqZHUrOWD5TmXYFlmf1J8BTJYw1/palZ7CdweBvNlZMIda56/DsRKAGy
 UYqNlqjJhhLbU7XHirInmeU3LRtQziUSTB/CNEjIv8MQQygAvMkyaf4C/s0ZjrE4pr
 dljqc5hKB3wcoTNYu9q+0SCkwE75awwFvz1MPVIg=
Date: Fri, 22 Feb 2019 15:44:31 +0100
From: Boris Brezillon <bbrezillon@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [RFC PATCH 25/27] mtd: nand: Add helpers to manage ECC engines
 and configurations
Message-ID: <20190222154431.66c6911f@kernel.org>
In-Reply-To: <20190221125806.28875-13-miquel.raynal@bootlin.com>
References: <20190221125806.28875-1-miquel.raynal@bootlin.com>
 <20190221125806.28875-13-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_064438_422280_54103144 
X-CRM114-Status: GOOD (  20.76  )
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

On Thu, 21 Feb 2019 13:58:04 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Add the logic in the NAND core to find the right ECC engine depending
> on the NAND chip requirements and the user desires. Right now, the
> choice may be made between (more will come):
> * software Hamming
> * software BCH
> * on-die (SPI-NAND devices only)
> 
> Once the ECC engine has been found, the ECC engine must be
> configured.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/mtd/nand/core.c  | 107 +++++++++++++++++++++++++++++++++++++++
>  include/linux/mtd/nand.h |   4 ++
>  2 files changed, 111 insertions(+)
> 
> diff --git a/drivers/mtd/nand/core.c b/drivers/mtd/nand/core.c
> index 872d46b5fc0f..9feb118c9f68 100644
> --- a/drivers/mtd/nand/core.c
> +++ b/drivers/mtd/nand/core.c
> @@ -207,6 +207,113 @@ int nanddev_mtd_max_bad_blocks(struct mtd_info *mtd, loff_t offs, size_t len)
>  }
>  EXPORT_SYMBOL_GPL(nanddev_mtd_max_bad_blocks);
>  
> +/**
> + * nanddev_find_ecc_engine() - Find a suitable ECC engine
> + * @nand: NAND device
> + */
> +static int nanddev_find_ecc_engine(struct nand_device *nand)

Can we pass the conf in argument instead of reading it from
nand->ecc.user_conf?

> +{
> +	bool is_spinand = mtd_type_is_spinand(&nand->mtd);

And here is the reason for the SPINAND type.

> +
> +	/* Read the user desires in terms of ECC engine/configuration */
> +	nand_ecc_read_user_conf(nand);
> +
> +	/* No ECC engine requestedn, let's return without error */
> +	if (nand->ecc.user_conf.mode == NAND_ECC_NONE)
> +		return 0;
> +
> +	/* Raw NAND default mode is hardware */
> +	if (!is_spinand && nand->ecc.user_conf.mode < 0)
> +		nand->ecc.user_conf.mode = NAND_ECC_HW;

We should let the raw NAND layer take this decision (actually, it's
even a raw NAND controller driver decision). Please complain if
user_conf.mode is invalid.
This way you won't need the SPINAND type you added in one of your
previous patch.

> +
> +	/* SPI-NAND default mode is on-die */
> +	if (is_spinand && nand->ecc.user_conf.mode < 0)
> +		nand->ecc.user_conf.mode = NAND_ECC_ON_DIE;
> +
> +	switch (nand->ecc.user_conf.mode) {
> +	case NAND_ECC_SOFT:
> +		nand->ecc.engine = nand_ecc_sw_get_engine(nand);
> +		break;
> +	case NAND_ECC_ON_DIE:
> +		if (is_spinand)
> +			nand->ecc.engine = spinand_ondie_ecc_get_engine();

So, maybe it's worth having the ondie ECC engine instance directly
embedded in nand_device instead of spinand, or maybe just a pointer, so
that you don't reserve extra space when the NAND device does not have
on-die ECC.

> +		else
> +			pr_err("On-die ECC engines for non SPI devices not supported yet\n");
> +		break;
> +	case NAND_ECC_HW:
> +		pr_err("Hardware ECC engines not supported yet\n");
> +		break;
> +	default:
> +		pr_err("Missing ECC engine property\n");
> +	}
> +
> +	if (!nand->ecc.engine)
> +		return  -EINVAL;
> +
> +	return 0;
> +}


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
