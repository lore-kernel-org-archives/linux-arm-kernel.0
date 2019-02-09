Return-Path: <SRS0=BTYN=QQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D032C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:17:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C96C72073D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m8VtqhXI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1LcHxH1m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C96C72073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ChoVBPD+ErkwxdZkq/yoXgSNFxTliVRtDhvgD3SZ9VQ=; b=m8VtqhXISPO8Dg
	YmVxVaafoNRkfEKpV1HavbDPkfXRGhWAnE20KIZpE45mIgR3UcLGxqF/hw+IV659ukhZNucifD/AU
	9yM9Av5YPV23L3Gg/WWRPRq9gAHji/p0spV9pT0l/wvefFOBx4gzE6pBwdXIBNzSOi6W5Qlk2lnDP
	rV6cTsGLowmymib0ZiCImX20KfNXLLpk8kaYhYjYhTmiQ9k+h+5K1/AfgMXqzcPZ95qa9BWpAacSM
	E2rsEK2gBKeSJ/wqZopLQg6JEbOR13wFosJhAeK5NWkgwG8fft5RLpjOD6usVXUKuj4gf6W+Zuysl
	I6lN4Ra3rumJYZ7DFzmA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsWFL-0001Sl-Rs; Sat, 09 Feb 2019 17:16:55 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsWFI-0001SN-MX
 for linux-arm-kernel@lists.infradead.org; Sat, 09 Feb 2019 17:16:54 +0000
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net
 [81.96.234.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 422102192B;
 Sat,  9 Feb 2019 17:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549732612;
 bh=UerVH8VXlCXxDgNhhBQ77j5qnQzNJbrDf8rDdwSnfio=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=1LcHxH1m7yrj6ePnH4yclzg0rTOw1882sA2lqFtf2xejmRre6HM3/QpMKBs+F85aa
 oXO2/GvZebMHjVTcomzCERtIG9z+k/c8jG7+vqIt9CAl/uq0WL7vhn1x61pNwNRWUW
 1aGlh0t4acZujpmN74xgTYSPT5ZdY7fj/9eB+gEY=
Date: Sat, 9 Feb 2019 17:16:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH 4/5] iio:adc:lpc32xx Cleanup headers
Message-ID: <20190209171646.49c75afc@archlinux>
In-Reply-To: <20190208160944.13281-5-gregory.clement@bootlin.com>
References: <20190208160944.13281-1-gregory.clement@bootlin.com>
 <20190208160944.13281-5-gregory.clement@bootlin.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190209_091652_755455_9D67B143 
X-CRM114-Status: GOOD (  13.69  )
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

On Fri,  8 Feb 2019 17:09:43 +0100
Gregory CLEMENT <gregory.clement@bootlin.com> wrote:

> A few headers was useless: remove them, and also sort them in alphabetic
> order.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Hmm. Given the headers in question are mostly only useless (I think)
in the sense they are always included by something else, I'm
not sure this patch is worth the churn.

It's also tricky to see which ones were actually removed
given the combination with sorting.
I think it's just kernel.h, device.h, err.h all of which
are used in various ways and often directly included.

The other one is the iio/sysfs.h file.  That one we could
do to eventually kill off entirely, so happy to see that
one alone go.

Jonathan

> ---
>  drivers/iio/adc/lpc32xx_adc.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/adc/lpc32xx_adc.c b/drivers/iio/adc/lpc32xx_adc.c
> index e361c1532a75..f391c1e10136 100644
> --- a/drivers/iio/adc/lpc32xx_adc.c
> +++ b/drivers/iio/adc/lpc32xx_adc.c
> @@ -7,20 +7,13 @@
>   *  Copyright (C) 2011, 2012 Roland Stigge <stigge@antcom.de>
>   */
>  
> -#include <linux/module.h>
> -#include <linux/platform_device.h>
> -#include <linux/interrupt.h>
> -#include <linux/device.h>
> -#include <linux/kernel.h>
> -#include <linux/slab.h>
> -#include <linux/io.h>
>  #include <linux/clk.h>
> -#include <linux/err.h>
>  #include <linux/completion.h>
> -#include <linux/of.h>
> -
>  #include <linux/iio/iio.h>
> -#include <linux/iio/sysfs.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
>  
>  /*
>   * LPC32XX registers definitions


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
