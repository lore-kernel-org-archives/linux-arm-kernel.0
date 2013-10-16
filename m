From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 15 Oct 2013 17:49:28 -0700
Subject: [GIT PULL] KVM/ARM Updates for kvm/next
Message-ID: <1381884577-24747-1-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

(You may want to make sure you actually pull this as opposed to picking
them off the mailing list, since the weird non-ASCII spaces in the
patches at least make both git send-email and git-am angry for me).

The following changes since commit 272b98c6455f00884f0350f775c5342358ebb73f:

  Linux 3.12-rc1 (2013-09-16 16:17:51 -0400)

are available in the git repository at:

  git://git.linaro.org/people/cdall/linux-kvm-arm.git tags/kvm-arm-for-3.13-1

for you to fetch changes up to a7265fb1751ffbfad553afc7f592a6dac6be48de:

  KVM: ARM: Remove non-ASCII space characters (2013-10-15 17:43:00 -0700)

----------------------------------------------------------------
Updates for KVM/ARM including cpu=host and Cortex-A7 support

----------------------------------------------------------------
Anup Patel (5):
      KVM: ARM: Fix typo in comments of inject_abt()
      ARM: KVM: Implement kvm_vcpu_preferred_target() function
      ARM64: KVM: Implement kvm_vcpu_preferred_target() function
      ARM/ARM64: KVM: Implement KVM_ARM_PREFERRED_TARGET ioctl
      KVM: Add documentation for KVM_ARM_PREFERRED_TARGET ioctl

Christoffer Dall (1):
      KVM: ARM: Remove non-ASCII space characters

Jonathan Austin (3):
      KVM: ARM: Fix calculation of virtual CPU ID
      KVM: ARM: fix the size of TTBCR_{T0SZ,T1SZ} masks
      KVM: ARM: Add support for Cortex-A7

 Documentation/virtual/kvm/api.txt |   31 ++++++++--
 arch/arm/include/asm/kvm_arm.h    |    4 +-
 arch/arm/include/asm/kvm_asm.h    |    2 +-
 arch/arm/include/asm/kvm_host.h   |    1 +
 arch/arm/include/uapi/asm/kvm.h   |    3 +-
 arch/arm/kvm/Makefile             |    2 +-
 arch/arm/kvm/arm.c                |   13 +++++
 arch/arm/kvm/coproc.c             |  114 ++++++++++++++++++++++++++++++++++++
 arch/arm/kvm/coproc_a15.c         |  117 +------------------------------------
 arch/arm/kvm/coproc_a7.c          |   54 +++++++++++++++++
 arch/arm/kvm/emulate.c            |    2 +-
 arch/arm/kvm/guest.c              |   24 +++++++-
 arch/arm/kvm/reset.c              |   15 ++---
 arch/arm64/include/asm/kvm_host.h |    1 +
 arch/arm64/kvm/guest.c            |   20 +++++++
 include/uapi/linux/kvm.h          |    1 +
 16 files changed, 270 insertions(+), 134 deletions(-)
 create mode 100644 arch/arm/kvm/coproc_a7.c
