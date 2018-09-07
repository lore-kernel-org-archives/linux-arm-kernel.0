From: christoffer.dall@arm.com (Christoffer Dall)
Date: Fri,  7 Sep 2018 15:12:52 +0200
Subject: [PULL RESEND v2 0/4] KVM/ARM Fixes for v4.19
Message-ID: <20180907131256.2412-1-christoffer.dall@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Radim and Paolo,

Here is the first small round of fixes for KVM/ARM for v4.19.  The
changes include:

 - Fix a VFP corruption in 32-bit guest
 - Add missing cache invalidation for CoW pages
 - Two small cleanups

This is a v2 because I forgot to add the appropriate cc stable on the first two
patches, otherwise there is no difference.

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kvm-arm-fixes-for-v4.19-v2

for you to fetch changes up to df3190e22016abf74ef67c9691e9fa1012a66bd5:

  arm64: KVM: Remove pgd_lock (2018-09-07 15:06:03 +0200)

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
