Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE78C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:30:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A5312082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XL1rdlMW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A5312082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HZBJV5JGuGWFKlVkBN6aabYceZIEMXM/JPr5Dv4cK4I=; b=XL1rdlMWNXUTRi
	a1Qo2k+fr1fP/yOtTZL9aCeKvN3fqh50ZF5Yc0OeUAqLWotYZim3IeMcK1/CrxE3QCpGEMaHP8bts
	LwflLx5ATIzQFF2gb/n2ATAIp7y1Lam7Itvbd7Zx+MZHEZwlTtX0ef4hIiGNfKAPObwp/GXE38hdW
	JGuWUSa/7YDMgdRDHvULMB8L8wvyfPW8d7HvyNBG2AMUa+PfgeMTtfNoiF0QSOmfKV8+cLb0c6bgB
	M4KXqNFriZ+7aOXCM1IXRZmSlsKkwo0Z3IdCFZhG+tcYaV5+mOBw9T9+h9ko8NnIdtphnwwZTWvDo
	kribJj/SAfRK5DpdidGw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSjnq-0000bp-M7; Fri, 30 Nov 2018 14:29:58 +0000
Received: from mail-qt1-f196.google.com ([209.85.160.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSjnn-0000at-Sc
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 14:29:57 +0000
Received: by mail-qt1-f196.google.com with SMTP id v11so6087530qtc.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 06:29:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=l6Oi6GC0wdMMdPX5DteUyrU2UlGocYS8qdj2AjpitFc=;
 b=PY8H/EMezBf5DKkxMoiE2DiLCrdEoTrgzXrM8uUZvG92M2Axh1S5tBrfIVOI3awowW
 MvwCUBBOr4DJjMhwuVqyOKdxU9H8s5dDGF2gE+sXOJxgVRJ0PXUjq+bib+MflYczhx54
 lZV/jMXD/RE8ng9x9EeuR2MRxuozY/nUf4VzJoZsH39smjI0+xZtat2S5vsHLYEH1WtS
 uEZNBeNvhO/u9Nn4UrWTMalvoJoTBIHiJbYsSkYwP9xhemZcdXnVSH+LvrWaJVSTcXIe
 uUW6aAi/kdjsDTguBxJnsosqmA1302aKF4MMyba5NhRQgcbHqgNL6rUY9zAHu//qp+FA
 bYQA==
X-Gm-Message-State: AA+aEWZCOWhQWE0PmwChZU39q6j+7ws0niqFfkINxpAIxCQrTBVlKxLM
 7IofMYTgKLC+vrKY2Ewc6nMLiwK/p8qFhFglFOU=
X-Google-Smtp-Source: AFSGD/WwuNPxAgpZNrsjrT2wCL81xeIk641DcsBLo+v7tlfLle6xtKAJM8cD3J7sEZDJAbYTbmG63kQ+0Z0Biqud/hg=
X-Received: by 2002:ac8:1d12:: with SMTP id d18mr5584884qtl.343.1543588184536; 
 Fri, 30 Nov 2018 06:29:44 -0800 (PST)
MIME-Version: 1.0
References: <20181129170530.37789-1-vincenzo.frascino@arm.com>
 <20181129170530.37789-7-vincenzo.frascino@arm.com>
 <alpine.DEB.2.21.1811292230430.1657@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1811292230430.1657@nanos.tec.linutronix.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 30 Nov 2018 15:29:25 +0100
Message-ID: <CAK8P3a1hmsf2CKWfQ60aUQMoC1YxWhkRKY3GBRusGnQ2cDCJpQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/28] kernel: Define gettimeofday vdso common code
To: Thomas Gleixner <tglx@linutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_062955_923313_B61F4295 
X-CRM114-Status: GOOD (  19.44  )
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
Cc: linux-arch <linux-arch@vger.kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Ralf Baechle <ralf@linux-mips.org>, Mark Salyzyn <salyzyn@android.com>,
 Paul Burton <paul.burton@mips.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Peter Collingbourne <pcc@google.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 29, 2018 at 11:12 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> On Thu, 29 Nov 2018, Vincenzo Frascino wrote:
> > +if HAVE_GENERIC_VDSO
> > +
> > +config GENERIC_GETTIMEOFDAY
> > +     bool
> > +     help
> > +       This is a generic implementation of gettimeofday vdso.
> > +       Each architecture that enables this feature has to
> > +       provide the fallback implementation.
> > +
> > +config GENERIC_VDSO_32
> > +     bool
> > +     depends on GENERIC_GETTIMEOFDAY && !64BIT
> > +     help
> > +       This config option helps to avoid possible performance issues
> > +       in 32 bit only architectures.
> > +
> > +config HAVE_ARCH_TIMER
> > +     bool
> > +     depends on GENERIC_GETTIMEOFDAY
> > +     help
> > +       Select this configuration option if the architecture has an arch
> > +       timer.
>
> Please don't add code which is architecture specific to the generic
> implementation. There is really no reason to make ARCH_TIMER special.

I think it's just unfortunate naming based on what arm64 had, but
conceptually it does the right thing, and just disable the clock_gettime
fastpath on kernel builds that never have access to a clocksource
from user space.

> > +static notrace int __cvdso_clock_getres(clockid_t clock_id,
> > +                                     struct __vdso_timespec *res)
> > +{
> > +     u64 ns;
> > +
> > +     if (!__arch_valid_arg(res))
> > +             return -EFAULT;
> > +
> > +     if (clock_id == CLOCK_REALTIME ||
> > +         clock_id == CLOCK_TAI ||
> > +         clock_id == CLOCK_BOOTTIME ||
> > +         clock_id == CLOCK_MONOTONIC ||
> > +         clock_id == CLOCK_MONOTONIC_RAW)
> > +             ns = MONOTONIC_RES_NSEC;
>
> This is wrong. You cannot unconditionally set that. See what the syscall
> based version does. You always need to verify that the syscall version and
> the vdso version return the same information and not something randomly
> different.

Do you think we actually need the fastpath here? If not, the
easy way to do it would be to always fall back to calling
the syscall based version. Or was this originally added
to deal with the syscall and vdso clock_gettime having
different resolutions (which would sound like a bad idea, but
might have to stay for compatibility)?

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
