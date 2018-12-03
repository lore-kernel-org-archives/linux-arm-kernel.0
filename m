Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32044C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:22:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F201F208A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ExENTsCC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F201F208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fTXQUHRqSQDIk475jn/v+J7c2jRG3dwJCyxdomzXMVI=; b=ExENTsCCsgl8XA
	nux2fOz51hTLw5NASXpFMInKdibURx4U4R1/7eE6Jgij6NTawaHZiAeqTE92DSJTgPRZ8QFx6yQqc
	HHS1IcxyAPFtFOp9CtBt49l5OKC5TrAyTq+uJ6si3AzWc8l0YH292JqsLFs45IqyyBK8r8DYjbyLy
	TApMYVQoZ5xMEXfkMkUYyBen13k1I/LkYFSMw+Jer4I5lXKAVKNN3nPbR9BWNNQDziAcUAF2qGoVI
	tcx9YkS7Xo2Ub2NZyDwnKL/kbXsNO96wDzFMSAaQQUoy+9f1NjlJNNGAkqlEz5cNJAu2cWIH5+QOW
	ORmNyW+ZyhoaMplzCnwQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTtns-0003qw-HU; Mon, 03 Dec 2018 19:22:48 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTtnd-0003Rk-Td
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 19:22:35 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37647169E;
 Mon,  3 Dec 2018 11:22:29 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 07BD03F575;
 Mon,  3 Dec 2018 11:22:29 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id 11E671AE1062; Mon,  3 Dec 2018 19:22:49 +0000 (GMT)
Date: Mon, 3 Dec 2018 19:22:49 +0000
From: Will Deacon <will.deacon@arm.com>
To: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [RFT PATCH] arm64: relocatable: build the kernel as a proper
 shared library
Message-ID: <20181203192248.GF29028@arm.com>
References: <20181201115324.20847-1-ard.biesheuvel@linaro.org>
 <20181203170854.GA28218@arm.com>
 <CAKwvOd=9cKeQrZ4QjfQa3FH+9gHJr6TRWy4eFAfT7A99T6FC6g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKwvOd=9cKeQrZ4QjfQa3FH+9gHJr6TRWy4eFAfT7A99T6FC6g@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_112234_003839_BBA1CB9E 
X-CRM114-Status: GOOD (  20.39  )
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

On Mon, Dec 03, 2018 at 10:29:00AM -0800, Nick Desaulniers wrote:
> On Mon, Dec 3, 2018 at 9:08 AM Will Deacon <will.deacon@arm.com> wrote:
> >
> > Hi Ard,
> >
> > On Sat, Dec 01, 2018 at 12:53:24PM +0100, Ard Biesheuvel wrote:
> > > readelf complains about the section layout of vmlinux when building
> > > with CONFIG_RELOCATABLE=y (for KASLR):
> > >
> > >   readelf: Warning: [21]: Link field (0) should index a symtab section.
> > >   readelf: Warning: [21]: Info field (0) should index a relocatable section.
> > >
> > > Also, it seems that our use of '-pie -shared' is contradictory, and
> > > thus ambiguous. In general, the way KASLR is wired up at the moment
> > > is highly tailored to how ld.bfd happens to implement (and conflate)
> > > PIE executables and shared libraries, so given the current effort to
> > > support other toolchains, let's fix some of these issues as well.
> > >
> > > - Drop the -pie linker argument and just leave -shared. In ld.bfd,
> > >   the differences between them are unclear (except for the ELF type
> > >   of the produced image [0]) but lld chokes on seeing both at the
> > >   same time.
> > >
> > > - Rename the .rela output section to .rela.dyn, as is customary for
> > >   shared libraries and PIE executables.
> > >
> > > - Don't discard the .dynamic, .dynsym, .dynstr and .hash sections.
> > >   Instead, make sure that they are [mostly] empty by marking all
> > >   symbols as local, and emit them into the .init segment.
> >
> > These second two changes seem fairly arbitrary to me: is lld unhappy without
> > them?
> 
> I don't know about .rela -> .rela.dyn, or .hash, but LLD developers
> just issued patches allowing the following sections to be discarded:
> 
> .dynamic:
> https://reviews.llvm.org/D55211
> .dynsym:
> https://reviews.llvm.org/D55218
> .dynstr:
> https://reviews.llvm.org/D55215

Thanks again.

> > My concern is that we'll make some other change in the future and run
> > into more arbitrary breakage. Is there any build bots hooked up with lld so
> > help us catch regressions quickly? (i.e nightly builds of mainline and next)
> 
> Yes.  We're running continuous integration at:
> https://github.com/ClangBuiltLinux/continuous-integration
> 
> We have nightly cron jobs building arm64 defconfigs with clang for
> mainline, -next, and some LTS branches of the stable tree. ex.
> https://travis-ci.com/ClangBuiltLinux/continuous-integration/builds/93312295

Great, that looks very promising! Hopefully that means we can keep things
building reliably once we get to that point.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
