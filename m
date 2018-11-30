Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73387C64EB4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:06:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D60720673
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="j1C2EzDD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QuNVMDSU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D60720673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VhXKtedxkRRhSHuEU+iDlwvKlt8ivHyONMOliiib6P0=; b=j1C2EzDDEVwpO4Ua9yvKU+/ZX
	C3evQCFOJfP64JbmnXXnVqJHYBauFeo+DtcqJXp5o2fPyCEr7IuJmel3Nq0TXq+RRbEhdu6wbEK76
	l9N8Iif0R/xpY4wUbClw8bJxSZQQUO10ZYRnYHTG6tg3/ieblIIBKkY7liHUNsqKXsDyoP10/IZRq
	gqnmRzrVVWbSciPRYaCidUTjcqtOPtrqa8LTbjeypKFSKcfKmc8Z3ZylvOmmG+yDuuo4cnG1ywCCc
	llsB9jD5kHHXBbtb6wVes9uBXjyNI/Yu9iCF3yrpZhcPW3aI/+LigKniAU19anRWA8zeHuF6rSr3r
	Wwm0qjRXA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSo7N-0003GT-2B; Fri, 30 Nov 2018 19:06:25 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSo6h-00036y-MO
 for linux-arm-kernel@bombadil.infradead.org; Fri, 30 Nov 2018 19:05:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=i7vsVN5VOn6UZRh+rs7GlzNSQbRIWQIZQpXXr/NpfIg=; b=QuNVMDSULMtNH/wufGbcarsM06
 PcX4vNpN6X+SaJoaijUehqehRqvCNrilLKtmgzIK7IpQ4G9VsZ41lH+s6YvwodFIIJ/bxSPpy/8JW
 aXNPrNMpoTT7/PYKwPTS5KixXEPXAylCgYiccz8vfDkyjxJx0k6ZZsPztmncJ7nJ89jybPQvPHgsc
 m0WwxLtfoLXbJeCb1PGSC5yq4iSCNcSOOT+d/qrb1GmPQHrJ/ohwkggGtnxtDLYFL/D+EwBj7oa3I
 kegUWL+noLVVd1lMFZApcm6g5258AIp1885aSmPbEtx94lbY6sP19vF1mJ+UQ6KC7mKdTWbKy39al
 m7hvd4fg==;
Received: from foss.arm.com ([217.140.101.70])
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSo6e-0006Pw-Uj
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 19:05:41 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF3411682;
 Fri, 30 Nov 2018 11:05:28 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 16C7A3F575;
 Fri, 30 Nov 2018 11:05:25 -0800 (PST)
Subject: Re: [PATCH 4/9] dma-mapping: move the arm64 ncoherent alloc/free
 support to common code
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
References: <20181105121931.13481-1-hch@lst.de>
 <20181105121931.13481-5-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <5526bc61-57a3-54ff-60c6-e9963230af22@arm.com>
Date: Fri, 30 Nov 2018 19:05:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181105121931.13481-5-hch@lst.de>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_140541_130670_3CF104FC 
X-CRM114-Status: GOOD (  27.10  )
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
 Guo Ren <ren_guo@c-sky.com>, Laura Abbott <labbott@redhat.com>,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 05/11/2018 12:19, Christoph Hellwig wrote:
> The arm64 codebase to implement coherent dma allocation for architectures
> with non-coherent DMA is a good start for a generic implementation, given
> that is uses the generic remap helpers, provides the atomic pool for
> allocations that can't sleep and still is realtively simple and well
> tested.  Move it to kernel/dma and allow architectures to opt into it
> using a config symbol.  Architectures just need to provide a new
> arch_dma_prep_coherent helper to writeback an invalidate the caches
> for any memory that gets remapped for uncached access.

It's a bit yuck that we now end up with arch_* hooks being a mix of arch 
code and not-actually-arch-code, but I guess there's some hope of coming 
back and streamlining things in future once all the big moves are done.

