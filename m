From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 29 Mar 2016 09:18:00 +0200
Subject: [PULL 0/4] ARM support for generic memremap()
Message-ID: <1459235884-24318-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

This is a straight rebase of version 3 of this patch series, which I posted
here: http://thread.gmane.org/gmane.linux.ports.arm.kernel/484005. I have
attached the individual patches to this cover letter for reference.

Please pull for v4.7. I expect some of my UEFI work regarding memory
protection tables and the EFI framebuffer to land in the 4.7 timeframe as well,
and thise rely on memremap() to do the right thing if firmware tables happen
to reside in memory that is also covered by memblock/the linear mapping.

Thanks,
Ard.

-------------8<-----------------
The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.linaro.org/people/ard.biesheuvel/linux-arm.git \
                                                  tags/arm-memremap-for-v4.7

for you to fetch changes up to fc77542bdffe9dcb3890c631ad571e1e4b0cc8c3:

  ARM: memremap: implement arch_memremap_wb() (2016-03-29 08:19:26 +0200)

----------------------------------------------------------------
This series wires up the generic memremap() function in a way that allows it
to be used as intended, i.e., without regard for whether the region being
mapped is covered by a struct page and/or the linear mapping (lowmem)

----------------------------------------------------------------

Ard Biesheuvel (4):
  ARM: reintroduce ioremap_cached() for creating cached I/O mappings
  mtd: pxa2xx-flash: switch back from memremap to ioremap_cached
  memremap: add arch specific hook for MEMREMAP_WB mappings
  ARM: memremap: implement arch_memremap_wb()

 arch/arm/include/asm/io.h       | 12 ++++++++++++
 arch/arm/mm/ioremap.c           | 16 ++++++++++++++--
 drivers/mtd/maps/pxa2xx-flash.c |  6 +++---
 kernel/memremap.c               | 11 ++++++++---
 4 files changed, 37 insertions(+), 8 deletions(-)

-- 
2.5.0
