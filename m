From: lauraa@codeaurora.org (Laura Abbott)
Date: Mon, 11 Aug 2014 16:40:26 -0700
Subject: [PATCHv7 0/5] DMA Atomic pool for arm64
Message-ID: <1407800431-21566-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is v7 of the series to add an atomic pool for arm64 and refactor some
of the dma atomic code. You know the drill.

Thanks,
Laura

v7: Added correct power aligned algorithm patch. Addressed comments from
Andrew.

Laura Abbott (5):
  lib/genalloc.c: Add power aligned algorithm
  lib/genalloc.c: Add genpool range check function
  common: dma-mapping: Introduce common remapping functions
  arm: use genalloc for the atomic pool
  arm64: Add atomic pool for non-coherent and CMA allocations.

 arch/arm/Kconfig                         |   1 +
 arch/arm/mm/dma-mapping.c                | 210 +++++++++----------------------
 arch/arm64/Kconfig                       |   1 +
 arch/arm64/mm/dma-mapping.c              | 164 +++++++++++++++++++++---
 drivers/base/dma-mapping.c               |  68 ++++++++++
 include/asm-generic/dma-mapping-common.h |   9 ++
 include/linux/genalloc.h                 |   7 ++
 lib/genalloc.c                           |  49 ++++++++
 8 files changed, 338 insertions(+), 171 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
