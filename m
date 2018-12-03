Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7A6C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:54:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A27F3208A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JXXOQvGY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A27F3208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=a9Xq6HOVnE8pXGa6X1LHuySzqz993393PhjCRBOa0Wo=; b=JXXOQvGYv15cBm
	DobCfUtXKPHaTiCZUosZSy3M3Dd9eb3MHMZzVGi0wxSxB1EVSPDAelhUkJR5itaICtlnYrhHc/1J7
	qcAXYnHaxH05cte8Fkw69Rxiiwal1xcNK1sdspFUJnRpI4vtkaVg1BZdflff9vnnhQ+aND0L1IfyX
	797+whYhn+fZwBPz5npUuTE7Wk/pyZs1VwmrNEW2e2n5jEXU9m4w2tGOFt3YaA8JCO6qOtpeDnUaV
	jK1Zgci+EqPdG7DWhN5bnhRtZjDvCFWXuIkUQPlfQPZGq7BjcR5nGM5ffjyKWBkHyAM4rVQVrWq4k
	jTljDPAESHvIecxk5OZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTtMA-0007Op-Au; Mon, 03 Dec 2018 18:54:10 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTtM7-0007M6-1l
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 18:54:08 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D2191688;
 Mon,  3 Dec 2018 10:53:56 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E19DD3F59C;
 Mon,  3 Dec 2018 10:53:55 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id EBAD01AE1062; Mon,  3 Dec 2018 18:54:15 +0000 (GMT)
Date: Mon, 3 Dec 2018 18:54:15 +0000
From: Will Deacon <will.deacon@arm.com>
To: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [RFT PATCH] arm64: add support for building the KASLR kernel
 with LLVM lld
Message-ID: <20181203185415.GA29028@arm.com>
References: <20181201135734.10060-1-ard.biesheuvel@linaro.org>
 <20181203165852.GD27796@arm.com>
 <CAKwvOd=mDNKhWxS8RtX5oTh0fmorfTayiD3+dGyPU5NOcROSuA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKwvOd=mDNKhWxS8RtX5oTh0fmorfTayiD3+dGyPU5NOcROSuA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_105407_097800_26E60655 
X-CRM114-Status: GOOD (  16.87  )
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

On Mon, Dec 03, 2018 at 10:33:06AM -0800, Nick Desaulniers wrote:
> On Mon, Dec 3, 2018 at 8:58 AM Will Deacon <will.deacon@arm.com> wrote:
> >
> > On Sat, Dec 01, 2018 at 02:57:34PM +0100, Ard Biesheuvel wrote:
> > > Work around some differences in the behavior of ld.lld as compared
> > > to lb.bfd:
> > > - pass the -z notext and -z norelro options to convince the linker to
> > >   permit text relocations, and relro sections that are non-adjacent
> > >   (both of which are irrelevant for bare metal executables such as the
> > >   kernel)
> > > - move the definition of some __efistub_ decorated section markers to
> > >   the linker script, which permits us to assign them as relative
> > >   quantities (since using an intermediate assignment loses the section
> > >   relative property when using ld.lld)
> >
> > I'd prefer not to work around a linker bug in today's lld just for KASLR
> > if it's anything more than passing a funny set of linker options.
> 
> Filed https://bugs.llvm.org/show_bug.cgi?id=39857 to follow up. Peter
> has narrowed down a straightforward reproducer.

Thank you.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
