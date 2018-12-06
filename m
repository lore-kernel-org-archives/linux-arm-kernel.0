Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E06C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:51:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9FB820878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QsdDOyPm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9FB820878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uM5V7p0Sgh9SDqN0XFZ0t0n3blcFBDiv2ukw9D1URLY=; b=QsdDOyPmVIeIV7
	1bT2WXgMLeEPlpOeosx906tN3Uu/6y9dtmcaXW0+I4PH/iZUs3Xbsr+VAYu4+Zfwg4Sa3fpcT0cf0
	HbuPruZO7986u7F21+1f31HF771G15tcnMY+h4s1bL3b8D45Zy3MgsjqhASBjkclYWNKYiM1xhhGl
	/1CcaH0WqiJh/vBtXusI4fUuGTrC7xj1hqGMTDZP5SXuSYwkRJRz4J4l1mwWk1a3wJFTXRbqnHsPh
	kIdNDHNvgI9HOOG2nnyis7CuxHTiKKPQwOs8RhnH+piRtvP93TUaKDVgp4+zTcqAXRI8FTtkeBtDN
	GpHTpwfPP2UZoN5gci+g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUsCC-0006wD-Du; Thu, 06 Dec 2018 11:51:56 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUsBw-0006gs-G2
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 11:51:43 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A7E480D;
 Thu,  6 Dec 2018 03:51:30 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CDB1D3F5AF;
 Thu,  6 Dec 2018 03:51:29 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id DDFEE1AE0B6A; Thu,  6 Dec 2018 11:51:50 +0000 (GMT)
Date: Thu, 6 Dec 2018 11:51:50 +0000
From: Will Deacon <will.deacon@arm.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] arm64/mm: use correct operators for string comparison in
 cache.S
Message-ID: <20181206115150.GA24063@arm.com>
References: <20181201110144.15970-1-ard.biesheuvel@linaro.org>
 <c5c51e6a-a4d6-ca3d-b413-1ecbbf7186f5@arm.com>
 <CAKv+Gu88W79sMoCFse4iaXwr=N1JT73-htvmGSQkVHdP1DaAYA@mail.gmail.com>
 <20181203174506.GA28497@arm.com>
 <CAKv+Gu8NQ9T4FFXRB0SL5U8ddn=tAtZH67XNNAbw8FaHKP_AfQ@mail.gmail.com>
 <20181203181100.GA28700@arm.com>
 <CAKv+Gu8=_PH1n2Z7QBNYpLMKAodo0GVWfzduo4UBdH_vmOnc1w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8=_PH1n2Z7QBNYpLMKAodo0GVWfzduo4UBdH_vmOnc1w@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_035140_542914_D8C21A65 
X-CRM114-Status: GOOD (  31.74  )
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
 Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 04, 2018 at 01:44:01AM +0100, Ard Biesheuvel wrote:
