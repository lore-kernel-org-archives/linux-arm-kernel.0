Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A430C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:29:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37872208A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X1MaFCH6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="hdaoqYZJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37872208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CXvixTY3KeGhTOBXmi+Wif9nrtSzRM8TQYgfUSFs00A=; b=X1MaFCH6vjqXTo
	phzPuuWZHov/lHL7JXODKtyzS8G8ZvgejiUfjCtSj6P6m8+d1hg7pe1aBIyry3LFQgIkvB7jm6QKG
	VKsCpQu4mC+jeAoAfrXioQk0wpU/RsWvt2cSNtMvCtVitAmrGS8Braei7bcmHGMc3QPoBBf1b392x
	ILLIpJkQ9y1QFpSU44fGVGOe49DqwoTWKmo6qsXa3PiLGukpWRD0S8+s2kWmAAySeOS8UjB9CejzD
	lB6BctuIVFB5misoc/1ND9ufCzH4PEwUVwJRF6nWbI6Ly3DgjEfP1HA4NSTjHLaQzdySZwqQ1kRa2
	fw8x/g4rs6vVSXY+thhA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTsyI-0000yy-C5; Mon, 03 Dec 2018 18:29:30 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTsyD-0000Qo-IM
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 18:29:27 +0000
Received: by mail-pg1-x542.google.com with SMTP id 17so6107956pgg.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 10:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4CrGrWl1CgXuSQkLcYyP4CAPuSK6JULdUzQHtACxrh0=;
 b=hdaoqYZJhY+h2NVBoe0htWjJKC+Z7Zqj5ZPD/NO86DnZilmQQftxBiVF+N1+oxwVPi
 fzxpDSlc2dOxkd+mE6on4AxUXKw5ow4rIlpsyvZ2mI7auA05GNQBBUELlwRWyhwPf0XT
 ncSQULKefRKo2/WY8Zf1YRX5F3Za/1TGuSEvGckRGit09q2Gm+Dmq2KUaUXnx2zcahB9
 LqD/gk8J8Wi/tl/SEIpKgn/HziLBgo1B0bI/z3x3jp5g5pcNfMonOX+ydipLhhwq/oWF
 LWXkATkUBu5RdVVIuwyBRlBF0xJmG+3Sfv0J4Waye0I2fNb5pLfe+xaZPeaoA2pkhT2o
 9P7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4CrGrWl1CgXuSQkLcYyP4CAPuSK6JULdUzQHtACxrh0=;
 b=TaX8yQcB1Ih3GCh7rtKuGniJ4qCIynoEtuctLQEO9yPZi0qcw4DbtZigc4p/htt7Ck
 z1CH850eyoophn2U+HCb1VrHP2YAZe6yrV4ciCtJPYKZt8kX1rkrOPizxf143pF0P5Rh
 5i9wGVSmBeoSgr0vk8pzl76p9CANYt/EfEB7PqD+HwTOlwUTtddLPy3a7LB9kt8k8Oqi
 f7clFxfdlWTU7pX+DBew14WZTGqIREqNYksnmAavBcIVTR20ax6yZNcYUtwci1zdGhil
 ZP+Az2k/fki8SeTG7mjPPJX+8UF5dIKjJK7HDdeEIX7ih8/UHqVBS2oy1ccjAiNzk9xQ
 ts2Q==
X-Gm-Message-State: AA+aEWaI8It0kCKi+X/Mi4xa0c0vIjIk6xm8ybzqMg6AOfb+zi2YppLK
 28C+Pzn0ILpXXeNd4aNXu+Y/LpeHSVHDDwYp1+0BSQ==
X-Google-Smtp-Source: AFSGD/XmRuOb74UkZU0x6dYmFZuxTItQSCY/2jCB7DiFk8ELqdQDKnOwAdc4iyN3vgJg0asPkicz6ZDZDuck88Hs3ig=
X-Received: by 2002:a63:42c1:: with SMTP id
 p184mr13993733pga.202.1543861751881; 
 Mon, 03 Dec 2018 10:29:11 -0800 (PST)
MIME-Version: 1.0
References: <20181201115324.20847-1-ard.biesheuvel@linaro.org>
 <20181203170854.GA28218@arm.com>
In-Reply-To: <20181203170854.GA28218@arm.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 3 Dec 2018 10:29:00 -0800
Message-ID: <CAKwvOd=9cKeQrZ4QjfQa3FH+9gHJr6TRWy4eFAfT7A99T6FC6g@mail.gmail.com>
Subject: Re: [RFT PATCH] arm64: relocatable: build the kernel as a proper
 shared library
To: Will Deacon <will.deacon@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_102925_635954_48459AD1 
X-CRM114-Status: GOOD (  16.81  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>, peter.smith@linaro.org,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 3, 2018 at 9:08 AM Will Deacon <will.deacon@arm.com> wrote:
>
> Hi Ard,
>
> On Sat, Dec 01, 2018 at 12:53:24PM +0100, Ard Biesheuvel wrote:
> > readelf complains about the section layout of vmlinux when building
> > with CONFIG_RELOCATABLE=y (for KASLR):
> >
> >   readelf: Warning: [21]: Link field (0) should index a symtab section.
> >   readelf: Warning: [21]: Info field (0) should index a relocatable section.
> >
> > Also, it seems that our use of '-pie -shared' is contradictory, and
> > thus ambiguous. In general, the way KASLR is wired up at the moment
> > is highly tailored to how ld.bfd happens to implement (and conflate)
> > PIE executables and shared libraries, so given the current effort to
> > support other toolchains, let's fix some of these issues as well.
> >
> > - Drop the -pie linker argument and just leave -shared. In ld.bfd,
> >   the differences between them are unclear (except for the ELF type
> >   of the produced image [0]) but lld chokes on seeing both at the
> >   same time.
> >
> > - Rename the .rela output section to .rela.dyn, as is customary for
> >   shared libraries and PIE executables.
> >
> > - Don't discard the .dynamic, .dynsym, .dynstr and .hash sections.
> >   Instead, make sure that they are [mostly] empty by marking all
> >   symbols as local, and emit them into the .init segment.
>
> These second two changes seem fairly arbitrary to me: is lld unhappy without
> them?

I don't know about .rela -> .rela.dyn, or .hash, but LLD developers
just issued patches allowing the following sections to be discarded:

.dynamic:
https://reviews.llvm.org/D55211
.dynsym:
https://reviews.llvm.org/D55218
.dynstr:
https://reviews.llvm.org/D55215

> My concern is that we'll make some other change in the future and run
> into more arbitrary breakage. Is there any build bots hooked up with lld so
> help us catch regressions quickly? (i.e nightly builds of mainline and next)

Yes.  We're running continuous integration at:
https://github.com/ClangBuiltLinux/continuous-integration

We have nightly cron jobs building arm64 defconfigs with clang for
mainline, -next, and some LTS branches of the stable tree. ex.
https://travis-ci.com/ClangBuiltLinux/continuous-integration/builds/93312295

Some arm64 targets are additionally being linked with LLD.
CONFIG_RANDOMIZE_BASE is not on in the defconfig (see:
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-December/616877.html)

We're working with kernel CI to get Clang builds (and LLD) setup ASAP,
as they cover more trees, bisect failures and notify developers
automatically.
-- 
Thanks,
~Nick Desaulniers

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
