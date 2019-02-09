Return-Path: <SRS0=BTYN=QQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FE0C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:23:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A4572192D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EWTiJ1+i";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOy0Fwlf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A4572192D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/JcLeMd7M2BdVvE8U1BEfnhTKCp6Kb9M4xkzlzVylIM=; b=EWTiJ1+it+S6pT
	4lGPoGo483imOc/wPhTX8QN8tSTXE78rLlFcCUGGDwUNnU39Md1FBtv7WfcErJ428rerjbyiLmgwT
	bxmWo1cifnigV+z643wciHWTCNsjDJfzBbtmsriPDNK4whpN8mjG45xjIHCgaUmYf6LXQV9qx6+W0
	Js7jgMAPqRf67tAYzBzJvyLEdnUEkhmeUwN4/nC1by36Zna+fVAd+5xwfr5iZlrrF0cxgjYvkHihm
	fdUmRtF79v79zVWdmV+hQomENVFCvJMFiKdRgwpQ1/BoC8LuZjTCdRqaPjj+ecJu0O0/Ccs0M2lhW
	rEUAS5dBpCyqMolQ8kPQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsWLR-0003Ow-Jj; Sat, 09 Feb 2019 17:23:13 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsWLN-0003OK-SI
 for linux-arm-kernel@lists.infradead.org; Sat, 09 Feb 2019 17:23:11 +0000
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net
 [81.96.234.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B54BD20857;
 Sat,  9 Feb 2019 17:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549732988;
 bh=M6KmZTIclL0H8BmK4tAnPKvjQpk3qRhvACHg3liVIKg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=fOy0FwlfZ1NLqe5uhQF+HUA007Lm0B8in4Q34OOQM46CrF2lS+Fl+Gso+mJ1mpch5
 RR3sAy6LDY6IAwWTcDoFFPkPezbXJ5e2NtngnrHvTCKHwsdlhD4aDu8fxP6q5ux6qQ
 D6OqSJ5IfHaEn8IORYc3o70AgtW5QrX1RaG57A+4=
Date: Sat, 9 Feb 2019 17:23:03 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH 5/5] iio:adc:lpc32xx Add scale feature
Message-ID: <20190209172303.43cff3ec@archlinux>
In-Reply-To: <20190208160944.13281-6-gregory.clement@bootlin.com>
References: <20190208160944.13281-1-gregory.clement@bootlin.com>
 <20190208160944.13281-6-gregory.clement@bootlin.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190209_092309_951646_AF8E2E89 
X-CRM114-Status: GOOD (  25.15  )
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
Cc: devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Hartmut Knaack <knaack.h@gmx.de>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri,  8 Feb 2019 17:09:44 +0100
Gregory CLEMENT <gregory.clement@bootlin.com> wrote:

> Until now this driver only exposed the raw value of the channels. With
> this patch, the scale value is also exposed.
> 
> It depends of a regulator supply, and unlike most of the other driver, do
> not having this regulator won't prevent to use the driver. The reason for
> it is to allow to continue to use this driver with an old device tree. If
> there is no regulator supply then the scale won't be exposed.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Hi Gregory,

A few minor comments inline.

I'll admit to being surprised to see any patches at all for this driver given
how long it has been since we had any known users.  We nearly dropped it as
unused years ago IIRC!  Good thing we didn't it seems.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/lpc32xx_adc.c | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/lpc32xx_adc.c b/drivers/iio/adc/lpc32xx_adc.c
> index f391c1e10136..e36ca307f065 100644
> --- a/drivers/iio/adc/lpc32xx_adc.c
> +++ b/drivers/iio/adc/lpc32xx_adc.c
> @@ -14,6 +14,7 @@
>  #include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
>  
>  /*
>   * LPC32XX registers definitions
> @@ -45,6 +46,7 @@ struct lpc32xx_adc_state {
>  	void __iomem *adc_base;
>  	struct clk *clk;
>  	struct completion completion;
> +	struct regulator *vref;
>  
>  	u32 value;
>  };
> @@ -57,7 +59,9 @@ static int lpc32xx_read_raw(struct iio_dev *indio_dev,
>  {
>  	struct lpc32xx_adc_state *st = iio_priv(indio_dev);
>  	int ret;
> -	if (mask == IIO_CHAN_INFO_RAW) {
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
>  		mutex_lock(&indio_dev->mlock);
>  		ret = clk_prepare_enable(st->clk);
>  		if (ret) {
> @@ -77,6 +81,12 @@ static int lpc32xx_read_raw(struct iio_dev *indio_dev,
>  		mutex_unlock(&indio_dev->mlock);
>  
>  		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = regulator_get_voltage(st->vref) / 1000;
> +		*val2 =  chan->scan_type.realbits;
> +
> +		return IIO_VAL_FRACTIONAL_LOG2;

Please add a default, otherwise we are going to get some compiler
warnings that are irritating as it will think we 'forgot' to handle
the other cases.

>  	}
>  
>  	return -EINVAL;
> @@ -93,9 +103,10 @@ static const struct iio_info lpc32xx_adc_iio_info = {
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
>  	.address = LPC32XXAD_IN * _index,		\
>  	.scan_index = _index,				\
> +	.scan_type.realbits = 10			\

Given scan_type is only used in the core in buffered modes
that this driver doesn't support this is a little 'unusual'.

Also, only one value, so why bother rather than just putting it
in the one place it is used?

>  }
>  
> -static const struct iio_chan_spec lpc32xx_adc_iio_channels[] = {
> +static struct iio_chan_spec lpc32xx_adc_iio_channels[] = {
Please provide two const versions and pick between them rather than
modifying the one.

Clearly we might 'know' there is only ever one such ADC on these devices
but it's not obvious to a reviewer who isn't familiar with the hardware,
making this look like a bug.

>  	LPC32XX_ADC_CHANNEL(0),
>  	LPC32XX_ADC_CHANNEL(1),
>  	LPC32XX_ADC_CHANNEL(2),
> @@ -119,7 +130,7 @@ static int lpc32xx_adc_probe(struct platform_device *pdev)
>  	struct resource *res;
>  	int retval = -ENODEV;
>  	struct iio_dev *iodev = NULL;
> -	int irq;
> +	int irq, i;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (!res) {
> @@ -159,6 +170,15 @@ static int lpc32xx_adc_probe(struct platform_device *pdev)
>  		return retval;
>  	}
>  
> +	st->vref = devm_regulator_get(&pdev->dev, "vref");
> +	if (IS_ERR(st->vref))
> +		dev_err(&pdev->dev,
> +			"Missing vref regulator: No scaling available\n");
> +	else
> +		for (i = 0; i <  ARRAY_SIZE(lpc32xx_adc_iio_channels); i++)
> +			lpc32xx_adc_iio_channels[i].info_mask_shared_by_type =
> +				BIT(IIO_CHAN_INFO_SCALE);
> +
>  	platform_set_drvdata(pdev, iodev);
>  
>  	init_completion(&st->completion);
> @@ -175,7 +195,6 @@ static int lpc32xx_adc_probe(struct platform_device *pdev)
>  		return retval;
>  
>  	dev_info(&pdev->dev, "LPC32XX ADC driver loaded, IRQ %d\n", irq);
> -
Unrelated (and in my view) bad whitespace change.
>  	return 0;
>  }
>  


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
