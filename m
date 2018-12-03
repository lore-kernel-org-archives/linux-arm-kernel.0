Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30A3C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:57:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4E67208A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YDkLtPMc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4E67208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KQD88x+MAdx8Oc1coGBeYWlYwdv/IFAkSOg60IdX+Cs=; b=YDkLtPMc4kFEAZ
	Gkrd4NQFEmx859YjIcUGv8cfh0LNukwLf9+7Y6oP6zhYj2yw2e2XpmUYR54luCO417ebyrzegeKhN
	DEh5fjijLOKAh1w0vlqWcsrMoixuAHn0MCl+c2u2484KUIAwqWDW+ID5azjyajs0yY4RQVuQhYWTQ
	7Rq7qt/H0k4N11lboDH+KZiwHSHPBQTtGIZjn7EhkRJO1S/M15Cd8Ttl3X0odLTER3RcqmQTABvzS
	Rrt5EQYnat81+ikXtB/9MCerMBhgXyASwZwmA8hzalCG+nXmzM3oDTadzVEubeoHL1qP4WZ+dV09Z
	yMM5m78fJ2nQpDemMgpw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTtPX-0001ZQ-TJ; Mon, 03 Dec 2018 18:57:39 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTtPU-0001Yo-3l
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 18:57:37 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C33791688;
 Mon,  3 Dec 2018 10:57:25 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 92E8F3F59C;
 Mon,  3 Dec 2018 10:57:25 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id 99A861AE1062; Mon,  3 Dec 2018 18:57:45 +0000 (GMT)
Date: Mon, 3 Dec 2018 18:57:45 +0000
From: Will Deacon <will.deacon@arm.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [RFT PATCH] arm64: relocatable: build the kernel as a proper
 shared library
Message-ID: <20181203185745.GB29028@arm.com>
References: <20181201115324.20847-1-ard.biesheuvel@linaro.org>
 <20181203170854.GA28218@arm.com>
 <CAKv+Gu9cZ6jMsoMG499g0416J6GW8KxJBmit9=F9ka4AqpZFZg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9cZ6jMsoMG499g0416J6GW8KxJBmit9=F9ka4AqpZFZg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_105736_154687_344B54B9 
X-CRM114-Status: GOOD (  21.25  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Peter Smith <peter.smith@linaro.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 03, 2018 at 06:11:47PM +0100, Ard Biesheuvel wrote:
> On Mon, 3 Dec 2018 at 18:08, Will Deacon <will.deacon@arm.com> wrote:
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
> > them? My concern is that we'll make some other change in the future and run
> > into more arbitrary breakage. Is there any build bots hooked up with lld so
> > help us catch regressions quickly? (i.e nightly builds of mainline and next)
> >
> 
> The .rela.dyn change is for readelf actually, not for lld. Discarding
> the .dyn* sections is indeed something lld chokes on.
> 
> It seems reasonable to make the vmlinux ELF image look as much as an
> ordinary shared library as we can, to avoid issues with tooling in
> general, not just lld. This is why I separated this patch from the one
> that caters for lld in particular.

Given that the LLD developers are looking at addressing the section
discards, can you repost without that part please?

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
