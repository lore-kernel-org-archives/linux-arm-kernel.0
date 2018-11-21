From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 21 Nov 2018 16:00:49 +0000
Subject: [PATCH v2 0/2] SWIOTLB fixes for 4.20
Message-ID: <cover.1542812807.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's a quick v2 addressing Christoph's nits and collecting the tags
given so far. I've reproduced my USB problem with a commit prior to the
dma-mapping pull, so it looks like the cache maintenance changes are off
the hook for that one (and I'll have to venture into USB/UAS territory).

No objection from me if Konrad wants to pick this up instead depending
on timing.

Robin.


Robin Murphy (2):
  dma-direct: Make DIRECT_MAPPING_ERROR viable for SWIOTLB
  swiotlb: Skip cache maintenance on map error

 include/linux/dma-direct.h | 2 +-
 kernel/dma/swiotlb.c       | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.19.1.dirty
