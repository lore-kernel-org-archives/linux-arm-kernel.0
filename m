From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 21 Jun 2013 14:52:16 +0200
Subject: [PATCH 0/2] IPU generic irq chip
Message-ID: <1371819139-22039-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

with linear domain support in the generic irq chip framework, we can drop the
custom irq_chip / irq_domain_ops altogether and use the generic irq chip
implementation instead. The following two patches depend on
"genirq: Generic chip: Add linear irq domain support" and
"genirq: irqchip: Add mask to block out invalid irqs":
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git/log/?id=e8bd834f73714378ef110a64287db1b77033c8da

regards
Philipp

---
 drivers/staging/imx-drm/ipu-v3/ipu-common.c | 101 ++++++++++------------------
 1 file changed, 37 insertions(+), 64 deletions(-)
