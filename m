Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46004C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:16:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FA4120878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SM1tJ+7r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FA4120878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rYbxklCvQw4KPDpLgzQFRecv8wwoU00xNFaqjmmmjlw=; b=SM1tJ+7rOMj4Ky
	5Gxkq+Uxq/0g2/fprhTDH1C6M1Hry175bf9iDEEWmpTSIaAEoch3XuWTdm1YsA3enXn/eRV2ZGLbA
	EcuwC8czswAdIIeUs1J/xcnVKWo1fyiIX7BBJVwwZH05IrUVlqCstTJrTvyxl5zuPnfP5YEBgeXss
	B06UortN6EzpOBcX0mhCWgt5kLrJvUvdE6IB5OzUh01ccIsUDB0k7sSeJigmgZ5L7rXxWwYOWwg9V
	1bT4uMNjj1AkBBC30FJVfB2R0WUI/U39iaicxv/1QvNfkIejITxOAimACY4fzRx7tDKHqwRRMjIfa
	tH7sKjvFyn8eI25IzXjw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTn9H-0006Tv-0o; Mon, 03 Dec 2018 12:16:27 +0000
Received: from mail-lj1-f193.google.com ([209.85.208.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTn9C-0006SR-QK
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 12:16:25 +0000
Received: by mail-lj1-f193.google.com with SMTP id 83-v6so11130257ljf.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 04:16:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=yD5iVmypOBQumLl+qGUTl1jKrrZfOHc7K3noc5twFmE=;
 b=mQnwmsihD94uNB1jbTuG+NS+nz0JuB2vyNfGjryWosNR8BY0PMBnEXKxqceHZlUyOG
 /U/mOYzXyJlW9JEMelRg3apniOekzo3CSxvANx2a/p5Wi4WCZt8DiHoBXehOJkYJzQMw
 D0C4/PVMpI56Egs2UWhSCb/YBkRMflFXN7KllvztCQi6wRZy9KkKwcJjRKB7TZCH4t5h
 S38BHbEr4AnO9d6YB3kXfbQtKNgeupdsVvk+l8QTjyzqHcyWJXL3gC8Vpl7BAUfJgNLc
 2qhMiylIdq5c2k+xJvXvyRJpPNhh02mgWZaxygtXVMWkZzB23h9SH43sZoKvmB42bZI0
 PXYg==
X-Gm-Message-State: AA+aEWbTfhfYf8Z4iTp3UDVRVf+oJ21Q5k7PtU80VWXY78xU4z7lfXKF
 MxZ7l5nuJzAMvj13GHFeA+k=
X-Google-Smtp-Source: AFSGD/V9Gq703U5if+R8Zc+VCdNkNOkpC31SbP76EShumpu2cWwKss7RdnrH21yapoPz4tXab7x5DA==
X-Received: by 2002:a2e:9dcb:: with SMTP id
 x11-v6mr10946163ljj.158.1543839369778; 
 Mon, 03 Dec 2018 04:16:09 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
 by smtp.gmail.com with ESMTPSA id d82sm2344923lfd.82.2018.12.03.04.16.07
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 03 Dec 2018 04:16:08 -0800 (PST)
Date: Mon, 3 Dec 2018 14:16:05 +0200
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v4 1/8] clk: clkdev/of_clk - add managed lookup and
 provider registrations
Message-ID: <20181203121605.GC15388@localhost.localdomain>
References: <cover.1542107769.git.matti.vaittinen@fi.rohmeurope.com>
 <ec0d6ee7ea79f0e05041ed3e564b0aadb297ef5f.1542107769.git.matti.vaittinen@fi.rohmeurope.com>
 <154356805035.88331.16867826308376667832@swboyd.mtv.corp.google.com>
 <20181130105022.GA15388@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181130105022.GA15388@localhost.localdomain>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_041623_414915_B9B0638A 
X-CRM114-Status: GOOD (  35.44  )
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
Cc: linux-doc@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>,
 Daniel Kurtz <djkurtz@chromium.org>, Sebastian Reichel <sre@kernel.org>,
 David Brown <david.brown@linaro.org>, Lee Jones <lee.jones@linaro.org>,
 linux-clk@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrey Smirnov <andrew.smirnov@gmail.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Russell King <linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk@kernel.org>,
 Chanwoo Choi <cw00.choi@samsung.com>, Andy Gross <andy.gross@linaro.org>,
 Huang Shijie <sjhuang@iluvatar.ai>, Guenter Roeck <linux@roeck-us.net>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Akshu Agrawal <akshu.agrawal@amd.com>, mazziesaccount@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello Stephen & All,

I created v5 where I fixed obvious issues. I'll send it in few minutes.
Please note following topics:

On Fri, Nov 30, 2018 at 12:50:22PM +0200, Matti Vaittinen wrote:
> 
> On Fri, Nov 30, 2018 at 12:54:10AM -0800, Stephen Boyd wrote:
> > Quoting Matti Vaittinen (2018-11-13 03:55:58)
> > >  
> > > -int devm_of_clk_add_hw_provider(struct device *dev,
> > > +static int __devm_of_clk_add_hw_provider(struct device *dev,
> > >                         struct clk_hw *(*get)(struct of_phandle_args *clkspec,
> > >                                               void *data),
> > > -                       void *data)
> > > +                       struct device_node *of_node, void *data)
> > >  {
> > > -       struct device_node **ptr, *np;
> > > +       struct device_node **ptr;
> > >         int ret;
> > >  
> > >         ptr = devres_alloc(devm_of_clk_release_provider, sizeof(*ptr),
> > > @@ -3906,10 +3906,9 @@ int devm_of_clk_add_hw_provider(struct device *dev,
> > >         if (!ptr)
> > >                 return -ENOMEM;
> > >  
> > > -       np = dev->of_node;
> > > -       ret = of_clk_add_hw_provider(np, get, data);
> > > +       *ptr = of_node;
> > > +       ret = of_clk_add_hw_provider(of_node, get, data);
> > >         if (!ret) {
> > > -               *ptr = np;
> > 
> > Why is this moved outside of the if condition?
> I completely removed the local variable np and just unconditionally set
> the allocated devres to point at the node (if allocation succeeded). We
> could of course only do this if the provider registration succeeded and
> save one assignment - but I guess I intended to remove the curly braces
> and thus decided to go for one liner after if. But apparently I didn't
> remove the braces O_o. Well, I can put the assignment inside the
> condition if you prefer that.
> 
> > In fact, why isn't just
> > the first line in this hunk deleted and passed to this function as
> > struct device_node *np?
> 
> I am sorry but I don't quite follow your suggestion here. Do you mean we
> could just pass the struct device_node *np in devres_add()? I thought
> the pointer passed to devress_add() should be allocated using
> devres_alloc. Can you please elaborate what you mean?

I could not really spot what to fix in patched code (see below).

static int __devm_of_clk_add_hw_provider(struct device *dev,
			struct clk_hw *(*get)(struct of_phandle_args *clkspec,
					      void *data),
			struct device_node *of_node, void *data)
{
	struct device_node **ptr;
	int ret;

	ptr = devres_alloc(devm_of_clk_release_provider, sizeof(*ptr),
			   GFP_KERNEL);
	if (!ptr)
		return -ENOMEM;

	*ptr = of_node;
	ret = of_clk_add_hw_provider(of_node, get, data);
	if (!ret)
		devres_add(dev, ptr);
	else
		devres_free(ptr);

	return ret;
}

As far as I understand we need to allocate the ptr using devres_alloc.
We also need to pass this ptr to of_clk_add_hw_provider - and we must
assign our node to the *ptr. (I removed the extra braces - this change
is laso included in v5 but I don't see how we should improve). Can you
please explain me if you still wish to me change this further?

> > > +int devm_of_clk_add_parent_hw_provider(struct device *dev,
> > > +                       struct clk_hw *(*get)(struct of_phandle_args *clkspec,
> > > +                                             void *data),
> > > +                       void *data)
> > > +{
> > > +       return __devm_of_clk_add_hw_provider(dev, get, dev->parent->of_node,
> > 
> > I'm wondering if we can somehow auto-detect this in
> > devm_of_clk_add_hw_provider() by looking for #clock-cells in the node.
> > If it isn't there, then we go to the parent node and look for a
> > #clock-cells property there in the DT node for that device. Does that
> > make sense? Then there isn't any new API and we can attach the lifetime
> > of the devm registration to the presence of the property indicating this
> > is a clk controller or not.
> 
> Huh. I don't know why but building this kind of logic in core is a bit
> scary to me. I guess I can try implementing something like this - but I
> am not really a fan of this. (Accidentally) omit the #clock-cells from
> node and we go to parent node - I am a novice on this area but this
> sounds like a potential hazard to me. I believe the driver should know
> if it's properties should be in own or parent node - and if they are
> not, then there should be no guessing but error. The lifetime is topic
> where I would like to get information from you who know the kernel
> better than I do =) But I guess the parent node is there at least as
> long as the child device is alive. So for me the life time of
> get-callback is more crucial - but as I said, I don't understand the
> kernel in details so you probably know it better than me. But please let
> me know your final take on this and I will follow the guidance =)

I did not put the 'auto-detection' for provider node in the patch v5 as
it really gives me bad vibes :) Maybe it is just my pessimistic nature
but I do expect that problems will arise when we accidentally end up in
parent node when this is not the purpose. I would rather keep this
simple by adding one specific API function more - and keeping the
existing API specific as well. But I can do v5 if you insist on having
this auto-detection.

-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
