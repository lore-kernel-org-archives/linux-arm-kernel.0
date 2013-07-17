From: steve.capper@linaro.org (Steve Capper)
Date: Wed, 17 Jul 2013 14:26:12 +0100
Subject: [PATCH 0/2] ARM: Tidying up huge pages in 3.11-rc1
Message-ID: <1374067574-32034-1-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

These two patches tidy up the huge page support in ARM that was
introduced in 3.11-rc1.

The first patch removes some duplicate code from arch/arm/mm by
referencing the mm/ functions introduced in my ARM64 huge page
series.

Whilst the second patch removes a compiler warning in the DMA
allocator that appears when huge pages are enabled.

Steve Capper (2):
  ARM: mm: Remove general hugetlb code from ARM.
  ARM: mm: Remove HugeTLB warning from dma-mapping.c

 arch/arm/Kconfig          |  3 +++
 arch/arm/mm/dma-mapping.c |  3 ---
 arch/arm/mm/hugetlbpage.c | 43 -------------------------------------------
 3 files changed, 3 insertions(+), 46 deletions(-)

-- 
1.8.1.4
