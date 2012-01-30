From: bill4carson@gmail.com (bill4carson at gmail.com)
Date: Mon, 30 Jan 2012 15:57:11 +0800
Subject: [RFC] ARM hugetlb support
Message-ID: <1327910238-18704-1-git-send-email-bill4carson@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Hi All


This patch aims to support huge page for ARM. For now, 2MB(two 1MB page)/16MB
huge page are supported, Versatile Express Cortex-A9x4 tile is used as test 
board. Verifications are running with libhugetlbfs and ltp.

Any suggestions would be welcome.


Signed-off-by: Bill Carson <bill4carson@gmail.com>
---
 arch/arm/Kconfig                      |   29 ++++
 arch/arm/include/asm/glue-proc.h      |    3 +
 arch/arm/include/asm/hugetlb.h        |  240 +++++++++++++++++++++++++++++++++
 arch/arm/include/asm/page.h           |   15 ++
 arch/arm/include/asm/pgtable-2level.h |    8 +
 arch/arm/include/asm/pgtable.h        |   28 ++++
 arch/arm/include/asm/proc-fns.h       |    3 +
 arch/arm/mm/Makefile                  |    1 +
 arch/arm/mm/dma-mapping.c             |    3 -
 arch/arm/mm/fault.c                   |   15 ++
 arch/arm/mm/hugetlb.c                 |  187 +++++++++++++++++++++++++
 arch/arm/mm/pgd.c                     |   28 ++++
 arch/arm/mm/proc-v7-2level.S          |   96 +++++++++++++
 include/linux/mm_types.h              |   11 ++
 14 files changed, 664 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/include/asm/hugetlb.h
 create mode 100644 arch/arm/mm/hugetlb.c
