From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  6 Mar 2015 16:37:39 +0000
Subject: [PATCH 00/11] Collection of GIC/GICv3 fixes for 4.0
Message-ID: <1425659870-11832-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series fixes a number of GIC(v3) issues, ranging from
initialization fixes to out of bound accesses and locking issues.

A number of these patches have already been posted before, but as
we're starting to get patch dependencies, and in an effort to reduce
the load on the maintainers, I've decided to collate them in a single
series.

This is based on v4.0-rc1, and available at from the following branch:
git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/gic-fixes

Marc Zyngier (4):
  irqchip: gicv3-its: Allocate enough memory for the full range of
    DeviceID
  irqchip: gicv3-its: Iterate over PCI aliases to generate ITS
    configuration
  irqchip: gicv3-its: Fix unsafe locking reported by lockdep
  irqchip: gic: Fix unsafe locking reported by lockdep

Vladimir Murzin (2):
  irqchip: gicv3-its: Fix ITS CPU init
  irqchip: gic-v3: fix out of bounds access to cpu_logical_map

Yun Wu (5):
  irqchip: gicv3-its: zero itt before handling to hardware
  irqchip: gicv3-its: use 64KB page as default granule
  irqchip: gicv3-its: add limitation to page order
  irqchip: gicv3-its: define macros for GITS_CTLR fields
  irqchip: gicv3-its: support safe initialization

 drivers/irqchip/irq-gic-v3-its.c   | 157 ++++++++++++++++++++++++++++++-------
 drivers/irqchip/irq-gic-v3.c       |   2 +-
 drivers/irqchip/irq-gic.c          |  20 +++--
 include/linux/irqchip/arm-gic-v3.h |   5 ++
 4 files changed, 146 insertions(+), 38 deletions(-)

-- 
2.1.4
