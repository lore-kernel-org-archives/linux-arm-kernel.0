Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9BDC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:28:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FB0B20645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r0f0q2Vg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FB0B20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=B1gXtRymjRCPyWcitRmTvQ/U3ysO3B7aihlpQC6Get4=; b=r0f0q2VgamEvKm
	805GyGjwGphSpaCndu5eEIDMqn9mrvFi9uVyzp7zaHdyOU9QpNVWUKDI43ebRWsPh1uH2pFs5cIev
	r+9iknhS7xmM5fBIH+fMcY7Vi+dfenOYvVRpqYFt0hSP52pLi3nSpga1o3Q6ykMyT79xdVPwgUqb6
	q12krn9z5qRRBhxJTJOL/kWBtV1sMJOgGX5rjK4Yg+gnBsNtnNMlmRtteGIrYQwf9B1wWBMDA8+1c
	IWK92mZvQxVXFY4X/t1qadBsDRoDnv7p5HgJ3rxZVbkd5rgxVbroRNj/reDJqileDBHUaoBnPQa/d
	Hoooirl1HkkNPykV7Fyw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUbul-0000kt-Pe; Wed, 05 Dec 2018 18:28:51 +0000
Received: from mail-lf1-f68.google.com ([209.85.167.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUbui-0000k1-OI
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 18:28:50 +0000
Received: by mail-lf1-f68.google.com with SMTP id v5so15473392lfe.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 10:28:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=wcAYodGRQZ/WfRzInPOa7lnugvmEvDMMOgV0d6MP/tM=;
 b=EO3oAYKGCq2JbcRw2a+rb9+6CZAm2LUNcScvuxhs1Wr5VqTDNFSPb8ShhU1mRFPYoH
 jk7JBePIIzXZNxD/1+fbpygB+2Jo8xi0hvLMFokoD18yYM0NJelro4d3f9Tv67UzvdVw
 oljycaudU6qKi+O5SHCJ3mczrTo0gMGUV1GZmLwkDVadg2luaPB3uOUjZu5SWe+rSvkK
 uAcBIt4ZlFNrVOoVuH07GBi797DqTrd9bOFZoxYSk0Lfwj6KpACEmuXzTP4mSC1ChP1N
 rgpaorNaGtuny6P578c/VqMdSc9skyoEQknbwGFaAwJx0zQmUCyw/fHffwyIgFMhN7nO
 Cggg==
X-Gm-Message-State: AA+aEWZvQ7b2N6gcxY3mRZHULEl6dZGUy+CG+7PmcmeyQKvvZ3pSpbZx
 k4QNWWHHOk9VvhwAYngFzAs=
X-Google-Smtp-Source: AFSGD/UfvKZo8AQnNasUmVrPXrNZkiV+4F00iATCP6ePoMJ3gS72wcJ70enMR/Zvzg40049wZVywRw==
X-Received: by 2002:ac2:4116:: with SMTP id b22mr15692588lfi.19.1544034516157; 
 Wed, 05 Dec 2018 10:28:36 -0800 (PST)
Received: from localhost.localdomain (84-253-205-125.bb.dnainternet.fi.
 [84.253.205.125])
 by smtp.gmail.com with ESMTPSA id 13-v6sm3814335ljj.49.2018.12.05.10.28.34
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 05 Dec 2018 10:28:35 -0800 (PST)
Date: Wed, 5 Dec 2018 20:28:32 +0200
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v6 03/10] clk: of-provider: look at parent if registered
 device has no provider info
Message-ID: <20181205182832.GH31204@localhost.localdomain>
References: <cover.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
 <a40442ad1a2f1d13798ba535eca371845bae9248.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
 <154395229720.88331.16585219136189943316@swboyd.mtv.corp.google.com>
 <20181205070046.GD31204@localhost.localdomain>
 <154403037317.88331.9382087418367713867@swboyd.mtv.corp.google.com>
 <20181205182058.GF31204@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181205182058.GF31204@localhost.localdomain>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_102848_789450_D049E95A 
X-CRM114-Status: GOOD (  30.69  )
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

On Wed, Dec 05, 2018 at 08:20:58PM +0200, Matti Vaittinen wrote:
> On Wed, Dec 05, 2018 at 09:19:33AM -0800, Stephen Boyd wrote:
> > Quoting Matti Vaittinen (2018-12-04 23:00:46)
> > > But that won't solve the issue if we don't do "dirty hacks" in driver.
> > > The devm interface still only gets the device-pointer, not the DT node
> > > as argument. And if DT node for device is NULL (like in MFD cases) -
> > > then there is no parent node, only parent device with a node. For plain
> > > of_clk_add_provider() the driver can just give the parent's node pointer
> > > in cases where it knows it is the parent who has the provider data in
> > > DT. But our original problem is in devm interfaces.
> > > 
> > 
> > I was misunderstanding the MFD design. Should still work though, so I
> > squashed this into the patch to clean things up a bit. Does this work
> > for you?
> 
> This looks good to me. Especially changing the of_is_clk_provider to
> get_clk_provider_node which allows to remove some repetition. If you
> apply this then I will drop my patch from the series. Just please let me
> know. I will cook version 7 of the series at Friday - tomorrow is the
> independence day in Finland and I'll be offline =)

I see you already applied the follow-up patches to clk-next. Please note
that most of the clean-ups did require this functionality as they used
the parent DT node.

> 
> Thanks!
> 
> > 
> > ------8<-----
> > 
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index bb689161f0f5..6ff852bda892 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -3893,9 +3893,23 @@ static void devm_of_clk_release_provider(struct device *dev, void *res)
> >  	of_clk_del_provider(*(struct device_node **)res);
> >  }
> >  
> > -static int of_is_clk_provider(struct device_node *np)
> > +/*
> > + * We allow a child device to use its parent device as the clock provider node
> > + * for cases like MFD sub-devices where the child device driver wants to use
> > + * devm_*() APIs but not list the device in DT as a sub-node.
> > + */
> > +static struct device_node *get_clk_provider_node(struct device *dev)
> >  {
> > -	return !!of_find_property(np, "#clock-cells", NULL);
> > +	struct device_node *np, *parent_np;
> > +
> > +	np = dev->of_node;
> > +	parent_np = dev->parent ? dev->parent->of_node : NULL;
> > +
> > +	if (!of_find_property(np, "#clock-cells", NULL))
> > +		if (of_find_property(parent_np, "#clock-cells", NULL))
> > +			np = parent_np;
> > +
> > +	return np;
> >  }
> >  
> >  /**
> > @@ -3920,17 +3934,12 @@ int devm_of_clk_add_hw_provider(struct device *dev,
> >  	struct device_node **ptr, *np;
> >  	int ret;
> >  
> > -	np = dev->of_node;
> > -
> > -	if (!of_is_clk_provider(dev->of_node))
> > -		if (of_is_clk_provider(dev->parent->of_node))
> > -			np = dev->parent->of_node;
> > -
> >  	ptr = devres_alloc(devm_of_clk_release_provider, sizeof(*ptr),
> >  			   GFP_KERNEL);
> >  	if (!ptr)
> >  		return -ENOMEM;
> >  
> > +	np = get_clk_provider_node(dev);
> >  	ret = of_clk_add_hw_provider(np, get, data);
> >  	if (!ret) {
> >  		*ptr = np;
> > @@ -3981,13 +3990,8 @@ static int devm_clk_provider_match(struct device *dev, void *res, void *data)
> >  void devm_of_clk_del_provider(struct device *dev)
> >  {
> >  	int ret;
> > -	struct device_node *np;
> > -
> > -	np = dev->of_node;
> > +	struct device_node *np = get_clk_provider_node(dev);
> >  
> > -	if (!of_is_clk_provider(dev->of_node))
> > -		if (of_is_clk_provider(dev->parent->of_node))
> > -			np = dev->parent->of_node;
> >  	ret = devres_release(dev, devm_of_clk_release_provider,
> >  			     devm_clk_provider_match, np);
> >  
> > 
> 
> -- 
> Matti Vaittinen
> ROHM Semiconductors
> 
> ~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~

-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
