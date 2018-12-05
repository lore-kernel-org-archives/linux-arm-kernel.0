Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26BEC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:21:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4AA3208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HgcRaU7Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4AA3208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6uUWymCLczEy6uxAIsbgZI5vDrSv3PR40z0CazcnmFg=; b=HgcRaU7Y1cE4kf
	irg0rlPuY1yvYLoTATAh3MQz/g70+wPEt4kLozKDi8d6Nwo4kzFy/9opLIdXfHkCVtF+foFhgx62v
	SbgGfSy24XnVueRvKjEPh7g+ZQIk+M0vgmRpzM33S5Q/BnbWal+9cmfn1Qg4dEjPZM28Nk5pVSZHy
	Cy3lenhunkFTMeekWjgGt2v3mYKuwdZFwzDuyOEY341vJHrytDHFIsMO6dY4w2rDUC9TDxs6/WLiY
	rhAjgMUM3agPgwdc5ph8YlzmrFW0LYykBKtcOu5piX5n2QG7IxIpAcsi7j8/C6zg/5823MbWJTc61
	666A9xH01FRTf0pxCScQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUbnT-0005r2-9q; Wed, 05 Dec 2018 18:21:19 +0000
Received: from mail-lj1-f196.google.com ([209.85.208.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUbnQ-0005qY-1U
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 18:21:17 +0000
Received: by mail-lj1-f196.google.com with SMTP id e5-v6so19260548lja.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 10:21:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=4154P4SeFkHg5lRonBhn1yP7c3OfbebgZCOeZYCgayo=;
 b=AIaQ8Wy1OyylK23ItPoX58rIZddNR8ZDxq67fGP54nQQ6ELAYj9hrn+RKCzxYG/j4q
 XquvGicEo+aOgGVT8xfrzO5mrZN6Vz/7yK4QVV1sFB2a4pQ+/+mkqXhPlbvmm+J/dZvq
 q79AYo/NtsLYwmOQnsHESKWQDy5nshaS/4UnxvQEckeRPNnEJ1vCmLNzZh79JIaoHKB3
 oxr8EQSxSvpzhcKgUojYFNbo7lCX1E4J+r5M2AUsP/H9oeSWFYZTebBXvd+5kK8Mn3tm
 3gBMh9Ubgb64L0+npqAqwF0ZpCqclz1hzBYx6icQeFBcaiVlGtxR0pitmmM7VDgh8iH9
 YBfg==
X-Gm-Message-State: AA+aEWYgdV2Y/EXioxBxuKGrEIy+ppoV7C8xG05OedAqPbv3oNAsi0bG
 SRSZRFNrdb62ACYY5c3MrZw=
X-Google-Smtp-Source: AFSGD/WANUvT+PdsYCMdb7t9W6H3FQKUHEcDkyfIdMqDF1+Wwhh5XYSFkXddgEIYris5VMh04xMMEA==
X-Received: by 2002:a2e:2f15:: with SMTP id
 v21-v6mr6875126ljv.56.1544034063702; 
 Wed, 05 Dec 2018 10:21:03 -0800 (PST)
Received: from localhost.localdomain (84-253-205-125.bb.dnainternet.fi.
 [84.253.205.125])
 by smtp.gmail.com with ESMTPSA id y1-v6sm3889220ljh.39.2018.12.05.10.21.00
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 05 Dec 2018 10:21:01 -0800 (PST)
Date: Wed, 5 Dec 2018 20:20:58 +0200
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v6 03/10] clk: of-provider: look at parent if registered
 device has no provider info
Message-ID: <20181205182058.GF31204@localhost.localdomain>
References: <cover.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
 <a40442ad1a2f1d13798ba535eca371845bae9248.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
 <154395229720.88331.16585219136189943316@swboyd.mtv.corp.google.com>
 <20181205070046.GD31204@localhost.localdomain>
 <154403037317.88331.9382087418367713867@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <154403037317.88331.9382087418367713867@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_102116_085177_BE466187 
X-CRM114-Status: GOOD (  27.46  )
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
Cc: david.brown@linaro.org, rafael.j.wysocki@intel.com,
 linux-clk@vger.kernel.org, b.zolnierkie@samsung.com, andrew.smirnov@gmail.com,
 linux-kernel@vger.kernel.org, mturquette@baylibre.com,
 mazziesaccount@gmail.com, linux-doc@vger.kernel.org, linux@armlinux.org.uk,
 krzk@kernel.org, akshu.agrawal@amd.com, cw00.choi@samsung.com,
 djkurtz@chromium.org, pavel@ucw.cz, pombredanne@nexb.com,
 andy.gross@linaro.org, sjhuang@iluvatar.ai,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 05, 2018 at 09:19:33AM -0800, Stephen Boyd wrote:
> Quoting Matti Vaittinen (2018-12-04 23:00:46)
> > But that won't solve the issue if we don't do "dirty hacks" in driver.
> > The devm interface still only gets the device-pointer, not the DT node
> > as argument. And if DT node for device is NULL (like in MFD cases) -
> > then there is no parent node, only parent device with a node. For plain
> > of_clk_add_provider() the driver can just give the parent's node pointer
> > in cases where it knows it is the parent who has the provider data in
> > DT. But our original problem is in devm interfaces.
> > 
> 
> I was misunderstanding the MFD design. Should still work though, so I
> squashed this into the patch to clean things up a bit. Does this work
> for you?

This looks good to me. Especially changing the of_is_clk_provider to
get_clk_provider_node which allows to remove some repetition. If you
apply this then I will drop my patch from the series. Just please let me
know. I will cook version 7 of the series at Friday - tomorrow is the
independence day in Finland and I'll be offline =)

Thanks!

> 
> ------8<-----
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index bb689161f0f5..6ff852bda892 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -3893,9 +3893,23 @@ static void devm_of_clk_release_provider(struct device *dev, void *res)
>  	of_clk_del_provider(*(struct device_node **)res);
>  }
>  
> -static int of_is_clk_provider(struct device_node *np)
> +/*
> + * We allow a child device to use its parent device as the clock provider node
> + * for cases like MFD sub-devices where the child device driver wants to use
> + * devm_*() APIs but not list the device in DT as a sub-node.
> + */
> +static struct device_node *get_clk_provider_node(struct device *dev)
>  {
> -	return !!of_find_property(np, "#clock-cells", NULL);
> +	struct device_node *np, *parent_np;
> +
> +	np = dev->of_node;
> +	parent_np = dev->parent ? dev->parent->of_node : NULL;
> +
> +	if (!of_find_property(np, "#clock-cells", NULL))
> +		if (of_find_property(parent_np, "#clock-cells", NULL))
> +			np = parent_np;
> +
> +	return np;
>  }
>  
>  /**
> @@ -3920,17 +3934,12 @@ int devm_of_clk_add_hw_provider(struct device *dev,
>  	struct device_node **ptr, *np;
>  	int ret;
>  
> -	np = dev->of_node;
> -
> -	if (!of_is_clk_provider(dev->of_node))
> -		if (of_is_clk_provider(dev->parent->of_node))
> -			np = dev->parent->of_node;
> -
>  	ptr = devres_alloc(devm_of_clk_release_provider, sizeof(*ptr),
>  			   GFP_KERNEL);
>  	if (!ptr)
>  		return -ENOMEM;
>  
> +	np = get_clk_provider_node(dev);
>  	ret = of_clk_add_hw_provider(np, get, data);
>  	if (!ret) {
>  		*ptr = np;
> @@ -3981,13 +3990,8 @@ static int devm_clk_provider_match(struct device *dev, void *res, void *data)
>  void devm_of_clk_del_provider(struct device *dev)
>  {
>  	int ret;
> -	struct device_node *np;
> -
> -	np = dev->of_node;
> +	struct device_node *np = get_clk_provider_node(dev);
>  
> -	if (!of_is_clk_provider(dev->of_node))
> -		if (of_is_clk_provider(dev->parent->of_node))
> -			np = dev->parent->of_node;
>  	ret = devres_release(dev, devm_of_clk_release_provider,
>  			     devm_clk_provider_match, np);
>  
> 

-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
