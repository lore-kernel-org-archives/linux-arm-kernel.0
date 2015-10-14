From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 14 Oct 2015 11:09:17 +0100
Subject: [PATCH 0/2] More GIC updates for Linux 4.4
Message-ID: <1444817359-15696-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

Here's a couple of GIC patches that I'd like to see in 4.4:

- A fix for a (copy-paste) bug introduced by the fwnode/fwspec
  conversion, breaking LPI translation

- An extension to the GICv2m driver, enabling support for multiple MSI
  frames (already posted)

This is on top of tip/irq/core as of yesterday. Hopefully, this is the
last set of GIC patches for the next merge window (yeah, right...).

Thanks,

	M.

Marc Zyngier (2):
  irqchip/gic-v3: Fix translation of LPIs after conversion to irq_fwspec
  irqchip/gic-v2m: Add support for multiple MSI frames

 drivers/irqchip/irq-gic-v2m.c | 124 ++++++++++++++++++++++++++----------------
 drivers/irqchip/irq-gic-v3.c  |  22 +++++---
 2 files changed, 91 insertions(+), 55 deletions(-)

-- 
2.1.4
