Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599B2C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:23:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BAD1206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NzEeMxcJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BAD1206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MMUH/enHlzN0hn7O2tQohC2zaIqd8qG/CDCKPukHLa0=; b=NzEeMxcJab0El9
	BI4D+c9UTBcGpTAPM0p+M5vuIDBA9rvtik5gEIDpuO9ocQIufalmfxLgjc+gFMYayM1wOKgSdgu6N
	ym8sYVsJLCLPR53xdn9UKeWd3/3CEhErbxd+YPUq7yXJFmKJWNILqfsm6AQp/EI71MyUd6MdWrRBr
	5PoyucFy90If+KD1OkmbProNN97mfGaVY08xYa2oyvQtz2psi8DJSLILYSrvZW6KjIzmfU9UXcd95
	qkDYDeQ6CNkgjgpS5JkEGvYw+TBDe1DHmVoR84y9I5Up5EbRXQztbZXhCC3H9FIt/Nu7yopv0wKbg
	TRxQG0zNWq2aQFMjGJyA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUBcC-0008Ul-DX; Tue, 04 Dec 2018 14:23:56 +0000
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUBbY-0007eJ-Ac
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 14:23:22 +0000
Received: by newverein.lst.de (Postfix, from userid 2407)
 id E943368BDF; Tue,  4 Dec 2018 15:23:04 +0100 (CET)
Date: Tue, 4 Dec 2018 15:23:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 5/9] dma-mapping: support highmem in the generic remap
 allocator
Message-ID: <20181204142304.GC2618@lst.de>
References: <20181105121931.13481-1-hch@lst.de>
 <20181105121931.13481-6-hch@lst.de>
 <CGME20181130190639epcas3p2c9a23f5788b7f8eea26ce8d305b5e6f7@epcas3p2.samsung.com>
 <449e0631-aa32-d4a8-9fa9-07234ae1e533@arm.com>
 <e1567e0d-4724-fb6b-cc22-3a723eec5e0f@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e1567e0d-4724-fb6b-cc22-3a723eec5e0f@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_062317_286050_FD3B069A 
X-CRM114-Status: GOOD (  15.40  )
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

On Tue, Dec 04, 2018 at 09:38:02AM +0100, Marek Szyprowski wrote:
> Hi All,
> 
> On 2018-11-30 20:05, Robin Murphy wrote:
> > On 05/11/2018 12:19, Christoph Hellwig wrote:
> >> By using __dma_direct_alloc_pages we can deal entirely with struct page
> >> instead of having to derive a kernel virtual address.
> >
> > Simple enough :)
> >
> > Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> 
> This patch has landed linux-next yesterday and I've noticed that it
> breaks operation of many drivers. The change looked simple, but a stupid
> bug managed to slip into the code. After a short investigation I've
> noticed that __dma_direct_alloc_pages() doesn't set dma_handle and zero
> allocated memory, while dma_direct_alloc_pages() did. The other
> difference is the lack of set_memory_decrypted() handling.
> 
> Following patch fixes the issue, but maybe it would be better to fix it
> in kernel/dma/direct.c:

Thanks for spotting this Marek.  Can you send the patch below with a
signoff and a changelog so that I can queue it up?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
