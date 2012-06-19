From: grgupta@ti.com (Gupta, Ramesh)
Date: Tue, 19 Jun 2012 16:50:40 +0530
Subject: [PATCH v2 0/4] OMAP:IOMMU:Add L1 and L2 cache flush
Message-ID: <CADysL2Yr05HUaT7jiqTxmL5dv7mxSpVzXFsJOW9jnsTeiA0E0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From 639d8228c118f884e0d04d33331338bf9561700e Mon Sep 17 00:00:00 2001
From: Ramesh Gupta G <grgupta@ti.com>
Date: Fri, 15 Jun 2012 17:06:14 +0530
 Subject: [PATCH v2 0/4] OMAP:IOMMU:Add L1 and L2 cache flush

This patch series is second version to
- add a new cache maintenance api to flush L1 cache
- flush both L1 and L2 caches from iommu whenever the pagetable memory
  is updated.

Added the new api support for ARMv6 and ARMv7
based on the dma functions. The implementation of the
new api is based on the approach[1] discussed some time back.

[1]http://marc.info/?l=linux-kernel&m=131316512713815&w=2

These patches have been validated on Panda Board.

Signed-off-by: Ramesh Gupta G <grgupta@ti.com>

Ramesh Gupta G (4):
  ARM: new cache maintenance api for iommu mem flush
  ARM: add flush_mem api for ARMv6
  ARM: add flush_mem api for ARMv7
  OMAP:IOMMU: flush L1 and L2 caches

 arch/arm/include/asm/cacheflush.h |   17 +++++++++++++++++
 arch/arm/include/asm/glue-cache.h |    1 +
 arch/arm/mm/cache-v6.S            |   28 ++++++++++++++++++++++++++++
 arch/arm/mm/cache-v7.S            |   21 +++++++++++++++++++++
 arch/arm/mm/proc-macros.S         |    1 +
 drivers/iommu/omap-iommu.c        |   26 +++++++++-----------------
 6 files changed, 77 insertions(+), 17 deletions(-)


-- 
regards
Ramesh Gupta G
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120619/52059a30/attachment.html>
