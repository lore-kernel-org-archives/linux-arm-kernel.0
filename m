From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 25 Feb 2013 12:18:27 +0000
Subject: Fixing KVM/ARM breakage in mainline
Message-ID: <512B5693.4000608@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell, Marcelo, Gleb,

Commit 89f8833 (Merge tag 'kvm-3.9-1' of
git://git.kernel.org/pub/scm/virt/kvm/kvm) broke KVM/ARM. Nothing
fundamental, just annoying enough.

I've posted patches against next-20130215 some time ago:
http://comments.gmane.org/gmane.comp.emulators.kvm.devel/105019

I've now created a branch based off mainline as of this morning, and
containing these fixes:
git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git
kvm-arm/core-3.9-rc1-fixes

Now the question is: who wants to merge this? The diffstat looks like this:

Marc Zyngier (3):
      ARM: KVM: fix kvm_arch_{prepare,commit}_memory_region
      ARM: KVM: Rename KVM_MEMORY_SLOTS -> KVM_USER_MEM_SLOTS
      ARM: KVM: fix compilation after removal of user_alloc from struct
kvm_memory_slot

 arch/arm/include/asm/kvm_host.h | 2 +-
 arch/arm/kvm/arm.c              | 4 ++--
 arch/arm/kvm/mmu.c              | 5 -----
 3 files changed, 3 insertions(+), 8 deletions(-)

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
