From: will.deacon@arm.com (Will Deacon)
Date: Fri,  9 Nov 2012 15:09:33 +0000
Subject: [GIT PULL] New ASID allocator for 3.8
Message-ID: <1352473773-18471-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

This has been in -next for a while now and we've been playing with it
internally for even longer than that. It hasn't received as much review
as I would have liked but I'm confident in my understanding of the code.

Cheers,

Will


The following changes since commit 3d70f8c617a436c7146ecb81df2265b4626dfe89:

  Linux 3.7-rc4 (2012-11-04 11:07:39 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git asid-allocation

Will Deacon (3):
      ARM: mm: remove IPI broadcasting on ASID rollover
      ARM: mm: avoid taking ASID spinlock on fastpath
      ARM: mm: use bitmap operations when allocating new ASIDs

 arch/arm/include/asm/mmu.h         |   11 +--
 arch/arm/include/asm/mmu_context.h |   82 +--------------
 arch/arm/mm/context.c              |  207 +++++++++++++++++++-----------------
 3 files changed, 115 insertions(+), 185 deletions(-)
