From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 4 Feb 2010 19:52:52 +0530
Subject: [PATCH 0/5] cache-l2x0 and omap4 l2 support
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C0B425F9@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell / Tony,

Here is the series which combines earlier two series because of dependency and 
rebased against 2.6.33-rc2. This series also implements Russell's suggested
combined monitor API. Tested on OMAP4430 SDP 


The following changes since commit abe94c756c08d50566c09a65b9c7fe72f83071c5:
  Linus Torvalds (1):
        Linux 2.6.33-rc6

Santosh Shilimkar (5):
      ARM: L2 : Add maintainace by line helper functions
      OMAP4: Add L2 Cache support
      OMAP4: Clean the secondary_data from L2
      ARM: L2 : Errata 588369: Clean & Invalidate do not invalidate clean lines
      OMAP4: Enable L2 Cache

 arch/arm/Kconfig                           |   13 +++++
 arch/arm/configs/omap_4430sdp_defconfig    |    3 +
 arch/arm/mach-omap2/board-4430sdp.c        |   53 +++++++++++++++++++++
 arch/arm/mach-omap2/omap-smp.c             |    2 +
 arch/arm/mm/Kconfig                        |    2 +-
 arch/arm/mm/cache-l2x0.c                   |   71 ++++++++++++++++++++++++----
 arch/arm/plat-omap/include/plat/omap44xx.h |    1 +
 7 files changed, 134 insertions(+), 11 deletions(-)

Regards,
Santosh