> On Mon, 3 Dec 2018 at 19:10, Will Deacon <will.deacon@arm.com> wrote:
> >
> > On Mon, Dec 03, 2018 at 06:54:35PM +0100, Ard Biesheuvel wrote:
> > > On Mon, 3 Dec 2018 at 18:44, Will Deacon <will.deacon@arm.com> wrote:
> > > >
> > > > On Mon, Dec 03, 2018 at 02:22:14PM +0100, Ard Biesheuvel wrote:
> > > > > On Mon, 3 Dec 2018 at 14:11, Robin Murphy <robin.murphy@arm.com> wrote:
> > > > > > On 01/12/2018 11:01, Ard Biesheuvel wrote:
> > > > > > > The GAS directives that are currently being used in dcache_by_line_op
> > > > > > > rely on assembler behavior that is not documented, and probably not
> > > > > > > guaranteed to produce the correct behavior going forward.
> > > > > > >
> > > > > > > Currently, we end up with some undefined symbols in cache.o:
> > > > > > >
> > > > > > > $ nm arch/arm64/mm/cache.o
> > > > > > >        ...
> > > > > > >        U civac
> > > > > > >        ...
> > > > > > >        U cvac
> > > > > > >        U cvap
> > > > > > >        U cvau
> > > > > > >
> > > > > > > This is due to the fact that the comparisons used to select the
> > > > > > > operation type in the dcache_by_line_op macro are comparing symbols
> > > > > > > not strings, and even though it seems that GAS is doing the right
> > > > > > > thing here (undefined symbols by the same name are equal to each
> > > > > > > other), it seems unwise to rely on this.
> > > > > > >
> > > > > > > So let's provide some definitions that are guaranteed to be distinct,
> > > > > > > and make them local so they don't pollute the gobal symbol space.
> > > > > >
> > > > > > Rather than making the unintended symbol comparisons work properly, can
> > > > > > we not just implement the string comparisons that were supposed to be?
> > > > > > Superficially, the diff below seems to still generate the desired output
> > > > > > (although as always there's probably some subtlety I'm missing).
> > > > > >
> > > > > > Robin.
> > > > > >
> > > > > > ----->8-----
> > > > > >
> > > > > > diff --git a/arch/arm64/include/asm/assembler.h
> > > > > > b/arch/arm64/include/asm/assembler.h
> > > > > > index 6142402c2eb4..2c5f4825fee3 100644
> > > > > > --- a/arch/arm64/include/asm/assembler.h
> > > > > > +++ b/arch/arm64/include/asm/assembler.h
> > > > > > @@ -383,13 +383,13 @@ alternative_endif
> > > > > >         sub     \tmp2, \tmp1, #1
> > > > > >         bic     \kaddr, \kaddr, \tmp2
> > > > > >   9998:
> > > > > > -       .if     (\op == cvau || \op == cvac)
> > > > > > +       .if     ("\op" == "cvau" || "\op" == "cvac")
> > > > > >   alternative_if_not ARM64_WORKAROUND_CLEAN_CACHE
> > > > > >         dc      \op, \kaddr
> > > > > >   alternative_else
> > > > > >         dc      civac, \kaddr
> > > > > >   alternative_endif
> > > > > > -       .elseif (\op == cvap)
> > > > > > +       .elseif ("\op" == "cvap")
> > > > > >   alternative_if ARM64_HAS_DCPOP
> > > > > >         sys 3, c7, c12, 1, \kaddr       // dc cvap
> > > > > >   alternative_else
> > > > > >
> > > > >
> > > > > Looking at the GAS info pages, I find
> > > > >
> > > > > "Operators" are arithmetic functions, like '+' or '%'.
> > > > > "Arguments" are symbols, numbers or subexpressions.
> > > > > An "expression" specifies an address or numeric value.
> > > > >
> > > > > so even if the comparison works as expected, I'm hesitant to rely on
> > > > > it to work as expected on any version of GAS or any other assembler
> > > > > claiming to implement the GAS asm dialect.
> > > > >
> > > > > We could change the logic to .ifc, which is defined to operate on string, i.e.,
> > > >
> > > > That looks better to me, although I'm not sure why you're inverted the logic
> > > > here:
> > > >
> > > > >     .ifnc \op, civac
> > > > >     .ifnc \op, cvap
> > > >
> > > > What am I missing?
> > > >
> > >
> > > .ifc does not permit '\op equals string1 or \op equals string2'
> >
> > Thanks. Then I guess we invert the logic as you suggest, or we duplicate the
> > alternative code. Looking at this some more, I think what we currently have
> > is broken because on a system with ARM64_WORKAROUND_CLEAN_CACHE but not
> > ARM64_HAS_DCPOP, you'll get DC CVAC for __clean_dcache_area_pop, which
> > would be broken on that CPU.
> >
> 
> Can we just fallback to civac instead? Or do we need to add logic to
> combine the two feature flags?

I guess this could introduce a performance regression for CPUs without
either DCPOP or ARM64_WORKAROUND_CLEAN_CACHE, since we're effectively
forcing a hefty cache miss on a subsequent access to the persisted data.

So I'd prefer not to make the CIVAC unconditional unless we have to.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
