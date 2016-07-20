From: vijay.kilari@gmail.com (vijay.kilari at gmail.com)
Date: Wed, 20 Jul 2016 18:32:24 +0530
Subject: [RFC PATCH v1 0/4] arm/arm64: vgic-new: Implement API for vGICv3 live
 migration
Message-ID: <1469019748-31005-1-git-send-email-vijay.kilari@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vijaya Kumar K <Vijaya.Kumar@cavium.com>

This patchset adds API for saving and restoring
of VGICv3 registers to support live migration with new vgic feature.
This API definition is as per draft version of VGICv3 specification
https://lists.cs.columbia.edu/pipermail/kvmarm/2016-May/020355.html

To test live migration with QEMU, the QEMU patches will
be posted soon.

The patch 3 & 4 are picked from the Pavel's previous implementation.
http://www.spinics.net/lists/kvm/msg122040.html

Vijaya Kumar K (4):
  arm/arm64: vgic-new: Introduce 64-bit reg access support
  arm/arm64: vgic-new: Add distributor and redistributor access
  arm/arm64: vgic-new: Introduce find_reg_by_id()
  arm/arm64: vgic-new: Implement VGICv3 CPU interface access

 arch/arm64/include/uapi/asm/kvm.h   |   12 ++
 arch/arm64/kvm/Makefile             |    1 +
 arch/arm64/kvm/sys_regs.c           |   22 ++--
 arch/arm64/kvm/sys_regs.h           |    4 +
 include/linux/irqchip/arm-gic-v3.h  |    4 +
 virt/kvm/arm/vgic/vgic-kvm-device.c |  120 +++++++++++++++++--
 virt/kvm/arm/vgic/vgic-mmio-v2.c    |    4 +-
 virt/kvm/arm/vgic/vgic-mmio-v3.c    |  111 +++++++++++++++++
 virt/kvm/arm/vgic/vgic-mmio.c       |    2 +-
 virt/kvm/arm/vgic/vgic-sys-reg-v3.c |  225 +++++++++++++++++++++++++++++++++++
 virt/kvm/arm/vgic/vgic.h            |   14 +++
 11 files changed, 497 insertions(+), 22 deletions(-)
 create mode 100644 virt/kvm/arm/vgic/vgic-sys-reg-v3.c

-- 
1.7.9.5
