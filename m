From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 30 Jun 2010 11:45:23 +0100
Subject: [PATCH 0/2] RealView barriers and ARM_DMA_MEM_BUFFERABLE
Message-ID: <20100630104105.16712.66741.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series is quite similar to the patch that Linus W. tested on
PB1176. The difference is that the RealView mandatory barriers are only
redefined for the ARM11MPCore boards in SMP configurations. For the UP
ones, the second patch is sufficient because of the #ifdef in system.h.

I split the patch in two so that the first one is applicable to 2.6.34
can can be sent to stable at kernel.org.

Linus, could you please confirm that the second patch still fixes the
PB1176 issues for you?

Thanks.


Catalin Marinas (2):
      ARM: RealView: Do not use outer_sync() on ARM11MPCore boards with L220
      ARM: Do not ARM_DMA_MEM_BUFFERABLE on RealView boards with L210/L220


 arch/arm/mach-realview/Kconfig                 |    2 ++
 arch/arm/mach-realview/include/mach/barriers.h |    8 ++++++++
 arch/arm/mm/Kconfig                            |    2 ++
 3 files changed, 12 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-realview/include/mach/barriers.h

-- 
Catalin
