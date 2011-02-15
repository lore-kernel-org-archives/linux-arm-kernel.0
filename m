From: dacohen@gmail.com (David Cohen)
Date: Tue, 15 Feb 2011 16:36:30 +0200
Subject: [PATCH v2 0/1] OMAP: IOMMU fault callback support
Message-ID: <1297780591-15613-1-git-send-email-dacohen@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

v2:

Previous patch 1/2 on v1 was dropped.

---

v1:

This patch set adds fault callback support to allow IOMMU users to debug or
react when a fault happens.
IOMMU faults might be very difficult to reproduce and then to figure out
the source of the problem. Currently IOMMU driver prints not so useful
debug message and does not notice user about such issue.
With a fault callback, IOMMU user may debug much more useful information
and/or react to go back to a valid state.

Br,

David
---

David Cohen (1):
  OMAP: IOMMU: add support to callback during fault handling

 arch/arm/mach-omap2/iommu2.c            |   21 +++++++++++++--
 arch/arm/plat-omap/include/plat/iommu.h |   15 ++++++++++-
 arch/arm/plat-omap/iommu.c              |   41 ++++++++++++++++++++++++++++---
 3 files changed, 69 insertions(+), 8 deletions(-)

-- 
1.7.2.3
