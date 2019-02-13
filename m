Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB57C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:45:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CF10222D5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KRt2l0h2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CF10222D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NT26AYHMBPVzEhRirzq7kvcOpdkFH9PK2UZ5LIijRQs=; b=KRt2l0h2dJm/+b
	oZlb09e4A5iC13iGPNFVtyrBQ0v7b05ouQ51xWjfCDjPpZJD5MtjzIZYcfUFKJ6qyg8zj0N9+T/XV
	agaLD2rkwS+tc9R2W9NHhr18Y0DCv/RVXA3rNG/u9QbtxmodPVBRVuC37Sn58rztlZ2fGbasKQyi8
	frqyzjGha23IBp5zP3fesBbELrX65GAwQRotUijvaJ25yn50t7FfoYalHPDVQZDRpgSlcVtUiqWrx
	VaZB0fGCJv3o8jZrz/ebv0J8A1g6zpWXkw3Dxka8nmQHF505BqQLN81H7ZY5arf+AGBDRVXnfEfnD
	A3V755z10GVsINpVeJhA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtzWg-0004HR-AC; Wed, 13 Feb 2019 18:44:54 +0000
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtzWb-0004Ai-GA
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 18:44:51 +0000
Received: by newverein.lst.de (Postfix, from userid 2407)
 id 238DF68C8E; Wed, 13 Feb 2019 19:44:48 +0100 (CET)
Date: Wed, 13 Feb 2019 19:44:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH 7/8] initramfs: proide a generic free_initrd_mem
 implementation
Message-ID: <20190213184448.GB20399@lst.de>
References: <20190213174621.29297-1-hch@lst.de>
 <20190213174621.29297-8-hch@lst.de> <20190213184139.GC15270@rapoport-lnx>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190213184139.GC15270@rapoport-lnx>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_104450_083765_D45298BE 
X-CRM114-Status: GOOD (  16.08  )
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
Cc: linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>, Guan Xuetao <gxt@pku.edu.cn>,
 Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 13, 2019 at 08:41:40PM +0200, Mike Rapoport wrote:
> csky seems to open-code free_reserved_page with the only
> difference that it's also increments totalram_pages for the freed pages,
> which doesn't seem correct anyway...
> 
> That said, I suppose arch/csky can be also added to the party.

Yes, I noticed that.  But I'd rather move it over manually in
another patch post rc1 or for the next merge window.

> > +void __weak free_initrd_mem(unsigned long start, unsigned long end)
> > +{
> > +	free_reserved_area((void *)start, (void *)end, -1, "initrd");
> 
> Some architectures have pr_info("Freeing initrd memory..."), I'd add it for
> the generic version as well.

Well, if we think such a printk is useful it should probably be
moved to the caller in init/initramfs.c instead.  I can include a
patch for that in the next iteration of the series.

> Another thing that I was thinking of is that x86 has all those memory
> protection calls in its free_initrd_mem, maybe it'd make sense to have them
> in the generic version as well?

Maybe.  But I'd rather keep it out of the initial series as it looks
a little more complicated.  Having a single implementation
of free_initrd_mem would be great, though.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
