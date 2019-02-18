Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08879C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:18:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE35C218B0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FDhVK9oU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE35C218B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tnUNyjgXvYuqOcwpM4CrmqtmXcyFk1z8f8hqpptd6VI=; b=FDhVK9oUdGvxrk
	jRZc4PsqED/ptBvmv1rxL07mbgJBDHAhaSAvxnrlXMqp+0vpfcKEsWhoQwPxAxhdK9Vk4uMRB/NB0
	mIaWbexw5E/zK1kVNAVDV50liQUMg8BKERd6fBn1iT/jVWZVyl+mu4KMKvovZlQtOE6NjyVXcRqfz
	hjYZdCi6uVt0dawxQvBU4TaFqXpYeFavLlpOxwHHPVYfW77xR3dwN4A7iSYQ5m3CE/dJlj0OARxst
	uIfcXA0MmEsf15RUXCDa+gNcSMf5PyYiPeBXutwJ5qIr1gZvhJoUWFLJr1J86yp5733FBMNWQCucr
	dcyfO5dMkCxlEsvkDBKg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvf4N-0002d8-RA; Mon, 18 Feb 2019 09:18:35 +0000
Received: from mail-qt1-f195.google.com ([209.85.160.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvf4K-0002ck-2H
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 09:18:33 +0000
Received: by mail-qt1-f195.google.com with SMTP id v10so18402041qtp.8
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 01:18:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2c6geFCKX+YzsXq6SlYnnZvqPcfkuNDgdgXGbErWd9Q=;
 b=mxv7N5CYIyiYBebPGYhZFIFFhiWOpXuhK/i42XrGhSjeY5h518ufP9Km4Es+Gjs//x
 vRwhQw315NV6YodWlwd3r6VrwS9i2/We6G733FduOIWLMiwxz+DER3LaDRQozG2pN9Y5
 RtS6AwwaAe/wmYS2NdeOwCYWaAJlYUPzkO/UoTy4Kaa07UxVlrRjaFVJxID8gwbjla5f
 xpOqRaHWetvur9e758Bvq+JZ2tqloLQ6zAMp2st3Q1oWcZcLIN4Es3ySR/JD2LUbvpjT
 ePaB/HOKhjpdxZWjUoAGRr1/DVo2xYTRdsw2/EYba3Rgu3epLxiTT0vs53/H5Ubrpf7+
 XPDg==
X-Gm-Message-State: AHQUAuaN6kKebyNUPiDnn5cG8ipSU7VxREPxZCAnnt3q/kFNHwEHxLXf
 k+V2vP0hQJGHKyKDceJEhNbK+h/yq5RLgKxSvOs=
X-Google-Smtp-Source: AHgI3IaacCv+bdgkEzYs/kvGAG8Gwl+McqUCDpdFY+CKTC0yBHgWXfZ+wGxf0Xfo7G4DeSZRgLMnxUTG5UcZ+0g6Yng=
X-Received: by 2002:ac8:33f1:: with SMTP id d46mr17216321qtb.319.1550481510433; 
 Mon, 18 Feb 2019 01:18:30 -0800 (PST)
MIME-Version: 1.0
References: <20190203214205.13594-1-linus.walleij@linaro.org>
 <20190203214205.13594-5-linus.walleij@linaro.org>
 <ffc97649-bfc2-e411-149f-cd5ed9e8c77e@arm.com>
 <CACRpkdZK7OU9rb-qw9tTjJLNvfQG-VmN_VBXUz9DPqVV11zuww@mail.gmail.com>
 <20190211221156.10036ad8@why.wild-wind.fr.eu.org>
In-Reply-To: <20190211221156.10036ad8@why.wild-wind.fr.eu.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 18 Feb 2019 10:18:14 +0100
Message-ID: <CAK8P3a0L0AsuqdiZ+RTWpV8EnO5xsVVkbmzJit4yi23nR0jrvw@mail.gmail.com>
Subject: Re: [PATCH 04/17 v1] irqchip: Add driver for IXP4xx
To: Marc Zyngier <marc.zyngier@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_011832_101813_116DAF65 
X-CRM114-Status: GOOD (  20.87  )
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
Cc: Jason Cooper <jason@lakedaemon.net>,
 Linus Walleij <linus.walleij@linaro.org>, Krzysztof Halasa <khalasa@piap.pl>,
 Olof Johansson <olof@lixom.net>, Thomas Gleixner <tglx@linutronix.de>,
 Imre Kaloz <kaloz@openwrt.org>, Tim Harvey <tharvey@gateworks.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 11, 2019 at 11:12 PM Marc Zyngier <marc.zyngier@arm.com> wrote:
>
> On Mon, 11 Feb 2019 21:58:41 +0100
> Linus Walleij <linus.walleij@linaro.org> wrote:
>
> > On Mon, Feb 11, 2019 at 4:30 PM Marc Zyngier <marc.zyngier@arm.com> wrote:
>
> [...]
>
> > > How about using something that enforces the endianness of the accesses,
> > > as I suspect the bus is hardcoded to BE?
> >
> > So, IIUC (Krzysztof can confirm) IXP4xx works like this that when the
> > CPU is brought up in LE mode, all bytes on the address bus are
> > swizzled so that the access can always use the CPU native
> > endianness.
> >
> > Isn't it crazy :D
>
> It's spelled BE32! ;-) I vaguely remember doing some of that on vulcan,
> but that's a decade ago, and I've paged it out... ;-)
>
> > This means __raw_writel() will always do the right thing, because
> > that uses native endianness, and that is why it is used quite a lot
> > in IXP4xx drivers.
>
> OK, it now makes some sense. Maybe a comment somewhere will help if
> someone tries to reverse engineer it again in the next decade!

I think the best way forward would be to change all the
__raw_readl()/__raw_writel() in ixp4xx specific drivers to a new
accessor that is defined as a trivial wrapper around __raw_readl()/
__raw_writel() but that is explicitly defined as

- always accessing a 32-bit word in native endianess
- only valid on ixp4xx on-chip registers (not PCI)
- containing the required barriers (if any)

In my mental model of the I/O accessors, readl/writel are used
for (little-endian) MMIO register accesses, while __raw_readl()/__raw_writel()
can only be used in portable code on byte streams in memory behind
a bus, not on registers. The way ixp4xx works fits into neither of those
two, so we should not use them here. I also think it's a bug to
use 8-bit or 16-bit accessors for internal registers on ixp4xx, so
having a pair of special helpers makes it impossible to do so.

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
