Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C242BC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:47:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AFEA20870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HxmGyUHV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AFEA20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=iWfOGQqN6HUKKEnZnd/ZZhOkwi/Nh6rzUxpWkcuyjaY=; b=HxmGyUHV44FeWHup3DAxHveDi
	2gdZ6zXMG/I395HFVAxC6eZJzJEiu2GIc5oRqZzA8HDh4UU3Et5q9QkKq+VBIJoQoWRm9z8u1YJwG
	iPuR0qG7a2/kTx9vyRK+LhaFNU83yJa4U8Z+BY/QxDB6WaGkObo//zF0R8lS6pFSRAdoLggxCbUPc
	te92/39/RSn5j6lPKQxxZwKfpwn7VjEWanBt+y+yVFjFeKb2HEeAyfSSVvtl4pWwhJsEqeH1bCxDA
	+yPVEaw1qfSGdd59tyY/FDUQg/gU9jzvW1ePTKg3+v1ugvoOyYXWvmo/IQDPRjbOZAwvEU4lGVpOT
	jN5zhm2nQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpa6H-000125-0Z; Fri, 01 Feb 2019 14:47:25 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpa6D-00011k-Uu
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 14:47:23 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C18280D;
 Fri,  1 Feb 2019 06:47:21 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F0153F589;
 Fri,  1 Feb 2019 06:47:18 -0800 (PST)
Subject: Re: [PATCH 02/19] dma-iommu: cleanup dma-iommu.h
To: Christoph Hellwig <hch@lst.de>
References: <20190114094159.27326-1-hch@lst.de>
 <20190114094159.27326-3-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <3f78b779-4360-1204-e942-39a8a81759c7@arm.com>
Date: Fri, 1 Feb 2019 14:47:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190114094159.27326-3-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_064722_004853_9F8C8B38 
X-CRM114-Status: GOOD (  24.14  )
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
> No need for a __KERNEL__ guard outside uapi, make sure we pull in the
> includes unconditionally so users can rely on it, and add a missing
> comment describing the #else cpp statement.  Last but not least include
> <linux/errno.h> instead of the asm version, which is frowned upon.

I think the __KERNEL__ and asm/errno.h slip-ups are things I 
cargo-culted from the arch code as a fresh-faced noob yet to learn the 
finer details, so ack for those parts. The forward-declarations, though, 
were a deliberate effort to minimise header dependencies and compilation 
bloat for includers who absolutely wouldn't care, and specifically to 
try to avoid setting transitive include expectations since they always 
seem to end up breaking someone's config somewhere down the line. 
Admittedly this little backwater is hardly comparable to the likes of 
the sched.h business, but I'm still somewhat on the fence about that 
change :/

Robin.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   include/linux/dma-iommu.h | 15 ++++-----------
>   1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
> index e760dc5d1fa8..65aa888c2768 100644
> --- a/include/linux/dma-iommu.h
> +++ b/include/linux/dma-iommu.h
> @@ -16,15 +16,13 @@
>   #ifndef __DMA_IOMMU_H
>   #define __DMA_IOMMU_H
>   
> -#ifdef __KERNEL__
> -#include <linux/types.h>
> -#include <asm/errno.h>
> -
> -#ifdef CONFIG_IOMMU_DMA
> +#include <linux/errno.h>
>   #include <linux/dma-mapping.h>
>   #include <linux/iommu.h>
>   #include <linux/msi.h>
> +#include <linux/types.h>
>   
> +#ifdef CONFIG_IOMMU_DMA
>   int iommu_dma_init(void);
>   
>   /* Domain management interface for IOMMU drivers */
> @@ -74,11 +72,7 @@ void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
>   void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg);
>   void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
>   
> -#else
> -
> -struct iommu_domain;
> -struct msi_msg;
> -struct device;
> +#else /* CONFIG_IOMMU_DMA */
>   
>   static inline int iommu_dma_init(void)
>   {
> @@ -108,5 +102,4 @@ static inline void iommu_dma_get_resv_regions(struct device *dev, struct list_he
>   }
>   
>   #endif	/* CONFIG_IOMMU_DMA */
> -#endif	/* __KERNEL__ */
>   #endif	/* __DMA_IOMMU_H */
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
