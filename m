From: steve.capper@linaro.org (Steve Capper)
Date: Tue, 4 Jun 2013 17:17:02 +0100
Subject: [GIT PULL] HugeTLB and THP support for ARM.
Message-ID: <20130604161701.GA20682@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,
Here is a pull request introducing HugeTLB + THP support for ARM.

There are no extra depencies required by the series.

Thanks,
-- 
Steve

--->8

The following changes since commit e4aa937ec75df0eea0bee03bffa3303ad36c986b:

  Linux 3.10-rc3 (2013-05-26 16:00:47 -0700)

are available in the git repository at:

  git://git.linaro.org/people/stevecapper/linux.git for-rmk/hugepages

for you to fetch changes up to 8d962507007357d6fbbcbdd1647faa389a9aed6d:

  ARM: mm: Transparent huge page support for LPAE systems. (2013-06-04 16:52:38 +0100)

----------------------------------------------------------------
Catalin Marinas (2):
      ARM: mm: HugeTLB support for LPAE systems.
      ARM: mm: Transparent huge page support for LPAE systems.

Steve Capper (2):
      ARM: mm: correct pte_same behaviour for LPAE.
      ARM: mm: Add support for flushing HugeTLB pages.

 arch/arm/Kconfig                            |   8 +++
 arch/arm/include/asm/hugetlb-3level.h       |  71 +++++++++++++++++++
 arch/arm/include/asm/hugetlb.h              |  84 +++++++++++++++++++++++
 arch/arm/include/asm/pgtable-3level-hwdef.h |   4 ++
 arch/arm/include/asm/pgtable-3level.h       |  88 ++++++++++++++++++++++++
 arch/arm/include/asm/pgtable.h              |   3 +
 arch/arm/include/asm/tlb.h                  |   6 ++
 arch/arm/include/asm/tlbflush.h             |   2 +
 arch/arm/mm/Makefile                        |   1 +
 arch/arm/mm/dma-mapping.c                   |   2 +-
 arch/arm/mm/flush.c                         |  25 ++++---
 arch/arm/mm/fsr-3level.c                    |   4 +-
 arch/arm/mm/hugetlbpage.c                   | 101 ++++++++++++++++++++++++++++
 13 files changed, 386 insertions(+), 13 deletions(-)
 create mode 100644 arch/arm/include/asm/hugetlb-3level.h
 create mode 100644 arch/arm/include/asm/hugetlb.h
 create mode 100644 arch/arm/mm/hugetlbpage.c
