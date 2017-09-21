From: ganapatrao.kulkarni@cavium.com (Ganapatrao Kulkarni)
Date: Thu, 21 Sep 2017 14:29:18 +0530
Subject: [PATCH 0/4] numa,
 iommu/smmu: IOMMU/SMMU driver optimization for NUMA systems
Message-ID: <20170921085922.11659-1-ganapatrao.kulkarni@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding numa aware memory allocations used for iommu dma allocation and
memory allocated for SMMU stream tables, page walk tables and command queues.

With this patch, iperf testing on ThunderX2, with 40G NIC card on
NODE 1 PCI shown same performance(around 30% improvement) as NODE 0.

Ganapatrao Kulkarni (4):
  mm: move function alloc_pages_exact_nid out of __meminit
  numa, iommu/io-pgtable-arm: Use NUMA aware memory allocation for smmu
    translation tables
  iommu/arm-smmu-v3: Use NUMA memory allocations for stream tables and
    comamnd queues
  iommu/dma, numa: Use NUMA aware memory allocations in
    __iommu_dma_alloc_pages

 drivers/iommu/arm-smmu-v3.c    | 57 +++++++++++++++++++++++++++++++++++++-----
 drivers/iommu/dma-iommu.c      | 17 +++++++------
 drivers/iommu/io-pgtable-arm.c |  4 ++-
 include/linux/gfp.h            |  2 +-
 mm/page_alloc.c                |  3 ++-
 5 files changed, 67 insertions(+), 16 deletions(-)

-- 
2.9.4
