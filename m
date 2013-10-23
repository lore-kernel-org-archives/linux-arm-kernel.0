From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 23 Oct 2013 02:19:51 -0700
Subject: [GIT PULL] Second round of KVM/ARM updates for 3.13
Message-ID: <1382519995-19886-1-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit d570142674890fe10b3d7d86aa105e3dfce1ddfa:

  Merge tag 'kvm-arm-for-3.13-1' of git://git.linaro.org/people/cdall/linux-kvm-arm into next (2013-10-16 15:30:32 +0300)

are available in the git repository at:


  git://git.linaro.org/people/cdall/linux-kvm-arm.git tags/kvm-arm-for-3.13-2

for you to fetch changes up to 9b5fdb9781f74fb15827e465bfb5aa63211953c8:

  KVM: ARM: Transparent huge page (THP) support (2013-10-17 17:06:30 -0700)

----------------------------------------------------------------
Updates for KVM/ARM, take 2 including:
 - Transparent Huge Pages and hugetlbfs support for KVM/ARM
 - Yield CPU when guest executes WFE to speed up CPU overcommit

----------------------------------------------------------------
Christoffer Dall (3):
      KVM: ARM: Update comments for kvm_handle_wfi
      KVM: ARM: Support hugetlbfs backed huge pages
      KVM: ARM: Transparent huge page (THP) support

Marc Zyngier (1):
      ARM: KVM: Yield CPU when vcpu executes a WFE

 arch/arm/include/asm/kvm_arm.h         |    5 +-
 arch/arm/include/asm/kvm_mmu.h         |   17 ++-
 arch/arm/include/asm/pgtable-3level.h  |    2 +
 arch/arm/kvm/Kconfig                   |    1 +
 arch/arm/kvm/handle_exit.c             |   20 ++-
 arch/arm/kvm/mmu.c                     |  223 ++++++++++++++++++++++++++------
 arch/arm64/include/asm/kvm_mmu.h       |   12 +-
 arch/arm64/include/asm/pgtable-hwdef.h |    2 +
 8 files changed, 230 insertions(+), 52 deletions(-)
