Return-Path: <SRS0=Q9BQ=QJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6B7C282DB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 07:16:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69D6E21479
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 07:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rLF/Wjg1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XV10zHJb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69D6E21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=stb+rT+zRfHr6PhtI87K+nTeczlq6DV+SpX2hl0kF+s=; b=rLF/Wjg15rLCWr
	qwPCWpfNUloi0T40l+uXRKO9/LgbOK9G/y3ujKJs6zLt5r+a3t18YHozqJoHXgl+yrMPNke1vB6FT
	j/16p/GsHZtfx1Exy0BoTelJ+NdEjsiZRHZq8cniTmlnszNV1p26IzG5qIFCTaX+hG26k6Ze5pqIh
	bB5+LZWXQDx6kKeUVyxxYQI5WE+uda6yySII4G///9fnz9wm6zBZjnWL9CyUVtDJRmoGmm7bo5Ral
	Wmb31zz/4bKBxirAbwt7ExENEOJwlZiEHYTkokKMushQ26jOrJd90jsXNnNfdikuqiwqytuzcESK4
	zkpmninZVpsqFZL0aHIw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gppXg-0003YL-A9; Sat, 02 Feb 2019 07:16:44 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gppXd-0003Xw-8I; Sat, 02 Feb 2019 07:16:42 +0000
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 76D1420869;
 Sat,  2 Feb 2019 07:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549091800;
 bh=LbbWCY52MZJlTmK3M5ALRbknLFOVhDeo6yjUTIUVON4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=XV10zHJblF6h4vbJVPvIyVrzQD8uDn6PSM2LNL4FdmV0Y5YlRRmhdpLGRScahI4OF
 JWKEq830IrJPSm4Tn10+FlfsukSxQq0gQi4ooYffqCsE2GpCmUnnK977u1cRW2PWxO
 mj7xmS39AtqyhePekiP6LVOQ7xJsJHdqOuH6K/rw=
Date: Sat, 2 Feb 2019 08:16:25 +0100
From: Boris Brezillon <bbrezillon@kernel.org>
To: <Tudor.Ambarus@microchip.com>
Subject: Re: [PATCH v3 11/13] spi: atmel-quadspi: add support for named
 peripheral clock
Message-ID: <20190202081625.58a0be1d@bbrezillon>
In-Reply-To: <20190202040653.1217-12-tudor.ambarus@microchip.com>
References: <20190202040653.1217-1-tudor.ambarus@microchip.com>
 <20190202040653.1217-12-tudor.ambarus@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_231641_323846_3F808987 
X-CRM114-Status: GOOD (  17.30  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
 Cyrille.Pitchen@microchip.com, robh+dt@kernel.org, linux-spi@vger.kernel.org,
 Ludovic.Desroches@microchip.com, broonie@kernel.org,
 linux-mtd@lists.infradead.org, bugalski.piotr@gmail.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, 2 Feb 2019 04:07:41 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Naming clocks is a good practice. Keep supporting unnamed
> peripheral clock, to be backward compatible with old DTs.
> While here, rename clk to pclk, to indicate that it is a
> peripheral clock.
> 
> Suggested-by: Boris Brezillon <bbrezillon@kernel.org>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>

> ---
> v3: new patch
> 
>  drivers/spi/atmel-quadspi.c | 33 ++++++++++++++++++---------------
>  1 file changed, 18 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
> index bfa5f5e92d96..c9548942535a 100644
> --- a/drivers/spi/atmel-quadspi.c
> +++ b/drivers/spi/atmel-quadspi.c
> @@ -136,7 +136,7 @@
>  struct atmel_qspi {
>  	void __iomem		*regs;
>  	void __iomem		*mem;
> -	struct clk		*clk;
> +	struct clk		*pclk;
>  	struct platform_device	*pdev;
>  	u32			pending;
>  	u32			smm;
> @@ -338,7 +338,7 @@ static int atmel_qspi_setup(struct spi_device *spi)
>  	if (!spi->max_speed_hz)
>  		return -EINVAL;
>  
> -	src_rate = clk_get_rate(aq->clk);
> +	src_rate = clk_get_rate(aq->pclk);
>  	if (!src_rate)
>  		return -EINVAL;
>  
> @@ -429,15 +429,18 @@ static int atmel_qspi_probe(struct platform_device *pdev)
>  	}
>  
>  	/* Get the peripheral clock */
> -	aq->clk = devm_clk_get(&pdev->dev, NULL);
> -	if (IS_ERR(aq->clk)) {
> +	aq->pclk = devm_clk_get(&pdev->dev, "pclk");
> +	if (IS_ERR(aq->pclk))
> +		aq->pclk = devm_clk_get(&pdev->dev, NULL);
> +
> +	if (IS_ERR(aq->pclk)) {
>  		dev_err(&pdev->dev, "missing peripheral clock\n");
> -		err = PTR_ERR(aq->clk);
> +		err = PTR_ERR(aq->pclk);
>  		goto exit;
>  	}
>  
>  	/* Enable the peripheral clock */
> -	err = clk_prepare_enable(aq->clk);
> +	err = clk_prepare_enable(aq->pclk);
>  	if (err) {
>  		dev_err(&pdev->dev, "failed to enable the peripheral clock\n");
>  		goto exit;
> @@ -448,25 +451,25 @@ static int atmel_qspi_probe(struct platform_device *pdev)
>  	if (irq < 0) {
>  		dev_err(&pdev->dev, "missing IRQ\n");
>  		err = irq;
> -		goto disable_clk;
> +		goto disable_pclk;
>  	}
>  	err = devm_request_irq(&pdev->dev, irq, atmel_qspi_interrupt,
>  			       0, dev_name(&pdev->dev), aq);
>  	if (err)
> -		goto disable_clk;
> +		goto disable_pclk;
>  
>  	err = atmel_qspi_init(aq);
>  	if (err)
> -		goto disable_clk;
> +		goto disable_pclk;
>  
>  	err = spi_register_controller(ctrl);
>  	if (err)
> -		goto disable_clk;
> +		goto disable_pclk;
>  
>  	return 0;
>  
> -disable_clk:
> -	clk_disable_unprepare(aq->clk);
> +disable_pclk:
> +	clk_disable_unprepare(aq->pclk);
>  exit:
>  	spi_controller_put(ctrl);
>  
> @@ -480,7 +483,7 @@ static int atmel_qspi_remove(struct platform_device *pdev)
>  
>  	spi_unregister_controller(ctrl);
>  	writel_relaxed(QSPI_CR_QSPIDIS, aq->regs + QSPI_CR);
> -	clk_disable_unprepare(aq->clk);
> +	clk_disable_unprepare(aq->pclk);
>  	return 0;
>  }
>  
> @@ -488,7 +491,7 @@ static int __maybe_unused atmel_qspi_suspend(struct device *dev)
>  {
>  	struct atmel_qspi *aq = dev_get_drvdata(dev);
>  
> -	clk_disable_unprepare(aq->clk);
> +	clk_disable_unprepare(aq->pclk);
>  
>  	return 0;
>  }
> @@ -497,7 +500,7 @@ static int __maybe_unused atmel_qspi_resume(struct device *dev)
>  {
>  	struct atmel_qspi *aq = dev_get_drvdata(dev);
>  
> -	clk_prepare_enable(aq->clk);
> +	clk_prepare_enable(aq->pclk);
>  
>  	return atmel_qspi_init(aq);
>  }


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
