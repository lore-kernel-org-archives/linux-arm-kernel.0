Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A6EC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:50:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C80B920863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LkrIQeXa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C80B920863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=byny+1uEOpBXN8jgMcj+bLKVYSJ2NskcDWVuoSOQ+o8=; b=LkrIQeXaFWQdtJ
	qsLYnDx6mh8QD6/b0KfizkW2qqMnib+jSVfEbMqQINB1nRaaLScQqqyZn/ndOOZ4GM4n83gWY5sqX
	MyRaO+TEXL34glLRKTVY+nQst2jST1DmpFkVNqb+4imxYlYZVLcJWJ1PYjbX8dltiNY+xNjjlG8vv
	iaceZLG1VHp6ZK4Vz/XDFVisaQreNpMt+xCR8ii9zPSWF+IRoz7WAhmpK3oHnpu1/kKpxV7FY0iZE
	0D6Y2lK2Bk3Rgq0TGekDKc5lyT+yPAO1+neaZqgMPxpNwxxm3DUJa5QGYgO+2ClUVtrBnyJmmshaQ
	lXqydblIkthNS3gyVVZw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSgNk-0004F6-Lx; Fri, 30 Nov 2018 10:50:48 +0000
Received: from mail-lj1-f196.google.com ([209.85.208.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSgNg-0004Dv-Cf
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 10:50:46 +0000
Received: by mail-lj1-f196.google.com with SMTP id k19-v6so4553112lji.11
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 02:50:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=daG1XJ3xEPZRYjxjHEIMiZ2KfFhva5k8E7JnZvAC+Oo=;
 b=oMGrNwbTVZFLwlpK3lRqavVp9ImPcWpXRM9mLkU5EK8ECUHj1bf/NMpfX0K1B/8JDe
 IamvArZGzo6VuBAXuUdMD3wKxgyB5rYcWlMWZOpWRsxfuGv4UOS5kx6snNpLBJGpMp/4
 0PL93Jz9zalad6rMw/WOGxci0GHDtnuvvZBXEFRb3huoSLRGCqRzVg0srmjiv19eLhzX
 2v9tnvNaeO6c2M10sWvFtQ5KxaGNz30LFpqCTs+OxHOUyGtxAI4bl0dFBP8ubtiWwKN9
 Z/k/jNdIzACb7uoWW+z2eeVJa7jK+aEjkcE4fTpNsn8Fuk5oVHRioHwwLzZIMX9BjEgv
 ADEg==
X-Gm-Message-State: AA+aEWaeoLnyDaz/7awa9S5PqGZmYkMXGUKSawNbd78ympcxisBZ0Tnd
 kLB5pz++8lIutOA+nsZ8YSE=
X-Google-Smtp-Source: AFSGD/XFPJ1MMWBlTqXBpTiP9WCmLCT4QKpGGG+olHyyiMLUAlROfdFfvehxLuxm1UY3PtnHFDGMbQ==
X-Received: by 2002:a2e:2281:: with SMTP id
 i123-v6mr3117217lji.154.1543575031301; 
 Fri, 30 Nov 2018 02:50:31 -0800 (PST)
Received: from localhost.localdomain (84-253-205-125.bb.dnainternet.fi.
 [84.253.205.125])
 by smtp.gmail.com with ESMTPSA id s127sm753225lfe.8.2018.11.30.02.50.28
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 30 Nov 2018 02:50:30 -0800 (PST)
Date: Fri, 30 Nov 2018 12:50:22 +0200
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v4 1/8] clk: clkdev/of_clk - add managed lookup and
 provider registrations
Message-ID: <20181130105022.GA15388@localhost.localdomain>
References: <cover.1542107769.git.matti.vaittinen@fi.rohmeurope.com>
 <ec0d6ee7ea79f0e05041ed3e564b0aadb297ef5f.1542107769.git.matti.vaittinen@fi.rohmeurope.com>
 <154356805035.88331.16867826308376667832@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <154356805035.88331.16867826308376667832@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_025044_427505_31F555A2 
X-CRM114-Status: GOOD (  33.86  )
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

Hello Stephen,

Thanks a bunch for taking the time and reviewing this!

On Fri, Nov 30, 2018 at 12:54:10AM -0800, Stephen Boyd wrote:
> Quoting Matti Vaittinen (2018-11-13 03:55:58)
> > With MFD devices the clk properties may be contained in MFD (parent) DT
> > node. Current devm_of_clk_add_hw_provider assumes the clk is bound to MFD
> > subdevice not to MFD device (parent). Add
> > devm_of_clk_add_hw_provider_parent to tackle this issue.
> > 
> > Also clkdev registration lacks of managed registration functions and it
> > seems few drivers do not drop clkdev lookups at exit. Add
> > devm_clk_hw_register_clkdev and devm_clk_release_clkdev to ease lookup
> > releasing at exit.
> 
> Please split this into clkdev and non-clkdev devm functionality.
Allright. I'll split this to two patches.

> > --- a/Documentation/driver-model/devres.txt
> > +++ b/Documentation/driver-model/devres.txt
> > @@ -238,6 +238,9 @@ CLOCK
> >    devm_clk_put()
> >    devm_clk_hw_register()
> >    devm_of_clk_add_hw_provider()
> > +  devm_of_clk_add_parent_hw_provider()
> > +  devm_clk_hw_register_clkdev()
> > +  devm_clk_release_clkdev()
> 
> The 'release' or non-common functions shouldn't be documented here.
So I will drop the line mentioning devm_clk_release_clkdev()

> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index af011974d4ec..9bb921eb90f6 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -3893,12 +3893,12 @@ static void devm_of_clk_release_provider(struct device *dev, void *res)
> >         of_clk_del_provider(*(struct device_node **)res);
> >  }
> >  
> > -int devm_of_clk_add_hw_provider(struct device *dev,
> > +static int __devm_of_clk_add_hw_provider(struct device *dev,
> >                         struct clk_hw *(*get)(struct of_phandle_args *clkspec,
> >                                               void *data),
> > -                       void *data)
> > +                       struct device_node *of_node, void *data)
> >  {
> > -       struct device_node **ptr, *np;
> > +       struct device_node **ptr;
> >         int ret;
> >  
> >         ptr = devres_alloc(devm_of_clk_release_provider, sizeof(*ptr),
> > @@ -3906,10 +3906,9 @@ int devm_of_clk_add_hw_provider(struct device *dev,
> >         if (!ptr)
> >                 return -ENOMEM;
> >  
> > -       np = dev->of_node;
> > -       ret = of_clk_add_hw_provider(np, get, data);
> > +       *ptr = of_node;
> > +       ret = of_clk_add_hw_provider(of_node, get, data);
> >         if (!ret) {
> > -               *ptr = np;
> 
> Why is this moved outside of the if condition?
I completely removed the local variable np and just unconditionally set
the allocated devres to point at the node (if allocation succeeded). We
could of course only do this if the provider registration succeeded and
save one assignment - but I guess I intended to remove the curly braces
and thus decided to go for one liner after if. But apparently I didn't
remove the braces O_o. Well, I can put the assignment inside the
condition if you prefer that.

> In fact, why isn't just
> the first line in this hunk deleted and passed to this function as
> struct device_node *np?

I am sorry but I don't quite follow your suggestion here. Do you mean we
could just pass the struct device_node *np in devres_add()? I thought
the pointer passed to devress_add() should be allocated using
devres_alloc. Can you please elaborate what you mean?

> 
> >                 devres_add(dev, ptr);
> >         } else {
> >                 devres_free(ptr);
> > @@ -3917,8 +3916,25 @@ int devm_of_clk_add_hw_provider(struct device *dev,
> >  
> >         return ret;
> >  }
> 
> Nitpick: Add a newline here.

Will do.

> 
> > +int devm_of_clk_add_hw_provider(struct device *dev,
> > +                       struct clk_hw *(*get)(struct of_phandle_args *clkspec,
> > +                                             void *data),
> > +                       void *data)
> > +{
> > +       return __devm_of_clk_add_hw_provider(dev, get, dev->of_node, data);
> > +}
> >  EXPORT_SYMBOL_GPL(devm_of_clk_add_hw_provider);
> >  
> > +int devm_of_clk_add_parent_hw_provider(struct device *dev,
> > +                       struct clk_hw *(*get)(struct of_phandle_args *clkspec,
> > +                                             void *data),
> > +                       void *data)
> > +{
> > +       return __devm_of_clk_add_hw_provider(dev, get, dev->parent->of_node,
> 
> I'm wondering if we can somehow auto-detect this in
> devm_of_clk_add_hw_provider() by looking for #clock-cells in the node.
> If it isn't there, then we go to the parent node and look for a
> #clock-cells property there in the DT node for that device. Does that
> make sense? Then there isn't any new API and we can attach the lifetime
> of the devm registration to the presence of the property indicating this
> is a clk controller or not.

Huh. I don't know why but building this kind of logic in core is a bit
scary to me. I guess I can try implementing something like this - but I
am not really a fan of this. (Accidentally) omit the #clock-cells from
node and we go to parent node - I am a novice on this area but this
sounds like a potential hazard to me. I believe the driver should know
if it's properties should be in own or parent node - and if they are
not, then there should be no guessing but error. The lifetime is topic
where I would like to get information from you who know the kernel
better than I do =) But I guess the parent node is there at least as
long as the child device is alive. So for me the life time of
get-callback is more crucial - but as I said, I don't understand the
kernel in details so you probably know it better than me. But please let
me know your final take on this and I will follow the guidance =)

> 
> > +                                            data);
> > +}
> > +EXPORT_SYMBOL_GPL(devm_of_clk_add_parent_hw_provider);
> 
> Can we get some kernel doc on these functions?
Sure. I will add the doc. Reason why I didn't do it is that the current
devm_of_clk_add_hw_provider() did not have doc. But I'll add that in
next patch.

> > +       rval = devres_release(dev, devm_clkdev_release,
> > +                             &devm_clk_match_clkdev, cl);
> 
> Nitpick: Drop & on functions taken as pointers.
Ok. Will do.

-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
