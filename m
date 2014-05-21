From: ritesh.harjani@gmail.com (Ritesh Harjani)
Date: Wed, 21 May 2014 14:22:39 +0530
Subject: Cache maintenance in arm_iommu_alloc_attrs for iommu_coherent_ops
Message-ID: <CAD15agav14RUb473+iCm24HM9eQfWYG8ytZOfpzm5j0e3EX3WQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

There is this path in arm dma-mapping.c with respect to iommu coherent
buffer allocation:

1. arm_iommu_alloc_attrs
       -> __iommu_alloc_buffer
                 -> __dma_clear_buffer


__dma_clear_buffer zeros out the allocated pages but also flushes the
cpu and the outer cache for coherent iommu ops.

I think the above operation for coherent iommu ops should not include
cache flush operation right ??
Or I am missing something here ? Whether this is put intentional or
its a mistake we can correct ?


Thanks
Ritesh
