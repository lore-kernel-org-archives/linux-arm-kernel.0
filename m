Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741BBC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:22:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47ECB20645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AyPN5aam";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="kgCam7tA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47ECB20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Sdv9RF5VSaq7rwqf8UyRbDzPmzm/7/6GB8jk3ob9UkE=; b=AyPN5aam6tN2eO
	LSodkHxdP6VpOYOOBsqJjg34YVUfKWe5NDz7ofBW46sP2midH0Owb4S3GDbAI79EjFAlaPnM4g0sD
	AjYf0wBPWNDRuOa2lhHEuakoRxI2rgNpQAn9XiGd77QFlTgIO2k7siy60Ny5+FbIQYYfKRl8EUziu
	T4zddX6W1BeedRkauIZVFCu/z5gS92/cqnYPbEa2N3EZIsX0dhWz9dbmLOsKV7XSSE4qq5CvsRnk8
	FrsWCK77nqhl92V4O+ra1o1Xp9qLIFMwJnXSNKBYs1KlzK9+DOdHcmryIExF0tVDWXcDdc8TG/xqV
	C/Y1JTLq5w6k1LtO24lw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUboO-000680-JZ; Wed, 05 Dec 2018 18:22:16 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUboL-00067a-MD
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 18:22:15 +0000
Received: by mail-pl1-x644.google.com with SMTP id 101so10455271pld.6
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 10:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FVLcth+zve8W7kZxNyGn8rpNinwxID8cOavPYQSqwts=;
 b=kgCam7tA0eMY0XXt46aDp8ig7QGiNW9BUhL8hTvZHSxqRp6M/ZLJpdGGkkOljnc/cN
 rTCz+V12g17zADlUNYA5TMrsztTAyuFKzzbsPPJ19x+WuNDpPZC6GfIS1WNKkQuXGpwz
 k6hpiahvEELTp57CfEcqtiDOcn3wGkAAwj9SOph6cfmXnumBni3Jet/K014Uqr3sL63w
 YMWKqIk4ukAEr2l+F9nRGmZ9pNre8Oh4C63zAVVAVTg991Zc4uaRfzQgZ15G8ye0yoDX
 gs4+ZBBojxehXuzAcH8apu4ek4eySlU0uCPXJQw3If8HxmeLWXBhskAsrNAI55Y+lhT3
 /iWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FVLcth+zve8W7kZxNyGn8rpNinwxID8cOavPYQSqwts=;
 b=hFhlMqacO6UMhOJx4u16wG/nZZLrv+YeKTKrYz3pIX4Y55yucER5JKSBB+iRK4Milw
 pmsLdF7RH3QNJSCWtbFZW7CG8J8+oBl7aVlm3qmtYGi67rMyvBxMX81D1nyeXDYnyvZ3
 0hkJEK6UeDdxSBFHRAP8BZMXQHALI6ZH4ZRSd4ocmX57xyElqL9ltpNzyqnm3NzT2afZ
 r3yr6rwhxc9+yclmYzsHcvGZUQvQAkEMDNzM3IrNaBYpdDCdf4HdfnOxDb/BkQMiE7uY
 +b27gUUP+nAq5GiXIvmlGyvUdxy42vvJG+a0Rn5FPOzro0bDVi4oOjp7wxhVXe5RN1Hn
 7sEQ==
X-Gm-Message-State: AA+aEWYW0YgoaaURthYTRoJMiOVBza+sGrReMkrK8AkYWC3+zCLKX45q
 /DkVVVFbHRDwARKPWuux70SrTiDeNMqLWdVwuBEakg==
X-Google-Smtp-Source: AFSGD/Wi9BMXahehLr+8WB6jiJzmP/eUMkEtF+wPuZKmyeTRRGER2RJTk3IUYznC/2FRZ24UZh7Rq78AJltqlqpFoEE=
X-Received: by 2002:a17:902:7b88:: with SMTP id
 w8mr24955859pll.320.1544034122740; 
 Wed, 05 Dec 2018 10:22:02 -0800 (PST)
