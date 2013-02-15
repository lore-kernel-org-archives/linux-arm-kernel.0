From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 15 Feb 2013 19:20:05 +0000
Subject: [PATCH 3.9-rc1 0/3] KVM/ARM core fixes for 3.9-rc1
Message-ID: <1360956008-5925-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's a number of patches to cope with the churn that occured in
kvm-next, and breaks the compilation in next-20130215.

No big deal, just regular breakage...

Tested on TC2.

Marc Zyngier (3):
  ARM: KVM: fix kvm_arch_{prepare,commit}_memory_region
  ARM: KVM: Rename KVM_MEMORY_SLOTS -> KVM_USER_MEM_SLOTS
  ARM: KVM: fix compilation after removal of user_alloc from struct
    kvm_memory_slot

 arch/arm/include/asm/kvm_host.h | 2 +-
 arch/arm/kvm/arm.c              | 4 ++--
 arch/arm/kvm/mmu.c              | 5 -----
 3 files changed, 3 insertions(+), 8 deletions(-)

-- 
1.8.1.2
