From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu,  2 May 2013 15:38:57 +0100
Subject: [PATCH v2 0/5] ARM: KVM: various mmu related fixes for 3.10
Message-ID: <1367505542-2231-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series fixes a number of of KVM/ARM issues that have either
been spotted during the review of the arm64 code, or while reworking
related code.

Only the first patch fixes a potential (if unlikely) problem, the
others are either cosmetic or performance related.

Tested on TC-2.

Marc Zyngier (5):
  ARM: KVM: be more thorough when invalidating TLBs
  ARM: KVM: remove dead prototype for __kvm_tlb_flush_vmid
  ARM: KVM: relax cache maintainance when building page tables
  ARM: KVM: get rid of S2_PGD_SIZE
  ARM: KVM: use phys_addr_t instead of unsigned long long for HYP PGDs

 arch/arm/include/asm/kvm_arm.h  |  1 -
 arch/arm/include/asm/kvm_asm.h  |  2 --
 arch/arm/include/asm/kvm_host.h |  4 ++--
 arch/arm/kvm/arm.c              |  8 +++----
 arch/arm/kvm/interrupts.S       |  2 ++
 arch/arm/kvm/mmu.c              | 48 +++++++++++++++++++++++------------------
 6 files changed, 35 insertions(+), 30 deletions(-)

-- 
1.8.2.1
