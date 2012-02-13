From: bill4carson@gmail.com (Bill Carson)
Date: Mon, 13 Feb 2012 17:44:21 +0800
Subject: [RFC-PATCH V2] ARM hugetlb support
Message-ID: <1329126268-11032-1-git-send-email-bill4carson@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All

This is 2nd RFC PATCH for ARM huge page support. 2MB(two 1MB page)/16MB
huge page are supported, Versatile Express Cortex-A9x4 tile is used as test 
board. Verification is done with libhugetlbfs with both arm/thumb2 instruction.

ChangeLog From V1:
    - Drop L_PTE_HUGEPAGE defines
    - Check whether super-section is supported through mmfr3
    - Using mmu_context_t to store huge linux pte instead of mm_struct

Any suggestions would be truly welcome :)

Bill Carson(3)
    - Add hugetlb high level hooks
    - Using mmu_context_t to store huge linux pte
    - Introduce set_hugepte_ext to set hardware pte

Signed-off-by: Bill Carson <bill4carson@gmail.com>
---
 arch/arm/Kconfig                      |   29 ++++++
 arch/arm/include/asm/glue-proc.h      |    3 +
 arch/arm/include/asm/hugetlb.h        |  178 +++++++++++++++++++++++++++++++++
 arch/arm/include/asm/mmu.h            |    4 +
 arch/arm/include/asm/page.h           |   15 +++
 arch/arm/include/asm/pgtable-2level.h |    3 +
 arch/arm/include/asm/pgtable.h        |    9 ++
 arch/arm/include/asm/proc-fns.h       |    3 +
 arch/arm/mm/Makefile                  |    1 +
 arch/arm/mm/dma-mapping.c             |    3 -
 arch/arm/mm/fault.c                   |   15 +++
 arch/arm/mm/hugetlb.c                 |  132 ++++++++++++++++++++++++
 arch/arm/mm/pgd.c                     |   11 ++
 arch/arm/mm/proc-v7-2level.S          |   87 ++++++++++++++++
 14 files changed, 490 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/include/asm/hugetlb.h
 create mode 100644 arch/arm/mm/hugetlb.c
