Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DFFC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:16:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5D8D2084F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RZpeQwAz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8Th/qaS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5D8D2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=B5tklEHwpd1W128vxOsHptcLncSKVUXZ/KK6ZzDtEX4=; b=RZpeQwAzwL61yP
	FrPdy6VTnQFW+sIp/+sj2NL6MIY7AhWO5Sd6jaAb9zpDobPXEqUs17KrKQNbPdx+K6qBBQ/5u/91S
	sUcgPnEWwG3Lrbxa56iKcZqB3Pvs80VfMWBBt55UTY7vG+OzuUtnUGlbRl7onQ70l2dSEYBJVCxbl
	n980ufjgag3CmyV6755yCbTyYEvFnewVyHLg/RIsT/b+Pw8LtB/7f2tZ0IPbsP9MA4LFJEUgOgiUG
	eO5BNbL3mBRVgCdyhoyz4Tc9HV6vLazr4oHtm/r5rwCGixXCBtPMTeq7AXirtaIrm/7ED9z494i1I
	7hvt3PazdnPkTSK6Af0A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwmLD-0004aq-Pv; Thu, 21 Feb 2019 11:16:35 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwmLB-0004aT-0E; Thu, 21 Feb 2019 11:16:34 +0000
Received: from localhost (unknown [91.160.177.164])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 641A12086C;
 Thu, 21 Feb 2019 11:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550747792;
 bh=4g0fFeIOMLK4749Aw70OPodjeXCJ/xU+ILuYlLNbbRY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=E8Th/qaS7iPn7WzxlZh0puUxBqg7JICMv8ZzRJmI7Ygs5jrI642zxQn6xDbwdL7CU
 h6a1wASClJJOz5cn+dZFkfugEx1/cAE1VOAldHRZksUHSIcfa//BdB1GQVKY5PqAPX
 AuHpPPXsvC0JqvgEJWMIPKEDT60LEkfPSCkoogAg=
Date: Thu, 21 Feb 2019 12:16:25 +0100
From: Boris Brezillon <bbrezillon@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 <linux-arm-kernel@lists.infradead.org>, Mason Yang
 <masonccyang@mxic.com.tw>
Subject: Re: [RFC PATCH 03/27] mtd: nand: Introduce the ECC engine abstraction
Message-ID: <20190221121625.33a7f6c0@kernel.org>
In-Reply-To: <20190221100216.25255-4-miquel.raynal@bootlin.com>
References: <20190221100216.25255-1-miquel.raynal@bootlin.com>
 <20190221100216.25255-4-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_031633_080132_83A1E8ED 
X-CRM114-Status: GOOD (  18.36  )
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
Cc: Vignesh R <vigneshr@ti.com>, Tudor Ambarus <Tudor.Ambarus@microchip.com>,
 Julien Su <juliensu@mxic.com.tw>, Richard Weinberger <richard@nod.at>,
 Schrempf Frieder <frieder.schrempf@kontron.de>,
 Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 21 Feb 2019 11:01:52 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:


> diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
> index 30f0fb02abe2..9e3b018d0b83 100644
> --- a/include/linux/mtd/nand.h
> +++ b/include/linux/mtd/nand.h
> @@ -82,8 +82,14 @@ struct nand_pos {
>  	unsigned int page;
>  };
>  
> +enum nand_page_io_req_type {
> +	NAND_PAGE_READ = 0,
> +	NAND_PAGE_WRITE,
> +};
> +
>  /**
>   * struct nand_page_io_req - NAND I/O request object
> + * @type: the type of page I/O: read or write
>   * @pos: the position this I/O request is targeting
>   * @dataoffs: the offset within the page
>   * @datalen: number of data bytes to read from/write to this page
> @@ -99,6 +105,7 @@ struct nand_pos {
>   * specific commands/operations.
>   */
>  struct nand_page_io_req {
> +	enum nand_page_io_req_type type;

Can you add the reqtype enum and type field (+ patch the iterator
helpers) in a separate patch?

>  	struct nand_pos pos;
>  	unsigned int dataoffs;
>  	unsigned int datalen;
> @@ -116,13 +123,35 @@ struct nand_page_io_req {
>  };
>  
>  /**
> - * struct nand_ecc_req - NAND ECC requirements
> + * struct nand_ecc_conf - NAND ECC configuration
> + * @strength: ECC strength
> + * @step_size: Number of bytes per step
> + * @total: Total number of bytes used for storing ECC codes, this is used by
> + *         generic OOB layouts
> + */
> +struct nand_ecc_conf {

Please do the s/nand_ecc_req/nand_ecc_conf/ in a separate patch.

> +	unsigned int strength;
> +	unsigned int step_size;
> +	unsigned int total;

Do we really need to add this total field here? Looks like something
that should be kept private to the ECC engine implementation.

> +};
> +
> +/**
> + * struct nand_ecc_user_conf - User desired ECC configuration
> + * @mode: ECC mode
> + * @algo: ECC algorithm
>   * @strength: ECC strength
>   * @step_size: ECC step/block size
> + * @maximize: ECC parameters must be maximized depending on the device
> + *            capabilities
> + * @flags: User flags
>   */
> -struct nand_ecc_req {
> +struct nand_ecc_user_conf {
> +	int mode;

We should definitely name that one differently ('provider' maybe).

> +	unsigned int algo;
>  	unsigned int strength;
>  	unsigned int step_size;
> +	unsigned int maximize;
> +	unsigned int flags;

maximize could be a flag.

>  };
>  
>  #define NAND_ECCREQ(str, stp) { .strength = (str), .step_size = (stp) }
> @@ -157,11 +186,76 @@ struct nand_ops {
>  	bool (*isbad)(struct nand_device *nand, const struct nand_pos *pos);
>  };


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
