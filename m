Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC98C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:11:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7B2F20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XV3O2kTd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7B2F20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xrROQo+aDyYI7SLh23zYaOIa0NRI3AgSrKIS6PfLOzs=; b=XV3O2kTdGtFsyd
	rb73k4LERNRxgXTvy3TDtld0UcieJUI11OutuoIYR0W4+br8RTmgbr1fXo3ltThw1p9SyjweK1Tsp
	UTlrIxf/7gDwz4AOuyq9Byw/j8WBpLIulPPh/gbKHWAjQUK/6Wo7CB+nhn2z9PvhUdVuw9NBE58g9
	qR9zSLsQ1rT8SbWfREY4wuMerOvcblCF9jt6hLXxZLw7SMkI/cKdYBr79iPmB2I2IVD6TeMHP7uPv
	WZU1qB3eLTv+hQoiZlKj9JxXL65IUt+mPDcvWMCawuBBZbaK7smksjffapGt7xAMDs11AVd6fH6Zb
	o/9czOOk9+XV4LmM4FJg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTsgM-0002XG-O4; Mon, 03 Dec 2018 18:10:58 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTsgJ-0002Cj-0c
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 18:10:56 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A570B168F;
 Mon,  3 Dec 2018 10:10:44 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 765703F59C;
 Mon,  3 Dec 2018 10:10:44 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id 7D4FD1AE1062; Mon,  3 Dec 2018 18:11:04 +0000 (GMT)
Date: Mon, 3 Dec 2018 18:11:04 +0000
From: Will Deacon <will.deacon@arm.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] arm64/mm: use correct operators for string comparison in
 cache.S
Message-ID: <20181203181100.GA28700@arm.com>
References: <20181201110144.15970-1-ard.biesheuvel@linaro.org>
 <c5c51e6a-a4d6-ca3d-b413-1ecbbf7186f5@arm.com>
 <CAKv+Gu88W79sMoCFse4iaXwr=N1JT73-htvmGSQkVHdP1DaAYA@mail.gmail.com>
 <20181203174506.GA28497@arm.com>
 <CAKv+Gu8NQ9T4FFXRB0SL5U8ddn=tAtZH67XNNAbw8FaHKP_AfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8NQ9T4FFXRB0SL5U8ddn=tAtZH67XNNAbw8FaHKP_AfQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_101055_115373_5CCA2E27 
X-CRM114-Status: GOOD (  27.37  )
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

On Mon, Dec 03, 2018 at 06:54:35PM +0100, Ard Biesheuvel wrote:
> On Mon, 3 Dec 2018 at 18:44, Will Deacon <will.deacon@arm.com> wrote:
> >
> > On Mon, Dec 03, 2018 at 02:22:14PM +0100, Ard Biesheuvel wrote:
> > > On Mon, 3 Dec 2018 at 14:11, Robin Murphy <robin.murphy@arm.com> wrote:
> > > > On 01/12/2018 11:01, Ard Biesheuvel wrote:
> > > > > The GAS directives that are currently being used in dcache_by_line_op
> > > > > rely on assembler behavior that is not documented, and probably not
> > > > > guaranteed to produce the correct behavior going forward.
> > > > >
> > > > > Currently, we end up with some undefined symbols in cache.o:
> > > > >
> > > > > $ nm arch/arm64/mm/cache.o
> > > > >        ...
> > > > >        U civac
> > > > >        ...
> > > > >        U cvac
> > > > >        U cvap
> > > > >        U cvau
> > > > >
> > > > > This is due to the fact that the comparisons used to select the
> > > > > operation type in the dcache_by_line_op macro are comparing symbols
> > > > > not strings, and even though it seems that GAS is doing the right
> > > > > thing here (undefined symbols by the same name are equal to each
> > > > > other), it seems unwise to rely on this.
> > > > >
> > > > > So let's provide some definitions that are guaranteed to be distinct,
> > > > > and make them local so they don't pollute the gobal symbol space.
> > > >
> > > > Rather than making the unintended symbol comparisons work properly, can
> > > > we not just implement the string comparisons that were supposed to be?
> > > > Superficially, the diff below seems to still generate the desired output
> > > > (although as always there's probably some subtlety I'm missing).
> > > >
> > > > Robin.
> > > >
> > > > ----->8-----
> > > >
> > > > diff --git a/arch/arm64/include/asm/assembler.h
> > > > b/arch/arm64/include/asm/assembler.h
> > > > index 6142402c2eb4..2c5f4825fee3 100644
> > > > --- a/arch/arm64/include/asm/assembler.h
> > > > +++ b/arch/arm64/include/asm/assembler.h
> > > > @@ -383,13 +383,13 @@ alternative_endif
> > > >         sub     \tmp2, \tmp1, #1
> > > >         bic     \kaddr, \kaddr, \tmp2
> > > >   9998:
> > > > -       .if     (\op == cvau || \op == cvac)
> > > > +       .if     ("\op" == "cvau" || "\op" == "cvac")
> > > >   alternative_if_not ARM64_WORKAROUND_CLEAN_CACHE
> > > >         dc      \op, \kaddr
> > > >   alternative_else
> > > >         dc      civac, \kaddr
> > > >   alternative_endif
> > > > -       .elseif (\op == cvap)
> > > > +       .elseif ("\op" == "cvap")
> > > >   alternative_if ARM64_HAS_DCPOP
> > > >         sys 3, c7, c12, 1, \kaddr       // dc cvap
> > > >   alternative_else
> > > >
> > >
> > > Looking at the GAS info pages, I find
> > >
> > > "Operators" are arithmetic functions, like '+' or '%'.
> > > "Arguments" are symbols, numbers or subexpressions.
> > > An "expression" specifies an address or numeric value.
> > >
> > > so even if the comparison works as expected, I'm hesitant to rely on
> > > it to work as expected on any version of GAS or any other assembler
> > > claiming to implement the GAS asm dialect.
> > >
> > > We could change the logic to .ifc, which is defined to operate on string, i.e.,
> >
> > That looks better to me, although I'm not sure why you're inverted the logic
> > here:
> >
> > >     .ifnc \op, civac
> > >     .ifnc \op, cvap
> >
> > What am I missing?
> >
> 
> .ifc does not permit '\op equals string1 or \op equals string2'

Thanks. Then I guess we invert the logic as you suggest, or we duplicate the
alternative code. Looking at this some more, I think what we currently have
is broken because on a system with ARM64_WORKAROUND_CLEAN_CACHE but not
ARM64_HAS_DCPOP, you'll get DC CVAC for __clean_dcache_area_pop, which
would be broken on that CPU.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
