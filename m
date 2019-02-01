Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885D2C282DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:22:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A2FD218EA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="irKuKfZH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A2FD218EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ShNIt2/8mft4x+un+ZTrOUGkgeo/8G0S3Z2yxsVtQG4=; b=irKuKfZHSXzW6xGLjK6hD4FOY
	rTnLoHfkQdmJrY3I/JkGjmvI1wiBCvHbuNOyLoCruQZiZGqVMOLxquENEfwkhShXfIG9kCYAcQTok
	Xl6pLUzpig5+4Mwl5y0xohzs5glUfF45rFUZIbWS9GpqpPP+cJbZWFGzgujPOHa/d0dlcJsj2YKtp
	hLsoXpbeH0kqJDAhjDIRRQyQkY/iDitM+sqkTxSZ4yIe+L2SXjFDX5g6in7Dv1BTtRyS22J4+dI9g
	UI79q10hwWKCBGJpNvz8TMu6h2UMYxCwPFmxfGGKO1GpKk3LoBXGaBr7FY+mMFFx1CQQ+mcZeqo8H
	dLPRMbycQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpZib-0004ml-E5; Fri, 01 Feb 2019 14:22:57 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpZiX-0004le-SY
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 14:22:55 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4D3780D;
 Fri,  1 Feb 2019 06:22:49 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5BE763F59C;
 Fri,  1 Feb 2019 06:22:48 -0800 (PST)
Subject: Re: [PATCH 01/19] dma-mapping: add a Kconfig symbol to indicated
 arch_dma_prep_coherent presence
To: Christoph Hellwig <hch@lst.de>
References: <20190114094159.27326-1-hch@lst.de>
 <20190114094159.27326-2-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <b3883403-f9b5-34ec-ff5d-9f2ddc9bf8e6@arm.com>
Date: Fri, 1 Feb 2019 14:22:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190114094159.27326-2-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_062253_928170_5D38CE7B 
X-CRM114-Status: GOOD (  24.40  )
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
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 14/01/2019 09:41, Christoph Hellwig wrote:
> Add a Kconfig symbol that indicates an architecture provides a
> arch_dma_prep_coherent implementation, and provide a stub otherwise.
> 
> This will allow the generic dma-iommu code to it while still allowing
> to be built for cache coherent architectures.

I've been pondering this for a while now, and I still can't really come 
up with a case where arch_dma_prep_coherent() would need to behave 
differently from arch_sync_dma_for_device(..., DMA_BIDIRECTIONAL). I 
wonder if we could just save ourselves this little bit of complexity by 
using that instead...

Robin.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   arch/arm64/Kconfig              | 1 +
>   arch/csky/Kconfig               | 1 +
>   include/linux/dma-noncoherent.h | 6 ++++++
>   kernel/dma/Kconfig              | 3 +++
>   4 files changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index a4168d366127..ae3f581a9bcc 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -13,6 +13,7 @@ config ARM64
>   	select ARCH_HAS_DEVMEM_IS_ALLOWED
>   	select ARCH_HAS_DMA_COHERENT_TO_PFN
>   	select ARCH_HAS_DMA_MMAP_PGPROT
> +	select ARCH_HAS_DMA_PREP_COHERENT
>   	select ARCH_HAS_ACPI_TABLE_UPGRADE if ACPI
>   	select ARCH_HAS_ELF_RANDOMIZE
>   	select ARCH_HAS_FAST_MULTIPLIER
> diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
> index 398113c845f5..8b84d4362ff6 100644
> --- a/arch/csky/Kconfig
> +++ b/arch/csky/Kconfig
> @@ -1,5 +1,6 @@
>   config CSKY
>   	def_bool y
> +	select ARCH_HAS_DMA_PREP_COHERENT
>   	select ARCH_HAS_SYNC_DMA_FOR_CPU
>   	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
>   	select ARCH_USE_BUILTIN_BSWAP
> diff --git a/include/linux/dma-noncoherent.h b/include/linux/dma-noncoherent.h
> index 69b36ed31a99..9741767e400f 100644
> --- a/include/linux/dma-noncoherent.h
> +++ b/include/linux/dma-noncoherent.h
> @@ -72,6 +72,12 @@ static inline void arch_sync_dma_for_cpu_all(struct device *dev)
>   }
>   #endif /* CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL */
>   
> +#ifdef CONFIG_ARCH_HAS_DMA_PREP_COHERENT
>   void arch_dma_prep_coherent(struct page *page, size_t size);
> +#else
> +static inline void arch_dma_prep_coherent(struct page *page, size_t size)
> +{
> +}
> +#endif /* CONFIG_ARCH_HAS_DMA_PREP_COHERENT */
>   
>   #endif /* _LINUX_DMA_NONCOHERENT_H */
> diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> index ca88b867e7fe..541128a32c5d 100644
> --- a/kernel/dma/Kconfig
> +++ b/kernel/dma/Kconfig
> @@ -29,6 +29,9 @@ config ARCH_HAS_SYNC_DMA_FOR_CPU
>   config ARCH_HAS_SYNC_DMA_FOR_CPU_ALL
>   	bool
>   
> +config ARCH_HAS_DMA_PREP_COHERENT
> +	bool
> +
>   config ARCH_HAS_DMA_COHERENT_TO_PFN
>   	bool
>   
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
