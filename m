From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  4 May 2018 17:15:55 +0100
Subject: [GIT PULL 0/4] KVM/arm fixes for 4.17-rc4
Message-ID: <20180504161559.22852-1-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paolo, Radim,

Here is the second batch of KVM/arm fixes for 4.17, mostly fixing a
few fallouts from the merge window.

Please pull.

	M.

The following changes since commit 85bd0ba1ff9875798fad94218b627ea9f768f3c3:

  arm/arm64: KVM: Add PSCI version selection API (2018-04-20 16:32:23 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kvmarm-fixes-for-4.17-2

for you to fetch changes up to b220244d41798c6592e7d17843256eb0bae456a0:

  arm64: vgic-v2: Fix proxying of cpuif access (2018-05-04 16:45:55 +0100)

----------------------------------------------------------------
KVM/arm fixes for 4.17, take #2

- Fix proxying of GICv2 CPU interface accesses
- Fix crash when switching to BE
- Track source vcpu git GICv2 SGIs
- Fix an outdated bit of documentation

----------------------------------------------------------------
James Morse (2):
      KVM: arm64: Fix order of vcpu_write_sys_reg() arguments
      arm64: vgic-v2: Fix proxying of cpuif access

Marc Zyngier (1):
      KVM: arm/arm64: vgic: Fix source vcpu issues for GICv2 SGI

Valentin Schneider (1):
      KVM: arm/arm64: vgic_init: Cleanup reference to process_maintenance

 arch/arm64/include/asm/kvm_emulate.h     |  2 +-
 arch/arm64/kvm/hyp/vgic-v2-cpuif-proxy.c | 24 ++++++++++++----
 include/kvm/arm_vgic.h                   |  1 +
 virt/kvm/arm/vgic/vgic-init.c            |  2 +-
 virt/kvm/arm/vgic/vgic-mmio.c            | 10 +++++--
 virt/kvm/arm/vgic/vgic-v2.c              | 38 ++++++++++++++-----------
 virt/kvm/arm/vgic/vgic-v3.c              | 49 +++++++++++++++++++-------------
 virt/kvm/arm/vgic/vgic.c                 | 30 +++++--------------
 virt/kvm/arm/vgic/vgic.h                 | 14 +++++++++
 9 files changed, 102 insertions(+), 68 deletions(-)
