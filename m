From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri,  8 Apr 2016 11:49:24 +0200
Subject: [GIT PULL v3 resend] ARM support for generic memremap()
Message-ID: <1460108964-12210-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

As discussed last Tuesday, this is a resend of my pull request that covers the
updated v5 of this series that I sent out on Monday. No other series or pull
requests are outstanding.

Please pull.

Regards,
Ard.

---------8<-----------
The following changes since commit 9735a22799b9214d17d3c231fe377fc852f042e9:

  Linux 4.6-rc2 (2016-04-03 09:09:40 -0500)

are available in the git repository at:

  git://git.linaro.org/people/ard.biesheuvel/linux-arm.git \
                                                 tags/arm-memremap-for-v4.7

for you to fetch changes up to 9ab9e4fce45379cb6a7dbf87cf8f8e6ba01853c2:

  ARM: memremap: implement arch_memremap_wb() (2016-04-04 10:26:42 +0200)

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
 arch/arm/mm/nommu.c             |  9 +++++++++
 drivers/mtd/maps/pxa2xx-flash.c |  6 +++---
 kernel/memremap.c               | 11 +++++++++--
 5 files changed, 47 insertions(+), 7 deletions(-)
