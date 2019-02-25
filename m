Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D4CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:29:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BD8720684
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SJntLAos";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="VFEtUOzH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BD8720684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:Subject:From:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Gis+TXW3RkULQJCcsyGKiNszHTRiSY/kzANjQt1MsQE=; b=SJntLAosXbt5VP
	pci2pSal/HweI482LBX2CXtJpCAjauhGjkzhH1d+poquE1tkFe8v7P467dfeXzL/Lp1W12O4bMEbP
	Azu9mIqv8ugAAeRsH1rlZxI0ong8GLh5r1c/AKJUdeRCyeypvOJDHeVXHIQIlXSOishWFbe+fZWHZ
	MLC0NVpAW6iKqw0969/WKVX4Y01Uj8UrNgf8rpMqImKZXYFpxtk7SuggNq5/W3YlqmZJL8KEur50K
	ZHxYhg2NN2q8G3pSi3S3fzKqVWSc4MDdpGNqkLrYt4c9Gw+2ahi/gggKQf9YwDhZpyEiLXgnQ3V5w
	gG2ajxU5HrY/hxLcqcKg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyJ8B-0000tp-EV; Mon, 25 Feb 2019 16:29:27 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyJ86-0000sh-TV
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 16:29:24 +0000
Received: by mail-lj1-x244.google.com with SMTP id t13so3595333lji.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 08:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
 h=from:subject:to:cc:references:organization:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=77QWyaOvI4TWPkxmGkA0CNCiytGViRfoudTqrVdJ1sA=;
 b=VFEtUOzHjjMvjKjWe28jdukO6Eqb1NTwUui0nv9p0cWKhkLU5mV6KCail7FeJ7OJIs
 AumIQ9rgIlFy3zXvPOJ0BNUgWXuP4f28CPm13HpUsgrkTU6SvLuHpQOJVNGv/KrqpvHz
 03WU+x0fKLYIuOV/ndcJ5r88dRnee8LX6k22w3b8yknMyvrMig51UUEsJML2hOPfAXph
 B/sMxl4BWKhsnVIc6bp7+8697m71pXS8Tvw+O51RGpw37Rz204Pxnzx3Q/tBLDPQCuKv
 1DHXdryAbWGkpeI5wS6+OZzrWKo37S23Ms+2USe1eew6SybQY/HDNk2VOSDSx2b3vkxi
 1yOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:subject:to:cc:references:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=77QWyaOvI4TWPkxmGkA0CNCiytGViRfoudTqrVdJ1sA=;
 b=oUMlVl/wUgBtDpMmU/PrtAaKAgRUn0S4FfX+ER/BDtto7hZBoi440aMomHnrS9dMkZ
 oFpUQceOvH5q3e1YPUftgIIfyoTbmrNT3QkAp9og5BAsY+Ak7sj1xl2VpSmhRHEyCMDk
 F/ogcP3KPhpfssyg1hxcRMXxIvK1Io8Tel5QhixxpI/guiJbkUUZeP2tfE4qwM/Hl6TO
 9HpPasy5gCVzmIPfDHiqaHlIp4607aNScWhoZZ0n0dthLv3VUCl2ICjYRL5q2d4/Zjg/
 qemDXLeH46B2gNN6wVYgqV1kXKbeUSlTFCqurfbrPJ+FOZgMnOPCOBwEkUwqcYDGoX9b
 6h+A==
X-Gm-Message-State: AHQUAuYF+QYxpL2Q4IjkO2se/VorMQm+X2yYIBIRHWNEEqBcdXz8DnWp
 Kn9FeNO4iHWF8fSp5k0urYF+ybinAbw=
X-Google-Smtp-Source: AHgI3IYYdp8ellX2609vk7mUpmN7j1raOop0Ut9baFTdGn7sWHszjVWlrWh8+ZWGmp3MGqsf4W4hrQ==
X-Received: by 2002:a2e:5d59:: with SMTP id r86mr9097130ljb.158.1551112159217; 
 Mon, 25 Feb 2019 08:29:19 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.86.138])
 by smtp.gmail.com with ESMTPSA id i15sm2361409ljb.48.2019.02.25.08.29.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 25 Feb 2019 08:29:18 -0800 (PST)
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
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
Organization: Cogent Embedded
Message-ID: <907041d1-8412-22ca-3716-109a56251850@cogentembedded.com>
Date: Mon, 25 Feb 2019 19:29:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190219063607.29949-6-vigneshr@ti.com>
Content-Language: en-MW
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_082923_209032_E3A99A31 
X-CRM114-Status: GOOD (  24.92  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello!

On 02/19/2019 09:36 AM, Vignesh R (by way of Boris Brezillon <bbrezillon@kernel.org>) wrote:

> Add driver for Hyperbus memory controller on TI's AM654 SoC. Programming
> IP is pretty simple and provides direct memory mapped access to
> connected Flash devices.

   Are you sure you posted the _complete_ driver?

> Add basic support for the IP without DMA. Second ChipSelect is not
> supported for now.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  drivers/mtd/hyperbus/hbmc_am654.c | 105 ++++++++++++++++++++++++++++++
>  1 file changed, 105 insertions(+)
>  create mode 100644 drivers/mtd/hyperbus/hbmc_am654.c
> 
> diff --git a/drivers/mtd/hyperbus/hbmc_am654.c b/drivers/mtd/hyperbus/hbmc_am654.c
> new file mode 100644
> index 000000000000..1f0d2dc52f9f
> --- /dev/null
> +++ b/drivers/mtd/hyperbus/hbmc_am654.c
> @@ -0,0 +1,105 @@
[...]
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
> +		dev_err(&pdev->dev, "failed to get memory resource\n");
> +		return -ENOENT;
> +	}
> +
> +	priv->regbase = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(priv->regbase)) {
> +		dev_err(dev, "Cannot remap controller address.\n");
> +		return PTR_ERR(priv->regbase);
> +	}
> +
> +	pm_runtime_enable(&pdev->dev);
> +	err = pm_runtime_get_sync(&pdev->dev);

   That's all nice but where's the code that accesses the actual registers?

> +	if (err < 0) {
> +		pm_runtime_put_noidle(&pdev->dev);

   Calling "put" with previously failed "get" sees strange...

> +		return err;
> +	}
> +
> +	priv->hbdev.needs_calib = true;
> +	priv->hbdev.dev = &pdev->dev;
> +	priv->hbdev.np = of_get_next_child(dev->of_node, NULL);
> +	err = hb_register_device(&priv->hbdev);
> +	if (err) {
> +		dev_err(&pdev->dev, "failed to register controller\n");
> +		goto err_destroy;
> +	}
> +
> +	return 0;
> +
> +err_destroy:
> +	hb_unregister_device(&priv->hbdev);

   Calling "unregister" with "register" previously failed also looks strange...

> +	pm_runtime_put_sync(&pdev->dev);

   Why the sync() version?

> +	return err;
> +}
[...]

MBR, Sergei

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
