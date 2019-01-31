Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C361EC282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:03:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FF65218AF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eiJAIJhm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cMtiRJa9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FF65218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DSO6Zmds52u21W+XdNrAmrc6LwkfjQxjrFB1FQCO4E8=; b=eiJAIJhmXkZOm2
	qQoxDNxL87qjJqj/L7Pa4DMSIrmnDjrfvbYm33H08t2b3D+Y7o8BGzb6aGi9iiC6y0kkXn0L79r5G
	Ktt4RTSIJ6AcVE/b+flp+BjpGBcg2ygU+SUvX6cdKPBy0yFutV4ye9hrLKn/xavOKw+5TYp/Mz2e5
	MOR2DN60L5alnfMRQlkqP/NAONDs6RMbppWlylCZITqCqRGsz35HXFnYNWEDmgEeD1WeSzOSFIu8M
	2AtfpNOGX/pR/1EZqsmVU5YPVeYNeK413+fyEsuu4JWE7EXjP5pzq8spYOTNIFeaquX4MtDT/kSoF
	grjwTPmlmAGh3RTqOY1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp7JZ-0005I4-Ix; Thu, 31 Jan 2019 08:03:13 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp7JN-0005AB-Qf
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 08:03:07 +0000
Received: by mail-lj1-x243.google.com with SMTP id t18-v6so1865404ljd.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 00:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=th0n7sJ1kpbg6jUTHvOwcYdoG8LZVB3dE8mGIZUNN44=;
 b=cMtiRJa9xzaXgKRLjIMljKdSvq27GQ1YWXO5LpxqkQcWn0Gixt6z9qihODgFX0goGd
 5fIBSdrJQYV6RuH8I2sxnZooJoJtWHdPrFtd79zwYc8qT1qZaKOHpeziwm6lxivDPdKw
 cqSAYCVlbjGKHooKkIwnbFoF/qcuEBCPGcUZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=th0n7sJ1kpbg6jUTHvOwcYdoG8LZVB3dE8mGIZUNN44=;
 b=RyqXtLXoSqwUvwCGjyXE803g0ra2t32mUM9HqfTLDxQCsTX/OqsD8lw/koztBgYppg
 tTX6iuyMJoJBAIq3uiqkDcytM+GogI+e3+6hdq7mWk6ZGiY8xVxVhwH0yEE8iSy36Kv3
 zRrF3YIN9FKBqovc0j8gvuBsS01Mrrx2+qgK8fA//mXghZWL3/WQKybesDPgJzHWjmRa
 /yz6fkPoZ2WeO/YIogEEUestJ+FgFQR3zFgvxg2g0K8+1/e6BIw9QP+Ew268mR3+Tp6g
 ToyVfX7wRsiYo39BvsWGxpEwfjuzrk4P/YKg2PKpdzIvudaVxO6Rolm6fIlX13CnMJcZ
 pYLw==
X-Gm-Message-State: AJcUukfUsQI8k8TD8EVkp6XIXCtMJIRjFAuMhXf4iMITq+xpQTy47RiP
 04kP0a1DjitNxkAcOncJbXq0Ru7fN61Mg8tu7Az8Pg==
X-Google-Smtp-Source: ALg8bN75Gm7w8La1x1kzmW3VrQK2OGP14iOpRLWufBN4sGtaDJCRFi7vsmAJnQ8SiSbRBxQI8/v2LflzKX8g6hpeYWs=
X-Received: by 2002:a2e:9356:: with SMTP id
 m22-v6mr26913706ljh.135.1548921779254; 
 Thu, 31 Jan 2019 00:02:59 -0800 (PST)
MIME-Version: 1.0
References: <CACRpkdYRiWZbkduBRxQdPC_1hJjQJCYhX9NFB31t1Su1CSBNyw@mail.gmail.com>
 <CAK8P3a1GK3sZ+1pFS-4y5EgsV0ttA0OsYrmdmSzrJc8me26J7A@mail.gmail.com>
In-Reply-To: <CAK8P3a1GK3sZ+1pFS-4y5EgsV0ttA0OsYrmdmSzrJc8me26J7A@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 31 Jan 2019 09:02:47 +0100
Message-ID: <CACRpkdancbk84o+wEvMPA-+qjeAQDo5Ob24KzaEc9TUH=x5Y3Q@mail.gmail.com>
Subject: Re: [GIT PULL] SPEAr defconfig update
To: Arnd Bergmann <arnd@arndb.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_000303_036559_4EBF0CF4 
X-CRM114-Status: GOOD (  15.25  )
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
Cc: viresh kumar <viresh.kumar@linaro.org>, arm-soc <arm@kernel.org>,
 shiraz hashim <shiraz.linux.kernel@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 30, 2019 at 10:52 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Jan 21, 2019 at 1:30 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > Hi ARM SoC maintainers,
> >
> > this:
> > 1. updates the SPEAr 3xx defconfig
> > 2. replaces the fbdev PL11x framebuffer driver with the DRM PL11x driver
> >    in the defconfig
> >
> > This has the ACK of the SPEAr maintainer Viresh Kumar. I don't think
> > there even is a SPEAr git tree so I send this from my GPIO tree. If they
> > have other plans, they can say so now :D
> >
> > Please pull it into ARM SoC in the appropriate place, next kernel is
>
> I have a similar comment to the nomadik update, though there
> is only one non-obvious option: why do you turn on CONFIG_PREEMPT=y?

Oh that's just something from my script, sorry.

It'd good that it comes up but I guess it should be a
separate patch.

These are not servers so any other configuration than
CONFIG_PREEMPT is probably just wrong, as is any
other setting than Tickless idle and HRTimers on.

I am thinking maybe we should actually have ARMv7 and
ARMv8 multi Kconfig simply select these things, I don't
really see why anyone would want to configure these
differently, it just seems vaguely cargoculty and overcautious.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
