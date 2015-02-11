From: eric.auger@linaro.org (Eric Auger)
Date: Wed, 11 Feb 2015 09:20:53 +0100
Subject: [RFC v2 0/4] chip/vgic adaptations for forwarded irq
Message-ID: <1423642857-24240-1-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series proposes some fixes that appeared to be necessary
to integrate IRQ forwarding in KVM/VFIO.

- deactivation of the forwarded IRQ in irq_disabled case
- a specific handling of forwarded IRQ into the VGIC state machine.
- deactivation of physical IRQ and unforwarding on vgic destruction
- rb_tree lock in vgic.c

Integrated pieces can be found at
ssh://git.linaro.org/people/eric.auger/linux.git
on branch irqfd_integ_v9

v1 -> v2:
- change title of the series (formerly "vgic additions for forwarded irq")
- "[RFC 4/4] KVM: arm: vgic: handle irqfd forwarded IRQ injection
  before vgic readiness" now handled in ARM irqfd series
- add chip.c patch file

Eric Auger (4):
  chip.c: complete the forwarded IRQ in case the handler is not reached
  KVM: arm: vgic: fix state machine for forwarded IRQ
  KVM: arm: vgic: add forwarded irq rbtree lock
  KVM: arm: vgic: cleanup forwarded IRQs on destroy

 include/kvm/arm_vgic.h |   1 +
 kernel/irq/chip.c      |   8 +++-
 virt/kvm/arm/vgic.c    | 106 ++++++++++++++++++++++++++++++++++++++++---------
 3 files changed, 94 insertions(+), 21 deletions(-)

-- 
1.9.1
