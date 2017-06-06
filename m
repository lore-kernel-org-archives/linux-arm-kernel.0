From: cdall@linaro.org (Christoffer Dall)
Date: Tue,  6 Jun 2017 15:56:26 +0200
Subject: [PULL 0/3] KVM/ARM Fixes for v4.12-rc5
Message-ID: <20170606135629.31664-1-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Radim and Paolo,

Three additional fixes for KVM/ARM for v4.12.

They fix an issue with migrating GICv2 VMs on GICv3 systems, squash a
bug for gicv3 when figuring out preemption levels, and fix a potential
null pointer derefence in KVM happening under memory pressure.

The following changes since commit fa472fa91a5a0b241f5ddae927d2e235d07545df:

  KVM: arm/arm64: Hold slots_lock when unregistering kvm io bus devices (2017-05-18 11:18:16 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git kvm-arm-for-v4.12-rc5

for you to fetch changes up to d6dbdd3c8558cad3b6d74cc357b408622d122331:

  KVM: arm/arm64: Handle possible NULL stage2 pud when ageing pages (2017-06-06 15:28:40 +0200)

Thanks,
-Christoffer

----------------------------------------------------------------
Christoffer Dall (2):
  KVM: arm/arm64: Fix isues with GICv2 on GICv3 migration
  KVM: arm/arm64: vgic-v3: Fix nr_pre_bits bitfield extraction

Marc Zyngier (1):
  KVM: arm/arm64: Handle possible NULL stage2 pud when ageing pages

 arch/arm64/kvm/vgic-sys-reg-v3.c   | 10 ++++----
 include/linux/irqchip/arm-gic-v3.h |  4 ++++
 include/linux/irqchip/arm-gic.h    | 28 ++++++++++++++++++++---
 virt/kvm/arm/hyp/vgic-v3-sr.c      |  2 +-
 virt/kvm/arm/mmu.c                 |  3 +++
 virt/kvm/arm/vgic/vgic-mmio-v2.c   | 16 +++++++++++--
 virt/kvm/arm/vgic/vgic-v2.c        | 28 ++++++++++++++++++++---
 virt/kvm/arm/vgic/vgic-v3.c        | 47 ++++++++++++++++++++++++++------------
 virt/kvm/arm/vgic/vgic.h           | 12 ++++++----
 9 files changed, 118 insertions(+), 32 deletions(-)
