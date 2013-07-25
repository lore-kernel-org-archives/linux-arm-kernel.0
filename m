From: steve.capper@linaro.org (Steve Capper)
Date: Thu, 25 Jul 2013 17:20:47 +0100
Subject: [RFC 0/2] ARM: mm: HugeTLB + THP support for non-LPAE
Message-ID: <1374769249-15908-1-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

The following patches bring both HugeTLB support and Transparent
HugePage (THP) support to ARM for 2 levels of paging (i.e. without
LPAE).

This code has been tested on an Arndale board (Exynos 5250), and
is based on 3.11-rc1, with the hugepage simplification patch:
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/184117.html

HugeTLB and THP support for LPAE has already been merged in 3.11-rc1.

Hugepages can give nice performance boosts to workloads that put
pressure on the TLBs. I've observed uplifts of ~5% to some tasks
just by enabling hugepages via the libhugetlbfs tools. Other
people have observed decent performance boosts when huge pages
are enabled:
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-February/148835.html

I would appreciate any discussion on these patches, as there are
people who have an interest in having huge page support in
non-LPAE kernels.

Cheers,
-- 
Steve

Steve Capper (2):
  ARM: mm: HugeTLB support for non-LPAE systems.
  ARM: mm: Transparent huge page support for non-LPAE systems.

 arch/arm/Kconfig                      |   4 +-
 arch/arm/include/asm/hugetlb-2level.h | 126 +++++++++++++++++++++++++
 arch/arm/include/asm/hugetlb.h        |   4 +
 arch/arm/include/asm/pgtable-2level.h | 170 ++++++++++++++++++++++++++++++++++
 arch/arm/include/asm/pgtable-3level.h |   6 ++
 arch/arm/include/asm/pgtable.h        |   7 +-
 arch/arm/include/asm/tlb.h            |  10 +-
 arch/arm/kernel/head.S                |  10 +-
 arch/arm/mm/fault.c                   |  13 ---
 arch/arm/mm/fsr-2level.c              |   4 +-
 arch/arm/mm/hugetlbpage.c             |   2 +-
 arch/arm/mm/mmu.c                     |  27 ++++++
 12 files changed, 360 insertions(+), 23 deletions(-)
 create mode 100644 arch/arm/include/asm/hugetlb-2level.h

-- 
1.8.1.4
