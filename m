Return-Path: <SRS0=tR0U=PB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C564DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 08:41:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94CD52173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 08:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C+OjVhSB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94CD52173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mHqAZj64wlnRY9zB4aEvG3l/38NicQqbiHkp4Rpl1LE=; b=C+OjVhSBvz7Wa7
	Bx3vlwyj49Rv+lnhVfn2edWfRXUu5vCPLG4JVWDulFhEFzUljfO3SM9BU3+m2gyOor1AcbGVG49zk
	pCi14R2sRGBeUmFeMe/UqR7VFP7fQnPB3cGbwlfPMM814+iWFdoCVcicC3RSul2wPgPnX0iLICJIG
	pnK6+FNO47Y/ExAaNYIoAgLZ+QN/CVesT0Ej+COslYk6eVcGxhUSC3ngeRLajRRdgTBuCWMHKrmRQ
	mrT1KOqNUKyEP+6n8iSVkthMFqROJNBDmVqF4aJyfk/3fxpN7XLpqLY/0o46BvjNz89HWw11KkEQj
	RGkdLkKPMjV7f9dWYyQQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbLnV-0005Af-MZ; Mon, 24 Dec 2018 08:41:13 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbLnQ-00059V-4Y
 for linux-arm-kernel@lists.infradead.org; Mon, 24 Dec 2018 08:41:10 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id F33F120A46; Mon, 24 Dec 2018 09:40:54 +0100 (CET)
Received: from aptenodytes (aaubervilliers-681-1-38-38.w90-88.abo.wanadoo.fr
 [90.88.157.38])
 by mail.bootlin.com (Postfix) with ESMTPSA id AD6342070E;
 Mon, 24 Dec 2018 09:40:54 +0100 (CET)
Message-ID: <5aaf26b5efe051fcd6dd2c6514a13a9bbe545e3d.camel@bootlin.com>
Subject: Re: [PATCH] media: sunxi: cedrus: Fix missing error message context
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: megous@megous.com, dev@linux-sunxi.org
Date: Mon, 24 Dec 2018 09:40:54 +0100
In-Reply-To: <20181221165641.16207-1-megous@megous.com>
References: <20181221165641.16207-1-megous@megous.com>
Organization: Bootlin
User-Agent: Evolution 3.30.3 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181224_004108_453365_1931149B 
X-CRM114-Status: GOOD (  13.64  )
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
Cc: "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 open list <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 "moderated list:ARM/Allwinner sunXi SoC
 support" <linux-arm-kernel@lists.infradead.org>,
 "open list:ALLWINNER VPU DRIVER" <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Fri, 2018-12-21 at 17:56 +0100, megous@megous.com wrote:
> From: Ondrej Jirman <megous@megous.com>
> 
> When cedrus_hw_probe is called, v4l2_dev is not yet initialized.
> Use dev_err instead.

Good catch and thanks for the patch!

Acked-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Cheers,

Paul

