From: robherring2@gmail.com (Rob Herring)
Date: Tue, 13 Aug 2013 22:01:01 -0500
Subject: [GIT PULL] Highbank fixes for 3.12
Message-ID: <520AF2ED.9030900@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin, Olof,

Please pull highbank updates for 3.12.

There's one trivial core ARM code change in the series to allow a
DMA_ZONE size of 4GB. I believe this should not conflict with Russell's
DMA mask series.

Rob

The following changes since commit d4e4ab86bcba5a72779c43dc1459f71fea3d89c8:

  Linux 3.11-rc5 (2013-08-11 18:04:20 -0700)

are available in the git repository at:

  git://sources.calxeda.com/kernel/linux.git
tags/highbank-lpae-fixes-for-3.12

for you to fetch changes up to ce3ec1d61c5ed6af3ceaace6f57acd588c41b4d6:

  ARM: highbank: fix debug uart virtual address for LPAE (2013-08-13
20:50:16 -0500)

----------------------------------------------------------------
A set of fixes for highbank to enable LPAE and selecting of necesssary
ARM errata.

----------------------------------------------------------------
Rob Herring (6):
      ARM: use phys_addr_t for DMA zone sizes
      ARM: highbank: enable DMA zone for LPAE
      ARM: highbank: select ARCH_HAS_HOLES_MEMORYMODEL
      ARM: highbank: select required errata work-arounds
      ARM: highbank: select ARCH_DMA_ADDR_T_64BIT for LPAE
      ARM: highbank: fix debug uart virtual address for LPAE

 arch/arm/include/asm/mach/arch.h  | 2 +-
 arch/arm/include/debug/highbank.S | 2 +-
 arch/arm/mach-highbank/Kconfig    | 6 ++++++
 arch/arm/mach-highbank/highbank.c | 3 +++
 arch/arm/mm/init.c                | 2 +-
 5 files changed, 12 insertions(+), 3 deletions(-)
