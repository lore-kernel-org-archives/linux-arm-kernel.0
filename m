From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 24 Jul 2015 09:59:54 +0100
Subject: [PATCH 0/2] Last level (leaf) TLBI support
Message-ID: <1437728396-5408-1-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AArch64 introduces TLBI operations that only invalidate the last level
of a page table (block entry). The first patch in the series is just a
minor clean-up to avoid defining too many functions. The second patch
introduces the last level TLBI support for flush_tlb_page() and
tlb_flush(). The flush_tlb_range() function cannot be changed since it
is used in THP code for collapsing multiple small pages into a huge
page.

Catalin Marinas (2):
  arm64: Clean up __flush_tlb(_kernel)_range functions
  arm64: Use last level TLBI for user pte changes

 arch/arm64/include/asm/tlb.h      |  7 +++-
 arch/arm64/include/asm/tlbflush.h | 69 ++++++++++++++++++++++++---------------
 2 files changed, 48 insertions(+), 28 deletions(-)
