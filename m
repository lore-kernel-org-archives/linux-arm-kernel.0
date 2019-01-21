Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B02C2F3A6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:12:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04DED2084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cNzO2e0R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04DED2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:Subject:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PDVV/gCxkupcz+7dbihKLkBIblNXj6hQMMyeOse5K4M=; b=cNzO2e0RuQGS1lLbzSn3m8BiI
	qTF5LTg+++7yICj0dht3xf4eEVMxQ0j8ajImDksFB9d24Thb1hmTL5RyvCOVX5HNPZSwyyVJ59e4S
	FYv4DIax0r4C/08TkAza+CQWcnpHEtISibW5s9Tnh30LPgc9x2sKL2yQwz/80PvIR7+YEO28k8B+R
	QKTWHx4czw7zazcR4gNHiuzejNkOxjjbVmbbv0cFCgoUA9BM2MmO9UNWydfhv75yi8U0g7Aao7wPI
	Y6mYVJVTNajIpTdJlwcR2O/Kfo1/ykOqTvDia5RJCpDYFKdCptIVRXS9iOVNKLDWiv1JVWA19R786
	QgxSl4xkQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glZNC-0001t9-CS; Mon, 21 Jan 2019 13:12:18 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glZN9-0001sI-2a
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 13:12:16 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8DE2580D;
 Mon, 21 Jan 2019 05:12:12 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3FE913F614;
 Mon, 21 Jan 2019 05:12:11 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 1/2] iommu/io-pgtable-arm: Add support for non-coherent
 page tables
To: Vivek Gautam <vivek.gautam@codeaurora.org>, will.deacon@arm.com,
 joro@8bytes.org, iommu@lists.linux-foundation.org
References: <20190117092718.1396-1-vivek.gautam@codeaurora.org>
 <20190117092718.1396-2-vivek.gautam@codeaurora.org>
