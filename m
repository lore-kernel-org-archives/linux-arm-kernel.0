Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81819C43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:28:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A2CC20863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h3Hma+OX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IMwsqU2p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A2CC20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lu12qoFPXTFL0h+NFyjCRTn/mJjlRprEDgRTEvjgX44=; b=h3Hma+OXOj/GGs
	WZdyOGQkozl2Z85v31K612iL1fBOmM0e735WELCXi8lsR+f2QAHINWletWW11lFFoQojP/AsCf1Ju
	cTrgy6q7AsJYDP55QAOpvJADhF6weM2EaOMrhS5gHXILgp4QV3TI6HXISkjIRkAv+Z50s5/4IgZXf
	ea2Yhj+GOW1FhmNcFQxPPDcck3elUrTvvO22N9+4ETlE4p4I5DDzbillZHfj+7JSeTKKIPsKkRbFy
	Gz9tbp+0N4LgAR0xvyNMalmVcL8OoQz8VVG9gkqiwmrPd6ZEMgNtukIEKZqRcFg6egQXiYhW46eVa
	xsQhj2ntMWRYuoXuRcRQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSPBL-0006xs-GF; Thu, 29 Nov 2018 16:28:51 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSPBJ-0006sx-JQ
 for linux-arm-kernel@bombadil.infradead.org; Thu, 29 Nov 2018 16:28:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RpWiZFyPV+GG12uLMyBidS/H9vBUnZK7N/81HdXjrn4=; b=IMwsqU2pEwkFM1LBUPyuZ6dD6
 Ph6hEKgz9dRACJXDsVA4O0DdX8UsBpo7coEerUghAQxSddEsrwrAtbZXtl2EVSpdlBByghPnuFXk6
 N16h6PWqrGoqxyKA4wk8jQ+wDZ4PD7mKJonDihyY+Pc0sz0G2C5OMLgukrD63LSV4hBaTnZ+q3sw3
 lTj33ag4aKf2Crmuy2RBN808MXPRVRWqmONX7e5RFvJK/ZpNL0my3lyF80h7zk4Y/ozRDMrNWJ0lz
 dgun1XuQwkgjfIw0Zvk47qFfPrvLTK8tsoEpgeix8cw3P2hlVG3A9x5Igfua1ZeMboGwWn17sPMwu
 Hsn9BZU+Q==;
Received: from foss.arm.com ([217.140.101.70])
 by casper.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSOwV-0000oE-7n
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 16:13:33 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A506BA78;
 Thu, 29 Nov 2018 08:13:19 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 74C193F59C;
 Thu, 29 Nov 2018 08:13:19 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id EF35D1AE0FD4; Thu, 29 Nov 2018 16:13:37 +0000 (GMT)
Date: Thu, 29 Nov 2018 16:13:37 +0000
From: Will Deacon <will.deacon@arm.com>
To: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH] arm64: io: specify asm operand width for __iormb()
Message-ID: <20181129161337.GA21349@arm.com>
References: <20181129041912.5918-1-nick.desaulniers@gmail.com>
 <fe3cba43-935b-448c-46e9-90ea75593e5b@arm.com>
 <20181129104902.GA2377@arm.com> <20181129161039.GA17063@flashbox>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181129161039.GA17063@flashbox>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_161331_681343_963ED62B 
X-CRM114-Status: GOOD (  25.28  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Julien Thierry <Julien.Thierry@arm.com>,
 Catalin Marinas <Catalin.Marinas@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Nick Desaulniers <nick.desaulniers@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 29, 2018 at 09:10:39AM -0700, Nathan Chancellor wrote:
> On Thu, Nov 29, 2018 at 10:49:03AM +0000, Will Deacon wrote:
> > On Thu, Nov 29, 2018 at 09:03:54AM +0000, Julien Thierry wrote:
> > > On 29/11/18 04:19, Nick Desaulniers wrote:
> > > > Fixes the warning produced from Clang:
> > > > ./include/asm-generic/io.h:711:9: warning: value size does not match
> > > > register size specified by the constraint and modifier
> > > > [-Wasm-operand-widths]
> > > >         return readl(addr);
> > > >                ^
> > > > ./arch/arm64/include/asm/io.h:149:58: note: expanded from macro 'readl'
> > > >                                                           ^
> > > > ./include/asm-generic/io.h:711:9: note: use constraint modifier "w"
> > > > ./arch/arm64/include/asm/io.h:149:50: note: expanded from macro 'readl'
> > > >                                                   ^
> > > > ./arch/arm64/include/asm/io.h:118:25: note: expanded from macro '__iormb'
> > > >         asm volatile("eor       %w0, %1, %1\n" \
> > > >                                      ^
> > >
> > > Why does the "eor %0, %1, %1" become "eor %w0, %1, %1" ?
> > > The variable passed to the inline assembly for %0 is unsigned long, so
> > > always 64-bits wide on arm64. Why is clang trying to use a 32-bit
> > > register for it?
> 
> Sorry, this was my fault, I accidentally added a w during testing to see
> what constraints were valid (given that my assembly knowledge is nearly
> non-existence so forgive the non-sensical experimentation) and I used
> that message rather than the original one. This is the unadulterated one.

Aha, that explains it. Thanks for clearing that up.

> In file included from arch/arm64/kernel/asm-offsets.c:24:
> In file included from ./include/linux/dma-mapping.h:11:
> In file included from ./include/linux/scatterlist.h:9:
> In file included from ./arch/arm64/include/asm/io.h:209:
> ./include/asm-generic/io.h:695:9: warning: value size does not match register size specified by the constraint and modifier [-Wasm-operand-widths]
>         return readb(addr);
>                ^
> ./arch/arm64/include/asm/io.h:147:58: note: expanded from macro 'readb'
> #define readb(c)                ({ u8  __v = readb_relaxed(c); __iormb(__v); __v; })
>                                                                        ^
> ./include/asm-generic/io.h:695:9: note: use constraint modifier "w"
> ./arch/arm64/include/asm/io.h:147:50: note: expanded from macro 'readb'
> #define readb(c)                ({ u8  __v = readb_relaxed(c); __iormb(__v); __v; })
>                                                                ^
> ./arch/arm64/include/asm/io.h:118:24: note: expanded from macro '__iormb'
>         asm volatile("eor       %0, %1, %1\n"                           \
>                                     ^
> 
> >
> > Yeah, the message above looks bogus to me. I can see %1 being 32-bit for
> > read[bwl], so maybe clang is just getting the diagnostic wrong. If so,
> > I wonder if the following fixes the problem:
> >
> 
> This doesn't appear to work, I get this error:
> 
> In file included from arch/arm64/kernel/asm-offsets.c:24:
> In file included from ./include/linux/dma-mapping.h:11:
> In file included from ./include/linux/scatterlist.h:9:
> In file included from ./arch/arm64/include/asm/io.h:209:
> ./include/asm-generic/io.h:695:9: error: expected expression
>         return readb(addr);
>                ^
> ./arch/arm64/include/asm/io.h:147:50: note: expanded from macro 'readb'
> #define readb(c)                ({ u8  __v = readb_relaxed(c); __iormb(__v); __v; })
>                                                                ^
> ./arch/arm64/include/asm/io.h:120:28: note: expanded from macro '__iormb'
>                      : "=r" (tmp) : "r" (unsigned long)(v) : "memory"); \
>                                          ^

Can you try throwing another set of brackets around it, please?

	((unsigned long)(v))

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
