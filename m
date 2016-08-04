From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu,  4 Aug 2016 13:40:28 +0200
Subject: [PULL 0/8] KVM/ARM Changes for v4.8 - Take #2
Message-ID: <1470310836-10371-1-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paolo and Radim,

The following changes since commit 3a88bded203591d4683aacdbb65cd0f549bc58cb:

  KVM: arm64: vgic-its: Simplify MAPI error handling (2016-07-18 18:15:20 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kvm-arm-for-4.8-take2

for you to fetch changes up to 89581f06b2bc225f0c9822fa52e714aa2e3810dd:

  arm64: KVM: Set cpsr before spsr on fault injection (2016-08-01 15:09:47 +0100)

The patches include GSI routing support to go along with the new VGIC and a
small fix that has been cooking in -next for a while.

There are still a number of fixes pending for the ITS and other things relating
to our init sequence, which we'll try to get ready for -rc2.

Thanks,
-Christoffer

Andrew Jones (1):
      arm64: KVM: Set cpsr before spsr on fault injection

Eric Auger (6):
      KVM: api: Pass the devid in the msi routing entry
      KVM: Add devid in kvm_kernel_irq_routing_entry
      KVM: irqchip: Convey devid to kvm_set_msi
      KVM: Move kvm_setup_default/empty_irq_routing declaration in arch specific header
      KVM: arm/arm64: Enable irqchip routing
      KVM: arm/arm64: Enable MSI routing

Marc Zyngier (1):
      KVM: arm: vgic-irqfd: Workaround changing kvm_set_routing_entry prototype

 Documentation/virtual/kvm/api.txt |  34 +++++++++--
 arch/arm/kvm/Kconfig              |   2 +
 arch/arm/kvm/Makefile             |   1 +
 arch/arm/kvm/irq.h                |  19 +++++++
 arch/arm64/kvm/Kconfig            |   2 +
 arch/arm64/kvm/Makefile           |   1 +
 arch/arm64/kvm/inject_fault.c     |  12 ++--
 arch/arm64/kvm/irq.h              |  19 +++++++
 arch/x86/kvm/irq.h                |   3 +
 include/kvm/arm_vgic.h            |   7 +++
 include/linux/kvm_host.h          |  12 +++-
 include/uapi/linux/kvm.h          |   5 +-
 virt/kvm/arm/vgic/vgic-init.c     |   4 ++
 virt/kvm/arm/vgic/vgic-irqfd.c    | 116 ++++++++++++++++++++++++++++++++------
 virt/kvm/arm/vgic/vgic.c          |   7 ---
 virt/kvm/irqchip.c                |  28 +++++----
 16 files changed, 220 insertions(+), 52 deletions(-)
 create mode 100644 arch/arm/kvm/irq.h
 create mode 100644 arch/arm64/kvm/irq.h
