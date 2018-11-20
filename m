From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 20 Nov 2018 14:09:51 +0000
Subject: [PATCH 0/2] SWIOTLB fixes for 4.20
Message-ID: <cover.1542722463.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is what I have so far, which at least resolves the most ovbious
problems. I still haven't got very far with the USB corruption issue
I see on Juno with -rc1, but I'm yet to confirm whether that's actually
attributable to the SWIOTLB changes or something else entirely.

Robin.

Robin Murphy (2):
  swiotlb: Make DIRECT_MAPPING_ERROR viable
  swiotlb: Skip cache maintenance on map error

 include/linux/dma-direct.h | 2 +-
 kernel/dma/swiotlb.c       | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.19.1.dirty
