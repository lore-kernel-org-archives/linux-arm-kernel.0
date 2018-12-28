Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A10C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 21:53:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9471A2184E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 21:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cN8N9mm9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iukieoM1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9471A2184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:In-Reply-To:From:Subject:
	References:Message-ID:To:MIME-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=amhNxKomXXDWajrR0twMgadByMEtxhZCRe0ZDQVG27k=; b=cN8N9mm9hOzfQJ
	LOXMq2sRHURFX7QOQKrOfFJjXaQn5wekT6vg5xejAudejCSg49+KX4tp3/KkCKsBGTOfQYspaQaAY
	9qpWhr9hc2yTTKg/MAcZi/KwTyGXnQha7YOw3jZ2MelpPYg0Khn3kPDjHmGm7xbUhBxIBN0FonlOa
	wO4AHs+ErPntNSEosEDwxb9vykYlZL1gKYrWRGGGDB5bgyEwhayQ3qv6KbN2kj1Q5w5VuJSQ9COLf
	eq4noqdQ08AXy3g6GKtAI51YwJk6nLwEEVhqGAzDPUndfvPlI1L7wGDpqqL0RYhYWiepJrYkBkUEb
	dp722CM1pucACsE1I4QA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gd04p-0002Wt-CU; Fri, 28 Dec 2018 21:53:55 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gd04Y-0002Vl-NV
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 21:53:40 +0000
Received: by mail-pl1-x642.google.com with SMTP id b5so10487288plr.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 28 Dec 2018 13:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:content-transfer-encoding:to:message-id:references
 :subject:cc:from:user-agent:in-reply-to:date;
 bh=6qz1J4MMw4nI/1NgI3i1H1ACJ2Y9IwK0nr8WJ/mYHTE=;
 b=iukieoM1WLKuxLN+Oo+G9QG7vo+SwUz9dbDU/lFatcBq6wAPdS24d6mit5yQdZ9+7g
 vOnC6J7QSTzD/DrLEvMoQJuwfs9T/l+ZnNJV5P5Ms7tmfuZ0lpuayNiLvSllGF2WLA0F
 HwWj0Y0Apg/CGUBNTk7DdPAwK5lUZsArERIiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:content-transfer-encoding:to
 :message-id:references:subject:cc:from:user-agent:in-reply-to:date;
 bh=6qz1J4MMw4nI/1NgI3i1H1ACJ2Y9IwK0nr8WJ/mYHTE=;
 b=dOrD89p09xJGr4STy91bRY0S52x9OVO8vQBlCelsDSlp4gEbWXpy4XOZLL54jm80VJ
 cNaTzGx/1hSD/IbCKFTT3m/rKVe9sIBhB0sFfd95rQxAnuKNQpK5lN2IGZrwuaMPt9wj
 go2S69Oq/5+A46Pp4aaiEbtFAHPdkoKBrrrgszlcEvvlMvjHlEDaF0ovgmUJ+09Abwh/
 5eFSG/G8cytwXMaprHSUSLcoLM5OLMbSlYQxqid0hzjPOzBqDITvUL3wLh2aQ3g6Pwz3
 hfOzPNfiWNrlkeUi2siugYuHvmUlHtak92gITWWR9jWVhuHZjSvZYDnhBp3780U08IO0
 WPyA==
X-Gm-Message-State: AJcUukeHAPpbTm71LdmQCgxvFhNMBOGGxl0UwwvKmRGJqaBppu4RzCN5
 7iDV88aNtiSuPQFt2/mKks+/og==
X-Google-Smtp-Source: ALg8bN60M7BC+G3+vor8em3TLFj1peiHcTtZSLiDeiCzpRLOeQhTurS9n1rDM4p5JyFQ4TFhxAylFQ==
X-Received: by 2002:a17:902:f01:: with SMTP id
 1mr28320270ply.143.1546034007274; 
 Fri, 28 Dec 2018 13:53:27 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
 by smtp.gmail.com with ESMTPSA id k15sm70220612pfb.147.2018.12.28.13.53.26
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 28 Dec 2018 13:53:26 -0800 (PST)
MIME-Version: 1.0
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Message-ID: <154603400565.179992.15420757926696319367@swboyd.mtv.corp.google.com>
References: <CABGGisxcHWwhUcQML7XmriK_DLFGjmud3cKt8yp+K4G2CAL=9Q@mail.gmail.com>
 <20181222072452.186726-1-swboyd@chromium.org>
 <20181222103320.GW26090@n2100.armlinux.org.uk>
Subject: Re: [PATCH] driver core: platform: Add an error message to
 platform_get_irq*()
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8
In-Reply-To: <20181222103320.GW26090@n2100.armlinux.org.uk>
Date: Fri, 28 Dec 2018 13:53:25 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_135338_769605_1CF08C23 
X-CRM114-Status: GOOD (  14.44  )
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
Cc: robh@kernel.org, b.zolnierkie@samsung.com, gregkh@linuxfoundation.org,
 rafael@kernel.org, javierm@redhat.com, linux-kernel@vger.kernel.org,
 a.hajda@samsung.com, andy.shevchenko@gmail.com, broonie@kernel.org,
 linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Russell King - ARM Linux (2018-12-22 02:33:20)
> On Fri, Dec 21, 2018 at 11:24:52PM -0800, Stephen Boyd wrote:
> > A grep of the kernel shows that many drivers print an error message if
> > they fail to get the irq they're looking for. Furthermore, those drivers
> > all decide to print the device name, or not, and the irq they were
> > requesting, or not, etc. Let's consolidate all these error messages into
> > the API itself, allowing us to get rid of the error messages in each
> > driver.
> ...
> > +error:
> > +     if (warn)
> > +             dev_err(&dev->dev, "IRQ%d not found\n", num);
> 
> Please don't use the notation IRQn - this is normally used when
> referring to interrupt numbers (such as those seen in
> /proc/interrupts) rather than a per-device interrupt index.
> Grep for IRQ% in drivers/ for many examples.
> 
> dev_err(&dev->dev, "IRQ index %u not found: %d\n", num, ret);

Sure! I'll use that one.

> 
> would be better - note also the use of %u for unsigned integers.
> Using %d for them is IMHO sloppy coding.
> 

Ok.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
