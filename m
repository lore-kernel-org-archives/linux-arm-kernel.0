From: drinkcat@chromium.org (Nicolas Boichat)
Date: Fri,  9 Nov 2018 16:24:45 +0800
Subject: [PATCH RFC 0/3] iommu/io-pgtable-arm-v7s: Use DMA32 zone for page
 tables
Message-ID: <20181109082448.150302-1-drinkcat@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a follow-up to the discussion in [1], to make sure that the page tables
allocated by iommu/io-pgtable-arm-v7s are contained within 32-bit physical
address space.

[1] https://lists.linuxfoundation.org/pipermail/iommu/2018-November/030876.html

Nicolas Boichat (3):
  mm: When CONFIG_ZONE_DMA32 is set, use DMA32 for SLAB_CACHE_DMA
  include/linux/gfp.h: Add __get_dma32_pages macro
  iommu/io-pgtable-arm-v7s: Request DMA32 memory, and improve debugging

 drivers/iommu/io-pgtable-arm-v7s.c |  6 ++++--
 include/linux/gfp.h                |  2 ++
 include/linux/slab.h               | 13 ++++++++++++-
 mm/slab.c                          |  2 +-
 mm/slub.c                          |  2 +-
 5 files changed, 20 insertions(+), 5 deletions(-)

-- 
2.19.1.930.g4563a0d9d0-goog
