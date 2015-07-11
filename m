From: ddaney.cavm@gmail.com (David Daney)
Date: Sat, 11 Jul 2015 13:25:20 -0700
Subject: [PATCH 0/3] arm64, mm: Use IPIs for TLB invalidation.
Message-ID: <1436646323-10527-1-git-send-email-ddaney.cavm@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Daney <david.daney@cavium.com>

This patch set (or something like it) is needed for the Cavium
ThunderX, but its performance improvements may make it compelling on
its own merits.

Summery: On ThunerX we cannot use broadcast TLB invalidation, so we
use IPIs where necessary.  The funny thing is that it also happens to
make workloads similar to kernel builds much faster.

David Daney (3):
  arm64, mm: Add flush_tlb_all_local() function.
  arm64, mm: Use flush_tlb_all_local() in flush_context().
  arm64, mm: Use IPIs for TLB invalidation.

 arch/arm64/include/asm/tlbflush.h | 64 ++++++++-------------------------------
 arch/arm64/mm/context.c           |  2 +-
 arch/arm64/mm/flush.c             | 46 ++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 53 deletions(-)

-- 
1.9.1
