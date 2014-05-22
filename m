From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 22 May 2014 10:30:16 +0200
Subject: Cache maintenance in arm_iommu_alloc_attrs for iommu_coherent_ops
In-Reply-To: <CAD15agav14RUb473+iCm24HM9eQfWYG8ytZOfpzm5j0e3EX3WQ@mail.gmail.com>
References: <CAD15agav14RUb473+iCm24HM9eQfWYG8ytZOfpzm5j0e3EX3WQ@mail.gmail.com>
Message-ID: <537DB598.9080300@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2014-05-21 10:52, Ritesh Harjani wrote:
> Hi All,
>
> There is this path in arm dma-mapping.c with respect to iommu coherent
> buffer allocation:
>
> 1. arm_iommu_alloc_attrs
>         -> __iommu_alloc_buffer
>                   -> __dma_clear_buffer
>
>
> __dma_clear_buffer zeros out the allocated pages but also flushes the
> cpu and the outer cache for coherent iommu ops.
>
> I think the above operation for coherent iommu ops should not include
> cache flush operation right ??
> Or I am missing something here ? Whether this is put intentional or
> its a mistake we can correct ?

You are right. For coherent devices we can skip cache maintenance after
clearing the buffer. I think that the above mentioned code flow has been
overlooked when coherent iommu support has been added.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
