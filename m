From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 12 Dec 2014 10:51:21 +0000
Subject: [PATCH 0/3] irqchip: gicv3-its: Fixes for 3.19-rc1
Message-ID: <1418381484-4394-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This small series contains a number of moderately important fixes for
the GICv3 ITS:

- proper deallocation of LPIs for multi-MSI
- cleaner separation of resource alloc/free vs HW configuration
- fix the allocation of Interrupt Translation Tables

This should be applied on top of the ITS code, currently scheduled to
go in -rc1.

Marc Zyngier (3):
  irqchip: gicv3-its: Fix domain free in multi-MSI case
  irqchip: gicv3-its: Move some alloc/free code to activate/deactivate
  irqchip: gicv3-its: Fix ITT allocation

 drivers/irqchip/irq-gic-v3-its.c | 45 ++++++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 11 deletions(-)

-- 
2.1.3
