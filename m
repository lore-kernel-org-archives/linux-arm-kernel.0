From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 23 Sep 2014 14:34:57 +0800
Subject: [PATCH 0/3] irqchip: dw-apb-ictl: IRQ_GC_MASK_CACHE_PER_TYPE and PM
 support
Message-ID: <1411454100-6814-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches try to improve dw-apb-ictl irqchip driver a bit.

The first patch does a bit clean up work -- unify the register access usage.

The two dw-apb-ictl's irq_chip_type instances have separate mask registers, so the second patch enables IRQ_GC_MASK_CACHE_PER_TYPE.

The last patch adds suspend/resume support to the driver.

Tested on Marvell BG2Q-DMP board.

Jisheng Zhang (3):
  irqchip: dw-apb-ictl: always use use {readl|writel}_relaxed
  irqchip: dw-apb-ictl: enable IRQ_GC_MASK_CACHE_PER_TYPE
  irqchip: dw-apb-ictl: add PM support

 drivers/irqchip/irq-dw-apb-ictl.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

-- 
2.1.0
