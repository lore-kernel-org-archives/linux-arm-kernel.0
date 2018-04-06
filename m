From: mark.rutland@arm.com (Mark Rutland)
Date: Fri,  6 Apr 2018 17:26:28 +0100
Subject: [PATCH 0/2] irqchip/gicv3: use readl_poll_timeout_relaxed()
Message-ID: <20180406162630.3244-1-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GICv3 code open-codes some IO polling loops, which a delay constructed as a
series of udelay(1) calls. We can make this simpler and more consistent by
using the readl_relaxed_poll_timeout() helper, so lets do so.

Thanks,
Mark.

Mark Rutland (2):
  irqchip/gic-v3-its: use readl_poll_timeout_relaxed()
  irqchip/gic-v3: use readl_poll_timeout_relaxed()

 drivers/irqchip/irq-gic-v3-its.c | 59 +++++++++++++++++-----------------------
 drivers/irqchip/irq-gic-v3.c     | 31 ++++++++-------------
 2 files changed, 37 insertions(+), 53 deletions(-)

-- 
2.11.0
