From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed,  8 Jan 2014 14:47:25 -0800
Subject: [GIT PULL] KVM/ARM Updates for 3.14
Message-ID: <1389221250-30034-1-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit d6d63b51fe3bfea0cf596993afa480b0b3b02c32:

  Merge tag 'kvm-s390-20131128' of git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into kvm-next (2013-11-28 15:30:16 +0100)

are available in the git repository at:


  git://git.linaro.org/people/christoffer.dall/linux-kvm-arm.git tags/kvm-arm-for-3.14

for you to fetch changes up to 61466710de078c697106fa5b70ec7afc9feab520:

  KVM: ARM: Remove duplicate include (2014-01-08 13:54:00 -0800)

----------------------------------------------------------------
KVM/ARM Changes for 3.14

 - Changes to idmap use for keystone compatibility
 - Documentation fixes
 - Fix PSCI race occasionally preventing 2nd CPUs from boot
 - Relax THP alignment requirement
 - Remove duplicate header include

----------------------------------------------------------------
Anup Patel (1):
      KVM: Documentation: Fix typo for KVM_ARM_VCPU_INIT ioctl

Christoffer Dall (1):
      arm: KVM: Don't return PSCI_INVAL if waitqueue is inactive

Marc Zyngier (1):
      arm/arm64: KVM: relax the requirements of VMA alignment for THP

Sachin Kamat (1):
      KVM: ARM: Remove duplicate include

Santosh Shilimkar (1):
      arm/arm64: kvm: Use virt_to_idmap instead of virt_to_phys for idmap mappings

 Documentation/virtual/kvm/api.txt |  2 +-
 arch/arm/include/asm/kvm_mmu.h    |  1 +
 arch/arm/kvm/arm.c                | 30 +++++++++++++++++++-----------
 arch/arm/kvm/handle_exit.c        |  2 --
 arch/arm/kvm/mmu.c                | 24 +++++++++++++-----------
 arch/arm/kvm/psci.c               | 11 ++++++-----
 arch/arm64/include/asm/kvm_mmu.h  |  1 +
 7 files changed, 41 insertions(+), 30 deletions(-)
