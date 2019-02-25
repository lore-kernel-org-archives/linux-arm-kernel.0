Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D054DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 18:58:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A246D2084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 18:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kz4gu92G";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ySURJmiU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A246D2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nE+l0J8DBdQ6dIWdqE2azY8A9GzkfcnCCni0aGRuaRs=; b=kz4gu92GorMSCH
	qjRwGFx5Qd3OQLr0mZ1oP/pVBKoJMfWjnBzyzcMw/OlMuZNjS3cEKfGfzXZT18ZblGgrptZ0ciDYx
	kWsXcTrm/sSvmZ45oYkR1Zn3Hz7g2lQCc2iAjkZJSIsBhIipASdhnh++JZXqNT0NZyOlMKvyXJgUA
	c+gB/hvo1EsOdUyZhcLJ1zmICC7TZOlDlKFlswdRBNkecQ4vGZl4ERB64fJ6gzBuwIghMROgPo+yW
	Io29vE7t3BBnv3/iS1MhwCR1DDMABO23WmsZcE730zs4RxTw/DffrsnoztEsl87z7A/luahkHTzqU
	Jy5rm4sCLIua/6DRgqEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyLSk-0000oY-Am; Mon, 25 Feb 2019 18:58:50 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyLSh-0000oC-Qq; Mon, 25 Feb 2019 18:58:49 +0000
Received: from localhost (unknown [91.160.177.164])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BE47C2084D;
 Mon, 25 Feb 2019 18:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1551121127;
 bh=6OwhA94VPuUzuGLlyDae0MNwBWGTKURwpr8z4WwA0sY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=ySURJmiUdEX1hQgB9Qe7BrCXJ7Blb1jm6cAn1v6jyaEevNiBxIP1DIPU+Ju5HPDW6
 WxQTkz0YfeagzpAyAiEuy5ELqx2oWP9KMzEqGcvApLWNBf4BH5x4r4bhMIru8t6pHO
 GJ0zc+un5ZOneZM8ZaCrrWbllJ/pYgX+/LLOtoqw=
Date: Mon, 25 Feb 2019 19:55:43 +0100
From: Boris Brezillon <bbrezillon@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [RFC PATCH 03/27] mtd: nand: Introduce the ECC engine abstraction
Message-ID: <20190225195543.27799e77@kernel.org>
In-Reply-To: <20190221100216.25255-4-miquel.raynal@bootlin.com>
References: <20190221100216.25255-1-miquel.raynal@bootlin.com>
 <20190221100216.25255-4-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_105847_887792_CDAC97CF 
X-CRM114-Status: GOOD (  13.72  )
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

On Thu, 21 Feb 2019 11:01:52 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> +
> +/**
> + * struct nand_ecc_engine_ops - Generic ECC engine operations
> + *
> + * @init_ctx: given a desired user configuration for the pointed NAND device,
> + *            requests the ECC engine driver to setup a configuration with
> + *            values it supports.
> + * @cleanup_ctx: clean the context initialized by @init_ctx.
> + * @prepare_io_req: is called before reading/writing a page to prepare the I/O
> + *                  request to be performed with ECC correction.
> + * @finish_io_req: is called after reading/writing a page to terminate the I/O
> + *                 request and ensure proper ECC correction.
> + */
> +struct nand_ecc_engine_ops {

We might want to add a

	void (*put_engine)(struct nand_ecc_engine *engine);

here if we want the nanddev cleanup path to be generic.
This hook would be implemented by drivers where the ECC engine object is
refcounted (typically the case for HW ECC engines shared by the raw NAND
controller and the SPI controller).

Alternatively, you can just add one nand_put_xxx_ecc_engine() func per
engine class (SW, ondie and HW).

> +	int (*init_ctx)(struct nand_device *nand);
> +	void (*cleanup_ctx)(struct nand_device *nand);
> +	int (*prepare_io_req)(struct nand_device *nand,
> +			      struct nand_page_io_req *req,
> +			      void *oobbuf);
> +	int (*finish_io_req)(struct nand_device *nand,
> +			     struct nand_page_io_req *req,
> +			     void *oobbuf);
> +};

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
