From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  9 Jan 2015 17:55:08 +0000
Subject: [PATCH 0/2] irqchip: gic*: Fix unsafe locking reported by lockdep
Message-ID: <1420826110-1697-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will Deacon reported some locking issues in the GICv3 ITS driver
(lockdep being quite angry...). After fixing those, I thought I'd
check the GIC driver. Good thing I did, because lockdep wasn't happy
either.

After these two patches, lockdep did stay quiet. Can't be completely
bad...

Marc Zyngier (2):
  irqchip: gicv3-its: Fix unsafe locking reported by lockdep
  irqchip: gic: Fix unsafe locking reported by lockdep

 drivers/irqchip/irq-gic-v3-its.c | 23 ++++++++++++++---------
 drivers/irqchip/irq-gic.c        | 20 ++++++++++++--------
 2 files changed, 26 insertions(+), 17 deletions(-)

-- 
2.1.4
