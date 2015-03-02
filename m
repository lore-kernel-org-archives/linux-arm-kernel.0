From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Mon,  2 Mar 2015 18:20:27 +0000
Subject: [PATCH v2 0/5] GICv3: add 32bit compatibility
Message-ID: <1425320432-6325-1-git-send-email-jean-philippe.brucker@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds 32bit compatibility to Marc's GICv3 driver. Only SGIs,
PPIs and SPIs support is present, no ITS.

It is now based on Linux 4.0-rc1, which contains Andre's GICv3 emulation
series for KVM [1]. With this support along with the kvmtool patches
mentioned in [1], it is possible to run ARM guests that use GICv3.

Changes since v1 [2]:
* rebased on 4.0-rc1
* fix the mistakes pointed out by Russell and Vladimir
* add a patch to select ARM_GIC_V3 under ARCH_VIRT, as suggested by Marc

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/316230.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/310124.htm

Cheers,
Jean


Jean-Philippe Brucker (5):
  arm64: GICv3: refactor the AArch64 specific parts
  arm64: GICv3: change unsigned types for AArch32 compatibility
  arm64: GICv3: Specialize readq and writeq accesses
  ARM: add 32bit support to GICv3
  ARM: virt: select ARM_GIC_V3

 arch/arm/Kconfig                    |   1 +
 arch/arm/include/asm/arch_gicv3.h   | 182 ++++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/arch_gicv3.h | 141 ++++++++++++++++++++++++++++
 drivers/irqchip/irq-gic-v3.c        |  69 ++++----------
 include/linux/irqchip/arm-gic-v3.h  | 115 ++++++-----------------
 5 files changed, 369 insertions(+), 139 deletions(-)
 create mode 100644 arch/arm/include/asm/arch_gicv3.h
 create mode 100644 arch/arm64/include/asm/arch_gicv3.h

-- 
2.2.0.rc1
