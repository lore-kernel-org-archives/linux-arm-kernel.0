Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA7AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:23:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C3F02176F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Eih6wI1n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C3F02176F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6TGQNdaoWazqStxAlTiVnTi4/Zj1qqIYpSPFMWMwuPs=; b=Eih6wI1nfXydAz
	cm0VVsPUHwR+fpzInmzdwUydsDSgIhTdBWXDnKYMAKN8qT17ZHPj30pbzp4Pf+mgRkioFs4JiBEkl
	b9U8g2fzdTTLUuBo3ZDo/7qlOKCnTNeQ3mEFzMOX2hVOuUTmqyZWSjcPiZxdXclae3ct553gfF7Na
	yDRovXHh74N2sHeCPslKP+OVEsZfw86zLw/EfxhGVQ2L5X7l4oUv/0GHQNW6ZacvvMsdC67KEQkYp
	AUZhYSVZlyT52wxWvSw4ul60tQVmcmzxRyVDnw4mv4jHs9ClaY5/G5DniCtzTJMQS9HfAeyYrex+B
	AyGBVCOfBgMNG86B2Sfg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf6i9-0002YI-6j; Thu, 03 Jan 2019 17:23:13 +0000
Received: from mail-ot1-f66.google.com ([209.85.210.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf6i5-0002XZ-6V
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 17:23:11 +0000
Received: by mail-ot1-f66.google.com with SMTP id w25so29904259otm.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 03 Jan 2019 09:23:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=d+Algh/Ysyc2qh0ZVeiaQBZGmFP+zB1c7uxH2nEn/v4=;
 b=W4XXc+SLlwZBbNe+s7VBONeXvSHz4/ODjXSgx1GRz6DJaXX6chSuVqEaP2MxZKq7Zs
 WcYsqwceNSrhc8yzoVlJ0liXrfA1V7T5ku0Pzo7av3xuR4LbTQ4MzlPrCRm3+5VXNPi2
 CHt2ais/1UDqUNVCStZPQ1bTDEjXkBdd9wF6QLkmNv8SUZS7OLlwNV0UP6xpA9MG9dlq
 6Zp0MYkNwDysr3CfFowEb/3VHxUH2wIjZhlX+iXeJAVfcIf6zIASpiAALmzfOeUZtdzj
 GcjxrWpk89ECIy/WSUMVKrihErLE2g3fC02e+3ZJxeild96K0r/Rqk33Q0aIhsdF9o/D
 18tw==
X-Gm-Message-State: AJcUukcOCteqkL5ZAcvzXIRf7pLEnG0tCOeqbMcjHfp06Tg+weyguuAR
 dtgZKaf1L9BWnOBeyIE4WrE9dPZ8NnJnlYRDa+w=
X-Google-Smtp-Source: ALg8bN4BW3f84jWlcOVu8qCZefasXC5VB9c2tgXpmhzdTqTmpOrIg2Js0+29sLhBYpBeetofjeWwRahjN+3vGjAIbtQ=
X-Received: by 2002:a9d:60b:: with SMTP id 11mr32154029otn.200.1546536188072; 
 Thu, 03 Jan 2019 09:23:08 -0800 (PST)
MIME-Version: 1.0
References: <CABGGisxcHWwhUcQML7XmriK_DLFGjmud3cKt8yp+K4G2CAL=9Q@mail.gmail.com>
 <20190102185106.56913-1-swboyd@chromium.org>
 <CAJZ5v0iL_Fq0RUbLjMj9WBitDw2amNV_ybirkiPbuYb0zroGAg@mail.gmail.com>
 <154653191998.15366.14229484132412159772@swboyd.mtv.corp.google.com>
In-Reply-To: <154653191998.15366.14229484132412159772@swboyd.mtv.corp.google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 3 Jan 2019 18:22:56 +0100
Message-ID: <CAJZ5v0hwhuerPoizdYjqNkdymxubOweZ3JhPiXRUcrNtByz_=Q@mail.gmail.com>
Subject: Re: [PATCH v3] driver core: platform: Add an error message to
 platform_get_irq*()
To: Stephen Boyd <swboyd@chromium.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_092309_244999_184A3723 
X-CRM114-Status: GOOD (  15.55  )
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
Cc: Rob Herring <robh@kernel.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, javierm@redhat.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Andrzej Hajda <a.hajda@samsung.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, Mark Brown <broonie@kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 3, 2019 at 5:12 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Rafael J. Wysocki (2019-01-03 01:40:26)
> > On Wed, Jan 2, 2019 at 7:51 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > > @@ -130,6 +125,22 @@ int platform_get_irq(struct platform_device *dev, unsigned int num)
> > >         return r ? r->start : -ENXIO;
> > >  #endif
> > >  }
> > > +
> > > +/**
> > > + * platform_get_irq - get an IRQ for a device
> > > + * @dev: platform device
> > > + * @num: IRQ number index
> > > + */
> > > +int platform_get_irq(struct platform_device *dev, unsigned int num)
> > > +{
> > > +       int ret;
> > > +
> > > +       ret = __platform_get_irq(dev, num);
> > > +       if (ret < 0 && ret != -EPROBE_DEFER)
> > > +               dev_err(&dev->dev, "IRQ index %u not found\n", num);
> >
> > Why don't you log the error code too?
> >
>
> I don't see much benefit to seeing -ENXIO or -EINVAL printed here, so I
> left out the error code.

OK, so the value of the message is to tell the user that some driver
asked for an invalid IRQ, right?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
