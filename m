From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 30 Apr 2013 15:17:22 +0100
Subject: [PATCH 0/4] ARM: KVM: random mmu related fixes for 3.10
Message-ID: <1367331446-28030-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series fixes a number of of KVM/ARM issues that have either
been spotted during the review of the arm64 code, or while reworking
related code.

Only the first patch fixes a potential (if unlikely) problem, the
others are either cosmetic or performance related.

Tested on TC-2.

Marc Zyngier (4):
  ARM: KVM: be more thorough when invalidating TLBs
  ARM: KVM: remove dead prototype for __kvm_tlb_flush_vmid
  ARM: KVM: relax cache maintainance when building page pables
  ARM: KVM: fix use of S2_PGD_SIZE

 arch/arm/include/asm/kvm_asm.h |  2 --
 arch/arm/include/asm/kvm_mmu.h |  1 +
 arch/arm/kvm/interrupts.S      |  2 ++
 arch/arm/kvm/mmu.c             | 44 ++++++++++++++++++++++++------------------
 4 files changed, 28 insertions(+), 21 deletions(-)

-- 
1.8.2.1
