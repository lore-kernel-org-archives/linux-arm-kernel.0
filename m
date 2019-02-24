Return-Path: <SRS0=QUhG=Q7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A98C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 14:08:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 622B5206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 14:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ijDTgbLF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="sLxiFdFp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 622B5206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RQPXpSUv4bHp/mvz6JB7PbcDCE91zh+w3ZDZpNfr0E4=; b=ijDTgbLFL4glo3qrCQDImio+k
	cdBhWLSmKx7udSdgW7xWx+AgK7wbIZjuO8PMwJDDuhUiFty0Ghz+bd+qvvNKQCaDUvU5bBvHByBNJ
	1nSszv53nU0l2QfVI+19xbYMDyPOXRVCBAi/dp5eyv6FHo9GldAJMQsg/3QC+eJ/O4A5t3YgyjR+u
	m2/OMDVjqJafy43Y05ExnXApfAog5arm0taHhhBWiI6Ka0LlIXIWStoaSHEQE6enVors1aQ4hgMS8
	5CBEjWJ0zOBI3JPcXVwJVVZaEMtKbnIaV/H1vujxip2xyHtKY7pAlble9zdwYS8JS+jMsNMNieuNC
	gs+QPOeRQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxuRy-0000aV-JH; Sun, 24 Feb 2019 14:08:14 +0000
Received: from mail-lf1-f66.google.com ([209.85.167.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxuRa-00006J-QO
 for linux-arm-kernel@lists.infradead.org; Sun, 24 Feb 2019 14:07:57 +0000
Received: by mail-lf1-f66.google.com with SMTP id z196so4262150lff.4
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 24 Feb 2019 06:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=X7AyGWsy6lqqt1CMP5klNyO7Se+yGqcYOfqOpxc8ZyY=;
 b=sLxiFdFpGTAsznEby3fF1geo7APwsBaQOD5Qtryj0FV6wz6OTh1jW1/9OvX5oMt5rT
 TKn4WCt5Q+x2EGyQHaZ5l/bSTyH2zfkNTFOttdFbGWBdy5b3OaNRwLOWtvkj4YpOIQuk
 OUw/nU9u3Uh6UgoCV6jXX8Bcm1aTB5s3U3EZ3gLPUVudvvbiRk7pi2jh8HEDATD2aZal
 pzVImyqAkskZRmf7jJ7HaIJTZklEBrnOajrYZs86qQFAui0nJ6+0ZduOSvHlHPsOOKkP
 DqL0JEELpEUALXT4TaDI5dfajiBpza+DZn/3qVioeBS385YS1IFDezEYVZ4IU0rarodM
 p/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=X7AyGWsy6lqqt1CMP5klNyO7Se+yGqcYOfqOpxc8ZyY=;
 b=UEXzJIN9Ij/kHeWNhIbqZUrRQJl4kl6UxCktKKy0489cU8lDMfsM09B1l0TxhZYqXU
 hmcm+rRQAQSTi3mCfPoiXTCQapFSJwT0SK2dyzf9BfRLz7sFdNR43gzbSa6qBIMh2H56
 pomfq4QpiCQK0qecQ8jzFFPVqTEI+4XQwRIyc+BtgxuVea0F7C+BHVac7Sb+KScRMiSU
 J6KD4JT7UHR5JnmjAakCB6q5/p8ZCH9PPEYtHesKJSPQtW2UcqKE0MJ3ycGKU71l2tpw
 KaJW+wCbwyLNp7FUTHdFJfSjLwEXwY9PxEDAoBQw1dg1hCNaVoToE/b1fQk+kUmNu5b0
 ihXw==
X-Gm-Message-State: AHQUAuaf0QeTIl0Ejr417LLOEk82H6z/MtGVvPZaJP+q+YR1KDqiRB6z
 C3eBiqswwx2m5Dbey259EsAA2jYTQ1E=
X-Google-Smtp-Source: AHgI3IalkRMkO15u/S1T1c9U+qR+uhOu2lPS0TW2/sC74Xcb7Y3gq3zt7QQ/crFfS9sBMFEXKjtJcw==
X-Received: by 2002:a19:5209:: with SMTP id m9mr7437620lfb.51.1551017207080;
 Sun, 24 Feb 2019 06:06:47 -0800 (PST)
Received: from [192.168.0.199] ([31.173.83.141])
 by smtp.gmail.com with ESMTPSA id c22sm2254961lfi.27.2019.02.24.06.06.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 24 Feb 2019 06:06:46 -0800 (PST)
Subject: Re: [RFC PATCH 5/5] mtd: hyperbus: Add driver for TI's Hyperbus
 memory controller
To: "Vignesh R (by way of Boris Brezillon <bbrezillon@kernel.org>)"
 <vigneshr@ti.com>, David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Boris Brezillon <bbrezillon@kernel.org>, Marek Vasut
 <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>,
 Rob Herring <robh+dt@kernel.org>
References: <20190219063607.29949-1-vigneshr@ti.com>
 <20190219063607.29949-6-vigneshr@ti.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <61d04389-414a-70d8-ad33-36ed138df38c@cogentembedded.com>
Date: Sun, 24 Feb 2019 17:06:44 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190219063607.29949-6-vigneshr@ti.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190224_060754_200824_04BAF765 
X-CRM114-Status: GOOD (  21.93  )
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
Cc: devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 tudor.ambarus@microchip.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello!

On 19.02.2019 9:36, Vignesh R (by way of Boris Brezillon
<bbrezillon@kernel.org>) wrote:

> Add driver for Hyperbus memory controller on TI's AM654 SoC. Programming
> IP is pretty simple and provides direct memory mapped access to
> connected Flash devices.
> 
> Add basic support for the IP without DMA. Second ChipSelect is not
> supported for now.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>   drivers/mtd/hyperbus/hbmc_am654.c | 105 ++++++++++++++++++++++++++++++
>   1 file changed, 105 insertions(+)
>   create mode 100644 drivers/mtd/hyperbus/hbmc_am654.c
> 
> diff --git a/drivers/mtd/hyperbus/hbmc_am654.c b/drivers/mtd/hyperbus/hbmc_am654.c
> new file mode 100644
> index 000000000000..1f0d2dc52f9f
> --- /dev/null
> +++ b/drivers/mtd/hyperbus/hbmc_am654.c
> @@ -0,0 +1,105 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
> +// Author: Vignesh R <vigneshr@ti.com>
> +
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mtd/hyperbus.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/types.h>
> +
> +struct am654_hbmc_priv {
> +	struct hb_device hbdev;
> +	void __iomem	*regbase;
> +};
> +
> +static int am654_hbmc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct am654_hbmc_priv *priv;
> +	struct resource *res;
> +	int err;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (IS_ERR(res)) {

     I don't think that function ever returns error ptrs. It should only 
return NULL on error.

> +		dev_err(&pdev->dev, "failed to get memory resource\n");
> +		return -ENOENT;
> +	}
> +
> +	priv->regbase = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(priv->regbase)) {
> +		dev_err(dev, "Cannot remap controller address.\n");

    The above function already prints its error messages.

[...]
> +module_platform_driver(am654_hbmc_platform_driver);
> +
> +MODULE_DESCRIPTION("HBMC driver for AM654 SoC");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:hbmc-am654");
> +MODULE_AUTHOR("Vignesh R <vigneshr@ti.com>");

MBR, Sergei

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
