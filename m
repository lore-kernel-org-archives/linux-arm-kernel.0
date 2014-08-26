From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 26 Aug 2014 16:03:33 +0100
Subject: [PATCH 0/2] irqchip: gicv3: add initial CPU PM support
Message-ID: <1409065415-20176-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sudeep Holla <sudeep.holla@arm.com>

This patch series adds initial support for CPU power management with GICv3.

When a CPU enters a low power state, the GICv3 system registers are lost.
They need to be saved and restored if required. Currently as the GICv3
system configuration register are not modified at runtime, the patch
just re-initialise to initial values.

This series only supports CPU power states. However, for system power
states, we may need to save and restore states of distributor and
re-distributors additionally.

Currently this is tested only on models, testing on real hardware is
much appreciated.

Regards,
Sudeep

Sudeep Holla (2):
  GICv3: refactor gic_enable_redist to support both enabling and
    disabling
  GICv3: implement CPU PM notifier

 drivers/irqchip/irq-gic-v3.c | 87 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 66 insertions(+), 21 deletions(-)

-- 
1.8.3.2
