From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Thu, 20 Jul 2017 11:19:57 +0100
Subject: [PATCH 0/2] Introduce interface for default DMA pool
Message-ID: <1500545999-17177-1-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is follow-up for Christoph complain [1] of overloading the current
dma coherent infrastructure with the global pool. To address that I
implemented Robin's idea of the new interface to the global pool and
wire up it with (only existent user) ARM NOMMU.  Since I have not
heard from Vitaly and/or George of their use of global pool, I'm
leaving ARM MMU part to them.

Changelog:
	RFC -> v1
	    - dropped RFC tag
	    - s/_from_coherent/_from_dev_coherent/g per Christoph
	    - added Tested-by from Andras

[1] https://lkml.org/lkml/2017/7/7/370

Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>

Thanks!

Vladimir Murzin (2):
  drivers: dma-coherent: Introduce interface for default DMA pool
  ARM: NOMMU: Wire-up default DMA interface

 arch/arc/mm/dma.c               |   2 +-
 arch/arm/mm/dma-mapping-nommu.c |  45 ++++++++---
 arch/arm/mm/dma-mapping.c       |   2 +-
 arch/arm64/mm/dma-mapping.c     |   4 +-
 arch/mips/mm/dma-default.c      |   2 +-
 drivers/base/dma-coherent.c     | 169 ++++++++++++++++++++++++++--------------
 drivers/base/dma-mapping.c      |   2 +-
 include/linux/dma-mapping.h     |  40 ++++++++--
 8 files changed, 185 insertions(+), 81 deletions(-)

-- 
2.0.0
