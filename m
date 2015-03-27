From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 27 Mar 2015 14:15:01 +0000
Subject: [PATCH 0/4] GICv3 ITS fixes for v4.0-rc6
Message-ID: <1427465705-17126-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The folowing patches fix a number of minor issues, some which have
been discovered when writing the KVM ITS emulation.

The first two patches fix some command encoding bugs, the third is
purely cosmetic, and the fourth fixes an issue that could occur on
configurations where the ITS geenrates cacheable accesses, but isn't
in the same shareability domain as the CPU.

It would be good if they could make it into 4.0-rc6.

Thanks,

	M.

Andre Przywara (1):
  irqchip: gicv3-its: Fix device ID encoding

Marc Zyngier (3):
  irqchip: gicv3-its: Fix encoding of collection's target redistributor
  irqchip: gicv3-its: Fix PROP/PEND and BASE/CBASE confusion
  irqchip: gicv3-its: Use non-cacheable accesses when no shareability

 drivers/irqchip/irq-gic-v3-its.c   | 57 ++++++++++++++++++++++++++++++++------
 include/linux/irqchip/arm-gic-v3.h | 17 ++++++++++++
 2 files changed, 65 insertions(+), 9 deletions(-)

-- 
2.1.4
