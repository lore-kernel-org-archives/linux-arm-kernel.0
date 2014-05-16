From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 16 May 2014 18:17:05 +0100
Subject: [GIT PULL] arm64 fixes for 3.15
Message-ID: <20140516171659.GA11088@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 fixes below. Thanks.


The following changes since commit 89ca3b881987f5a4be4c5dbaa7f0df12bbdde2fd:

  Linux 3.15-rc4 (2014-05-04 18:14:42 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 4797ec2dc83a43be35bad56037d1b53db9e2b5d5:

  arm64: fix pud_huge() for 2-level pagetables (2014-05-16 17:34:40 +0100)

----------------------------------------------------------------
- arm64 migrate_irqs() fix following commit ffde1de64012 (irqchip: Gic:
  Support forced affinity setting)
- fix arm64 pud_huge() to return 0 when only 2 levels page tables are
  used (__PAGETABLE_PMD_FOLDED defined and pmd_huge already covers block
  entries at the first level), otherwise KVM gets confused

----------------------------------------------------------------
Mark Salter (1):
      arm64: fix pud_huge() for 2-level pagetables

Sudeep Holla (1):
      arm64: use cpu_online_mask when using forced irq_set_affinity

 arch/arm64/kernel/irq.c     | 10 +++++++---
 arch/arm64/mm/hugetlbpage.c |  4 ++++
 2 files changed, 11 insertions(+), 3 deletions(-)

-- 
Catalin
