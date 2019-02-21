Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BB5C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:49:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95D562084F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L3L6wVbA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GApEs4x8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95D562084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=beenuxrfI4qsdJDD3YghHa7+azxc/mYsC+8Y8YmMX5c=; b=L3L6wVbA3YL4Yz
	Ac45imfQ8AehPEA+FJ1bf3cyJjYfHRkPyj5vaiWH+cFstkikEBgazPWlQIRdVU4Ls8vy2ZAedPH2J
	jqWDAWRAcoXNGGjNCnvQ8ctk21rKYEoXJCcS3JeGlht1vSSLZoOSW5fjfjmJmsSmmD9J7RAVeC397
	IwA5W+R7Jhkgnyr4768F/OqTztmxWOQ2Gm9+pExlhQ4Z+88NOuOVuXDLdW8dJ/H7cWj5Sf43yR1wj
	dQRxxfsvPAxAALBmxVA5WzFur7duzqM3WXV4PyiclCSBhIP7mJmbX9MyZ4/01oCrEgso0Q4EivRyy
	1c+gFNtx3cSM9x6yIyyg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwoir-0007RY-MW; Thu, 21 Feb 2019 13:49:09 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwoih-0007IO-3P; Thu, 21 Feb 2019 13:49:00 +0000
Received: by mail-it1-x143.google.com with SMTP id i2so22828975ite.5;
 Thu, 21 Feb 2019 05:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PVDwraPMuK128R4L9+QhmYly3JI7tJ6lX5ehsk36Uqg=;
 b=GApEs4x8iCt0AU5nxvw5PpHnIe5HPwW3TJFZOgiZGe+OuTHi9jzsWx42UmFZiGJtBH
 qwu5Q8oiFygNgZetfxeP3GYbuIBV/o/jl6eFVxYcMtJuipkB6iyM8j7DE5cQRDzCCWSK
 6xdtBA4FjCAPqS+SOL0pG4j/nLgRVwhyGOa7K5cxKLie6S7dZ0H3hsNnNypYy6PWleo3
 R4ziauQtJfdTbFd+rVy+cfj23saVxUPJ5QGtSeTY03Uf96hGYJ/oqORIhiZBVunjU56V
 Ry13COsryK0O2DDNTktsopK44eZCVE3Klo7rEmDkcKbS2J5qU1nA+mPX0jKjkDI7kl21
 FwJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PVDwraPMuK128R4L9+QhmYly3JI7tJ6lX5ehsk36Uqg=;
 b=U58i6Q5fHNCY/y6qKy5dJjUQj3mNz4ozrJkENsnPdP9AUCvk9SkQldK/OcJq529Z45
 KwmO9SRg5NWvKwOg2J3IyowQtP5gmQAByCkX6E3zxx8AJYUo0kLFCxXRZeMjlcpaw9W1
 /zeafdxDDunKVADg8JTQQUEayzBp4TdKJeGaJrbsAHfeF/TDFol5pXbNzes352s3Qexi
 CoiwNOhfE/wH5B2RH95Oto+BXpDDXP7jZ9FPC/OQFZX6OgII2zOF7+50TOWKA5FsjeSF
 hgoChNvR8l7BM0mLrGorMpd3W/j397J7FW/PMT5u8pcObMCsV5j5csi14ShhrhgSOv3O
 GF3Q==
X-Gm-Message-State: AHQUAubeKjQNxpE4GZWKc6x6uAKXvHoVOlFZpZ41WZxNQaCFIdX2/jzm
 2AsyRdC4Ma9/rEEFtkjOFg3aqYevOAN4rIrLNyQ=
X-Google-Smtp-Source: AHgI3IZt1XMvCF1DAEUjEINeZr1UH3ga6FuCMW11CpyNO/1clOAqjaXEp/EKrpvXRTFH/OOT7KkaLot6ReWO1BQ6wV4=
X-Received: by 2002:a02:9f19:: with SMTP id z25mr1972490jal.3.1550756937998;
 Thu, 21 Feb 2019 05:48:57 -0800 (PST)
MIME-Version: 1.0
References: <20190221125806.28875-1-miquel.raynal@bootlin.com>
 <20190221125806.28875-4-miquel.raynal@bootlin.com>
In-Reply-To: <20190221125806.28875-4-miquel.raynal@bootlin.com>
From: Adam Ford <aford173@gmail.com>
Date: Thu, 21 Feb 2019 07:48:46 -0600
Message-ID: <CAHCN7xJhoEAjPchpp=-zEyyK1Ggzt24aQAX9ujfavdP329+ouw@mail.gmail.com>
Subject: Re: [RFC PATCH 16/27] mtd: nand: ecc: Let the software BCH ECC engine
 be a module
To: Miquel Raynal <miquel.raynal@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_054859_178609_DB5303FC 
X-CRM114-Status: GOOD (  20.42  )
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
 Richard Weinberger <richard@nod.at>, Boris Brezillon <bbrezillon@kernel.org>,
 Schrempf Frieder <frieder.schrempf@kontron.de>,
 Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>,
 arm-soc <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 21, 2019 at 6:58 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> There is no reason to prevent the software BCH ECC engine
> implementation to be compiled as a module, so change the 'bool' into a
> 'tristate'.

If you're booting from nand and need the BCH engine, it seems to me
like you'd need it to be compiled into the kernel because you'd have
to mount the filesystem before loading the module unless you have a
initramfs.  If you need the BCH engine to mount the filesystem, it
creates a dependency issue.

Just my two cents.

adam
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/mtd/nand/ecc/Kconfig           | 2 +-
>  include/linux/mtd/nand-sw-bch-engine.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mtd/nand/ecc/Kconfig b/drivers/mtd/nand/ecc/Kconfig
> index 6ce9007e1d9b..e0106b3a7ec1 100644
> --- a/drivers/mtd/nand/ecc/Kconfig
> +++ b/drivers/mtd/nand/ecc/Kconfig
> @@ -12,7 +12,7 @@ config MTD_NAND_ECC_SW_HAMMING_SMC
>           The original Linux implementation had byte 0 and 1 swapped.
>
>  config MTD_NAND_ECC_SW_BCH
> -       bool "Software BCH ECC engine"
> +       tristate "Software BCH ECC engine"
>         select BCH
>         default n
>         help
> diff --git a/include/linux/mtd/nand-sw-bch-engine.h b/include/linux/mtd/nand-sw-bch-engine.h
> index d8abfc9fc288..5d0b98e34a3a 100644
> --- a/include/linux/mtd/nand-sw-bch-engine.h
> +++ b/include/linux/mtd/nand-sw-bch-engine.h
> @@ -33,7 +33,7 @@ struct ecc_sw_bch_conf {
>         unsigned char *eccmask;
>  };
>
> -#if defined(CONFIG_MTD_NAND_ECC_SW_BCH)
> +#if IS_ENABLED(CONFIG_MTD_NAND_ECC_SW_BCH)
>
>  int ecc_sw_bch_calculate(struct nand_device *nand, const unsigned char *buf,
>                          unsigned char *code);
> --
> 2.19.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
