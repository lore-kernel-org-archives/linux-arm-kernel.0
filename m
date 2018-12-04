Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4D6C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 07:13:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BA442082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 07:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P2mG0fDh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BA442082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ri7Fvftsu4yO1O8N7UlKGCe/r8h80mahKgEwKF2iI48=; b=P2mG0fDhv4rFrS
	IqLwfNxmdIkPARzGtMdvTARMyfXcKQ30B6gvJaLkQL5sk0pP6Opk72jUsPGxyv90sJqKrsTmEiVgV
	ZJLyT736ElYZ2ZuBFrqR+mR66ykluTMh8ZtJQWnUalOntXmTMXk92gCJfYijRHY0CORWwzaXspfwd
	gws/XWHsgSkG9QtOiGKcuEtVTvfqBHC78yHZLiwXjKLM2WDMpRaIJBFcNYiNhNF4yynq3jkeyAkoh
	gO6wrsHv4H9F2kD/0cHE62Rs3+QUtFCtGYKnTt/Poq/1cbHiJaSIlGHbrRxEWill4w/8NCy75WIUY
	BaoQY3NuoSTqUgxPrLFw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU4tq-0002tY-70; Tue, 04 Dec 2018 07:13:42 +0000
Received: from mail-lj1-f196.google.com ([209.85.208.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU4tm-0002sV-Fo
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 07:13:40 +0000
Received: by mail-lj1-f196.google.com with SMTP id v15-v6so13854906ljh.13
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 23:13:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=xmeezsH2L85SbH1REd44WuAJXxNc3UqWGXKyi96Uj28=;
 b=eIbtJPF/AJgl3CCmBJfOrAmxrg0TRzifnqjkCNqvQHs0Bos9pkrNRF8Ks4WfLVuRCX
 ggQG+fkRQA2i2bhcBfgpRA+NA84JUm78IcKDqMRoLB62bDDFtnQLfAaotkhkO/I+ONKM
 sWJmaNEVqcakYHNgBj3P3JfpRSxwrEiiMfuPS0LfVlyWAPu4uDoTvzKX17pTyAuJMz4J
 ajSQG58r/JiS6wWZjeUNkIQsQbDuM5Pl+GOXg4Inx9A8QZpYqODluoVFfUCK0IoGnl98
 ZviKQa5VKgY+ATV5X2wWK4zmRR8SIMYkY1m/6NMYvDNkqkuaiWebsvTXbxvohSTgECY4
 MvsQ==
X-Gm-Message-State: AA+aEWb8WlNwjNs0xHipP+3a/NxffjhW3CxcM+HaHEy9+OM7OiDCvepG
 qeKKp+N8FO+AxXwzmjfx8UQ=
X-Google-Smtp-Source: AFSGD/XYIGAw29yRvRUedjQ9g4fIn0B0FHC5J9uW9shhq4igz9NfvdIuMojadcAS7atDvAZfLd0dxQ==
X-Received: by 2002:a2e:4299:: with SMTP id
 h25-v6mr11561739ljf.5.1543907605271; 
 Mon, 03 Dec 2018 23:13:25 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
 by smtp.gmail.com with ESMTPSA id x204sm2789009lfa.5.2018.12.03.23.13.23
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 03 Dec 2018 23:13:24 -0800 (PST)
Date: Tue, 4 Dec 2018 09:13:15 +0200
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v4 1/8] clk: clkdev/of_clk - add managed lookup and
 provider registrations
Message-ID: <20181204071315.GA31204@localhost.localdomain>
References: <cover.1542107769.git.matti.vaittinen@fi.rohmeurope.com>
 <ec0d6ee7ea79f0e05041ed3e564b0aadb297ef5f.1542107769.git.matti.vaittinen@fi.rohmeurope.com>
 <154356805035.88331.16867826308376667832@swboyd.mtv.corp.google.com>
 <20181130105022.GA15388@localhost.localdomain>
 <154388011043.88331.6461709079501929390@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <154388011043.88331.6461709079501929390@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_231338_533173_4A375C62 
X-CRM114-Status: GOOD (  44.83  )
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
 David Brown <david.brown@linaro.org>, linux-clk@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
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

Hello Again Stephen,

I did already send v5 prior to your reply but I will create v6 today
based on this discussion.

On Mon, Dec 03, 2018 at 03:35:10PM -0800, Stephen Boyd wrote:
> Quoting Matti Vaittinen (2018-11-30 02:50:22)
> > Hello Stephen,
> > 
> > Thanks a bunch for taking the time and reviewing this!
> > 
> > On Fri, Nov 30, 2018 at 12:54:10AM -0800, Stephen Boyd wrote:
> > > Quoting Matti Vaittinen (2018-11-13 03:55:58)
> > > > -int devm_of_clk_add_hw_provider(struct device *dev,
> > > > +static int __devm_of_clk_add_hw_provider(struct device *dev,
> > > >                         struct clk_hw *(*get)(struct of_phandle_args *clkspec,
> > > >                                               void *data),
> > > > -                       void *data)
> > > > +                       struct device_node *of_node, void *data)
> > > >  {
> > > > -       struct device_node **ptr, *np;
> > > > +       struct device_node **ptr;
> > > >         int ret;
> > > >  
> > > >         ptr = devres_alloc(devm_of_clk_release_provider, sizeof(*ptr),
> > > > @@ -3906,10 +3906,9 @@ int devm_of_clk_add_hw_provider(struct device *dev,
> > > >         if (!ptr)
> > > >                 return -ENOMEM;
> > > >  
> > > > -       np = dev->of_node;
> > > > -       ret = of_clk_add_hw_provider(np, get, data);
> > > > +       *ptr = of_node;
> > > > +       ret = of_clk_add_hw_provider(of_node, get, data);
> > > >         if (!ret) {
> > > > -               *ptr = np;
> > > 
> > > Why is this moved outside of the if condition?
> > I completely removed the local variable np and just unconditionally set
> > the allocated devres to point at the node (if allocation succeeded). We
> > could of course only do this if the provider registration succeeded and
> > save one assignment - but I guess I intended to remove the curly braces
> > and thus decided to go for one liner after if. But apparently I didn't
> > remove the braces O_o. Well, I can put the assignment inside the
> > condition if you prefer that.
> > 
> > > In fact, why isn't just
> > > the first line in this hunk deleted and passed to this function as
> > > struct device_node *np?
> > 
> > I am sorry but I don't quite follow your suggestion here. Do you mean we
> > could just pass the struct device_node *np in devres_add()? I thought
> > the pointer passed to devress_add() should be allocated using
> > devres_alloc. Can you please elaborate what you mean?
> 
> I'm just trying to reduce the diff in the patch.

Oh, right. I will see how renaming the argument to np would impact to
patch size. iActually, I never consider the patch size at all - I have
only been concentrating on how the resulting file looks like. It didn't
ever cross my mind that patch size matters. But I guess the size of
chanes is really meaningfull when the amount of changes is large.

> > > >                 devres_add(dev, ptr);
> > > >         } else {
> > > >                 devres_free(ptr);
> [..]
> > > 
> > > > +int devm_of_clk_add_hw_provider(struct device *dev,
> > > > +                       struct clk_hw *(*get)(struct of_phandle_args *clkspec,
> > > > +                                             void *data),
> > > > +                       void *data)
> > > > +{
> > > > +       return __devm_of_clk_add_hw_provider(dev, get, dev->of_node, data);
> > > > +}
> > > >  EXPORT_SYMBOL_GPL(devm_of_clk_add_hw_provider);
> > > >  
> > > > +int devm_of_clk_add_parent_hw_provider(struct device *dev,
> > > > +                       struct clk_hw *(*get)(struct of_phandle_args *clkspec,
> > > > +                                             void *data),
> > > > +                       void *data)
> > > > +{
> > > > +       return __devm_of_clk_add_hw_provider(dev, get, dev->parent->of_node,
> > > 
> > > I'm wondering if we can somehow auto-detect this in
> > > devm_of_clk_add_hw_provider() by looking for #clock-cells in the node.
> > > If it isn't there, then we go to the parent node and look for a
> > > #clock-cells property there in the DT node for that device. Does that
> > > make sense? Then there isn't any new API and we can attach the lifetime
> > > of the devm registration to the presence of the property indicating this
> > > is a clk controller or not.
> > 
> > Huh. I don't know why but building this kind of logic in core is a bit
> > scary to me. I guess I can try implementing something like this - but I
> > am not really a fan of this. (Accidentally) omit the #clock-cells from
> > node and we go to parent node - I am a novice on this area but this
> > sounds like a potential hazard to me. I believe the driver should know
> > if it's properties should be in own or parent node - and if they are
> > not, then there should be no guessing but error. The lifetime is topic
> > where I would like to get information from you who know the kernel
> > better than I do =) But I guess the parent node is there at least as
> > long as the child device is alive. So for me the life time of
> > get-callback is more crucial - but as I said, I don't understand the
> > kernel in details so you probably know it better than me. But please let
> > me know your final take on this and I will follow the guidance =)
> 
> Please do the magic instead of adding another API. It makes things
> simpler and will work for this case without having to change anything
> besides of_clk_add_provider().

All right. Let's go on this direction then.

> If the DT doesn't have the #clock-cells property in the node being
> registered then calling clk_get() will fail for any consumer devices
> that point to the node with a phandle and clock specifier. I don't
> expect us to get very far into development if that's the case.

Makes sense. So only potential thing to break is if someone out there
has broken DT/driver - where they currently see this failure. Eg. they
use node w/o #clock-cells as provider and where they try and fail
controlling this clock - but ignore the error (and system just "works"
with HW defaults). After this change they may actually succeed in
controlling - but do control wrong clock.

Not likely scenario (sure happens somewhere) - and it involves already
broken design. So I agree with you. Besides, you are the maintainer for
clk framework and thus get the most of the rain if **** hits the fan =D

> Of course, we don't fail in of_clk_add_provider() if there isn't a
> #clock-cells property in the node, we just happily add the node to the
> provider list and carry on. I doubt anyone is failing to specify the DT
> property, but maybe they are, in which case we could keep not failing
> and just add the node of whatever we're called with originally if
> neither the parent or the passed node have the #clock-cells property. I
> wouldn't try to go any higher than one node above the current node and
> look for a #clock-cells though.

I think we should use parent device's node, not the paren node in DT,
right? But I agree, we should only look "one level up in the chain".

> 
> If this all still seems scary then don't worry about it, I'll implement
> it myself.

It still is somewhat "scary" - but I really would like to use the devm
based provider registration in the bd718x7 driver so I will implement it
in this series. The engineer version of the "living on the edge", you
know =)

Br,
	Matti Vaittinen

-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
