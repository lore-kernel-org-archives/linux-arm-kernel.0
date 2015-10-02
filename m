From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  2 Oct 2015 16:44:04 +0100
Subject: [PATCH 0/2] GICv3 ITS fixes for v4.3
Message-ID: <1443800646-8074-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas, Jason,

A couple of relatively minor fixes for the GICv3 ITS code:
- Silence a warning that seems to happen when GCC is a bit inlining happy,
- Fix a thinko when trying to account for PCI aliases.

Thanks,

	M.

Marc Zyngier (2):
  irqchip/gic-v3-its: Silence warning when its_lpi_alloc_chunks gets
    inlined
  irqchip/gic-v3-its: Count additional LPIs for the aliased devices

 drivers/irqchip/irq-gic-v3-its-pci-msi.c | 2 +-
 drivers/irqchip/irq-gic-v3-its.c         | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.1.4
