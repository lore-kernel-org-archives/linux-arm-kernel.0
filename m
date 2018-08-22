From: john.garry@huawei.com (John Garry)
Date: Wed, 22 Aug 2018 14:44:33 +0100
Subject: [PATCH 0/4] numa, iommu/smmu: IOMMU/SMMU driver optimization for
 NUMA systems
In-Reply-To: <20170921085922.11659-1-ganapatrao.kulkarni@cavium.com>
References: <20170921085922.11659-1-ganapatrao.kulkarni@cavium.com>
Message-ID: <452f1665-eb3a-5e8c-f671-099ef4a15d84@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/09/2017 09:59, Ganapatrao Kulkarni wrote:
> Adding numa aware memory allocations used for iommu dma allocation and
> memory allocated for SMMU stream tables, page walk tables and command queues.
>
> With this patch, iperf testing on ThunderX2, with 40G NIC card on
> NODE 1 PCI shown same performance(around 30% improvement) as NODE 0.
>
> Ganapatrao Kulkarni (4):
>   mm: move function alloc_pages_exact_nid out of __meminit
>   numa, iommu/io-pgtable-arm: Use NUMA aware memory allocation for smmu
>     translation tables
>   iommu/arm-smmu-v3: Use NUMA memory allocations for stream tables and
>     comamnd queues
>   iommu/dma, numa: Use NUMA aware memory allocations in
>     __iommu_dma_alloc_pages
>
>  drivers/iommu/arm-smmu-v3.c    | 57 +++++++++++++++++++++++++++++++++++++-----
>  drivers/iommu/dma-iommu.c      | 17 +++++++------
>  drivers/iommu/io-pgtable-arm.c |  4 ++-
>  include/linux/gfp.h            |  2 +-
>  mm/page_alloc.c                |  3 ++-
>  5 files changed, 67 insertions(+), 16 deletions(-)
>

Hi Ganapatrao,

Have you any plans for further work on this patchset? I have not seen 
anything since this v1 was posted+discussed.

Thanks,
John

> --
> 2.9.4
>
> _______________________________________________
> iommu mailing list
> iommu at lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>
> .
>
