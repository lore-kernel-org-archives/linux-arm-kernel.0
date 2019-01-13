Return-Path: <SRS0=Fp1N=PV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153E0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 12:14:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAC0320836
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 12:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O8+cP0m/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UCuYxNAR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAC0320836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JqKMDYuofiM6ymjXDxNkcymgBy7/JhrEanKb4H0Oi0E=; b=O8+cP0m/q99jg3
	SBdP53mrdhLJQnY4aZ0va6g362b/JCAmsog0ksrVYmyCekJs0ozXhmieALFhddQP6MjvsyAXd6gU3
	3spOGEljW8bF9HUNcv2fqtkVE5F4nKltQh8USmtypFPjujOhvJd2Hk1/XkUQekX8pWGq+RLxnl4IM
	A8MgHYPxuVPPudyW3AugWIcAkmC8+aUGzvYCR1mLVLUYWhV7O2JASvZzhUS9KAkbuh7zKPSSALWK2
	siym3RkFBFCNGQPIqos1QZW0+eBMAQkkx5UWd95XrbwS8c7iRP9y1ieyQf5ZLzlBofAJ6vZmL21cT
	9Df3aubz1Q8XL9zywJJw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giefJ-0001b8-QC; Sun, 13 Jan 2019 12:14:57 +0000
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giefG-0001aI-A0
 for linux-arm-kernel@lists.infradead.org; Sun, 13 Jan 2019 12:14:56 +0000
Received: by mail-lf1-x12f.google.com with SMTP id a8so13754512lfk.5
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 13 Jan 2019 04:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MquxggZERArLSwcbYfp+/d7MLmRd+ChJbqyHgXD3DKs=;
 b=UCuYxNAR7gssRmQyGDZFRp/4GXqMgJ0MgiVIqCBF7UD92ooD58BzAKuAWe7oChZXrQ
 7XBnqkKhxwM5FxTQ3kd7bThOAC+71olgHmPswOdC3jxfq+dS/oJQv0vhvbHbFRc2Zqqt
 aisHmzvpuKSnVAPd3IXpsj9qYL7SNwKVcTeic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MquxggZERArLSwcbYfp+/d7MLmRd+ChJbqyHgXD3DKs=;
 b=ciaBiOnkRLB9tn7W+PD/fMkUHLQJYI2R3L3T7UcWn1aHDi/EeWtF3RKxL6nlEDJ77/
 zbdvpfnXgCjIGkisR5L63kWc3YrzduzWmeqFimRRBv2w/lTHuO+wW0j74bf9kBml3KzS
 dqgwysZeqA8/rIQNQECmmxCrC0tu95j162LCcZVABccnt163Sn+qBpQ8fcM6jsiEisJV
 gXrbanVgbKGrudz1RdJMbqBAxxko+e7QWc11aWcVP7iSzSvsQolVOWWuqjKqUTZYwlWL
 Ow+0m6bYWZka7pcg0LDtxB1Izb6x4jj/KTUdpNy6yKXY6maSRQZYDEGYvS5r14WyO+WS
 hYJQ==
X-Gm-Message-State: AJcUukenb26B3aYb8ef1kKgvN3v+T75SluLPALC3Luc9QbGTSjSvP5jP
 IwH54QSj7FfrSBzPKTq5dVMb7OK97BsCmLTFW9V6xw==
X-Google-Smtp-Source: ALg8bN49Y3tUQKx8d/P5foBkL8G7ghYtF5A2c7sFFzpKkcUdQUpMeHNTid2hbZp7RaIUjBOynFi6k+YyaBiljh06uqc=
X-Received: by 2002:a19:c801:: with SMTP id y1mr10930365lff.53.1547381688007; 
 Sun, 13 Jan 2019 04:14:48 -0800 (PST)
MIME-Version: 1.0
References: <CACRpkdb-zphMyZbGh5XYy2A6B1224BGFmTwr0Bm98G3oM0MeoQ@mail.gmail.com>
 <CAK8P3a08TV+sQhsCPjkXh6wOKEpLfGLqVo9+FHoXzDVXs_bY7A@mail.gmail.com>
In-Reply-To: <CAK8P3a08TV+sQhsCPjkXh6wOKEpLfGLqVo9+FHoXzDVXs_bY7A@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 13 Jan 2019 13:14:36 +0100
Message-ID: <CACRpkdZ7KSmgTYP8a_RUJAWKzuc652OZ420Lq4ZnzkCuESLZ2Q@mail.gmail.com>
Subject: Re: Hilscher NetX mach-netx refactorings
To: Arnd Bergmann <arnd@arndb.de>, Ladislav Michl <ladis@linux-mips.org>,
 github@hilscher.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190113_041454_351623_FD715C8C 
X-CRM114-Status: GOOD (  17.84  )
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
Cc: Olof Johansson <olof@lixom.net>,
 Robert Schwebel <r.schwebel@pengutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Pengutronix Kernel Team <kernel@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Jan 12, 2019 at 1:03 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Sat, Jan 12, 2019 at 9:35 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > Hi Sascha, Robert,
> >
> > I am looking at refactoring mach-netx to use the new PL11x
> > DRM driver for the graphics.
> >
> > I need to make sure that patches get tested on the hardware
> > and just want to ascertain that there is an active maintainer that
> > will be able to test patches I make for this and work on getting
> > it migrated to DRM before I start spending time on it.
> >
> > Are you/pengutronix still actively maintaining this machine and
> > testing new kernels on netx?
> >
> > I guess the second question is whether you have plans to migrate
> > it to device tree and multiplatform, but I'm mainly thinking about
> > my own little patches now.
>
>
> On a related note, there does appear to be active work on
> newer netx machines that were never upstreamed, see
> https://github.com/Hilscher/netx4000-linux/commits/v4.9-netx4000-stable

That RS485 addition to PL011 using GPIOs is a bit hacky but
looks like very useful for industrial applications.
Ladislav, have you been in contact with Hilscher?

> I wonder if anyone has contacts into the company so we can
> work together with them to include them into mainline Linux.

They have a mail address github@hilscher.com, let's knock
on the door and see if somebody answers it :D

I'd personally be able to take a stab at converting this machine
to device tree and multiplatform if I only had access to the
hardware, as it seems to be in the same class as EP93xx
and MOXA ART: deployed in industrial systems as we speak.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
