From: christoffer.dall@arm.com (Christoffer Dall)
Date: Mon,  3 Sep 2018 15:45:12 +0200
Subject: [PULL 0/4] KVM/ARM Fixes for v4.19
Message-ID: <20180903134516.17796-1-christoffer.dall@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Radim and Paolo,

Here is the first small round of fixes for KVM/ARM for v4.19.  The
changes include:

 - Fix a VFP corruption in 32-bit guest
 - Add missing cache invalidation for CoW pages
 - Two small cleanups

Note that I have a question out on the CoW cache issue relating to
zero-page backed PMD mappings, but if there is any additional fixes to
be done, that doesn't invalidate the current patch and we can follow up
later.

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kvm-arm-fixes-for-v4.19

for you to fetch changes up to f901c848464922bdf85a3b993539d56eedd20809:

  arm64: KVM: Remove pgd_lock (2018-08-30 10:08:01 +0200)

---

Marc Zyngier (3):
  KVM: arm/arm64: Clean dcache to PoC when changing PTE due to CoW
  arm64: KVM: Only force FPEXC32_EL2.EN if trapping FPSIMD
  KVM: Remove obsolete kvm_unmap_hva notifier backend

Steven Price (1):
  arm64: KVM: Remove pgd_lock

 arch/arm/include/asm/kvm_host.h   |  1 -
 arch/arm64/include/asm/kvm_host.h |  4 +---
 arch/arm64/kvm/hyp/switch.c       |  9 ++++++---
 arch/mips/include/asm/kvm_host.h  |  1 -
 arch/mips/kvm/mmu.c               | 10 ----------
 arch/x86/include/asm/kvm_host.h   |  1 -
 arch/x86/kvm/mmu.c                |  5 -----
 virt/kvm/arm/mmu.c                | 21 ++++++++-------------
 virt/kvm/arm/trace.h              | 15 ---------------
 9 files changed, 15 insertions(+), 52 deletions(-)

-- 
2.18.0
