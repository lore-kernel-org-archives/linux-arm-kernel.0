From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 25 Jun 2010 13:01:27 +0100
Subject: [PATCH 0/3] Cache maintenance on VIPT caches
Message-ID: <20100625115826.30030.89790.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The first and third patches have already been posted in the same form.
The second patch have been modified to handle all the VIPT caches via
__sync_icache_dcache(). The initial use case for this patch was dealing
with an SMP race condition but following suggestions from Rabin, it was
extended to cover ARMv6 onwards, both UP and SMP.

Any Tested-by's are welcome.

Thanks.


Catalin Marinas (3):
      ARM: Assume new page cache pages have dirty D-cache
      ARM: Introduce __sync_icache_dcache() for VIPT caches
      ARM: Use lazy cache flushing on ARMv7 SMP systems


 arch/arm/include/asm/cacheflush.h |    6 ++---
 arch/arm/include/asm/pgtable.h    |   26 +++++++++++++++++++--
 arch/arm/include/asm/smp_plat.h   |    4 +++
 arch/arm/include/asm/tlbflush.h   |   12 ++++++++--
 arch/arm/mm/copypage-v4mc.c       |    2 +-
 arch/arm/mm/copypage-v6.c         |    2 +-
 arch/arm/mm/copypage-xscale.c     |    2 +-
 arch/arm/mm/dma-mapping.c         |    6 +++++
 arch/arm/mm/fault-armv.c          |    8 +++---
 arch/arm/mm/flush.c               |   46 +++++++++++++++++++++++++++++--------
 10 files changed, 89 insertions(+), 25 deletions(-)

-- 
Catalin
