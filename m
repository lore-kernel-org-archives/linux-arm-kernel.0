Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67976C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:30:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 350482075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="reOVZSKu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5pV6d6z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 350482075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kEoR3VS6/gt0faEtwXlMC7A7zQrHbZGMRPj+pS7/WNc=; b=reOVZSKu3jJAEt
	StPJfzAJd7EFnIQQoPSnT3vZVqomjuIGx5/h59GfQtLXhlN/0RH7fciaERiHdqYfcTQp4ZQU+5kaQ
	sadv2KXMiZZhTv7Yihtz7SYypa/cG0JWGAUDpvSpYAqMzCwVq0F4iQiRUILG6cGBsKgD+3u1Q6zce
	YYnBbWfSwYVWdEXHxuKRN3Jiqt3zotwyymuYWS3NoxpliLXjJWyqd7w2KbucH0TKZChc0E3ExBKQJ
	6RFmqYqoElJ16nZgt3DkDx5KTEn5EKJyO6ps8LCAuUKUrBpCEnT7g3oc0PBrLQla1H0Rw9ZfbMO2+
	IPe4dpjoxQlPlNnkJWNQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxBq5-0005tC-74; Fri, 22 Feb 2019 14:30:09 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxBq0-0005IM-TY; Fri, 22 Feb 2019 14:30:06 +0000
Received: from localhost (91-160-177-164.subs.proxad.net [91.160.177.164])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 268152075A;
 Fri, 22 Feb 2019 14:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550845804;
 bh=PiGTghA0PgvscknPMoZ2cpko+6W1HKwWlWJ11D6sl6k=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=s5pV6d6zdnytmJmt3Hoq77YPja48GkshZ+gT9kk9aZGgx+7Ni0Mh7VYIazkiTRf1X
 CNeWLa9ZK+SZcT3hkqzFPpf/CBC/d7GG8HTELncTt+3eTggFh5va5hPdfH20hubYOa
 npWh+ix7ZwexrJncrZPCCwJeXHEBmJBuDIwItkaY=
Date: Fri, 22 Feb 2019 15:29:57 +0100
From: Boris Brezillon <bbrezillon@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [RFC PATCH 20/27] mtd: nand: Let software ECC engines be
 retrieved from the NAND core
Message-ID: <20190222152957.737a8c5c@kernel.org>
In-Reply-To: <20190221125806.28875-8-miquel.raynal@bootlin.com>
References: <20190221125806.28875-1-miquel.raynal@bootlin.com>
 <20190221125806.28875-8-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_063005_003520_3267FBA8 
X-CRM114-Status: GOOD (  18.33  )
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

On Thu, 21 Feb 2019 13:57:59 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Before making use of the ECC engines, we must retrieve them. Add the
> boilerplate for the ones already available: software engines (Hamming
> and BCH).
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/mtd/nand/ecc/engine.c              | 14 ++++++++++++++
>  include/linux/mtd/nand-sw-bch-engine.h     |  3 +++
>  include/linux/mtd/nand-sw-hamming-engine.h |  3 +++
>  include/linux/mtd/nand.h                   |  3 +++
>  4 files changed, 23 insertions(+)
> 
> diff --git a/drivers/mtd/nand/ecc/engine.c b/drivers/mtd/nand/ecc/engine.c
> index 7dd3f9772698..318dbb2d56a2 100644
> --- a/drivers/mtd/nand/ecc/engine.c
> +++ b/drivers/mtd/nand/ecc/engine.c
> @@ -286,6 +286,20 @@ bool nand_ecc_correction_is_enough(struct nand_device *nand)
>  	return corr >= ds_corr && conf->strength >= reqs->strength;
>  }
>  
> +struct nand_ecc_engine *nand_ecc_sw_get_engine(struct nand_device *nand)

What if you want to instantiate SW ECC with a custom layout? Can't we
instead have a function that create a new engine dynamically?

struct nand_ecc_engine *
nand_ecc_create_sw_engine(struct nand_device* nand,
			  enum nand_ecc_algo algo,
			  struct mtd_ooblayout *layout);



> +{
> +	switch (nand->ecc.user_conf.algo) {

Note that the conf is supposed to be passed afterwards, when the ctx is
created, so you should check nand->ecc.user_conf directly here.

> +	case NAND_ECC_HAMMING:
> +		return ecc_sw_hamming_get_engine();
> +	case NAND_ECC_BCH:
> +		return ecc_sw_bch_get_engine();
> +	default:
> +		break;
> +	}
> +
> +	return NULL;
> +}
> +
>  MODULE_LICENSE("GPL v2");
>  MODULE_AUTHOR("Miquel Raynal <miquel.raynal@bootlin.com>");
>  MODULE_DESCRIPTION("Generic ECC engine");
> diff --git a/include/linux/mtd/nand-sw-bch-engine.h b/include/linux/mtd/nand-sw-bch-engine.h
> index e406aa53ec4e..38cdad117fea 100644
> --- a/include/linux/mtd/nand-sw-bch-engine.h
> +++ b/include/linux/mtd/nand-sw-bch-engine.h
> @@ -11,6 +11,9 @@
>  #include <linux/mtd/nand.h>
>  #include <linux/bch.h>
>  
> +/* Needed for cross inclusion with nand.h */
> +struct nand_device;
> +
>  /**
>   * struct ecc_sw_bch_conf - private software BCH ECC engine structure
>   * @reqooblen: Save the actual user OOB length requested before overwriting it
> diff --git a/include/linux/mtd/nand-sw-hamming-engine.h b/include/linux/mtd/nand-sw-hamming-engine.h
> index 8df36d189482..51c5a2acee42 100644
> --- a/include/linux/mtd/nand-sw-hamming-engine.h
> +++ b/include/linux/mtd/nand-sw-hamming-engine.h
> @@ -12,6 +12,9 @@
>  
>  #include <linux/mtd/nand.h>
>  
> +/* Needed for cross inclusion with nand.h */
> +struct nand_device;
> +
>  /**
>   * struct ecc_sw_hamming_conf - private software Hamming ECC engine structure
>   * @reqooblen: Save the actual user OOB length requested before overwriting it
> diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
> index 4482eb2bbfd4..3abe113e4f06 100644
> --- a/include/linux/mtd/nand.h
> +++ b/include/linux/mtd/nand.h
> @@ -11,6 +11,8 @@
>  #define __LINUX_MTD_NAND_H
>  
>  #include <linux/mtd/mtd.h>
> +#include <linux/mtd/nand-sw-hamming-engine.h>
> +#include <linux/mtd/nand-sw-bch-engine.h>
>  
>  struct nand_device;
>  
> @@ -253,6 +255,7 @@ struct nand_ecc_engine {
>  };
>  
>  void nand_ecc_read_user_conf(struct nand_device *nand);
> +struct nand_ecc_engine *nand_ecc_sw_get_engine(struct nand_device *nand);
>  int nand_ecc_init_ctx(struct nand_device *nand);
>  void nand_ecc_cleanup_ctx(struct nand_device *nand);
>  int nand_ecc_prepare_io_req(struct nand_device *nand,


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
