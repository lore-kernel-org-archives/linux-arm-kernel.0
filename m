Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7540EC00319
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:56:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44242214AF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RBPk3bIE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIF7FG3C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44242214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KbvcM0i1MoHgWyn6+PohfHtbEwjZbc3NI2EeLWnl57s=; b=RBPk3bIE/pH04/
	Va/yfY9luaAOIdZYYx1momUDvWrs0mABaIJc+DGNNj5tZs9Lx5scu6Bjycdh/j6jrdn7YBI6o8/hS
	JuB2sSXsX3ee0kOztpJQOsk04NTCICRn3CUKAuZ79RF2lnc6pFkOypawzZOmGsPjQ/OBUGkfmpVGL
	NbTGCp08YcThhafTnMBF7B2qQNRH+EVKBd3MC6vwK8gPw/BN7OcC18LxkOQhNCVROy8S9sKWTH8jv
	Dtzq22FxWG39RBC9tUqc+990QX6Xo3+iLWBvirfW3W9FquCUbZqQ8diJQXS1ArkN77BIZ5RQZDTry
	PWqDR62Llri7qKqZyDQw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwm1M-0004s2-Uy; Thu, 21 Feb 2019 10:56:04 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwm1J-0004qa-A9; Thu, 21 Feb 2019 10:56:02 +0000
Received: from localhost (unknown [91.160.177.164])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9F1812086A;
 Thu, 21 Feb 2019 10:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550746560;
 bh=8b0jdkoIJUtGvzzZKY2RFI9ZaRIq0rKjd+MkiLGiACg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=fIF7FG3CoZX4tt4BtXgkwYrDVLHLGdT+q7LYD6BJNvcMY6WlkiYwwXTq7ZWxd07lb
 iLW4xHihETZf1ZqnxfVlJbpc1WnRjaFwt2lri16gItELggC5zAycd51kppolOHqJ1K
 4k4BdhyPDi2lFeLlGVyyTXmN4VR64qh9n0ti18zM=
Date: Thu, 21 Feb 2019 11:55:54 +0100
From: Boris Brezillon <bbrezillon@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [RFC PATCH 02/27] mtd: nand: Compile in the NAND core by default
Message-ID: <20190221115554.315fbd9b@kernel.org>
In-Reply-To: <20190221100216.25255-3-miquel.raynal@bootlin.com>
References: <20190221100216.25255-1-miquel.raynal@bootlin.com>
 <20190221100216.25255-3-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_025601_416897_A8BA3170 
X-CRM114-Status: GOOD (  18.93  )
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

On Thu, 21 Feb 2019 11:01:51 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Force the NAND core be compiled-in when using any kind of NAND.

Why?

> 
> Also remove the redundant dependencies on MTD which is enforced by the
> game of the if/endif blocs.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/mtd/nand/Kconfig         | 12 ++++++++++--
>  drivers/mtd/nand/onenand/Kconfig |  1 -
>  drivers/mtd/nand/raw/Kconfig     |  1 -
>  drivers/mtd/nand/spi/Kconfig     |  1 -
>  4 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> index 495751ed3fd7..e8d26a715922 100644
> --- a/drivers/mtd/nand/Kconfig
> +++ b/drivers/mtd/nand/Kconfig
> @@ -1,6 +1,14 @@
> -config MTD_NAND_CORE
> -	tristate
> +menuconfig MTD_NAND_CORE
> +	tristate "NAND"

Definitely not something we want to expose in menuconfig.

> +	default y

I don't see what's the problem with letting SPINAND, RAWNAND and
ONENAND select this options if they actually need it.

> +	help
> +	  Embed the NAND core. This is the generic part between raw
> +	  NAND, SPI NAND and Onenand.
> +
> +if MTD_NAND_CORE
>  
>  source "drivers/mtd/nand/onenand/Kconfig"
>  source "drivers/mtd/nand/raw/Kconfig"
>  source "drivers/mtd/nand/spi/Kconfig"
> +
> +endif
> diff --git a/drivers/mtd/nand/onenand/Kconfig b/drivers/mtd/nand/onenand/Kconfig
> index 9dc15748947b..c168f3b4b296 100644
> --- a/drivers/mtd/nand/onenand/Kconfig
> +++ b/drivers/mtd/nand/onenand/Kconfig
> @@ -1,6 +1,5 @@
>  menuconfig MTD_ONENAND
>  	tristate "OneNAND Device Support"
> -	depends on MTD
>  	depends on HAS_IOMEM
>  	help
>  	  This enables support for accessing all type of OneNAND flash
> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> index 510a6b32820d..ebb8a3da9fa5 100644
> --- a/drivers/mtd/nand/raw/Kconfig
> +++ b/drivers/mtd/nand/raw/Kconfig
> @@ -11,7 +11,6 @@ config MTD_NAND_ECC_SW_HAMMING_SMC
>  
>  menuconfig MTD_RAW_NAND
>  	tristate "Raw/Parallel NAND Device Support"
> -	depends on MTD
>  	select MTD_NAND_ECC_SW_HAMMING
>  	help
>  	  This enables support for accessing all type of raw/parallel
> diff --git a/drivers/mtd/nand/spi/Kconfig b/drivers/mtd/nand/spi/Kconfig
> index 7c37d2929b68..7631050610ab 100644
> --- a/drivers/mtd/nand/spi/Kconfig
> +++ b/drivers/mtd/nand/spi/Kconfig
> @@ -1,6 +1,5 @@
>  menuconfig MTD_SPI_NAND
>  	tristate "SPI NAND device Support"
> -	select MTD_NAND_CORE
>  	depends on SPI_MASTER
>  	select SPI_MEM
>  	help


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
