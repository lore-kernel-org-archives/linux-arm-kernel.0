Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED980C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:11:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3A9B20651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VXQyIHFs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3A9B20651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PW9wOr1fObVz+5nu7i/7XiBvoku8bVBGwF1yDUShRzk=; b=VXQyIHFs+XKqUg
	aAaWGCdyciut5QZPXGT+b1/GcmItP0e6VJj3g991SswMN2TL2FWWvSym/5drF7CiMLiyn4USVcoMj
	M7WevSjt+cd1af6pzN5TJ+qsY0bfxFgJslZpNCGPx/roU4PeMz8W+GEdfG4QZ0c0JVuiC2GzqvWOV
	jlE2npNJf1nMX7VUqOXdcvXdIEyIKPfkrkl5ekp6lkGimhA68mCoa/DzPSuqexCysDdVG5RdpTxj3
	USHBAi5dp7klKz1b+Jk9QIkfDkW2QQAh42/xkoB17/aQPpoDtycQmKC0BYjRU4bFI14GPNvDQk3Ek
	Aq6vAz0gwKaWveaSYdrQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjLgo-0008DE-Ff; Tue, 15 Jan 2019 10:11:22 +0000
Received: from mail-qk1-f196.google.com ([209.85.222.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjLgl-0008Cr-Lk
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 10:11:21 +0000
Received: by mail-qk1-f196.google.com with SMTP id d15so1228766qkj.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 15 Jan 2019 02:11:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yrqxPEjqbdZ7s8bNMx4mtYmthBcDcFKZlJ7J2nO+7wA=;
 b=svUPkYOCj1wZG9f/kbmAMhHxCAhCe8ZRWjpqsP+K3FMp4kCngKJrOuz0WkwWGohy6X
 oI3Z2lSjbtJUJI5Bexan9fYzHqvSWijeRtRg7yStwL/xKosZ8aqteMxjhvyEDi4ZZlRg
 3etv3KXWzrPerHWd8+qJzB+B6ORonavTY7R8AyqvhLNZ6eerNy/NwyWdAHxId54d+vf3
 5Fi3GJ1i+CvP48zQGiXrXKqeTn4Sjjw31mKipvjJW/9otBjytlRTsNxBscFCgLnvfEqC
 hn+AZufdCglKULfGh7TKJIcnyXzCNOJx7S9LMBCzoz+3qEwn8aN+iE5VHq+VshcEKtSE
 Cmmw==
X-Gm-Message-State: AJcUukdsc7a1ByBqrD7liRHWZklyvujxzo8YPt4K7rugMKiRf3FibBv/
 38LZGGR0jvge7fQaiPQHODgK55Av9p7JY7KcOqM=
X-Google-Smtp-Source: ALg8bN52TqxNpSJ+fxTf+nxD5AbBWKw+pQ+7ZLX1t2uYM62qRyX3vBP6C1KgGtkqxuYEtiTZf2ttsP80YvX1UUpYlFg=
X-Received: by 2002:a37:9a89:: with SMTP id c131mr2135914qke.173.1547547077696; 
 Tue, 15 Jan 2019 02:11:17 -0800 (PST)
MIME-Version: 1.0
References: <CACRpkdb-zphMyZbGh5XYy2A6B1224BGFmTwr0Bm98G3oM0MeoQ@mail.gmail.com>
 <CAK8P3a08TV+sQhsCPjkXh6wOKEpLfGLqVo9+FHoXzDVXs_bY7A@mail.gmail.com>
 <CACRpkdZ7KSmgTYP8a_RUJAWKzuc652OZ420Lq4ZnzkCuESLZ2Q@mail.gmail.com>
 <b5e70ac4-4cf8-9abe-ec30-7d225089caf0@hilscher.com>
 <CACRpkdYnbCmfTVB_aFX-vhkbWma=60U0D6pKZ8bcKdxCdSXdyA@mail.gmail.com>
 <39b5ad22-7e78-20f5-164b-30df943ce79f@hilscher.com>
In-Reply-To: <39b5ad22-7e78-20f5-164b-30df943ce79f@hilscher.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 15 Jan 2019 11:11:00 +0100
Message-ID: <CAK8P3a19RykzzOuSUcKUQ+cDcL1kWgEJ5Z1cEO2dB7XzB9g2mw@mail.gmail.com>
Subject: Re: Hilscher NetX mach-netx refactorings
To: Michael Trensch <MTrensch@hilscher.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_021119_710929_9B286CF0 
X-CRM114-Status: GOOD (  24.55  )
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
Cc: Ladislav Michl <ladis@linux-mips.org>,
 Linus Walleij <linus.walleij@linaro.org>, nagasureshkumarrelli@gmail.com,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Olof Johansson <olof@lixom.net>, Robert Schwebel <r.schwebel@pengutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 15, 2019 at 8:05 AM Michael Trensch <MTrensch@hilscher.com> wrote:
> On 14.01.2019 15:22, Linus Walleij wrote:
> > So a pressing question is whether it is OK with Hilscher that we
> > decomission/delete the current support code for NetX
> > nxdkn, nxdb500 and nxeb500hmi? Or are these products that
> > still see active deployment (new designs) and maintenance
> > in the long term (5-10 years from now)?
> >
> It's ok from Hilscher side. I've talked to our CEO and he is fine with
> dropping it. Those boards are not produced anymore and our new Asics
> (e.g. netX4000 and upcoming) will replace netX100/500 in the long term.
> Our Asics usually have a guaranteed lifecycle of 10 years and netX100
> has been around since 2006, if I remember correctly, so we don't expect
> many new linux projects arising, with the need for the newest kernel.
> Old kernel version will still be working though.

I think we also need to consider any existing installations here that
have already deployed hardware but do require kernel upgrades in
the future, e.g. when systems are connected to public networks
and may be vulnerable to attacks.

I would assume that the 10 year lifecycle is for deploying boards into
the field, not the time that you expect your customers to stop using
the hardware, right?

Some of the SoCs that we support in mainline Linux have been EOLed
by their manufacturers many years ago, but are still deployed in
large numbers and get kernel updates through projects like OpenWRT
or through companies like Pengutronix or Bootlin working directly with
companies using them.

> > OK! But when you have time and resources, please consider to
> > work with the kernel community to get the board support upstream.
> >
> We want to work with the community now and in the future, but for
> netX4000 we first needed to get this SoC working. It took many
> development cycles to get all implementation working and now it seems to
> have settled so we can think about step two. netX4000 Final (with all
> required changes) was released end of last year.
>
> Main problem would have been the continuous change of the Asic during
> development and more or less constant changes to kernel sources. I think
> this would have caused some laughing on the mailing list if we submit a
> patch one day and do it the complete other way round with the next
> (possibly non-public) stepping of the Asic.

Not at all, in fact our preferred way to operate is to work with hardware
companies as early as possible. We definitely merge drivers for
pre-production SoCs that can end up getting rewritten or even dropped
completely within a short time if it turns out the hardware gets changed
again or never gets sold for reasons that are not our concern.

I usually suggest submitting drivers as soon as you have cleared
any nontechnical obstacles (e.g. unannounced product features)
and have code that looks maintainable, even if you have remaining
bugs and missing features.

Since SoC support is now split into many independent drivers, you
can upstream each driver at its own pace, with the goal of reducing
the number of patches you keep in your own tree compared to
mainline. The ideal case is that all features work in a mainline
kernel on the day that the first hardware gets into your customers'
hands, though more commonly there will be a set of patches that
take a bit longer.

       Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
