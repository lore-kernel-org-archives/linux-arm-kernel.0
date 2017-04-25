From: majun258@huawei.com (Majun)
Date: Tue, 25 Apr 2017 10:16:03 +0800
Subject: [PATCH] irqchip/mbigen: Fix the clear register offset
Message-ID: <1493086563-36396-1-git-send-email-majun258@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: MaJun <majun258@huawei.com>

Don't minus reserved interrupts (64) when get the clear register offset,because
the clear register space includes the space of these 64 interrupts.

Signed-off-by: MaJun <majun258@huawei.com>
---
 drivers/irqchip/irq-mbigen.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index 061cdb8..75818a5 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -108,7 +108,6 @@ static inline void get_mbigen_clear_reg(irq_hw_number_t hwirq,
 {
 	unsigned int ofst;
 
-	hwirq -= RESERVED_IRQ_PER_MBIGEN_CHIP;
 	ofst = hwirq / 32 * 4;
 
 	*mask = 1 << (hwirq % 32);
-- 
1.7.12.4
