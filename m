From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Mon, 01 Oct 2012 05:15:33 -0400
Subject: [PATCH v2 0/5] KVM/ARM Architected Timers support
Message-ID: <20121001091528.49694.69990.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following series implements support for the architected generic
timers for KVM/ARM.

This is an unmodified repost of the previously submitted series.

This patch series can also be pulled from:
    git://github.com/virtualopensystems/linux-kvm-arm.git
        branch: kvm-arm-v12-vgic-timers

---

Marc Zyngier (5):
      ARM: arch_timers: switch to physical timers if HYP mode is available
      ARM: KVM: arch_timers: Add minimal infrastructure
      ARM: KVM: arch_timers: Add guest timer core support
      ARM: KVM: arch_timers: Add timer world switch
      ARM: KVM: arch_timers: Wire the init code and config option


 arch/arm/include/asm/kvm_arch_timer.h |   95 +++++++++++++++
 arch/arm/include/asm/kvm_host.h       |    5 +
 arch/arm/kernel/arch_timer.c          |    7 +
 arch/arm/kernel/asm-offsets.c         |    8 +
 arch/arm/kvm/Kconfig                  |    7 +
 arch/arm/kvm/Makefile                 |    1 
 arch/arm/kvm/arm.c                    |   14 ++
 arch/arm/kvm/interrupts.S             |    2 
 arch/arm/kvm/interrupts_head.S        |   60 ++++++++++
 arch/arm/kvm/reset.c                  |    9 +
 arch/arm/kvm/timer.c                  |  204 +++++++++++++++++++++++++++++++++
 arch/arm/kvm/vgic.c                   |    4 +
 12 files changed, 415 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/include/asm/kvm_arch_timer.h
 create mode 100644 arch/arm/kvm/timer.c

-- 
