Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F238C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:08:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3ABB2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TWkPhosK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PIiY/Ywr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3ABB2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1RmS+unueoqXiINsx4tt44Eg6lsSjElKg312IQ6up14=; b=TWkPhosKI7RU6R
	HgMe+07fOiqddaLYI32Aqw10kBetarfr71kMTxr++rM4ggQFhPQpnv2Sl44MfjEUSxtN9MF7wFzIA
	MyzmMHHF0uKlMR7tS5lz9YgRqnrywVG+bEs6FAQl+Giijoasnup/Tc0ddD7Y+jgZthMSqw6KaaJcV
	i43+CVJZdnWVnhhxpGRSYwVlsjg6s5Ws4pimbsd7IS0cF+P7cxRLkKsxLBgKAmxnqZOilX+UMrDZl
	WnLuBFsWPvA4WuDUWhIfiV+5Hv6n2zx6eP3fTItY93g72UzleeIDezYZ50bD8W1CxGIr7oYNEf4LE
	8f1HhgcBMq40bgXehYdA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTjHB-00006M-PW; Mon, 03 Dec 2018 08:08:21 +0000
Received: from mail-it1-x135.google.com ([2607:f8b0:4864:20::135])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTjH9-0008Vb-6Z
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 08:08:20 +0000
Received: by mail-it1-x135.google.com with SMTP id x19so7864740itl.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 00:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SlIHWfQ8A+enlaPYnb1RuUEyV5B/aT1qGi5NGPtMosY=;
 b=PIiY/Ywrd2HArzvmJXIzCv29BEGd4ZbeLf1iWgAWJnQpTJePTtbX3pOLDbyL/i4pI5
 V1HvWvWuy7XE/3Bik6lhkSiS/XaYOBHOoFAp83fk6LB4GNks3HEiiq7CikFejRom9Fpv
 QbzyS3VvpuZ2t5Ym+2e6c3UXR42oixMbXv054=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SlIHWfQ8A+enlaPYnb1RuUEyV5B/aT1qGi5NGPtMosY=;
 b=Wv34oQdZeoNxT1Bqptgk0rxZ9vCtckx19l4tBoIV0ZH6IUAoK7m39UJAsPtT6uF1FQ
 5Pz2vycOAhOytw7yMWFrJtS2Y22zVBPU1Wua+PQ4PH3Gf7kFJgHgwsia93BUCawQZuy8
 5Idc04WPSnh6LiDS66vC9BVCDhIOAeQzvk7mG1rMIViNvL1XIBsHr72YL0N4jF29tVMs
 FzgL0r6M1QWy68vzgF3PXdKkUjpE8OG5bpNevxZij+T45PLONpoLFrXG9+VjFOOLTu7q
 TAa5Yt8lmNCTanYnZXck8Yb7DTZcJ2Qyo6KfTeW1BvZXCz/a69kusWFWDsJEQwBEMA5B
 9Q9A==
X-Gm-Message-State: AA+aEWZqljGWRZs0+qfHZc/I+srvQKvJj/84sWUnHXQzRH2P2LdU2Jl+
 t4zsyhPBop1AwRGbzFu2UZPLHivhv0U29LOwnHjDkw==
X-Google-Smtp-Source: AFSGD/UXVDHOdX1lYPL7VyvzVqPxxsi8P/OpDxCj25WgtyISGtUXTd1DRBuCI4oUrPzAGDQW3NEL2nurt+SwgAXZ8IY=
X-Received: by 2002:a05:660c:4b:: with SMTP id
 p11mr7288359itk.71.1543824487641; 
 Mon, 03 Dec 2018 00:08:07 -0800 (PST)
MIME-Version: 1.0
References: <CAH7mPvjbZoYYxS3mThEjS-uuLkemuts06pKaOWOw22hUzvAT8g@mail.gmail.com>
In-Reply-To: <CAH7mPvjbZoYYxS3mThEjS-uuLkemuts06pKaOWOw22hUzvAT8g@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 3 Dec 2018 09:07:56 +0100
Message-ID: <CAKv+Gu8Ux29mb65Ms6MYXkDec=jKg4NGRE9N_r+64cBrTg01nA@mail.gmail.com>
Subject: Re: adding CONFIG_MY_NEWCONFIG=y to defconfig considered harmful?
To: nick.desaulniers@gmail.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_000819_256117_A46ED10B 
X-CRM114-Status: GOOD (  17.26  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, 2 Dec 2018 at 22:59, Nick Desaulniers
<nick.desaulniers@gmail.com> wrote:
>
> Arnd,
> I was looking through `git log arch/arm64/configs/defconfig` and
> noticed a few commits like
>
> 41925a21 ("arm64: defconfig: Enable TI_SCI related configs")
>
> that add new configs defaulted on.
>
> How come these get turned on for the defconfigs vs a board specific config?
>
> How come arch/arm64/config/ contains a lone defconfig (that appears to
> be picking up everyone's wanted defaults) vs arch/arm/config/ having
> many board specific configs?
>

The arm64 maintainers deliberately aim for a single config, since they
aim for a single binary Image that can run on all targets. Any
platform or SoC specific changes to the core are applied via code
patching (for errata workarounds etc). Everything else is pushed into
modules, which are only loaded on demand.

Note that this is a *huge* advantage also from CI/ test coverage
perspective, since you don't have to test 50 configs if you modify
something in the core.

> From a continuous integration standpoint, I prefer a slimmer
> defconfig, as the more we add to it, the slower the individual builds
> get.  I would love to take a hacksaw to arch/arm64/configs/defconfig
> (removing a bunch of stuff defaulted on), but maybe there's a strong
> argument for this difference from arch/arm/configs/ that I'm not aware
> of?
>

Yes. See above.

> I was looking into this because I want to add CONFIG_RANDOMIZE_BASE=y
> to the defaults, so RFC for that idea, too.

That would be an excellent idea, actually. I didn't propose it at the
time, since it was brand new code, but today, all the distros ship
with KASLR enabled as well, so it makes sense to turn it on in
defconfig.

What I would prefer is to enable CONFIG_RANDOMIZE_BASE and
CONFIG_RANDOMIZE_MODULE_REGION_FULL in the defconfig, and drop the
'default 'y for the latter in Kconfig, so that we keep exercising the
PLT code in our test builds (local but also kernelci, kbuild test
robot etc), but don't enable it in other cases (.e.g, distro configs).
The 'full' module randomization increases the number of random bits in
the module region address from 11 to 16, now that the full range is
limited to 4 GB, so the difference is not earth shattering.


On an unrelated but similar note, would anyone mind if we disable
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS in defconfig?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
