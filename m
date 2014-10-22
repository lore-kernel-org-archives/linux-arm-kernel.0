From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 22 Oct 2014 20:55:24 +0800
Subject: [PATCH] irqchip: dw-apb-ictl: select GENERIC_IRQ_CHIP
Message-ID: <1413982524-470-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dw-apb-ictl driver uses the clocksource MMIO functions.
Thus it needs to select GENERIC_IRQ_CHIP in Kconfig.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/irqchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index b21f12f..a925da0 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -56,6 +56,7 @@ config BRCMSTB_L2_IRQ
 
 config DW_APB_ICTL
 	bool
+	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
 
 config IMGPDC_IRQ
-- 
2.1.1
