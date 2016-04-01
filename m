From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri,  1 Apr 2016 14:48:54 +0200
Subject: [GIT PULL v2] ARM support for generic memremap()
Message-ID: <1459514934-28128-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

This pull request covers the updated v4 of this series that I sent out
yesterday, which fixed a thinko in my changes to the memremap() fallback
logic when attempting to reuse the existing kernel direct address of a
memory range. Anyway, all the required acks are in place for the patches
that touches drivers/mtd and kernel/, so please pull.

Regards,
Ard.

---------8<-----------
The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.linaro.org/people/ard.biesheuvel/linux-arm.git \
                                                  tags/arm-memremap-for-v4.7

for you to fetch changes up to f6684ab45b2dac9bc1cbca5e397f99a33bfbc219:

  ARM: memremap: implement arch_memremap_wb() (2016-03-31 10:42:40 +0200)

----------------------------------------------------------------
This series wires up the generic memremap() function for ARM in a way
that allows it to be used as intended, i.e., without regard for whether
the region being mapped is covered by a struct page and/or the linear
mapping (lowmem)
----------------------------------------------------------------
Ard Biesheuvel (4):
      ARM: reintroduce ioremap_cached() for creating cached I/O mappings
      mtd: pxa2xx-flash: switch back from memremap to ioremap_cached
      memremap: add arch specific hook for MEMREMAP_WB mappings
      ARM: memremap: implement arch_memremap_wb()

 arch/arm/include/asm/io.h       | 12 ++++++++++++
 arch/arm/mm/ioremap.c           | 16 ++++++++++++++--
 drivers/mtd/maps/pxa2xx-flash.c |  6 +++---
 kernel/memremap.c               | 11 +++++++++--
 4 files changed, 38 insertions(+), 7 deletions(-)
