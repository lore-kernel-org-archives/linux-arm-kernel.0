Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5770FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:12:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2543A2070D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="muOjz0xJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JaE2w7ST"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2543A2070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Message-ID:References:From:
	In-Reply-To:To:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=k0eNHBzM/lOq/6v+mKQMgsOZuTa6haBBU/GejofE2ks=; b=muOjz0xJqqHDyE
	yr1rWhCWlm+ND04kUBMZD8FUFIOn6O9dbYISwdBsa1H99VRFNDD7aelk64MJQDvACONAUUh8nN7kA
	anPKbx53uUOUkGIWDhSO5iJdNbwHf7QNM3OIZqKXPbELX5a1bDljzf7G9hv74X3dzaWnChPQfO/B2
	Zyla8F2tu8k8cXL10p/ipLEB187/EXCRZUFueA9mulwAWyzaT4FmXi657QSnShPH6cMdPR83I0ICt
	zpEclvlIUUI0BjhyH6HUvF4UEb5M+I9PWSp4Q7PD6Fuy7sPbl4S/HdwNrvNoN9LE6Tvo3Z4j4gDQR
	qJardSUOkSXZ2/VJfCvQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf5bK-0002xd-Ee; Thu, 03 Jan 2019 16:12:06 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf5bG-0002xH-GX
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 16:12:03 +0000
Received: by mail-pf1-x442.google.com with SMTP id 64so16881612pfr.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 03 Jan 2019 08:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:content-transfer-encoding:subject:cc:to:in-reply-to
 :from:user-agent:references:message-id:date;
 bh=j51rfX6wnYKjcDiMwHcW7yVFPbV8mnVTvkI9KgLgShg=;
 b=JaE2w7ST29UZmkZPVI7AxzMfWlORWEFj7Rd0JibNoV9y8F25kf/RD/lSTOMuegYsah
 /oq6PHK09n0aG5VE3ql7HIN9riu5GdCcf1RLLN8pggvnPyXhi1+ZAhlkCx2BQDNExQa0
 0PhZT4080ztEB7d531xZAC8Ba/DE+gxzNYTyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:content-transfer-encoding:subject
 :cc:to:in-reply-to:from:user-agent:references:message-id:date;
 bh=j51rfX6wnYKjcDiMwHcW7yVFPbV8mnVTvkI9KgLgShg=;
 b=NBm+/1KXENIKeGrfZrJTsJzeCBoz3A8/LMY5ru5Ag1YL2Z1Fka08irzcfu9dKoQZSw
 py4V5UODg3BGchJONFSRq52gzKauq0YQFKBuZ1o+4UuMRX7qn3JJb+ywNU264htufNS1
 XvGe8XpnQRN1eCvfu2u4hZimZ3X3ljyHR7R/hVrEzz0zHDGssE1kEbwFstqANJpayTTl
 HErZ1oojVdEz/iuLxKPwYkGXydRvO558sWD7NNe52vh9bhgA1Q+nlOaGHebfZMYKizab
 goPHZE9ThY9BcfaZL5MkmO2Vi+R7TBJlyJJYG127erWTmbrslA+e3t1Bsz2IiWZmpNaT
 BVJQ==
X-Gm-Message-State: AA+aEWa+4nd063S9RoiGBgTpf1Vm8q6TdmEQ8yknxRxVDOu15Qteobcc
 oRG76sVlKbfYD429PzE4+xk6sg==
X-Google-Smtp-Source: AFSGD/XuCw0hsJkDC3j5+y0kOHh6FU6j34xxri+Ugu+SPl23SgyHan9DK0b2+89V6ZVsmGdX+ZlFoQ==
X-Received: by 2002:a62:1112:: with SMTP id z18mr48399261pfi.173.1546531921854; 
 Thu, 03 Jan 2019 08:12:01 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
 by smtp.gmail.com with ESMTPSA id v5sm93011023pgn.5.2019.01.03.08.12.00
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Jan 2019 08:12:01 -0800 (PST)
MIME-Version: 1.0
Subject: Re: [PATCH v3] driver core: platform: Add an error message to
 platform_get_irq*()
To: "Rafael J. Wysocki" <rafael@kernel.org>
In-Reply-To: <CAJZ5v0iL_Fq0RUbLjMj9WBitDw2amNV_ybirkiPbuYb0zroGAg@mail.gmail.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8
References: <CABGGisxcHWwhUcQML7XmriK_DLFGjmud3cKt8yp+K4G2CAL=9Q@mail.gmail.com>
 <20190102185106.56913-1-swboyd@chromium.org>
 <CAJZ5v0iL_Fq0RUbLjMj9WBitDw2amNV_ybirkiPbuYb0zroGAg@mail.gmail.com>
Message-ID: <154653191998.15366.14229484132412159772@swboyd.mtv.corp.google.com>
Date: Thu, 03 Jan 2019 08:11:59 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_081202_604837_A62712B1 
X-CRM114-Status: GOOD (  13.70  )
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

Quoting Rafael J. Wysocki (2019-01-03 01:40:26)
> On Wed, Jan 2, 2019 at 7:51 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > @@ -130,6 +125,22 @@ int platform_get_irq(struct platform_device *dev, unsigned int num)
> >         return r ? r->start : -ENXIO;
> >  #endif
> >  }
> > +
> > +/**
> > + * platform_get_irq - get an IRQ for a device
> > + * @dev: platform device
> > + * @num: IRQ number index
> > + */
> > +int platform_get_irq(struct platform_device *dev, unsigned int num)
> > +{
> > +       int ret;
> > +
> > +       ret = __platform_get_irq(dev, num);
> > +       if (ret < 0 && ret != -EPROBE_DEFER)
> > +               dev_err(&dev->dev, "IRQ index %u not found\n", num);
> 
> Why don't you log the error code too?
> 

I don't see much benefit to seeing -ENXIO or -EINVAL printed here, so I
left out the error code.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
