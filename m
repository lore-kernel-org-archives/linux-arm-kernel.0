Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33A6C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:22:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82E2D206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iTkUxO+L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82E2D206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wmWplyCYklQNXkHJEYjM1lBofb9qyGKVLsjF6A/aTJk=; b=iTkUxO+LwcZcHk
	fuOnUKW5LV1e+I4WiLCpJnhS3UcFxBUGNF0QsMSERLNtqqxb15n7STr0cWvwDi8FmEE9L/2WPgO0W
	+Z9fRnho3L8p/acPcUNr++3QpHATaUjInFb7K86afIDRKrLnBeRgagvsL4pQhB/Zgxvq8GkpvRCSj
	29gu5fPJqI4VIBR4EqtWAxX0FNXMTd+mxKTw21G/iDSzdUa9dXVY567fhi0KsYzTcAo0Al3W5MvYG
	1ApnsKO0d+oOTvZsAIRlixAHUpCRsqUrEQOGajpoyppBSNelL7NcZH1YFxEOO9WLWKsEy+66xpnuq
	3FxnwzEdxZWBWLp8AbcQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUBaq-0007Nr-Gl; Tue, 04 Dec 2018 14:22:32 +0000
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUBan-0007N2-By
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 14:22:31 +0000
Received: by newverein.lst.de (Postfix, from userid 2407)
 id C09C968BDF; Tue,  4 Dec 2018 15:22:16 +0100 (CET)
Date: Tue, 4 Dec 2018 15:22:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH 4/9] dma-mapping: move the arm64 ncoherent alloc/free
 support to common code
Message-ID: <20181204142216.GB2618@lst.de>
References: <20181105121931.13481-1-hch@lst.de>
 <20181105121931.13481-5-hch@lst.de>
 <20181204100954.GN30658@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181204100954.GN30658@n2100.armlinux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_062229_575552_57EFB59B 
X-CRM114-Status: GOOD (  12.31  )
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
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Guo Ren <ren_guo@c-sky.com>,
 Laura Abbott <labbott@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> > +int __init dma_atomic_pool_init(gfp_t gfp, pgprot_t prot)
> > +{
> > +	unsigned int pool_size_order = get_order(atomic_pool_size);
> > +	unsigned long nr_pages = atomic_pool_size >> PAGE_SHIFT;
> > +	struct page *page;
> > +	void *addr;
> > +	int ret;
> > +
> > +	if (dev_get_cma_area(NULL))
> > +		page = dma_alloc_from_contiguous(NULL, nr_pages,
> > +						 pool_size_order, false);
> > +	else
> > +		page = alloc_pages(gfp, pool_size_order);
> > +	if (!page)
> > +		goto out;
> > +
> > +	memset(page_address(page), 0, atomic_pool_size);
> 
> Note that this won't work if 'page' is a highmem page - should there
> be a check for that, or a check for the gfp flags?
>
> Also, is this memset() actually useful, or a waste of cycles - when we
> allocate from this pool (see dma_alloc_from_pool()), we always memset()
> the buffer.

Currently there is no user that supports highmem, but yes, the memset
should probably simply be removed.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
