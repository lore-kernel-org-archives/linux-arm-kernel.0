From: will.deacon@arm.com (Will Deacon)
Date: Fri,  9 Nov 2012 15:08:23 +0000
Subject: [GIT PULL] prot-none fixes for 3.8
Message-ID: <1352473703-18408-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

This patch series fixes the treatment of PROT_NONE pages for 2-level and
3-level page tables so that the kernel cannot be used to access these
pages on behalf of userspace when !CPU_USE_DOMAINS.

Thanks,

Will


The following changes since commit 3d70f8c617a436c7146ecb81df2265b4626dfe89:

  Linux 3.7-rc4 (2012-11-04 11:07:39 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-rmk/prot-none

Will Deacon (4):
      ARM: mm: use pteval_t to represent page protection values
      ARM: mm: don't use the access flag permissions mechanism for classic MMU
      ARM: mm: introduce L_PTE_VALID for page table entries
      ARM: mm: introduce present, faulting entries for PAGE_NONE

 arch/arm/include/asm/pgtable-2level.h |    2 ++
 arch/arm/include/asm/pgtable-3level.h |    4 +++-
 arch/arm/include/asm/pgtable.h        |   10 ++++------
 arch/arm/mm/mmu.c                     |    2 +-
 arch/arm/mm/proc-macros.S             |    4 ++++
 arch/arm/mm/proc-v7-2level.S          |   10 +++++++---
 arch/arm/mm/proc-v7-3level.S          |    5 ++++-
 7 files changed, 25 insertions(+), 12 deletions(-)