> Signed-off-by: Ondrej Jirman <megous@megous.com>
> ---
>  .../staging/media/sunxi/cedrus/cedrus_hw.c    | 28 +++++++++----------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
> index 300339fee1bc..0acf219a8c91 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
> @@ -157,14 +157,14 @@ int cedrus_hw_probe(struct cedrus_dev *dev)
>  
>  	irq_dec = platform_get_irq(dev->pdev, 0);
>  	if (irq_dec <= 0) {
> -		v4l2_err(&dev->v4l2_dev, "Failed to get IRQ\n");
> +		dev_err(dev->dev, "Failed to get IRQ\n");
>  
>  		return irq_dec;
>  	}
>  	ret = devm_request_irq(dev->dev, irq_dec, cedrus_irq,
>  			       0, dev_name(dev->dev), dev);
>  	if (ret) {
> -		v4l2_err(&dev->v4l2_dev, "Failed to request IRQ\n");
> +		dev_err(dev->dev, "Failed to request IRQ\n");
>  
>  		return ret;
>  	}
> @@ -182,21 +182,21 @@ int cedrus_hw_probe(struct cedrus_dev *dev)
>  
>  	ret = of_reserved_mem_device_init(dev->dev);
>  	if (ret && ret != -ENODEV) {
> -		v4l2_err(&dev->v4l2_dev, "Failed to reserve memory\n");
> +		dev_err(dev->dev, "Failed to reserve memory\n");
>  
>  		return ret;
>  	}
>  
>  	ret = sunxi_sram_claim(dev->dev);
>  	if (ret) {
> -		v4l2_err(&dev->v4l2_dev, "Failed to claim SRAM\n");
> +		dev_err(dev->dev, "Failed to claim SRAM\n");
>  
>  		goto err_mem;
>  	}
>  
>  	dev->ahb_clk = devm_clk_get(dev->dev, "ahb");
>  	if (IS_ERR(dev->ahb_clk)) {
> -		v4l2_err(&dev->v4l2_dev, "Failed to get AHB clock\n");
> +		dev_err(dev->dev, "Failed to get AHB clock\n");
>  
>  		ret = PTR_ERR(dev->ahb_clk);
>  		goto err_sram;
> @@ -204,7 +204,7 @@ int cedrus_hw_probe(struct cedrus_dev *dev)
>  
>  	dev->mod_clk = devm_clk_get(dev->dev, "mod");
>  	if (IS_ERR(dev->mod_clk)) {
> -		v4l2_err(&dev->v4l2_dev, "Failed to get MOD clock\n");
> +		dev_err(dev->dev, "Failed to get MOD clock\n");
>  
>  		ret = PTR_ERR(dev->mod_clk);
>  		goto err_sram;
> @@ -212,7 +212,7 @@ int cedrus_hw_probe(struct cedrus_dev *dev)
>  
>  	dev->ram_clk = devm_clk_get(dev->dev, "ram");
>  	if (IS_ERR(dev->ram_clk)) {
> -		v4l2_err(&dev->v4l2_dev, "Failed to get RAM clock\n");
> +		dev_err(dev->dev, "Failed to get RAM clock\n");
>  
>  		ret = PTR_ERR(dev->ram_clk);
>  		goto err_sram;
> @@ -220,7 +220,7 @@ int cedrus_hw_probe(struct cedrus_dev *dev)
>  
>  	dev->rstc = devm_reset_control_get(dev->dev, NULL);
>  	if (IS_ERR(dev->rstc)) {
> -		v4l2_err(&dev->v4l2_dev, "Failed to get reset control\n");
> +		dev_err(dev->dev, "Failed to get reset control\n");
>  
>  		ret = PTR_ERR(dev->rstc);
>  		goto err_sram;
> @@ -229,7 +229,7 @@ int cedrus_hw_probe(struct cedrus_dev *dev)
>  	res = platform_get_resource(dev->pdev, IORESOURCE_MEM, 0);
>  	dev->base = devm_ioremap_resource(dev->dev, res);
>  	if (IS_ERR(dev->base)) {
> -		v4l2_err(&dev->v4l2_dev, "Failed to map registers\n");
> +		dev_err(dev->dev, "Failed to map registers\n");
>  
>  		ret = PTR_ERR(dev->base);
>  		goto err_sram;
> @@ -237,35 +237,35 @@ int cedrus_hw_probe(struct cedrus_dev *dev)
>  
>  	ret = clk_set_rate(dev->mod_clk, CEDRUS_CLOCK_RATE_DEFAULT);
>  	if (ret) {
> -		v4l2_err(&dev->v4l2_dev, "Failed to set clock rate\n");
> +		dev_err(dev->dev, "Failed to set clock rate\n");
>  
>  		goto err_sram;
>  	}
>  
>  	ret = clk_prepare_enable(dev->ahb_clk);
>  	if (ret) {
> -		v4l2_err(&dev->v4l2_dev, "Failed to enable AHB clock\n");
> +		dev_err(dev->dev, "Failed to enable AHB clock\n");
>  
>  		goto err_sram;
>  	}
>  
>  	ret = clk_prepare_enable(dev->mod_clk);
>  	if (ret) {
> -		v4l2_err(&dev->v4l2_dev, "Failed to enable MOD clock\n");
> +		dev_err(dev->dev, "Failed to enable MOD clock\n");
>  
>  		goto err_ahb_clk;
>  	}
>  
>  	ret = clk_prepare_enable(dev->ram_clk);
>  	if (ret) {
> -		v4l2_err(&dev->v4l2_dev, "Failed to enable RAM clock\n");
> +		dev_err(dev->dev, "Failed to enable RAM clock\n");
>  
>  		goto err_mod_clk;
>  	}
>  
>  	ret = reset_control_reset(dev->rstc);
>  	if (ret) {
> -		v4l2_err(&dev->v4l2_dev, "Failed to apply reset\n");
> +		dev_err(dev->dev, "Failed to apply reset\n");
>  
>  		goto err_ram_clk;
>  	}
-- 
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
