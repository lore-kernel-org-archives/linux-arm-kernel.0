From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Wed,  2 Nov 2016 11:54:02 +0000
Subject: [PATCH v1 0/6] Support GICv3 ITS in 32-bit mode
Message-ID: <1478087648-5346-1-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series introduces GICv3 ITS to 32-bit world. Since I'm limited
with real world 32-bit platforms which uses ITS it was tested with
help of vITS on 64-bit host running 32-bit guest.

I used Andrea's its/v8 branch at [1] with following option passed to
kvmtool: --aarch32 --irqchip=gicv3-its --force-pci

[1] git://www.linux-arm.org/kvmtool.git

Changelog:

    RFC -> v1
        - rebased on 4.9-rc2,  gits_read_typer() has been dropped
	- spilt ITS and vITS in separate patch sets
	
Vladimir Murzin (6):
  irqchip/gic-v3-its: Change unsigned types for AArch32 compatibility
  irqchip/gic-v3-its: Narrow down Entry Size when used as a divider
  irqchip/gicv3-its: Specialise flush_dcache operation
  irqchip/gicv3-its: Specialise readq and writeq accesses
  ARM: gic-v3-its: Add 32bit support to GICv3 ITS
  ARM: virt: Select ARM_GIC_V3_ITS

 arch/arm/Kconfig                    |    1 +
 arch/arm/include/asm/arch_gicv3.h   |   54 +++++++++++++++++++++----
 arch/arm64/include/asm/arch_gicv3.h |   17 ++++++++
 drivers/irqchip/irq-gic-v3-its.c    |   75 +++++++++++++++++------------------
 include/linux/irqchip/arm-gic-v3.h  |    4 +-
 5 files changed, 104 insertions(+), 47 deletions(-)

-- 
1.7.9.5
