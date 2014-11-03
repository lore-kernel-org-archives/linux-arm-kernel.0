From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon,  3 Nov 2014 09:30:59 +0100
Subject: [PATCH v2 0/5] irqchip: atmel-aic: add RTT irq fixup
Message-ID: <1415003464-29239-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series add a new fixup function for the RTT (Real Time Timer)
block and make use of it on SoCs integrating at least one RTT to prevent
spurious interrupts on the first interrupt line.

This fixup function was previously implemented in
arch/arm/mach-at91/sysirq_mask.c, but is now moved to the AIC driver so
that we can remove SoC specific hooks in arch/arm/mach-at91/ when booting
a DT kernel.

This series also reworks the naming convention of the SoC specific fixup
functions and add an entry for the at91rm9200.

Best Regards,

Boris

Changes since v1:
- rebased on linux-3.18-rc2

Boris BREZILLON (5):
  irqchip: atmel-aic: add irq fixup for RTT block
  irqchip: atmel-aic: add irq fixups for at91sam926x SoCs
  irqchip: atmel-aic: add specific irq fixup function for sam9g45 and
    sam9rl
  irqchip: atmel-aic: rename at91sam9_aic_irq_fixup for naming
    consistency
  irqchip: atmel-aic: add missing entry for rm9200 irq fixups

 drivers/irqchip/irq-atmel-aic-common.c | 26 ++++++++++++++++++++++++++
 drivers/irqchip/irq-atmel-aic-common.h |  2 ++
 drivers/irqchip/irq-atmel-aic.c        | 26 +++++++++++++++++++++-----
 3 files changed, 49 insertions(+), 5 deletions(-)

-- 
1.9.1
