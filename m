From: robherring2@gmail.com (Rob Herring)
Date: Tue, 27 Aug 2013 13:12:39 -0500
Subject: [GIT PULL] Highbank updates for 3.12, take 2
Message-ID: <521CEC17.4050208@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof, Kevin,

Please pull highbank updates for 3.12. Now the pl08x build issue is
sorted. I've dropped the DEBUG_LL change and sent it to Russell.

Rob

The following changes since commit d4e4ab86bcba5a72779c43dc1459f71fea3d89c8:

  Linux 3.11-rc5 (2013-08-11 18:04:20 -0700)

are available in the git repository at:

  git://sources.calxeda.com/kernel/linux.git tags/highbank-for-3.12

for you to fetch changes up to e7dc0796083c7a9e8e3620600a80f6bc7a2fce1a:

  ARM: highbank: clean-up some unused includes (2013-08-27 07:51:43 -0500)

----------------------------------------------------------------
Updates for Highbank for 3.12:
- A couple of fixes to enable LPAE.
- pl08x driver fixes to make it build with ARCH_DMA_ADDR_T_64BIT.
- Avoid L2 related smc calls on Midway.
- Add selecting of necesssary ARM errata.

----------------------------------------------------------------
Andre Przywara (2):
      DMA: fix AMBA PL08x compilation issue with 64bit DMA address type
      DMA: fix printk warning in AMBA PL08x DMA driver

Rob Herring (8):
      ARM: use phys_addr_t for DMA zone sizes
      ARM: highbank: enable DMA zone for LPAE
      ARM: highbank: select ARCH_HAS_HOLES_MEMORYMODEL
      ARM: highbank: select required errata work-arounds
      ARM: highbank: select ARCH_DMA_ADDR_T_64BIT for LPAE
      ARM: move outer_cache declaration out of ifdef
      ARM: highbank: avoid L2 cache smc calls when PL310 is not present
      ARM: highbank: clean-up some unused includes

 arch/arm/include/asm/mach/arch.h  |  2 +-
 arch/arm/include/asm/outercache.h |  4 ++--
 arch/arm/mach-highbank/Kconfig    |  6 ++++++
 arch/arm/mach-highbank/highbank.c | 20 +++++++++-----------
 arch/arm/mm/init.c                |  2 +-
 drivers/dma/amba-pl08x.c          | 23 ++++++++++++++---------
 6 files changed, 33 insertions(+), 24 deletions(-)