MIME-Version: 1.0
References: <20181205014213.943-1-natechancellor@gmail.com>
 <20181205014213.943-2-natechancellor@gmail.com>
 <CAKv+Gu-N9j5X4WoFDbQrzeOCfBaNm6ujXe_fAruusE_kWdj8iQ@mail.gmail.com>
 <20181205080645.GA11936@flashbox>
 <CAKv+Gu9Nq51Fj_14MYS6MEm0VPHOJB1CBFkCHmyC8Wt0=NWpRg@mail.gmail.com>
In-Reply-To: <CAKv+Gu9Nq51Fj_14MYS6MEm0VPHOJB1CBFkCHmyC8Wt0=NWpRg@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Wed, 5 Dec 2018 10:21:51 -0800
Message-ID: <CAKwvOdno9AdzNvMVmzqV7y+_u_z7VgfbRvKm73rRZ+iUuraYtw@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: Wrap '--pic-veneer' with ld-option
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_102213_753407_26D1B25C 
X-CRM114-Status: GOOD (  25.07  )
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
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 linux@armlinux.org.uk, Stefan Agner <stefan@agner.ch>,
 LKML <linux-kernel@vger.kernel.org>, Peter Smith <peter.smith@linaro.org>,
 Nathan Chancellor <natechancellor@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 5, 2018 at 12:10 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> (+ Arnd)
>
> On Wed, 5 Dec 2018 at 09:06, Nathan Chancellor <natechancellor@gmail.com> wrote:
> >
> > On Wed, Dec 05, 2018 at 08:37:05AM +0100, Ard Biesheuvel wrote:
> > > On Wed, 5 Dec 2018 at 02:42, Nathan Chancellor <natechancellor@gmail.com> wrote:
> > > >
> > > > This flag is not supported by lld:
> > > >
> > > >     ld.lld: error: unknown argument: --pic-veneer
> > > >
> > > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > >
> > > Hi Nate,
> > >
> > > Does this mean ld.lld is guaranteed to produce position independent
> > > veneers if you build kernels that are bigger than the typical range of
> > > a relative branch?

(+ Peter) who might be able to answer this.

> > >
> >
> > Hi Ard,
> >
> > Honestly, I'm not quite sure. I saw your commit that introduced this
> > flag and I wasn't quite sure what to make of it for lld. What
> > configuration would I use to verify and what would I check for?
> >
>
> Try building allyesconfig, and check the resulting binary for veneers
> (which have 'veneer' in the symbol name, at least when ld.bfd emits
> them). These veneers should not take the [virtual] address of the
> branch target directly, but take a PC relative offset (as in the
> example in the commit log of that patch you are referring to)

Not sure clang can compile an arm32 allyesconfig (haven't tried
personally, yet, TODO), but we could try gcc+lld.

>
> > Additionally, I have filed an LLVM bug for the lld developers to
> > check and see if this is a flag they should support:
> >
> > https://bugs.llvm.org/show_bug.cgi?id=39886
> >
> > Thanks for the quick reply,
> > Nathan
> >
> > > > ---
> > > >  arch/arm/Makefile | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> > > > index e2a0baf36766..4fab2aa29570 100644
> > > > --- a/arch/arm/Makefile
> > > > +++ b/arch/arm/Makefile
> > > > @@ -10,7 +10,7 @@
> > > >  #
> > > >  # Copyright (C) 1995-2001 by Russell King
> > > >
> > > > -LDFLAGS_vmlinux        := --no-undefined -X --pic-veneer
> > > > +LDFLAGS_vmlinux        := --no-undefined -X $(call ld-option,--pic-veneer)
> > > >  ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
> > > >  LDFLAGS_vmlinux        += --be8
> > > >  KBUILD_LDFLAGS_MODULE  += --be8
> > > > --
> > > > 2.20.0.rc1
> > > >



-- 
Thanks,
~Nick Desaulniers

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
