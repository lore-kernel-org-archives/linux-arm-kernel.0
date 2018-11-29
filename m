Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DAEC43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:23:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0136A20863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YkdEZtq0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0136A20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BYzy+zCEumnB6ZFvCd1AhuLnKufi35f0TRSN0MhUJyg=; b=YkdEZtq0cfXbo7
	3nyq+6M47QzQLhBCfoo5JK/K7YjnLowFicAOmXdWG1Eyzw0xgctPxDypwP25wIaQae+hGdWTmxIMN
	oWaqsJiFBrkb33Omxmv7sLhF9vA960XNIGWqsz1WpiOHN9a0atgaRZvRZJ8XcTBWtlG2Ey93k8tv5
	TE6FzhW3inPEG3YPEgTMkM6X0JSMWDTA31yMI1HuFGoM6yjsfzSqhc7dcHC/hcjahnvsapT/iJciT
	8Tg5ClphDfMwj2GTZoxAcc3tNCWQfx7nahJOE2d3RVh1fYvgFf4vz2tTi727znyxLCtEd+6evjCj9
	8bg/vasQYMdBRPqyDAOQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSP6J-0003Us-6L; Thu, 29 Nov 2018 16:23:39 +0000
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSP6F-0003UQ-Rl
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 16:23:37 +0000
Received: by newverein.lst.de (Postfix, from userid 2407)
 id 5722B68B02; Thu, 29 Nov 2018 17:23:23 +0100 (CET)
Date: Thu, 29 Nov 2018 17:23:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: remove the ->mapping_error method from dma_map_ops V2
Message-ID: <20181129162323.GA27068@lst.de>
References: <CAHk-=wgfGzXuDAKFQPdzMib3QCRHfSTsy5=gLU-WCoya+Ym+1A@mail.gmail.com>
 <11829e3c-7302-f821-cf5c-863e5267a17b@arm.com>
 <CAHk-=whxf0zqutExPr_j1A625Z3gcL6k_ABzKo1BtzN4F93hkA@mail.gmail.com>
 <20181123065511.GA17856@lst.de> <20181128074117.GA21126@lst.de>
 <CAHk-=wg5+rXK8dpjkSmK7tuz29VfxVWNEwmTVYB409mmyLkeew@mail.gmail.com>
 <20181128174545.GJ30658@n2100.armlinux.org.uk>
 <CAHk-=whnz4Kty6cas11bc2Gh=9zTzeeRS2k=dV9Hfc4B=xnHkQ@mail.gmail.com>
 <20181128180841.GM30658@n2100.armlinux.org.uk>
 <CAHk-=whcbiSxSUprsKjVPEdN5-+o8WnTGiKxEV-+HbKNDs=iNA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHk-=whcbiSxSUprsKjVPEdN5-+o8WnTGiKxEV-+HbKNDs=iNA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_082336_045327_2E4690B5 
X-CRM114-Status: GOOD (  14.44  )
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
Cc: linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-parisc@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
 the arch/x86 maintainers <x86@kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
 xen-devel@lists.xenproject.org, robin.murphy@arm.com,
 Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Nov 28, 2018 at 11:19:15AM -0800, Linus Torvalds wrote:
> Let me just paste it back in here:
> 
>   "Which is what we ALREADY do for these exact reasons. If the DMA
> mappings means that you'd need to add one more page to that list of
> reserved pages, then so be it."
> 
> So no, I'm not at all confused.
> 
> Let me re-iterate: the argument that all addresses have to be dma'able is
> garbage.
> 
> *Exactly* as with kmalloc and limited virtual addresses, we can limit
> physical addresses.

We can.  At least in theory.  The problem is that depending on the
crazy mapping from physical and kernel virtual address to dma addresses
these might be pages at pretty random places.  Look at fun like
arch/x86/pci/sta2x11-fixup.c for how ugly these mappings could look.

It also means that we might have setup swiotlb on just about every
32-bit architecture, even if it has no real addressing limit except for
the one we imposed.  I don't really see how this is a win for us just
to be able to report more detailed error codes, which would be nice
to have, but the lack of which hasn't really harmed us.

So as far as I'm concerned I'd go either with the series that we are
discussing here, or change the map_page method to return an errno
and the dma_addr_t in the argument.  As Davem pointed out that can lead
to less optimal code, but it would still be better than the indirect
call we have.  But then again I think the series as posted here might
and up much simpler and good enough without opening up this rathole.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
