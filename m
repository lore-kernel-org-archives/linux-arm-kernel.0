From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 19 Jun 2013 13:44:50 +0100
Subject: [PATCH 0/3] ASID allocator fixes
Message-ID: <1371645893-7630-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series fixes a number of ASID allocator issues that have
been found while running in a virtualized environment (KVM).

The first one is rather critical, as it is pretty easy to trigger and
leads to userspace dying randomly in a VM.
The second one is more unlikely but may lead to memory corruption.
The last one makes the handling of erratum 798181 more robust.

For these reasons, I've added the "Cc: stable" tag.

They have all been tested on TC2 with 3.10-rc5. The patches are also
available in my tree:
git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git asid-fixes

Marc Zyngier (3):
  ARM: let the ASID allocator handle suspended animation
  ARM: prevent risks of out-of-bound access in ASID allocator
  ARM: Cortex-A15: fix erratum 798181 implementation

 arch/arm/include/asm/mmu_context.h | 10 ++++++-
 arch/arm/kernel/smp_tlb.c          | 18 ++-----------
 arch/arm/mm/context.c              | 55 +++++++++++++++++++++++++++++++-------
 3 files changed, 56 insertions(+), 27 deletions(-)

-- 
1.8.2.3
