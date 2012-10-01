From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Mon, 01 Oct 2012 05:12:50 -0400
Subject: [PATCH v2 00/10] KVM/ARM vGIC support
Message-ID: <20121001091244.49503.96318.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following series implements support for the virtual generic
interrupt controller architecture for KVM/ARM.

This is an unmodified repost of the previously submitted series.

This patch series can also be pulled from:
    git://github.com/virtualopensystems/linux-kvm-arm.git
        branch: kvm-arm-v12-vgic

---

Marc Zyngier (10):
      ARM: KVM: Keep track of currently running vcpus
      ARM: KVM: Initial VGIC infrastructure support
      ARM: KVM: Initial VGIC MMIO support code
      ARM: KVM: VGIC distributor handling
      ARM: KVM: VGIC virtual CPU interface management
      ARM: KVM: VGIC interrupt injection
      ARM: KVM: VGIC control interface world switch
      ARM: KVM: VGIC initialisation code
      ARM: KVM: vgic: reduce the number of vcpu kick
      ARM: KVM: Add VGIC configuration option


 arch/arm/include/asm/kvm_arm.h  |   12 
 arch/arm/include/asm/kvm_host.h |   16 +
 arch/arm/include/asm/kvm_vgic.h |  301 +++++++++++
 arch/arm/kernel/asm-offsets.c   |   12 
 arch/arm/kvm/Kconfig            |    7 
 arch/arm/kvm/Makefile           |    1 
 arch/arm/kvm/arm.c              |  101 +++-
 arch/arm/kvm/interrupts.S       |    4 
 arch/arm/kvm/interrupts_head.S  |   68 ++
 arch/arm/kvm/mmu.c              |    3 
 arch/arm/kvm/vgic.c             | 1115 +++++++++++++++++++++++++++++++++++++++
 virt/kvm/kvm_main.c             |    5 
 12 files changed, 1640 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/include/asm/kvm_vgic.h
 create mode 100644 arch/arm/kvm/vgic.c

-- 