I can't really be bothered to nitpick the typos above and the slight 
inconsistencies in some of the cosmetic code changes, but one worthwhile 
thing stands out...

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   arch/arm64/Kconfig              |   2 +-
>   arch/arm64/mm/dma-mapping.c     | 184 ++------------------------------
>   include/linux/dma-mapping.h     |   5 +
>   include/linux/dma-noncoherent.h |   2 +
>   kernel/dma/Kconfig              |   6 ++
>   kernel/dma/remap.c              | 158 ++++++++++++++++++++++++++-
>   6 files changed, 181 insertions(+), 176 deletions(-)

[...]

> +void *dma_alloc_from_pool(size_t size, struct page **ret_page, gfp_t flags)
> +{
> +	unsigned long val;
> +	void *ptr = NULL;
> +
> +	if (!atomic_pool) {
> +		WARN(1, "coherent pool not initialised!\n");
> +		return NULL;
> +	}
> +
> +	val = gen_pool_alloc(atomic_pool, size);
> +	if (val) {
> +		phys_addr_t phys = gen_pool_virt_to_phys(atomic_pool, val);
> +
> +		*ret_page = phys_to_page(phys);

Looks like phys_to_page() isn't particularly portable, so we probably 
want an explicit pfn_to_page(__phys_to_pfn(phys)) here. Otherwise, the 
fundamental refactoring looks OK.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

[ In fact, looking at phys_to_page(), microblaze, riscv, unicore and 
csky (by the end of this series if it's fixed here) don't need to define 
it at all; s390 defines it for the sake of a single call in a single 
driver; it's used in two other places in arm-related drivers but at 
least one of those is clearly wrong. All in all it's quite the sorry mess. ]

> +		ptr = (void *)val;
> +		memset(ptr, 0, size);
> +	}
> +
> +	return ptr;
> +}
> +
> +bool dma_free_from_pool(void *start, size_t size)
> +{
> +	if (!dma_in_atomic_pool(start, size))
> +		return false;
> +	gen_pool_free(atomic_pool, (unsigned long)start, size);
> +	return true;
> +}
> +
> +void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
> +		gfp_t flags, unsigned long attrs)
> +{
> +	struct page *page = NULL;
> +	void *ret, *kaddr;
> +
> +	size = PAGE_ALIGN(size);
> +
> +	if (!gfpflags_allow_blocking(flags)) {
> +		ret = dma_alloc_from_pool(size, &page, flags);
> +		if (!ret)
> +			return NULL;
> +		*dma_handle = phys_to_dma(dev, page_to_phys(page));
> +		return ret;
> +	}
> +
> +	kaddr = dma_direct_alloc_pages(dev, size, dma_handle, flags, attrs);
> +	if (!kaddr)
> +		return NULL;
> +	page = virt_to_page(kaddr);
> +
> +	/* remove any dirty cache lines on the kernel alias */
> +	arch_dma_prep_coherent(page, size);
> +
> +	/* create a coherent mapping */
> +	ret = dma_common_contiguous_remap(page, size, VM_USERMAP,
> +			arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs),
> +			__builtin_return_address(0));
> +	if (!ret)
> +		dma_direct_free_pages(dev, size, kaddr, *dma_handle, attrs);
> +	return ret;
> +}
> +
> +void arch_dma_free(struct device *dev, size_t size, void *vaddr,
> +		dma_addr_t dma_handle, unsigned long attrs)
> +{
> +	if (!dma_free_from_pool(vaddr, PAGE_ALIGN(size))) {
> +		void *kaddr = phys_to_virt(dma_to_phys(dev, dma_handle));
> +
> +		vunmap(vaddr);
> +		dma_direct_free_pages(dev, size, kaddr, dma_handle, attrs);
> +	}
> +}
> +
> +long arch_dma_coherent_to_pfn(struct device *dev, void *cpu_addr,
> +		dma_addr_t dma_addr)
> +{
> +	return __phys_to_pfn(dma_to_phys(dev, dma_addr));
> +}
> +#endif /* CONFIG_DMA_DIRECT_REMAP */
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
