From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 24 Nov 2015 18:35:28 +0100
Subject: [PULL 0/8] KVM/ARM Fixes for v4.4-rc3
Message-ID: <1448386536-30118-1-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paolo,

Here's a set of fixes for KVM/ARM for v4.4-rc3 based on v4.4-rc2, because the
errata fixes don't apply on v4.4-rc1.  Let me know if you can pull this anyhow.

Thanks,
-Christoffer

The following changes since commit 1ec218373b8ebda821aec00bb156a9c94fad9cd4:

  Linux 4.4-rc2 (2015-11-22 16:45:59 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kvm-arm-for-v4.4-rc3

for you to fetch changes up to fbb4574ce9a37e15a9872860bf202f2be5bdf6c4:

  arm64: kvm: report original PAR_EL1 upon panic (2015-11-24 18:20:58 +0100)

----------------------------------------------------------------
KVM/ARM Fixes for v4.4-rc3.

Includes some timer fixes, properly unmapping PTEs, an errata fix, and two
tweaks to the EL2 panic code.

----------------------------------------------------------------
Ard Biesheuvel (1):
      ARM/arm64: KVM: test properly for a PTE's uncachedness

Christoffer Dall (3):
      KVM: arm/arm64: Fix preemptible timer active state crazyness
      KVM: arm/arm64: arch_timer: Preserve physical dist. active state on LR.active
      KVM: arm/arm64: vgic: Trust the LR state for HW IRQs

Marc Zyngier (2):
      arm64: KVM: Fix AArch32 to AArch64 register mapping
      arm64: KVM: Add workaround for Cortex-A57 erratum 834220

Mark Rutland (2):
      arm64: kvm: avoid %p in __kvm_hyp_panic
      arm64: kvm: report original PAR_EL1 upon panic

 arch/arm/kvm/arm.c                   |  7 +----
 arch/arm/kvm/mmu.c                   | 15 +++++------
 arch/arm64/Kconfig                   | 21 +++++++++++++++
 arch/arm64/include/asm/cpufeature.h  |  3 ++-
 arch/arm64/include/asm/kvm_emulate.h |  8 +++---
 arch/arm64/kernel/cpu_errata.c       |  9 +++++++
 arch/arm64/kvm/hyp.S                 | 14 ++++++++--
 arch/arm64/kvm/inject_fault.c        |  2 +-
 include/kvm/arm_vgic.h               |  2 +-
 virt/kvm/arm/arch_timer.c            | 28 ++++++++++++--------
 virt/kvm/arm/vgic.c                  | 50 +++++++++++++++++-------------------
 11 files changed, 100 insertions(+), 59 deletions(-)
