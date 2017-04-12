From: punit.agrawal@arm.com (Punit Agrawal)
Date: Wed, 12 Apr 2017 15:04:56 +0100
Subject: [PATCH 0/3] arm64: Add support for handling memory corruption
Message-ID: <20170412140459.21824-1-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

With support for contiguous hugepages being turned off[0], some of the
problems arising from swap entries go away[1]. This simplifies the
changes needed to enable memory corruption handling for arm64 (done in
this seris).

In this series, we updates huge_pte_offset() to correctly deal with
swap entries (Patch 1). This function will need to be updated when
contiguous hugepages are re-enabled.

Patch 2 adds support to send SIGBUS to processes that have their
memory corrupted. With the prerequisites in place, enable memory
corruption handling for arm64 (patch 3).

Thanks,
Punit

[0] https://lkml.org/lkml/2017/4/7/486
[1] https://lkml.org/lkml/2017/4/5/402

Jonathan (Zhixiong) Zhang (2):
  arm64: hwpoison: add VM_FAULT_HWPOISON[_LARGE] handling
  arm64: kconfig: allow support for memory failure handling

Punit Agrawal (1):
  arm64: hugetlb: Fix huge_pte_offset to return poisoned page table
    entries

 arch/arm64/Kconfig          |  1 +
 arch/arm64/mm/fault.c       | 22 +++++++++++++++++++---
 arch/arm64/mm/hugetlbpage.c | 20 +++++++++++++++-----
 3 files changed, 35 insertions(+), 8 deletions(-)

-- 
2.11.0
