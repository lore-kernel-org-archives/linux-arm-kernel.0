From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 16 Mar 2018 14:55:09 +0000
Subject: [PATCH 0/2] irqchip/gic*: Complain about the use of IRQ_TYPE_NONE
Message-ID: <20180316145511.28362-1-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grepping through the dts files, the documentation, and reviewing
patches, one can only notice the use of IRQ_TYPE_NONE in interrupt
specifiers. At least for the GIC, this doesn't mean anything. The
unsuspecting driver will end-up with whatever was there before, and
there is a 50% probability that it is not what it wants.

I'd love to fix it myself, but I also have a 50% probability of
getting it wrong. In order to make the user aware they are walking on
thin ice, let's add some warnings. Hopefully, they'll be annoying
enough that people will fix their firmware. Croudsourcing debugging...

If nobody complains louder than the warnings, I plan to get this into
4.17.

Marc Zyngier (2):
  irqchip/gic: Loudly complain about the use of IRQ_TYPE_NONE
  irqchip/gic-v3: Loudly complain about the use of IRQ_TYPE_NONE

 drivers/irqchip/irq-gic-v3.c | 5 +++++
 drivers/irqchip/irq-gic.c    | 5 +++++
 2 files changed, 10 insertions(+)

-- 
2.14.2
