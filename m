From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 21 Jun 2010 13:23:23 +0100
Subject: [PATCH 0/2] Barrier changes with !ARM_DMA_MEM_BUFFERABLE
Message-ID: <20100621115703.7162.95491.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patches are relatively simple but without them the RealView boards
cannot be used with L210/L220 enabled (hardware deadlock, not a software
issue).

Catalin Marinas (2):
      ARM: Do not use outer_sync() in mb() if !ARM_DMA_MEM_BUFFERABLE
      ARM: Do not enable ARM_DMA_MEM_BUFFERABLE for some RealView boards


 arch/arm/include/asm/system.h |    6 +++++-
 arch/arm/mm/Kconfig           |    2 ++
 2 files changed, 7 insertions(+), 1 deletions(-)

-- 
Catalin
