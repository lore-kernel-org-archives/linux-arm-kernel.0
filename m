From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 17 Feb 2014 22:19:44 +0100
Subject: [PATCH 4/4] pinctrl-sunxi: Fix interrupt register offset calculation
In-Reply-To: <1392671984-29872-1-git-send-email-hdegoede@redhat.com>
References: <1392671984-29872-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1392671984-29872-5-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixing setting the interrupt type for eints >= 8.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pinctrl/pinctrl-sunxi.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-sunxi.h b/drivers/pinctrl/pinctrl-sunxi.h
index 01c494f..552b0e9 100644
--- a/drivers/pinctrl/pinctrl-sunxi.h
+++ b/drivers/pinctrl/pinctrl-sunxi.h
@@ -511,7 +511,7 @@ static inline u32 sunxi_pull_offset(u16 pin)
 
 static inline u32 sunxi_irq_cfg_reg(u16 irq)
 {
-	u8 reg = irq / IRQ_CFG_IRQ_PER_REG;
+	u8 reg = irq / IRQ_CFG_IRQ_PER_REG * 0x04;
 	return reg + IRQ_CFG_REG;
 }
 
@@ -523,7 +523,7 @@ static inline u32 sunxi_irq_cfg_offset(u16 irq)
 
 static inline u32 sunxi_irq_ctrl_reg(u16 irq)
 {
-	u8 reg = irq / IRQ_CTRL_IRQ_PER_REG;
+	u8 reg = irq / IRQ_CTRL_IRQ_PER_REG * 0x04;
 	return reg + IRQ_CTRL_REG;
 }
 
@@ -535,7 +535,7 @@ static inline u32 sunxi_irq_ctrl_offset(u16 irq)
 
 static inline u32 sunxi_irq_status_reg(u16 irq)
 {
-	u8 reg = irq / IRQ_STATUS_IRQ_PER_REG;
+	u8 reg = irq / IRQ_STATUS_IRQ_PER_REG * 0x04;
 	return reg + IRQ_STATUS_REG;
 }
 
-- 
1.8.5.3