Message-ID: <a508a6a5-8e1f-3660-51ef-e65bc382931e@arm.com>
Date: Mon, 21 Jan 2019 13:12:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190117092718.1396-2-vivek.gautam@codeaurora.org>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_051215_124918_8340C3AD 
X-CRM114-Status: GOOD (  29.09  )
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
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 17/01/2019 09:27, Vivek Gautam wrote:
>  From Robin's comment [1] about touching TCR configurations -
> 
> "TBH if we're going to touch the TCR attributes at all then we should
> probably correct that sloppiness first - there's an occasional argument
> for using non-cacheable pagetables even on a coherent SMMU if reducing
> snoop traffic/latency on walks outweighs the cost of cache maintenance
> on PTE updates, but anyone thinking they can get that by overriding
> dma-coherent silently gets the worst of both worlds thanks to this
> current TCR value."
> 
> We have IO_PGTABLE_QUIRK_NO_DMA quirk present, but we don't force
> anybody _not_ using dma-coherent smmu to have non-cacheable page table
> mappings.
> Having another quirk flag can help in having non-cacheable memory for
> page tables once and for all.
> 
> [1] https://lore.kernel.org/patchwork/patch/1020906/
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> ---
>   drivers/iommu/io-pgtable-arm.c | 17 ++++++++++++-----
>   drivers/iommu/io-pgtable.h     |  6 ++++++
>   2 files changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 237cacd4a62b..c76919c30f1a 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -780,7 +780,8 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
>   	struct arm_lpae_io_pgtable *data;
>   
>   	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS | IO_PGTABLE_QUIRK_NO_DMA |
> -			    IO_PGTABLE_QUIRK_NON_STRICT))
> +			    IO_PGTABLE_QUIRK_NON_STRICT |
> +			    IO_PGTABLE_QUIRK_NON_COHERENT))
>   		return NULL;
>   
>   	data = arm_lpae_alloc_pgtable(cfg);
> @@ -788,9 +789,14 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
>   		return NULL;
>   
>   	/* TCR */
> -	reg = (ARM_LPAE_TCR_SH_IS << ARM_LPAE_TCR_SH0_SHIFT) |
> -	      (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_IRGN0_SHIFT) |
> -	      (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_ORGN0_SHIFT);
> +	reg = ARM_LPAE_TCR_SH_IS << ARM_LPAE_TCR_SH0_SHIFT;
> +
> +	if (cfg->quirks & IO_PGTABLE_QUIRK_NON_COHERENT)
> +		reg |= ARM_LPAE_TCR_RGN_NC << ARM_LPAE_TCR_IRGN0_SHIFT |
> +		       ARM_LPAE_TCR_RGN_NC << ARM_LPAE_TCR_ORGN0_SHIFT;
> +	else
> +		reg |= ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_IRGN0_SHIFT |
> +		       ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_ORGN0_SHIFT;
>   
>   	switch (ARM_LPAE_GRANULE(data)) {
>   	case SZ_4K:
> @@ -873,7 +879,8 @@ arm_64_lpae_alloc_pgtable_s2(struct io_pgtable_cfg *cfg, void *cookie)
>   
>   	/* The NS quirk doesn't apply at stage 2 */
>   	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_NO_DMA |
> -			    IO_PGTABLE_QUIRK_NON_STRICT))
> +			    IO_PGTABLE_QUIRK_NON_STRICT |
> +			    IO_PGTABLE_QUIRK_NON_COHERENT))
>   		return NULL;
>   
>   	data = arm_lpae_alloc_pgtable(cfg);
> diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
> index 47d5ae559329..46604cf7b017 100644
> --- a/drivers/iommu/io-pgtable.h
> +++ b/drivers/iommu/io-pgtable.h
> @@ -75,6 +75,11 @@ struct io_pgtable_cfg {
>   	 * IO_PGTABLE_QUIRK_NON_STRICT: Skip issuing synchronous leaf TLBIs
>   	 *	on unmap, for DMA domains using the flush queue mechanism for
>   	 *	delayed invalidation.
> +	 *
> +	 * IO_PGTABLE_QUIRK_NON_COHERENT: Enforce non-cacheable mappings for
> +	 *      pagetables even on a coherent SMMU for cases where reducing
> +	 *      snoop traffic/latency on walks outweighs the cost of cache
> +	 *      maintenance on PTE updates.

Hmm, we can't actually "enforce" anything with this as-is - all we're 
doing is setting the attributes that the IOMMU will use for pagetable 
walks, and that has no impact on how the CPU actually writes PTEs to 
memory. In particular, in the case of a hardware-coherent IOMMU which is 
described as such, even if we make the dma_map/sync calls they still 
won't do anything since they 'know' that the IOMMU is coherent. Thus if 
we then set up a non-cacheable TCR we would have no proper means of 
making pagetables correctly visible to the walker.

Aw crap, this is turning out to be a microcosm of the PCIe no-snoop 
mess... :(

To start with, at least, what we want is to set a non-cacheable TCR if 
the IOMMU is *not* coherent (as far as Linux is concerned - that 
includes the firmware-lying-about-the-hardware situation I was alluding 
to before), but even that isn't necessarily as straightforward as it 
seems. AFAICS, if QUIRK_NO_DMA is set then we definitely have to use a 
cacheable TCR; we can't strictly rely on the inverse being true, but in 
practice we *might* get away with it since we already disallow most 
cases in which the DMA API calls would actually do anything for a 
known-coherent IOMMU device.

Robin.

>   	 */
>   	#define IO_PGTABLE_QUIRK_ARM_NS		BIT(0)
>   	#define IO_PGTABLE_QUIRK_NO_PERMS	BIT(1)
> @@ -82,6 +87,7 @@ struct io_pgtable_cfg {
>   	#define IO_PGTABLE_QUIRK_ARM_MTK_4GB	BIT(3)
>   	#define IO_PGTABLE_QUIRK_NO_DMA		BIT(4)
>   	#define IO_PGTABLE_QUIRK_NON_STRICT	BIT(5)
> +	#define IO_PGTABLE_QUIRK_NON_COHERENT	BIT(6)
>   	unsigned long			quirks;
>   	unsigned long			pgsize_bitmap;
>   	unsigned int			ias;
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
